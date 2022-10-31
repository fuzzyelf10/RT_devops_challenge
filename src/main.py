import json
import os
import re

from flask import Flask
from flask import request
from urllib.request import urlopen
app = Flask(__name__)

#RESPONSE = os.environ["RESPONSE"]

@app.route("/status")
def root():
	ret = {
		'result': 'success'
	}

	return json.dumps(ret)

@app.route("/ip")
def get_ip_info():
    
    url = 'http://ipinfo.io/json'
    response = urlopen(url)
    data = json.load(response)
    
    ret = {
		'ip': data['ip'],
		'city' : data['city'],
		'state' : data['region']
	}
    
    return json.dumps(ret)

if __name__ == "__main__":
	app.run(host='0.0.0.0')