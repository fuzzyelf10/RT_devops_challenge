import json
import os

from flask import Flask
from flask import request
app = Flask(__name__)

#RESPONSE = os.environ["RESPONSE"]

@app.route("/status")
def root():
	ret = {
		'result': 'success'
	}

	return json.dumps(ret)

if __name__ == "__main__":
	app.run(host='0.0.0.0')