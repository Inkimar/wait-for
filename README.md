# wait-for
inspiration from the project wait-for-it.sh

## beaware
timeout is not implemented yet .... so forever is forever .....

## usage
use in your docker-compose.yml-file

opens the site : i.e https://example.com/ when it is up and ready
~~~
up:
 	docker-compose up -d
  ./wait-for-app.sh https://example.com/
	xdg-open https:https://example.com/
	~~~