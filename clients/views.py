from django.views.generic import ListView
from django.shortcuts import get_object_or_404
from .models import Client


class ClientListView(ListView):
    model = Client
    template_name = 'client_list.html'
