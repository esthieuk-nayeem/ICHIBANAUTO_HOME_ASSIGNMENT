from django.urls import path
from .views import *

urlpatterns = [
    path('bookings/', BookingAPIView.as_view(), name='booking-list'),
    path('bookings/<int:pk>/', BookingAPIView.as_view(), name='booking-detail'),
    path('search/', SearchMechanic.as_view(), name='mechanics'),
]
