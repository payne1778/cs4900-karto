# Database Setup With Docker

### Database Initalization

Below are the steps to install and run Docker to initalize the `Karto` group database. 

1. Install `Docker Desktop` or a docker compose package onto your system
2. Go into your terminal
3. Navigate to the directory with the `docker-compose.yml` file
4. Run `docker compose up`

This will start a docker container with MariaDB configured with our database scripts.
In particular, it will load and run a super SQL script that contains each table in our database, effectively initalizing it. 

### Start & Stop Container

To stop the container at any time, you can enter `Ctrl+C` in the terminal where the container is running
If you have already created the container, you can do the following to restart the container:

1. Go into your terminal
2. Navigate to the directory with the `docker-compose.yml` file
3. Run `docker compose start`

### Change Configurations

When the container is running, you can interact with the database on Port 3306 (default for MariaDB). 
The credentials are `user` for the username and `password` for the password. 
You can change these configurations at any time by navigating to the `ports` and `environment` parts of the `docker-compose.yml` file. 

## How to connect to Database

To connect to it, in this case we will be using dbeaver.
- First right click on the left panel and create a new connection.
- Then make sure to select MariaDB
- Then in the port for localhost, put in `7872`, since that is what our database uses just in case the default port is full
- Then for the user: `root` and password: `karto`
- Then after clicking create/connect, the database should appear.