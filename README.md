# Running
Execute this commands in the repository's root directory to build and run a docker image:
```
sudo docker build -t ktor-webapplication .
sudo docker run -d -p 8080:8080 --rm ktor-webapplication
```

Execute this command to remove building image:
```
sudo docker image prune --filter label=stage=webApplicationBuilder
```

Navigate to http://localhost:8080/ to see the application home page.