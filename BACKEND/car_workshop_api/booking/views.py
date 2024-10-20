from django.shortcuts import render
from rest_framework import viewsets, permissions
from rest_framework.views import APIView
from rest_framework.authentication import TokenAuthentication
from rest_framework.response import Response
from rest_framework import status,filters
from django.shortcuts import get_object_or_404
from .permissions import *

from authentication.models import User
from .models import Booking
from .serializers import BookingSerializer
from authentication.serializers import UserViewSerializer

 

class BookingAPIView(APIView):
    authentication_classes = [TokenAuthentication]
    permission_classes = [permissions.IsAuthenticated, IsAdminPermission]

    def get(self, request, pk=None):
        if pk:
            booking = get_object_or_404(Booking, pk=pk)
            serializer = BookingSerializer(booking)
            return Response(serializer.data)
        
        user = request.user
        if user.is_staff:
            queryset = Booking.objects.all()
        elif user.groups.filter(name="mechanic").exists():
            queryset = Booking.objects.filter(mechanic=user)
        else:
            queryset = Booking.objects.filter(user=user)
        
        serializer = BookingSerializer(queryset, many=True)
        return Response(serializer.data)

    def post(self, request):
        serializer = BookingSerializer(data=request.data, context={'request': request})
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    def put(self, request, pk):
        booking = get_object_or_404(Booking, pk=pk)
        serializer = BookingSerializer(booking, data=request.data, context={'request': request})
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    def patch(self, request, pk):
        booking = get_object_or_404(Booking, pk=pk)
        serializer = BookingSerializer(booking, data=request.data, partial=True, context={'request': request})
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    def delete(self, request, pk):
        booking = get_object_or_404(Booking, pk=pk)
        booking.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)





class SearchMechanic(APIView):
    authentication_classes = [TokenAuthentication]
    permission_classes = [permissions.IsAuthenticated, IsAdminPermission]
    filter_backends = [filters.SearchFilter]
    search_fields = ['phone', 'full_name', 'email']  

    def get(self, request):
        
        mechanics = User.objects.filter(groups__id=3)
        query = request.query_params.get('search', None)
        if query is not None:
            all_mechanics = mechanics.filter(phone__icontains=query) | mechanics.filter(full_name__icontains=query) | mechanics.filter(email__icontains=query)
       

        serializer = UserViewSerializer(all_mechanics, many=True)
        data = serializer.data

        return Response(data)
    



class AddMechanicToBooking(APIView):
    authentication_classes = [TokenAuthentication]
    permission_classes = [permissions.IsAuthenticated, IsAdminPermission]

    def patch(self, request):
        data = request.data
        user_id = data.get("id")
        booking_id = data.get("booking_id")

        try:
            user = User.objects.get(id=user_id)
            booking = Booking.objects.get(id=booking_id)
            booking.mechanic = user
            booking.save()
            return Response({"message": f"Mechanic with id {user_id} added to booking {booking_id}"}, status=status.HTTP_200_OK)
        except User.DoesNotExist:
            return Response({"error": f"Mechanic with id {user_id} does not exist"}, status=status.HTTP_404_NOT_FOUND)
        except Booking.DoesNotExist:
            return Response({"error": f"Booking with id {booking_id} does not exist"}, status=status.HTTP_404_NOT_FOUND)



class RemoveMechanicFromBooking(APIView):
    authentication_classes = [TokenAuthentication]
    permission_classes = [permissions.IsAuthenticated, IsAdminPermission]

    def patch(self, request):
        data = request.data
        user_id = data.get("id")
        booking_id = data.get("booking_id")

        try:
            user = User.objects.get(id=user_id)
            booking = Booking.objects.get(id=booking_id)
            if booking.mechanic == user:
                booking.mechanic = None
                booking.save()
                return Response({"message": f"Mechanic with id {user_id} removed from booking {booking_id}"}, status=status.HTTP_200_OK)
            else:
                return Response({"error": f"Mechanic with id {user_id} is not assigned to booking {booking_id}"}, status=status.HTTP_404_NOT_FOUND)
        except User.DoesNotExist:
            return Response({"error": f"Mechanic with id {user_id} does not exist"}, status=status.HTTP_404_NOT_FOUND)
        except Booking.DoesNotExist:
            return Response({"error": f"Booking with id {booking_id} does not exist"}, status=status.HTTP_404_NOT_FOUND)
