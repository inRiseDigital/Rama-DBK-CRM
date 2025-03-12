from rest_framework.pagination import PageNumberPagination

class VehiclePagination(PageNumberPagination):
    page_size = 10  # Default number of records per page
    page_size_query_param = 'page_size'  # Allow client to set page size
    max_page_size = 100  # Max page size limit
