#!flask/bin/python
from flask import Flask, jsonify
import pandas as pd
from flask_caching import Cache
import sys
import requests
import json
from flask_cors import CORS

app = Flask(__name__)
cache = Cache(app,config={'CACHE_TYPE': 'simple'})
CORS(app)

lastValue = None

def getPage():

    url = "https://www.worldometers.info/coronavirus/"

    header = {
    "User-Agent": "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.75 Safari/537.36",
    "X-Requested-With": "XMLHttpRequest"
    }

    r = requests.get(url, headers=header)
    return r.text



# @cache.cached(timeout=500)
def getData():
    global lastValue
    pageData = getPage()
    tables = pd.read_html(pageData)
    data = tables[0]
    data = data.fillna(0)
    print (data)
    entries = data.values.tolist()
    result = []
    total = {}
    for i,item in enumerate(entries) :
        
        dict_obj = {
            "name" : item[0],   
            "totalCases": str( int(item[1])),
            "newCases" : str( int(item[2])),
            "totalDeaths" :str( int(item[3]) ),
            "newDeaths" : str(int(item[4])),
            "recovered" : str(int(item[5])),
            "active" : str(int(item[6])),
            "serious" : str(int(item[7]))
        }
        if i==(len(entries)-1) :
            total = dict_obj
        else:
            result.append(dict_obj)
    lastValue = result
    return { "all" :  result, "total":total}
    
   
    
@app.route('/all')
def index():
    data = getData()
    return json.dumps(data) , 201

if __name__ == '__main__':
    app.run(debug=True)