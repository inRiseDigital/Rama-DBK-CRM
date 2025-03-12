from django.urls import path
from .views import SparePartOrderCreateAPIView, StockPartListAPIView

urlpatterns = [
    path('api/spare-part-order/', SparePartOrderCreateAPIView.as_view(), name='spare-part-order-create'),
    path('api/spare-parts/', StockPartListAPIView.as_view(), name='spare-part-list'), 
    path('api/spare-parts/<int:id>/', StockPartListAPIView.as_view(), name='spare-part-detail'),  
]
