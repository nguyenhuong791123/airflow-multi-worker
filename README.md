# docker rm $(docker ps -q -a)
# docker rmi $(docker images -q)
# alias docker-purge='docker stop $(docker ps -q) && docker rmi $(docker images -q) -f'

# Step 1
git pull https://github.com/nguyenhuong791123/airflow.git

# Step2
mv /home/airflow/docker/docker /home
rm -rf /home/airflow
mkdir /home/db
mkdir /home/redis
mkdir /home/dags

# Step 3
# Create container DB and Redis in one server
# Setting ENV in /home/docker/db/mysql.env
docker-compose -f docker-compose-db.yml up --build -d

# Step 4
# Create container Web and Schedule and flower in one server
# Check DB and Redis IP Address server and setting ENV in /home/docker/airflow.env
docker-compose -f docker-compose-web.yml up --build -d

# Step 5
# Create container Worker in one server
docker-compose -f docker-compose-worker.yml up --build -d
# And you can scale multiline container by below command
docker-compose -f docker-compose-worker.yml scale af-worker=N

Good Luck !!!
