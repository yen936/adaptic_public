import numpy as np
from datetime import datetime
import datetime
import os
from sklearn.linear_model import LinearRegression
from sklearn import preprocessing, model_selection
from iexfinance.stocks import get_historical_data

year_3_ago = datetime.datetime.now().year - 2
this_year = datetime.datetime.now().year
month = datetime.datetime.now().month - 3


def predict_data(stock, days):
    start = datetime.datetime(this_year, 1, 1)
    end = datetime.datetime.now()

    # Setting data frame equal to fetched data
    df = get_historical_data(stock, start=start, end=end, output_format='pandas')
    df['prediction'] = df['close'].shift(-1)
    df.dropna(inplace=True)
    forecast_time = int(days)

    X = np.array(df.drop(['prediction'], 1))
    Y = np.array(df['prediction'])
    X = preprocessing.scale(X)
    X_prediction = X[-forecast_time:]
    X_train, X_test, Y_train, Y_test = model_selection.train_test_split(X, Y, test_size=0.5)

    # Performing the Regression on the training data
    clf = LinearRegression()
    clf.fit(X_train, Y_train)
    prediction = (clf.predict(X_prediction))

    result = np.ndarray.tolist(prediction)
    return result


# Using the stock list to predict the future price of the stock a specificed amount of days
def run(stock_list):
    try:
        result = predict_data(stock_list, 30)
    except:
        print("Stock: " + stock_list + " was not predicted")
    return result


# result = run(['aapl'])
# print(result)
