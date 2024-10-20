# Generated by Django 4.2.7 on 2024-10-20 10:51

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='Booking',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('car_make', models.CharField(max_length=255)),
                ('car_model', models.CharField(max_length=255)),
                ('car_year', models.IntegerField()),
                ('car_registration_plate', models.CharField(max_length=10, unique=True)),
                ('booking_description', models.CharField(max_length=255)),
                ('pickup_point', models.CharField(max_length=255)),
                ('appointment_date', models.DateField()),
                ('appointment_time', models.CharField(choices=[('08:01am-10:00am', '08:01am-10:00am'), ('10:01am-12:00am', '10:01am-12:00am'), ('12:01pm-02:00pm', '12:01pm-02:00pm'), ('02:01am-04:00pm', '02:01am-04:00pm'), ('04:01am-06:00pm', '04:01am-06:00pm')], max_length=50)),
                ('status', models.CharField(choices=[('Requested', 'Requested'), ('Pickup Requested', 'Pickup Requested'), ('Pending Pickup', 'Pending Pickup'), ('Pickup In Progress', 'Pickup In Progress'), ('Repair In Progress', 'Repair In Progress'), ('Pending Delivery', 'Pending Delivery'), ('Delivered', 'Delivered'), ('Canceled', 'Canceled')], max_length=50)),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('mechanic', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='booking_mechanic', to=settings.AUTH_USER_MODEL)),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='booking_user', to=settings.AUTH_USER_MODEL)),
            ],
        ),
    ]
