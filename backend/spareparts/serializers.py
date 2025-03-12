from rest_framework import serializers
from .models import SparePartOrder, StockPart

class SparePartOrderSerializer(serializers.ModelSerializer):
    class Meta:
        model = SparePartOrder
        fields = '__all__'  
        

class StockPartSerializer(serializers.ModelSerializer):
    class Meta:
        model = StockPart
        fields = ['id', 'stock_number', 'part_name', 'description', 'created_at', 'updated_at']
