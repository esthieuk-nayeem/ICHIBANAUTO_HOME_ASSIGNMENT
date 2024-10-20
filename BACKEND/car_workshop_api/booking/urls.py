from django.urls import path
from .views import BookingAPIView

urlpatterns = [
    path('bookings/', BookingAPIView.as_view(), name='booking-list'),
    path('bookings/<int:pk>/', BookingAPIView.as_view(), name='booking-detail'),
]
