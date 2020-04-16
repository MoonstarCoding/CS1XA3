from django.http import HttpResponse, HttpResponseNotFound
from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth.forms import AuthenticationForm, UserCreationForm, PasswordChangeForm
from django.contrib.auth import authenticate, login, logout, update_session_auth_hash
from django.contrib import messages

from . import models as models
import datetime as dt


def messages_view(request):
    """Private Page Only an Authorized User Can View, renders messages page
       Displays all posts and friends, also allows user to make new posts and like posts
    Parameters
    ---------
      request: (HttpRequest) - should contain an authorized user
    Returns
    --------
      out: (HttpResponse) - if user is authenticated, will render private.djhtml
    """
    if request.user.is_authenticated:
        user_info = models.UserInfo.objects.get(user=request.user)

        # TODO Objective 9: query for posts (HINT only return posts needed to be displayed)
        request.session['post_count'] = request.session.get('post_count', 1)
        posts = [post for post in models.Post.objects.all()]


        # TODO Objective 10: check if user has like post, attach as a new attribute to each post

        context = {'user_info': user_info, 'posts': posts[:request.session['post_count']], 'friends_list': user_info.friends.all()}
        return render(request, 'messages.djhtml', context)

    request.session['failed'] = True
    return redirect('login:login_view')


def account_view(request):
    """Private Page Only an Authorized User Can View, allows user to update
       their account information (i.e UserInfo fields), including changing
       their password
    Parameters
    ---------
      request: (HttpRequest) should be either a GET or POST
    Returns
    --------
      out: (HttpResponse)
                 GET - if user is authenticated, will render account.djhtml
                 POST - handle form submissions for changing password, or User Info
                        (if handled in this view)
    """
    if request.user.is_authenticated:
        pass_change_form = PasswordChangeForm(request)

        # TODO Objective 3: Create Forms and Handle POST to Update UserInfo / Password

        user_info = models.UserInfo.objects.get(user=request.user)
        interest_list = list(user_info.interests.all())
        if len(interest_list) == 0:
            interest_list = [1,2,3,4,5]
        if user_info.birthday is not None:
            render_birthday = dt.datetime.strftime(user_info.birthday, "%Y-%m-%d")
        else:
            render_birthday = "0001-01-01"
        context = {'user_info': user_info,
                   'pass_change_form': pass_change_form,
                   'fields': ["Employment", "Location", "Birthday", "Interests"],
                   'render_birthday': render_birthday,
                   'interest_list': interest_list}
        return render(request, 'account.djhtml', context)

    request.session['failed'] = True
    return redirect('login:login_view')


def info_update_view(request):
    user_info = models.UserInfo.objects.get(user=request.user)
    if request.method == 'POST':
        employment = request.POST.get('Employment', 'Unspecified')
        location = request.POST.get('Location', 'Unspecified')
        birthday = request.POST.get('Birthday', '0001-01-01')
        interest = request.POST.get('Interests', models.Interest('No Interest'))

        if type(interest) == str and interest != '':
            interest = models.Interest(label=f"{interest}")
            interest.save(using='default')
            user_info.interests.add(interest)

        if birthday == '':
            birthday = '0001-01-01'

        if type(birthday) == str and birthday != '0001-01-01':
            birthday = dt.datetime.strptime(birthday,'%Y-%m-%d')
            birthday = birthday.date().strftime('%Y-%m-%d')
            user_info.birthday = birthday

        user_info.employment = employment
        user_info.location = location
        user_info.save(using='default')
    return redirect('social:account_view')


def people_view(request):
    """Private Page Only an Authorized User Can View, renders people page
       Displays all users who are not friends of the current user and friend requests
    Parameters
    ---------
      request: (HttpRequest) - should contain an authorized user
    Returns
    --------
      out: (HttpResponse) - if user is authenticated, will render people.djhtml
    """
    if request.user.is_authenticated:
        user_info = models.UserInfo.objects.get(user=request.user)
        others = models.UserInfo.objects.exclude(user=request.user)
        request.session['display_count'] = request.session.get('display_count', 1)

        # TODO Objective 4: create a list of all users who aren't friends to the current user (and limit size)
        all_people = []
        for user in list(others):
            if user not in list(user_info.friends.all()):
                all_people += [user]

        # TODO Objective 5: create a list of all friend requests to current user
        friend_info = models.FriendRequest.objects.all()
        friend_requests = []
        for friend in friend_info:
            # print(friend.to_user.user)
            # print(friend.from_user.user)
            if friend.to_user == user_info:
                friend_requests += [friend]

        context = {'user_info': user_info,
                   'all_people': all_people[:request.session['display_count']],
                   'friend_requests': friend_requests,
                   'display_count': request.session['display_count']}

        return render(request, 'people.djhtml', context)

    request.session['failed'] = True
    return redirect('login:login_view')


def like_view(request):
    '''Handles POST Request recieved from clicking Like button in messages.djhtml,
       sent by messages.js, by updating the corrresponding entry in the Post Model
       by adding user to its likes field
    Parameters
        ----------
          request : (HttpRequest) - should contain json data with attribute postID,
                                a string of format post-n where n is an id in the
                                Post model

        Returns
        -------
          out : (HttpResponse) - queries the Post model for the corresponding postID, and
                             adds the current user to the likes attribute, then returns
                             an empty HttpResponse, 404 if any error occurs
    '''
    postIDReq = request.POST.get('postID')
    if postIDReq is not None:
        user_info = models.UserInfo.objects.get(user=request.user)
        # TODO Objective 10: parse post id from postIDReq
        postID = int(postIDReq)
        post = list(models.Post.objects.all())[postID]

        if request.user.is_authenticated:
            # TODO Objective 10: update Post model entry to add user to likes field
            post.likes.add(user_info)
            post.save()
            print(post.likes.all())

            # return status='success'
            return HttpResponse()
        else:
            return redirect('login:login_view')

    return HttpResponseNotFound('like_view called without postID in POST')


def post_submit_view(request):
    '''Handles POST Request recieved from submitting a post in messages.djhtml by adding an entry
       to the Post Model
    Parameters
        ----------
          request : (HttpRequest) - should contain json data with attribute postContent, a string of content

        Returns
        -------
          out : (HttpResponse) - after adding a new entry to the POST model, returns an empty HttpResponse,
                             or 404 if any error occurs
    '''
    postContent = request.POST.get('postContent')
    if postContent is not None:
        if request.user.is_authenticated:
            # TODO Objective 8: Add a new entry to the Post model
            user_info = models.UserInfo.objects.get(user=request.user)
            post_obj = models.Post(owner=user_info, content=postContent)
            post_obj.save()

            # return status='success'
            return HttpResponse()
        else:
            return redirect('login:login_view')

    return HttpResponseNotFound('post_submit_view called without postContent in POST')


def more_post_view(request):
    '''Handles POST Request requesting to increase the amount of Post's displayed in messages.djhtml
    Parameters
        ----------
          request : (HttpRequest) - should be an empty POST

        Returns
        -------
          out : (HttpResponse) - should return an empty HttpResponse after updating hte num_posts sessions variable
    '''
    if request.user.is_authenticated:
        # update the # of posts dispalyed
        posts = [post for post in models.Post.objects.all()]
        # TODO Objective 9: update how many posts are displayed/returned by messages_view
        if request.session['post_count'] + 1 <= len(posts):
            request.session['post_count'] += 1
        else:
            request.session['post_count'] = len(posts)
        # return status='success'
        return HttpResponse()

    return redirect('login:login_view')


def more_ppl_view(request):
    '''Handles POST Request requesting to increase the amount of People displayed in people.djhtml
    Parameters
        ----------
          request : (HttpRequest) - should be an empty POST

        Returns
        -------
          out : (HttpResponse) - should return an empty HttpResponse after updating the num ppl sessions variable
    '''
    if request.user.is_authenticated:
        # update the # of people displayed
        others = models.UserInfo.objects.exclude(user=request.user)
        all_people = []
        for user in list(others):
            if user not in list(models.UserInfo.objects.get(user=request.user).friends.all()):
                all_people += [user]

        # TODO Objective 4: increment session variable for keeping track of num ppl displayed
        if request.session['display_count'] + 1 <= len(all_people):
            request.session['display_count'] += 1
        else:
            request.session['display_count'] = len(all_people)
        # return status='success'
        return HttpResponse()

    return redirect('login:login_view')


def friend_request_view(request):
    '''Handles POST Request recieved from clicking Friend Request button in people.djhtml,
       sent by people.js, by adding an entry to the FriendRequest Model
    Parameters
        ----------
          request : (HttpRequest) - should contain json data with attribute frID,
                                a string of format fr-name where name is a valid username

        Returns
        -------
          out : (HttpResponse) - adds an etnry to the FriendRequest Model, then returns
                             an empty HttpResponse, 404 if POST data doesn't contain frID
    '''
    frID = request.POST.get('frID')
    if frID is not None:
        # remove 'fr-' from frID
        username = frID[3:]

        if request.user.is_authenticated:
            # TODO Objective 5: add new entry to FriendRequest
            user_info = models.UserInfo.objects.get(user=request.user)
            others = models.UserInfo.objects.exclude(user=request.user)

            for user in others:
                if str(user.user) == username:
                    others = user
                    break

            friend_request = models.FriendRequest(to_user=others, from_user=user_info)
            requests = models.FriendRequest.objects.filter(to_user=others, from_user=user_info)

            if len(list(requests)) == 0:
                friend_request.save()
                print('Friend Request Added')
            else:
                print('Friend Request Failed')
            # return status='success'
            return HttpResponse()
        else:
            return redirect('login:login_view')

    return HttpResponseNotFound('friend_request_view called without frID in POST')


def accept_decline_view(request):
    '''Handles POST Request recieved from accepting or declining a friend request in people.djhtml,
       sent by people.js, deletes corresponding FriendRequest entry and adds to users friends relation
       if accepted
    Parameters
        ----------
          request : (HttpRequest) - should contain json data with attribute decision,
                                a string of format A-name or D-name where name is
                                a valid username (the user who sent the request)

        Returns
        -------
          out : (HttpResponse) - deletes entry to FriendRequest table, appends friends in UserInfo Models,
                             then returns an empty HttpResponse, 404 if POST data doesn't contain decision
    '''
    data = [request.POST.get('decision'), request.POST.get('username')]
    user_info = models.UserInfo.objects.get(user=request.user)
    if data is not None:
        if request.user.is_authenticated:
            # TODO Objective 6: delete FriendRequest entry and update friends in both Users
            friend_request = list(models.FriendRequest.objects.filter(to_user=user_info))
            for fr in friend_request:
                if str(fr.from_user.user) == data[1]:
                    friend_request = fr
                    break

            if data[0] == "A":
                user_info.friends.add(friend_request.from_user)
                friend_request.from_user.friends.add(user_info)
                user_info.save()
                friend_request.from_user.save()
            else:
                pass


            instance = models.FriendRequest.objects.get(to_user=friend_request.to_user, from_user=friend_request.from_user)
            instance.delete()
            # In Case of Emergency, Uncomment Below
            # models.FriendRequest.objects.all().delete()

            # return status='success'
            return HttpResponse()
        else:
            return redirect('login:login_view')
    return HttpResponseNotFound('accept-decline-view called without decision in POST')
