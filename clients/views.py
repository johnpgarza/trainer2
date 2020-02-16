from django.contrib.auth.mixins import LoginRequiredMixin
from django.views.generic.edit import UpdateView, DeleteView, CreateView
from django.views.generic import ListView, DetailView
from django.shortcuts import get_object_or_404
from .models import Client, Comment, Diary
from django.urls import reverse_lazy


class ClientListView(LoginRequiredMixin, ListView):
    model = Client
    template_name = 'client_list.html'

    def get_queryset(self):
        return Client.objects.filter(trainer=self.request.user)

    login_url = 'login'


class ClientDetailView(LoginRequiredMixin, DetailView):
    model = Client
    template_name = 'client_detail.html'
    login_url = 'login'


class ClientUpdateView(LoginRequiredMixin, UpdateView):
    model = Client
    fields = ('name', 'address', 'city', 'state', 'zipcode', 'email', 'cell_phone', 'acct_number', 'trainer')
    template_name = 'client_edit.html'
    login_url = 'login'


class ClientDeleteView(LoginRequiredMixin, DeleteView):
    model = Client
    template_name = 'client_delete.html'
    success_url = reverse_lazy('client_list')
    login_url = 'login'


class ClientCreateView(LoginRequiredMixin, CreateView):
    model = Client
    template_name = 'client_new.html'
    fields = ('name', 'address', 'city', 'state', 'zipcode', 'email', 'cell_phone', 'acct_number', 'trainer')
    login_url = 'login'

    def form_valid(self, form):
        form.instance.author = self.request.user
        return super().form_valid(form)


class DiaryListView(LoginRequiredMixin, ListView):
    model = Diary
    template_name = 'diary_list.html'

    def get_queryset(self):
        return Diary.objects.filter(trainer=self.request.user)

    login_url = 'login'


class DiaryDetailView(LoginRequiredMixin, DetailView):
    model = Diary
    template_name = 'diary_detail.html'
    login_url = 'login'


class DiaryUpdateView(LoginRequiredMixin, UpdateView):
    model = Diary
    fields = ('trainer', 'client', 'day', 'exercises', 'duration', 'duration_units', 'reps', 'weight', 'weight_units')
    template_name = 'diary_edit.html'
    login_url = 'login'


class DiaryDeleteView(LoginRequiredMixin, DeleteView):
    model = Diary
    template_name = 'diary_delete.html'
    success_url = reverse_lazy('diary_list')
    login_url = 'login'


class DiaryCreateView(LoginRequiredMixin, CreateView):
    model = Diary
    fields = ('trainer', 'client', 'day', 'exercises', 'duration', 'duration_units', 'reps', 'weight', 'weight_units')
    template_name = 'diary_new.html'
    login_url = 'login'

    def form_valid(self, form):
        form.instance.author = self.request.user
        return super().form_valid(form)


class CommentCreateView(LoginRequiredMixin, CreateView):
    model = Comment
    fields = ('client', 'day', 'comment', 'trainer')
    template_name = 'client_new_comment.html'
    success_url = reverse_lazy('comment_list')
    login_url = 'login'

    def form_valid(self, form):
        form.instance.author = self.request.user
        return super().form_valid(form)


class CommentListView(LoginRequiredMixin, ListView):
    model = Comment
    template_name = 'comment_list.html'

    def get_queryset(self):
        return Comment.objects.filter(trainer=self.request.user)

    login_url = 'login'
