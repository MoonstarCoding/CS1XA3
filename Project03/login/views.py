from django.http import HttpResponse, HttpResponseNotFound
from django.shortcuts import render, redirect
from django.contrib.auth.forms import AuthenticationForm, UserCreationForm, PasswordChangeForm
from django.contrib.auth import authenticate, login, logout, update_session_auth_hash
from django.contrib import messages

from social import models


def login_view(request):
    """Serves lagin.djhtml from /e/macid/ (url name: login_view)
    Parameters
    ----------
      request: (HttpRequest) - POST with username and password or an empty GET
    Returns
    -------
      out: (HttpResponse)
                   POST - authenticate, login and redirect user to social app
                   GET - render login.djhtml with an authentication form
    """
    if request.method == 'POST':
        username = request.POST['username']
        password = request.POST['password']
        user = authenticate(request, username=username, password=password)
        if user is not None:
            login(request, user)
            request.session['failed'] = False
            return redirect('social:messages_view')
        else:
            request.session['failed'] = True

    form = AuthenticationForm(request.POST)
    failed = request.session.get('failed', False)
    context = {'login_form': form,
               'failed': failed}

    return render(request, 'login.djhtml', context)


def logout_view(request):
    """Redirects to login_view from /e/macid/logout/ (url name: logout_view)
    Parameters
    ----------
      request: (HttpRequest) - expected to be an empty get request
    Returns
    -------
      out: (HttpResponse) - perform User logout and redirects to login_view
    """
    # TODO Objective 4 and 9: reset sessions variables

    # logout user
    logout(request)

    return redirect('login:login_view')


def signup_view(request):
    """Serves signup.djhtml from /e/macid/signup (url name: signup_view)
    Parameters
    ----------
      request : (HttpRequest) - expected to be an empty get request
    Returns
    -------
      out : (HttpRepsonse) - renders signup.djhtml
    """
    form = UserCreationForm()
    failed = request.session.get('create_failed', False)
    context = {'signup_form': form, 'create_failed': failed}

    return render(request, 'signup.djhtml', context)


def user_create_view(request):
    if request.method == 'POST':
        form = UserCreationForm(request.POST)
        if form.is_valid():
            # Get the form data
            username = form.cleaned_data.get('username')
            raw_password = form.cleaned_data.get('password1')
            # make the custom user model
            user = models.UserInfo.objects.create_user_info(
                username=f'{username}', password=f'{raw_password}')
            # Authenticate the model
            auth = authenticate(username=username, password=raw_password)
            # Login
            login(request, auth)
            # Redirect
            return redirect('social:messages_view')
    else:
        form = UserCreationForm()
    request.session['create_failed'] = True
    return redirect('login:signup_view')
