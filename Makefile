NAME = inception

CREATE_DIRS = sh srcs/requirements/tools/init.sh

all:
	@echo "Building images..."
	$(CREATE_DIRS)
	@docker-compose -p $(NAME) -f srcs/docker-compose.yml up --build -d


clean:
	@echo "Removing containers..."
	docker-compose -p $(NAME) -f srcs/docker-compose.yml down
fclean: clean
	@echo "Full cleaning..."
	@docker builder prune -a -f
	docker-compose -p $(NAME) -f srcs/docker-compose.yml down -v --remove-orphans
	docker rmi -f $(shell docker images -q)
	docker volume rm $(shell docker volume ls -q)
	@sudo rm -rf /home/$(USER)/data
re: fclean all
