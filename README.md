# Running
Execute this commands in the repository's root directory to build and run a docker image:
```bash
docker build -t ktor-webapplication .
docker run -p 8080:8080 --rm ktor-webapplication
```