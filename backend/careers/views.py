from rest_framework import generics
from .models import Career
from .serializers import CareerSerializer

class CareerCreateAPIView(generics.CreateAPIView):
    queryset = Career.objects.all()
    serializer_class = CareerSerializer
