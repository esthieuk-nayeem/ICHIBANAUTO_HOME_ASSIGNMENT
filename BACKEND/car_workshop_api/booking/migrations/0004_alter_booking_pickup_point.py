# Generated by Django 5.1.2 on 2024-10-24 09:27

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('booking', '0003_alter_booking_car_registration_plate'),
    ]

    operations = [
        migrations.AlterField(
            model_name='booking',
            name='pickup_point',
            field=models.CharField(max_length=255, null=True),
        ),
    ]
