from django import forms
from django.contrib.auth.forms import UserCreationForm, UserChangeForm

from .models import CustomTrainer


class CustomUserCreationForm(UserCreationForm):
    class Meta(UserCreationForm):
        model = CustomTrainer
        fields = ('username', 'first_name', 'last_name', 'email', 'employee_cell_phone')


class CustomUserChangeForm(UserChangeForm):
    class Meta:
        model = CustomTrainer
        fields = ('username', 'first_name', 'last_name', 'email', 'employee_cell_phone')
