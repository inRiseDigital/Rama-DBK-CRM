from django.urls import path
from .views import ContactMessageCreateView, RequestCallBackCreateAPIView, CarInquiryCreateAPIView


urlpatterns = [
    path('api/contact/', ContactMessageCreateView.as_view(), name='contact-message-create'),
    path('api/request-callback/', RequestCallBackCreateAPIView.as_view(), name='request-callback'),
    path('api/car-inquiry/create/', CarInquiryCreateAPIView.as_view(), name='car-inquiry-create'),

]