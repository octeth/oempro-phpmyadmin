#!/bin/bash

# Configuration variables
CONTAINER_NAME="phpmyadmin"
IMAGE_NAME="phpmyadmin"
NETWORK_NAME="oempro-network"  # Specify the Docker network
PMA_HOST="oempro_mysql"        # Replace with your MySQL host container name on the same network
PMA_PORT=3306                  # Replace with your MySQL port if not default
PMA_ARBITRARY=1                # Set to 1 if you want to connect to any MySQL server
EXPOSED_PORT=8080              # Port on which phpMyAdmin will be accessible

# Function to build the phpMyAdmin image
build() {
    echo "Pulling the phpMyAdmin image..."
    docker pull $IMAGE_NAME
}

# Function to start the phpMyAdmin container
start() {
    echo "Starting the phpMyAdmin container..."
    docker run --name $CONTAINER_NAME --network $NETWORK_NAME -d \
        -e PMA_HOST=$PMA_HOST \
        -e PMA_PORT=$PMA_PORT \
        -e PMA_ARBITRARY=$PMA_ARBITRARY \
        -p $EXPOSED_PORT:80 \
        $IMAGE_NAME
}

# Function to stop the phpMyAdmin container
stop() {
    echo "Stopping the phpMyAdmin container..."
    docker stop $CONTAINER_NAME
}

# Function to kill the phpMyAdmin container
kill_container() {
    echo "Killing the phpMyAdmin container..."
    docker kill $CONTAINER_NAME
}

# Function to remove the phpMyAdmin container
remove() {
    echo "Removing the phpMyAdmin container..."
    docker rm $CONTAINER_NAME
}

# Function to clean (stop and remove) the phpMyAdmin container
clean() {
    stop
    remove
}

# Function to restart the phpMyAdmin container
restart() {
    stop
    start
}

# Show usage information
usage() {
    echo "Usage: $0 {build|start|stop|kill|remove|clean|restart}"
    exit 1
}

# Main script execution
case "$1" in
    build)
        build
        ;;
    start)
        start
        ;;
    stop)
        stop
        ;;
    kill)
        kill_container
        ;;
    remove)
        remove
        ;;
    clean)
        clean
        ;;
    restart)
        restart
        ;;
    *)
        usage
        ;;
esac
