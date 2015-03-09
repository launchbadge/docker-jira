# Jira

#### Build

```
docker build -t jira:6.3.3 --rm https://github.com/launchbadge/docker-jira.git
```

#### Run

```
docker run -v /data/postgres:/var/lib/postgresql/data --restart=always -d --name postgres postgres
docker run -v /data/jira:/data --restart=always -d -p 8080:8080 --name jira --link postgres:db jira:6.3.3
```
