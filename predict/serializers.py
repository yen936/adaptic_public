from rest_framework import serializers


class TickerSerializer(serializers.Serializer):
    tickers = serializers.CharField(max_length=10000)
