from fbprophet import Prophet

# Build function that creates Prophet model
def prophet_train(data):
    """
    Creates a forecast based on the inputted zipcode.
    1. Filters the zipcode from the train set
    2. Builds the model
    3. Runs the model
    4. Creates a list of the next 12 months and produces a forecast for said months
    5. Appends zipcode for identification
    """   
    model = Prophet(interval_width=.95, changepoint_prior_scale=6, yearly_seasonality=True, 
             seasonality_prior_scale=1, weekly_seasonality=False, daily_seasonality=False)
    model.add_seasonality(name='monthly', period=120, fourier_order=4)
    
    model.fit(data)
    
    future_dates = model.make_future_dataframe(periods=12, freq='MS')
    forecast = model.predict(future_dates)
    forecast = forecast[['ds', 'yhat', 'yhat_lower', 'yhat_upper']]
    results = forecast[forecast['ds']>='2018-01-01']
    return(results)