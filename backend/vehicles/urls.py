from django.urls import path
from .views import VehicleListAPIView

urlpatterns = [
    path('api/vehicles/', VehicleListAPIView.as_view(), name='vehicle-list'),
    path('api/vehicle/<int:id>/', VehicleListAPIView.as_view(), name='vehicle-detail'),
]