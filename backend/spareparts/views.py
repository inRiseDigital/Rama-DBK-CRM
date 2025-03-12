from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from .models import SparePartOrder, StockPart
from .serializers import SparePartOrderSerializer, StockPartSerializer
from .pagination import StockPartPagination

class SparePartOrderCreateAPIView(APIView):
    def post(self, request):
        serializer = SparePartOrderSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    

class StockPartListAPIView(APIView):
    def get(self, request, id=None):
        if id: 
            try:
                spare_part = StockPart.objects.get(id=id)
                serializer = StockPartSerializer(spare_part)
                return Response(serializer.data, status=status.HTTP_200_OK)
            except StockPart.DoesNotExist:
                return Response({'error': 'Spare part not found.'}, status=status.HTTP_404_NOT_FOUND)
        else:  
            spare_parts = StockPart.objects.all().order_by('-created_at')
            paginator = StockPartPagination()
            page = paginator.paginate_queryset(spare_parts, request)
            serializer = StockPartSerializer(page, many=True)
            return paginator.get_paginated_response(serializer.data)

