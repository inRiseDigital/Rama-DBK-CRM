from rest_framework.pagination import PageNumberPagination

class StockPartPagination(PageNumberPagination):
    page_size = 10  # You can adjust this value
    page_size_query_param = 'page_size'
    max_page_size = 100