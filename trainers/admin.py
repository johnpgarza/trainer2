from django.contrib import admin
from django.contrib.auth.admin import UserAdmin

from .forms import CustomUserCreationForm, CustomUserChangeForm
from .models import CustomTrainer


class CustomUserAdmin(UserAdmin):
    add_form = CustomUserCreationForm
    form = CustomUserChangeForm
    model = CustomTrainer
    list_display = ['email', 'username', 'specialty', 'employee_cell_phone', 'is_staff', ]


admin.site.register(CustomTrainer, CustomUserAdmin)
