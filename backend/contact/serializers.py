from rest_framework import serializers
from .models import ContactMessage, RequestCallBack, CarInquiry


class ContactMessageSerializer(serializers.ModelSerializer):
    class Meta:
        model = ContactMessage
        fields = ['id', 'name', 'email', 'subject', 'message', 'country', 'phone', 'created_at']
        read_only_fields = ['id', 'created_at']



class RequestCallBackSerializer(serializers.ModelSerializer):
    class Meta:
        model = RequestCallBack
        fields = '__all__'

    def validate(self, data):
        if not data.get('contact_number'):
            raise serializers.ValidationError("Contact number is required.")
        if not data.get('country'):
            raise serializers.ValidationError("Country is required.")
        if not data.get('name'):
            raise serializers.ValidationError("Name is required.")
        return data
    
    
class CarInquirySerializer(serializers.ModelSerializer):
    class Meta:
        model = CarInquiry
        fields = '__all__'