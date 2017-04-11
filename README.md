# jmeter-docker
<h1>Setting up JMeter under Swarm Mode</h1>

<b>Pre-requisite:</b>

1. Installing Docker 17.03 on all the cluster of nodes
2. Setting up Swarm Mode Cluster( running atleast 1 master and n-number of Slave Nodes)
3. Installing Docker Compose on the master node

<b>1. Installing Docker 17.03 on all the cluster of nodes:</b>

                $curl -sSL https://get.docker.com/ | sh

<b>2. Setting up Swarm Mode Cluster:</b>

<b>On Master Node:</b>

              $docker swarm init --listen-addr <master-ip>:2377 --advertise-addr <master-ip>:2377

<b>On Slave Node:</b>

              $docker swarm join --token <TOKEN> master-ip  <-- Run this command on all the slave nodes

<b>3. Installing Docker Compose on the master node:</b>

            $curl -L https://github.com/docker/compose/releases/download/1.11.2/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
              $chmod +x /usr/local/bin/docker-compose

<b> Pulling the Repository </b>

Login to master node and copy the repository:

                $git https://github.com/epikurus/jmeter-docker/jmeter-docker
                $cd jmeter-docker

<b>Running Docker Compose locally</b>

                $docker-compose up -d

<b>Deploying services in Swarm Cluster with docker-compose</b>

                $docker stack deploy --compose-file docker-compose.yml  jmeter

It will push jmeter-master to the master node and jmeter-server to the slave nodes and make it ready to start load using the external JMX file.

                @master$ docker service ls
                ID            NAME                  MODE        REPLICAS  IMAGE
                1cey6tzk0c7b  jmeter_jmeter-master  replicated  1/1       epikurus/jmeter-master:latest
                u5ac3vgkphpf  jmeter_jmeter-slave   global      1/1       epikurus/jmeter-slave:latest

Let us verify these containers on both the nodes:

          @master:~$ docker ps
          CONTAINER ID        IMAGE                                                                                            COMMAND                  CREATED              STATUS              PORTS               NAMES
          efd8ad49d932        epikurus/jmeter-master@sha256:09f1ec46eb291b706f4447aecf5fb7c900d05728e0e2fd899f5e8a80029a9d97   "/entrypoint.sh /t..."   About a minute ago   Up About a minute   60000/tcp           jmeter_jmeter-master.1.i1engta4a0ofl4d8gywdpx7zl

Use the same command to verify on the slave nodes.

<b> Pushing a JMX file into the container</b>

       $docker exec -i <container-running-on-master-node> sh -c 'cat > /tests/jmeter-docker.jmx' < jmeter-docker.jmx

<b> Starting the Load testing</b>

      $docker exec -it <container-on-master-node> sh
      $jmeter -n -t /tests/<test-name>.jmx -R<list of containers running on slave nodes seperated by commas)


# Handful Commands 

<b> Listing the Slave IPs </b>

       $ docker inspect --format '{{ .Name }} => {{ .NetworkSettings.IPAddress }}' $(docker ps -a -q)


<b> Stopping all the containers in a single shot </b>

       $docker stop $(docker ps -a -q)

