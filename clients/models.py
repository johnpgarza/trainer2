from django.contrib.auth import get_user_model
from django.db import models
from phonenumber_field.modelfields import PhoneNumberField
from django.urls import reverse


class Client(models.Model):
    name = models.CharField("Clients First Name", max_length=50, blank=False, null=False, default=' ')
    address = models.CharField("Address", max_length=50, blank=True, null=True, default=' ')
    city = models.CharField("City", max_length=50, default=' ')
    state = models.CharField("State", max_length=50, default='NE')
    zipcode = models.CharField("Zip Code", max_length=10, default='00000')
    email = models.EmailField("E-mail", max_length=100, default=' ')
    cell_phone = PhoneNumberField(null=False, blank=True,)
    acct_number = models.CharField("Account Number", max_length=50, blank=True, null=True, default='00000')
    date = models.DateTimeField("Date", auto_now_add=True)
    trainer = models.ForeignKey(
        get_user_model(),
        on_delete=models.CASCADE,
    )

    def __str__(self):
        return self.name

    def get_absolute_url(self):
        return reverse('client_detail', args=[str(self.id)])


class ExerciseCategory(models.Model):
    category = models.CharField(max_length=26, unique=True, default='cardio')

    def __str__(self):
        return self.category

    def get_absolute_url(self):
        return reverse('client_detail', args=[str(self.id)])


class Exercises(models.Model):
    name = models.CharField(max_length=26, unique=True, default='running')
    exercise_category_category = models.ForeignKey(
        ExerciseCategory, on_delete=models.CASCADE
    )

    def __str__(self):
        return self.name

    def get_absolute_url(self):
        return reverse('exercise_detail', args=[str(self.id)])


class Diary(models.Model):
    trainer = models.ForeignKey(
        get_user_model(),
        on_delete=models.CASCADE,
        null=True,
    )
    day = models.DateField()
    duration = models.IntegerField(default='10')
    duration_units = models.CharField(max_length=5, default='min')
    reps = models.IntegerField(default='10')
    weight = models.IntegerField(default='10')
    weight_units = models.CharField(max_length=5, default='lbs')
    client = models.ForeignKey(
        Client, on_delete=models.CASCADE
    )
    exercises = models.ForeignKey(
        Exercises, on_delete=models.CASCADE
    )

    def __str__(self):
        return self.client.name

    def get_absolute_url(self):
        return reverse('diary_detail', args=[str(self.id)])


class Comment(models.Model):
    client = models.ForeignKey(
        Client,
        on_delete=models.CASCADE,
        related_name='comments',
    )
    day = models.DateField()
    comment = models.TextField(max_length=250)
    trainer = models.ForeignKey(
        get_user_model(),
        on_delete=models.CASCADE,
    )

    def __str__(self):
        return self.comment

    def get_absolute_url(self):
        return reverse('comment_detail', args=[str(self.id)])
