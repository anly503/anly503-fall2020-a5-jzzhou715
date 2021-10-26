#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Oct 25 16:32:43 2021

@author: Zhou
"""

import pandas as pd
import plotly.express as px

import plotly.io as pio
pio.renderers.default='browser'

data = pd.read_csv('tablet.csv')

data = data.iloc[: , 1:]

data.date = pd.to_datetime(data.Date)


fig = px.bar(data, x = "Date", y=["Low", "Medium", "High"],
             title="Tablet Energy Consumption",
             labels=dict(value = "Energy Consumption", variable = ''))
fig.update_layout(
    xaxis=dict(
        rangeselector=dict(
            buttons=list([
                dict(count=1,
                     label="1m",
                     step="month",
                     stepmode="backward"),
                dict(count=6,
                     label="6m",
                     step="month",
                     stepmode="backward"),
                dict(count=1,
                     label="YTD",
                     step="year",
                     stepmode="todate"),
                dict(count=1,
                     label="1y",
                     step="year",
                     stepmode="backward"),
                dict(step="all")
            ])
        ),
        rangeslider=dict(
            visible=True
        ),
        type="date"
    )
)


fig.show()

fig.write_html("viz_1.html")
