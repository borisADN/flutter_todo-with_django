from rest_framework.routers import DefaultRouter
import todo.views as views
from django.urls import path, include

router = DefaultRouter()
router.register(r'tasks', views.TaskViewSet)

urlpatterns = [
    path('', include(router.urls)),
]