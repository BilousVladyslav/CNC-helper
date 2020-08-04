from rest_framework.pagination import PageNumberPagination


class LogsPageNumberPagination(PageNumberPagination):
    page_size = 80
    page_size_query_param = 'page_size'
    max_page_size = 1000


class MachinesPageNumberPagination(PageNumberPagination):
    page_size = 100
    page_size_query_param = 'page_size'
    max_page_size = 1000
