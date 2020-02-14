from django.contrib.auth import get_user_model
from django.db import models
from django.urls import reverse


class Client(models.Model):
    name = models.CharField("Clients First Name", max_length=50, blank=False, null=False, default=' ')
    address = models.CharField("Address", max_length=50, blank=True, null=True, default=' ')
    city = models.CharField("City", max_length=50, default=' ')
    state = models.CharField("State", max_length=50, default='NE')
    zipcode = models.CharField("Zip Code", max_length=10, default='00000')
    email = models.EmailField("E-mail", max_length=100, default=' ')
    cell_phone = models.CharField("Cell", max_length=50, default='(402)000-0000')
    acct_number = models.CharField("Account Number", max_length=50, blank=True, null=True, default='00000')
    notes = models.TextField("Notes")
    date = models.DateTimeField("Date", auto_now_add=True)
    author = models.ForeignKey(
        get_user_model(),
        on_delete=models.CASCADE,
    )

    def __str__(self):
        return self.name

    def get_absolute_url(self):
        return reverse('client_detail', args=[str(self.id)])


class exerciseCategory(models.Model):
    category = models.CharField(max_length=26, unique=True, default='cardio')

    def __str__(self):
        return self.category

    def get_absolute_url(self):
        return reverse('client_detail', args=[str(self.id)])


class exercises(models.Model):
    name = models.CharField(max_length=26, unique=True, default='running')
    exercise_category_category = models.ForeignKey(
        exerciseCategory, on_delete=models.CASCADE
    )

    def __str__(self):
        return self.name

    def get_absolute_url(self):
        return reverse('client_detail', args=[str(self.id)])


class diary(models.Model):
    day = models.DateTimeField()
    duration = models.IntegerField(default='10')
    duration_units = models.CharField(max_length=5, default='min')
    reps = models.IntegerField(default='10')
    weight = models.IntegerField(default='10')
    weight_units = models.CharField(max_length=5, default='lbs')
    client = models.ForeignKey(
        Client, on_delete=models.CASCADE
    )
    exercises = models.ForeignKey(
        exercises, on_delete=models.CASCADE
    )

    def __str__(self):
        return self.client.name
