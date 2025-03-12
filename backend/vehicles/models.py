from django.db import models

class Vehicle(models.Model):
    stock_no = models.CharField(max_length=20, unique=True)
    make = models.CharField(max_length=100)
    model = models.CharField(max_length=100)
    reg_year = models.CharField(max_length=20)  
    type = models.CharField(max_length=50)
    body_type = models.CharField(max_length=50)
    grade = models.CharField(max_length=100)
    chassis = models.CharField(max_length=100)
    mileage = models.PositiveIntegerField(help_text="Mileage in km")
    engine_capacity = models.PositiveIntegerField(help_text="Engine capacity in cc")
    transmission = models.CharField(max_length=50)
    fuel = models.CharField(max_length=50)
    steering = models.CharField(max_length=50)
    model_no = models.CharField(max_length=100)
    drive = models.CharField(max_length=10)
    seats = models.PositiveIntegerField()
    doors = models.PositiveIntegerField()
    engine_model = models.CharField(max_length=100)
    color = models.CharField(max_length=50)
    location = models.CharField(max_length=100)
    m3_size = models.FloatField(help_text="Cubic meter size")
    length_cm = models.PositiveIntegerField(help_text="Length in cm")
    width_cm = models.PositiveIntegerField(help_text="Width in cm")
    height_cm = models.PositiveIntegerField(help_text="Height in cm")
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f"{self.make} {self.model} ({self.stock_no})"
