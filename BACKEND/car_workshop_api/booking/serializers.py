from rest_framework import serializers
from .models import Booking
from authentication.serializers import UserViewSerializer

class BookingSerializer(serializers.ModelSerializer):
    user = UserViewSerializer(read_only=True)
    mechanic = UserViewSerializer(read_only=True)

    class Meta:
        model = Booking
        fields = '__all__'
        read_only_fields = ('id', 'created_at')

    def create(self, validated_data):
        user = self.context['request'].user
        validated_data['user'] = user
        validated_data['status'] = 'Requested'
        return super().create(validated_data)

