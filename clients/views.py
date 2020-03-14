from django.contrib.auth.decorators import login_required
from django.contrib.auth.mixins import LoginRequiredMixin
from django.utils import timezone
from django.views.generic.edit import UpdateView, DeleteView, CreateView
from django.views.generic import ListView, DetailView
from django.shortcuts import render, get_object_or_404
from .forms import *
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


@login_required(login_url='/trainers/login/')
def client_new(request):
    if request.method == "POST":
        form = ClientForm(request.POST)
        if form.is_valid():
            client = form.save(commit=False)
            client.created_date = timezone.now()
            client.save()
            return render(request, '../templates/client_list.html', {'client': client})

    else:
        form = ClientForm()
    return render(request, '../templates/client_new.html', {'form': form})


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


@login_required(login_url='/trainers/login/')
def diary_new(request):
    if request.method == "POST":
        form = DiaryForm(request.POST)
        if form.is_valid():
            diary = form.save(commit=False)
            diary.created_date = timezone.now()
            diary.save()
            return render(request, '../templates/diary_list.html', {'diary': diary})

    else:
        form = DiaryForm()
    return render(request, '../templates/diary_new.html', {'form': form})


# class CommentCreateView(LoginRequiredMixin, CreateView):
#    model = Comment
#    fields = ('client', 'day', 'comment', 'trainer')
#    template_name = 'client_new_comment.html'
#    success_url = reverse_lazy('comment_list')
#    login_url = 'login'

#    def form_valid(self, form):
#        form.instance.author = self.request.user
#        return super().form_valid(form)

def comment_new(request):
    if request.method == "POST":
        form = CommentForm(request.POST)
        if form.is_valid():
            comment = form.save(commit=False)
            comment.created_date = timezone.now()
            comment.save()
            return render(request, '../templates/comment_list.html', {'comment': comment})

    else:
        form = CommentForm()
    return render(request, '../templates/comment_new.html', {'form': form})


class CommentListView(LoginRequiredMixin, ListView):
    model = Comment
    template_name = 'comment_list.html'

    def get_queryset(self):
        return Comment.objects.filter(trainer=self.request.user)

    login_url = 'login'
