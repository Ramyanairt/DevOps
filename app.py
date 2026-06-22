from flask import Flask
import os
app = Flask(__name__)

@app.route("/")
def hello():
    return "Hello from Cloud Run!This service will be deployed using Git Hub action"

if __name__ == "__main__":
    # Cloud Run expects the container to listen on PORT (default 8080)
    import os
    port = int(os.environ.get("PORT", 8080))
    app.run(host="0.0.0.0", port=port)
