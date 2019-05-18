from django.db import models


class Tickers(models.Model):
    tickers = models.TextField()
