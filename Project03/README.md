# CS 1XA3 Project03 - hutchm6

## Usage

Install Conda Environment with:

```bash
conda env create -f environment.yml
```

Run locally with

```bash
python manage.py runserver localhost:8000
```

Run on mac1xa3.ca with

```bash
python manage.py runserver localhost:10045
```

For a list of Users, refer to Objective 11. It consists of every user, as well as expected information tied to that user in JSON format.

This will be the main user you will use that I have made, but I encourage you make another user as well.

```json
{
  "username": "Mark",
  "password": "PlanetMoon3",
  "employment": "McDonald's",
  "Location": "Acton",
  "birthday": "Aug. 1st, 2001",
  "interests": ["Computers", "Video Games", "Food"],
  "friends": ["Samantha", "Irene", "Craig", "Logan", "Gavin", "Susan", "Russel"]
}
```

## Objective 01 - Login and SignUp

Description:
Finish the prebuilt login system within the login app:

- Create a user sign up form that allows new users to be created.
  - This form will be created with Django's `UserCreateForm()` and `request.POST.get()` method to get the form's inputs.
  - If the user is invalid, the user will be redirected to the sign up page and an appropriate error will be displayed using Django's error field from the prebuilt form.
- Link this form to `def signup_view` in the `views.py`
- If the new user is created successfully, redirect that new user to their messages page.

## Objective 02 - Adding User Profile and Interests

Description:
Get user information and display it on the `social_base.djhtml`:

- Access the request.user object and iterate over each of the fields contained within the user model, displaying each field within the `social_base.djhtml` file using for loops and inline variable accessing.

## Objective 03 - Account Settings Page

Description:
The Account Settings page allows a user to either change their password, or their account settings.

Password Change:

- Through using `form = PasswordChangeForm(request.user, request.POST)`, I imported the default form that allows password changing.
- This prebuilt in method requires absolutely no tweaking.

Update Settings:

- Through a form made purely in HTML, no Django involved, a Post request is sent to the `def info_update_view(request)`.
- Each input is then gathered from the request object, and has a default value incase deleted or unset. This default value correlates to the existing default in the databases.
  - The ony exception to this is the Birthday, as it requires a default birthday in YYYY-MM-dd format.
- Once every value of the `UserInfo` object is set, the object is updated appropriately.

## Objective 04 - Displaying People List

Description:
Objective Description

- Dot Jots

## Objective 05 - Sending Friend Request

Description:
Objective Description

- Dot Jots

## Objective 06 - Accepting/Declining Friend Requests

Description:
Objective Description

- Dot Jots

## Objective 07 - Displaying Friends

Description:
Objective Description

- Dot Jots

## Objective 08 - Submitting Posts

Description:
Objective Description

- Dot Jots

## Objective 09 - Displaying Post List

Description:
Objective Description

- Dot Jots

## Objective 10 - Liking Posts (and Displaying Like Count)

Description:
Objective Description

- Dot Jots

## Objective 11 - Testing Database

Description:
This is a testing database built around my family and a close friend's family. You will **probably** be logging in through the Mark account for the bulk majority, but every existing account is listed.

```json
{
  "username": "Mark",
  "password": "PlanetMoon3",
  "employment": "McDonald's",
  "Location": "Acton",
  "birthday": "Aug. 1st, 2001",
  "interests": ["Computers", "Video Games", "Food"],
  "friends": ["Samantha", "Irene", "Craig", "Logan", "Gavin", "Susan", "Russel"]
},
{
  "username": "Samantha",
  "password": "Butterfly77",
  "employment": "Tim Horton's",
  "Location": "Acton",
  "birthday": "Aug. 7th, 1997",
  "interests": ["History", "Museums", "Travelling"],
  "friends": ["Mark", "Irene", "Craig"]
},
{
  "username": "Irene",
  "password": "Flowers5",
  "employment": "Pinchin Environmental",
  "Location": "Acton",
  "birthday": "Jan. 21st, 1967",
  "interests": ["Travelling", "Gardening", "Reading"],
  "friends": ["Mark", "Samantha", "Craig"]
},
{
  "username": "Craig",
  "password": "Wolfman4",
  "employment": "RBC",
  "Location": "Acton",
  "birthday": "Nov. 25th, 1965",
  "interests": ["Computers", "Cooking", "Age of Empires II"],
  "friends": ["Mark", "Samantha", "Irene"]
},
{
  "username": "Logan",
  "password": "Pikachu117",
  "employment": "None",
  "Location": "Acton",
  "birthday": "Nov. 11th, 2001",
  "interests": ["Computers", "Video Games", "Soda"],
  "friends": ["Mark", "Gavin", "Susan", "Russel"]
},
{
  "username": "Gavin",
  "password": "Halo1234",
  "employment": "None",
  "Location": "Acton",
  "birthday": "July 4th, 1997",
  "interests": ["Computers", "Video Games"],
  "friends": ["Mark", "Logan", "Susan", "Russel"]
},
{
  "username": "Susan",
  "password": "Clover12",
  "employment": "Eramosa Physiotherapy",
  "Location": "Acton",
  "birthday": "Jan. 1st, 2001",
  "interests": ["Television", "Gardening", "Reading"],
  "friends": ["Mark", "Logan", "Gavin", "Russel"]
},
{
  "username": "Russell",
  "password": "ClashMan8",
  "employment": "Unspecified",
  "Location": "Acton",
  "birthday": "Unspecified",
  "interests": ["Computers", "Clash of Clans"],
  "friends": ["Mark", "Logan", "Gavin", "Susan"]
},
{
  "username": "TestUser",
  "password": "IAmATester123",
  "employment": "",
  "Location": "",
  "birthday": "",
  "interests": [],
  "friends": []
},
```
