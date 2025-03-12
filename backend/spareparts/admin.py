from django.contrib import admin
from .models import SparePartOrder, StockPart

# Register your models here.

admin.site.register(SparePartOrder)
admin.site.register(StockPart)
