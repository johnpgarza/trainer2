from django import forms
from .models import Diary, Client, Comment


class DateInput(forms.DateInput):
    input_type = 'date'


class ClientForm(forms.ModelForm):
    class Meta:
        model = Client
        fields = ('name', 'address', 'city', 'state', 'zipcode', 'email', 'cell_phone', 'trainer')


class DiaryForm(forms.ModelForm):
    class Meta:
        widgets = {'day': DateInput()}
        model = Diary
        fields = ('trainer', 'day', 'client', 'day', 'exercises', 'duration', 'duration_units', 'reps', 'weight',
                  'weight_units')


class CommentForm(forms.ModelForm):
    class Meta:
        widgets = {'day': DateInput()}
        model = Comment
        fields = ('client', 'day', 'comment', 'trainer')
