FROM python:3.9

WORKDIR /app

# Copy all submodules into the image
COPY repo1 /app/repo1
COPY repo2 /app/repo2
COPY repo3 /app/repo3
COPY repo4 /app/repo4
COPY repo5 /app/repo5

# Install dependencies (modify as needed)
RUN pip install -r repo1/requirements.txt
RUN pip install -r repo2/requirements.txt

CMD ["python", "repo1/main.py"]