from django.db import models

class SparePartOrder(models.Model):
    CONDITION_CHOICES = [
        ('New', 'New'),
        ('Used', 'Used')
    ]
    
    SHIPPING_CHOICES = [
        ('Any', 'Any'),
        ('DHL', 'by DHL'),
        ('OCS', 'by OCS'),
        ('EMS', 'by EMS'),
        ('IN-CAR', 'IN-CAR')
    ]
    
    name = models.CharField(max_length=255)
    email = models.EmailField()
    country = models.CharField(max_length=100)
    phone_mobile = models.CharField(max_length=50)
    maker = models.CharField(max_length=100, blank=True, null=True)
    model = models.CharField(max_length=100, blank=True, null=True)
    chassis_no = models.CharField(max_length=100, blank=True, null=True)
    year = models.CharField(max_length=50, blank=True, null=True)
    engine_model = models.CharField(max_length=100, blank=True, null=True)
    bought_from_rama = models.BooleanField(default=False)
    has_japanese_registration = models.BooleanField(default=False)
    attachment_1 = models.FileField(upload_to='attachments/', blank=True, null=True)
    attachment_2 = models.FileField(upload_to='attachments/', blank=True, null=True)
    condition_of_part = models.CharField(max_length=10, choices=CONDITION_CHOICES)
    more_details = models.TextField()
    shipping = models.CharField(max_length=10, choices=SHIPPING_CHOICES, default='Any')
    in_car_code_chassis = models.CharField(max_length=100, blank=True, null=True)
    sales_person = models.CharField(max_length=100, blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Order by {self.name} ({self.email})"
    
    
from django.db import models

class StockPart(models.Model):
    stock_number = models.CharField(max_length=50, unique=True, verbose_name="Stock Number")
    part_name = models.CharField(max_length=255, verbose_name="Part Name")
    description = models.TextField(blank=True, null=True, verbose_name="Description")
    created_at = models.DateTimeField(auto_now_add=True, verbose_name="Created At")
    updated_at = models.DateTimeField(auto_now=True, verbose_name="Updated At")

    def __str__(self):
        return f"{self.stock_number} - {self.part_name}"

