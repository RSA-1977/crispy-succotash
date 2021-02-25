from flask import Flask, redirect, url_for, render_template
from assets.serverUp import serverUp
from assets.servers.server1 import backupServer
from assets.servers.server2 import machineLearning
from assets.servers.server3 import raspberryPi

app = Flask(__name__)

@app.route("/")
def home():
    return render_template("index.html", backup=backupServer(), 
    machine=machineLearning(), raspberry=raspberryPi())

if __name__ == "__main__":
    app.run()

