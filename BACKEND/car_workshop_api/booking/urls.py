from django.urls import path
from .views import *

urlpatterns = [
    path('bookings/', BookingAPIView.as_view(), name='booking-list'),
    path('bookings/<int:pk>/', BookingAPIView.as_view(), name='booking-detail'),
    path('search/', SearchMechanic.as_view(), name='mechanics'),
    path('assignmechanic/', AddMechanicToBooking.as_view(), name='assign_mechanic'),
    path('removemechanic/', RemoveMechanicFromBooking.as_view(), name='remove_mechanic'),
    path('data/', BookingDataAPIView.as_view(), name='data'),
]
