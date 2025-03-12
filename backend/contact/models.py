from django.db import models

class ContactMessage(models.Model):
    name = models.CharField(max_length=100, verbose_name="Name", help_text="Please enter your name")
    email = models.EmailField(verbose_name="Email", help_text="Please enter your email")
    subject = models.CharField(max_length=200, verbose_name="Subject", help_text="Please enter subject")
    message = models.TextField(verbose_name="Message", help_text="Please enter your message")
    country = models.CharField(max_length=100, verbose_name="Country", help_text="Please enter your country")
    phone = models.CharField(max_length=20, verbose_name="Phone", blank=True, null=True)  # Optional field

    created_at = models.DateTimeField(auto_now_add=True)  # To store submission time

    def __str__(self):
        return f"Message from {self.name} - {self.subject}"


class RequestCallBack(models.Model):
    name = models.CharField(max_length=255)
    country = models.CharField(max_length=100)
    country_code = models.CharField(max_length=10, blank=True, null=True)
    area_code = models.CharField(max_length=10, blank=True, null=True)
    contact_number = models.CharField(max_length=20)
    email = models.EmailField(blank=True, null=True)
    remark = models.TextField(max_length=250, blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.name} ({self.contact_number})"
    
    
    
    
# models.py
from django.db import models

class CarInquiry(models.Model):
    make = models.CharField(max_length=100)
    model = models.CharField(max_length=100)
    transmission = models.CharField(max_length=50)
    reg_year_from = models.PositiveIntegerField()
    reg_year_to = models.PositiveIntegerField()
    more_option = models.TextField(blank=True, null=True)
    name = models.CharField(max_length=100)
    country = models.CharField(max_length=100)
    tel_mobile = models.CharField(max_length=20)
    email = models.EmailField()
    i_am = models.CharField(max_length=20)

    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.name} - {self.make} {self.model}"
