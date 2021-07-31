## Run on local machine
#### Using docker
Both action server and rasa-core runs as separate processes in the same container.

```
sudo docker build -t personal-chatbot .
sudo docker run -it --rm -p 5005:5005 personal-chatbot
```

It starts a webserver with rest api and listens for messages at localhost:5006

#### Test over REST api

```bash
curl --request POST \
  --url http://localhost:5005/webhooks/rest/webhook \
  --header 'content-type: application/json' \
  --data '{
    "message": "Hello"
  }'
```
**Response**
```http
HTTP/1.1 200 OK
Content-Type: application/json
Content-Length: 59
Access-Control-Allow-Origin: *

[{
  "recipient_id": "default",
  "text": "Hi, how is it going?"
}]
```

# Deploy on Heroku for testing

```
heroku login

```
For free tier heroku deployment, we have to run both rasa server and custom action server in a same container.
So, pushing project as a docker container:
```
sudo heroku container:login
sudo heroku container:push -a <heroku app name> web
```
```
sudo heroku container:release -a <heroku app name> web
```

https://*******.herokuapp.com/webhooks/rest/webhook backend endpoint
Demo: https://sbmagar.github.io

# Deploy in server other than heroku
We can deploy with any method(docker container, docker-compose, or using "supervisord" for multiple services processing)
##Using supervisord
Comment following lines in Dockerfile:
```
RUN chmod +x /app/scripts/*

CMD /app/scripts/start_services.sh
```
Uncomment following lines in Dockerfile:
```angular2html
RUN apt-get install -y supervisor

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
```
and
```angular2html
CMD ["/usr/bin/supervisord"]
```

Then you're ready to deploy with process manager "supervisord".
