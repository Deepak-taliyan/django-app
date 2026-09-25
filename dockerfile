from python:3.12 as builder
workdir app/
copy requirements.txt ./
run pip install -r requirements.txt

# stage 2
from python:3.12-slim
workdir app/
copy --from=builder /usr/local/lib/python3.12/site-packages/ /usr/local/lib/python3.12/site-packages/
COPY --from=builder /usr/local/bin/ /usr/local/bin/
copy . .



cmd ["gunicorn","-b","0.0.0.0:8000","todoApp.wsgi:application"]
