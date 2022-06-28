# SPBU-Homework-3
Here you can find the solution to problem from 3 semester.

## Navigation menu
* [Semester №1](https://github.com/GirZ0n/SPBU-Homework-1) 
* [Semester №2](https://github.com/GirZ0n/SPBU-Homework-2) 
* [Semester №3](https://github.com/GirZ0n/SPBU-Homework-3) 
* [Semester №4](https://github.com/GirZ0n/SPBU-Homework-4) 

## Running
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
