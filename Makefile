NAME = inception

CREATE_DIRS = sh srcs/requirements/tools/init.sh

all:
	@if [ ! -d "/home/$(USER)/data" ]; then \
		echo "Creating local volumes directories..."; \
		$(CREATE_DIRS); \
	fi
	@echo "Building images and starting containers..."
	@docker-compose -p $(NAME) -f srcs/docker-compose.yml up --build -d

clean:
	@if [ -n "$$(docker container ls -q)" ]; then \
		echo "Removing containers..."; \
		docker-compose -p $(NAME) -f srcs/docker-compose.yml down; \
	fi
	@if [ -n "$$(docker volume ls -q)" ]; then \
		echo "Removing docker volumes..."; \
		docker volume rm $$(docker volume ls -q); \
	fi

fclean: clean
	@if [ -n "$$(docker images -q)" ]; then \
		echo "Removing images..."; \
		docker rmi -f $$(docker images -q); \
	fi

	@if [ -d "/home/$(USER)/data" ]; then \
		echo "Removing local volumes directories..."; \
		sudo rm -rf /home/$(USER)/data; \
	fi
re: clean all