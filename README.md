# Running
Execute this commands in the repository's root directory to build and run a docker image:
```
docker build -t ktor-webapplication .
docker run -p 8080:8080 --rm ktor-webapplication
```
And navigate to http://localhost:8080/ to see the application home page.

Execute this command to remove building image
```
docker image prune --filter label=stage=webApplicationBuilder
```