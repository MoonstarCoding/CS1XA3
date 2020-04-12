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

List of Users:

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