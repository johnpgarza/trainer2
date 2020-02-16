from django.urls import path
from .views import (
    ClientListView,
    ClientUpdateView,
    ClientDetailView,
    ClientDeleteView,
    ClientCreateView,
    DiaryListView,
    DiaryDetailView,
    DiaryUpdateView,
    DiaryDeleteView,
    DiaryCreateView,
    CommentCreateView,
    CommentListView,
)

urlpatterns = [

    path('', ClientListView.as_view(), name='client_list'),
    path('<int:pk>/edit/', ClientUpdateView.as_view(), name='client_edit'),
    path('<int:pk>/', ClientDetailView.as_view(), name='client_detail'),
    path('<int:pk>/delete/', ClientDeleteView.as_view(), name='client_delete'),
    path('new_client/', ClientCreateView.as_view(), name='client_new'),
    path('diary_list', DiaryListView.as_view(), name='diary_list'),
    path('detail/<int:pk>/', DiaryDetailView.as_view(), name='diary_detail'),
    path('diary_edit/<int:pk>', DiaryUpdateView.as_view(), name='diary_edit'),
    path('diary_delete/<int:pk>', DiaryDeleteView.as_view(), name='diary_delete'),
    path('diary_new/', DiaryCreateView.as_view(), name='diary_new'),
    path('new_comment/', CommentCreateView.as_view(), name='new_comment'),
    path('comment_list', CommentListView.as_view(), name='comment_list'),

]
