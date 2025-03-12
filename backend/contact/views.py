from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from .serializers import ContactMessageSerializer, RequestCallBackSerializer, CarInquirySerializer
from rest_framework import generics
from .models import RequestCallBack, CarInquiry

class ContactMessageCreateView(APIView):
    def post(self, request, format=None):
        serializer = ContactMessageSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response({"message": "Message sent successfully!"}, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
    
    
class RequestCallBackCreateAPIView(generics.CreateAPIView):
    queryset = RequestCallBack.objects.all()
    serializer_class = RequestCallBackSerializer


class CarInquiryCreateAPIView(generics.CreateAPIView):
    queryset = CarInquiry.objects.all()
    serializer_class = CarInquirySerializer