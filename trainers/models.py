from django.contrib.auth.models import AbstractUser
from django.db import models


class CustomTrainer(AbstractUser):
    specialty = models.CharField(max_length=50, default=' ', null=True, blank=True)
    employee_cell_phone = models.CharField(max_length=50, default=' ', null=True, blank=True)
