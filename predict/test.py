import requests
import matplotlib
matplotlib.use('TkAgg')
import matplotlib.pyplot as plt


her = requests.post("https://polar-inlet-88029.herokuapp.com/predict/", json={"tickers": 'fb'})
#res = requests.post("http://127.0.0.1:8000/predict/", json={"tickers": 'fb'})

#print(res.text)

print(her.text)




