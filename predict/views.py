from predict.serializers import TickerSerializer
from predict import predict
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status


class Predictor(APIView):
    """
    List all snippets, or create a new snippet.
    """

    def get(self):
        return Response("Must be a POST request", status=status.HTTP_400_BAD_REQUEST)

    def post(self, request, format=None):
        serializer = TickerSerializer(data=request.data)
        if serializer.is_valid():
            data = serializer.data
            resp = predict.run(data["tickers"])
            return Response(resp, status=status.HTTP_202_ACCEPTED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
