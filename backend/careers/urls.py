from django.urls import path
from .views import CareerCreateAPIView

urlpatterns = [
    path('api/career/', CareerCreateAPIView.as_view(), name='career-create'),
]