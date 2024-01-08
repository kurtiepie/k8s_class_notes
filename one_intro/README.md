# One

## Intro

We have an application named "headers"
that will runs in a kind kubernetes cluster

This is a bare bones example that we will build on.

## Start Kind Server / Build / Deploy test app

Write a program that will:

- make help
- bash localReg.sh
- docker build . -t localhost:5001/headers:0.1
- docker push localhost:5001/headers:0.1
- helm install header ./headerschart/


## Test
```
curl -H 'Host: headers.local' localhost
X-Forwarded-Proto: [http]
X-Scheme: [http]
Accept: [*/*]
X-Forwarded-For: [172.19.0.1]
X-Forwarded-Host: [headers.local]
X-Real-Ip: [172.19.0.1]
X-Forwarded-Port: [80]
X-Forwarded-Scheme: [http]
User-Agent: [curl/7.64.1]
X-Request-Id: [6b56eb8c75ccb3793819cef6c843e6ae]
```

## Now lets enable image gates with 
  
- docker scan
- trivy image

## Scan IAC configfiles with Trivy before depoying

