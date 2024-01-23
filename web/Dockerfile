FROM python:3.9-slim
RUN apt-get update && apt-get install -y libpq-dev build-essential
COPY . /app
WORKDIR /app
COPY requirements.txt .
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt
ENV FLASK_APP=server
ENV FLASK_DEBUG=1
CMD [ "flask", "run","--host","0.0.0.0","--port","5123"]
