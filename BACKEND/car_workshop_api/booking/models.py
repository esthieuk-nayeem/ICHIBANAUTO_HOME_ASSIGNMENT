from django.db import models
from authentication.models import User
# Create your models here.
    

statuses = [('Requested', 'Requested'),('Pickup Requested', 'Pickup Requested'), ('Pending Pickup', 'Pending Pickup'), ('Pickup In Progress', 'Pickup In Progress'), ('Repair In Progress', 'Repair In Progress'), ('Pending Delivery', 'Pending Delivery'), ('Delivered', 'Delivered'), ('Canceled', 'Canceled')]
time_slots = [('08:01am-10:00am', '08:01am-10:00am'), ('10:01am-12:00am', '10:01am-12:00am'), ('12:01pm-02:00pm', '12:01pm-02:00pm'), ('02:01am-04:00pm', '02:01am-04:00pm'), ('04:01am-06:00pm', '04:01am-06:00pm')]

class Booking(models.Model):
    car_make = models.CharField(max_length=255)
    car_model = models.CharField(max_length=255)
    car_year = models.IntegerField()
    car_registration_plate = models.CharField(max_length=50)
    booking_description = models.CharField(max_length=255)
    pickup_point = models.CharField(max_length=255,null=True)
    appointment_date = models.DateField()
    appointment_time = models.CharField(max_length=50, choices=time_slots)
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='booking_user')
    mechanic = models.ForeignKey(User, on_delete=models.CASCADE, related_name='booking_mechanic', null=True)
    status = models.CharField(max_length=50, choices=statuses)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.user.full_name}'s booking for {self.car_registration_plate} on {self.appointment_date} at {self.appointment_time}"

