from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from .models import Vehicle
from .serializers import VehicleSerializer
from .pagination import VehiclePagination  # Or from rest_framework.pagination import PageNumberPagination if no custom

class VehicleListAPIView(APIView):
    def get(self, request, id=None):
        if id:  # Fetch single vehicle
            try:
                vehicle = Vehicle.objects.get(id=id)
                serializer = VehicleSerializer(vehicle)
                return Response(serializer.data)
            except Vehicle.DoesNotExist:
                return Response({'error': 'Vehicle not found.'}, status=status.HTTP_404_NOT_FOUND)
        else:  # Fetch all vehicles with pagination
            vehicles = Vehicle.objects.all()
            paginator = VehiclePagination()
            page = paginator.paginate_queryset(vehicles, request)
            serializer = VehicleSerializer(page, many=True)
            return paginator.get_paginated_response(serializer.data)