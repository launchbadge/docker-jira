# Jira

## Build

```
docker build -t jira:6.3.3 --rm .
```

## Run

```
docker run --restart=always -d --name postgres postgres
docker run --restart=always -d -p 8080:8080 --name jira --link postgres:db jira:6.3.3
```
