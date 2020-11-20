# Running
Execute this commands in the repository's root directory to build and remove unnecessary building image:
```
sudo docker build -t ktor-webapplication .
sudo docker image prune --filter label=stage=webApplicationBuilder
```

Execute this command to run a docker image:
```
sudo docker run -d -p 8080:8080 --rm ktor-webapplication
```

Navigate to http://localhost:8080/ to see the application home page.
