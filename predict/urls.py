from django.urls import path
from predict.views import Predictor

urlpatterns = [
    path('predict/', Predictor.as_view()),
]
