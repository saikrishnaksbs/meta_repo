FROM python:3.9

WORKDIR /app

# Copy all submodules into the image
COPY R1 /app/R1
COPY R2 /app/R2
COPY R3 /app/R3
COPY R4 /app/R4

# Install dependencies (modify as needed)
RUN pip install -r R1/requirements.txt
RUN pip install -r R2/requirements.txt
RUN pip install -r R3/requirements.txt || true
RUN pip install -r R4/requirements.txt || true

CMD python R1/main.py && python R2/main.py && python R3/main.py && python R4/main.py
