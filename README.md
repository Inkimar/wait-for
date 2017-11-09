# wait-for
inspiration from the project wait-for-it.sh

## beaware
timeout is not implemented yet .... so forever is forever .....

## usage
use in your docker-compose.yml-file

~~~
up:
 	docker-compose up -d
	#firefox https:<site>
  ./wait-for-app.sh https:<site>
	xdg-open https:<site>
	~~~