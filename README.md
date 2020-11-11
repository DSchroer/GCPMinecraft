# GCP Minecraft

This project provides a terraform module that allows you to deploy a cheap Minecraft server on Google Cloud Platform. It is designed to be cheap. The server is intended for infrequent use and will shut itself off regularly to reduce code. 

The module assumes that you will be accessing it via a domain, it created a cloud DNS entry that points to the server to allow you to access it easily. 

## Usage

Setup a simple GCP terraform project and add the following module in order to deploy a Minecraft server.

```tf
module "gcp-minecraft" {
  source = "github.com/DSchroer/GCPMinecraft"

  name         = "minecraft"
  domain       = "mine.schroer.ca"
  docker_image = "us.gcr.io/personal-147022/minecraft:1"
  world_path   = "/minecraft/world"
}
```

The module exposes the following variables for use:

* __name__: The name of the deployment
* __domain__: Domain to attach DNS entries to
* __docker_image__: Image containing your minecraft deployment
* __world_path__: Path to the world in your docker container
* __machine_type__: The instance type [default: e2-standard-2]
* __time_zone__: The machine timezone [default: America/Toronto]
* __shutdown_time__: The time of day that will shut the machine down [default: 00:00]

## Using an existing world

If you want to upload an existing world you can use the following scripts. Simply replace ${CONFIG} with your connection information. The world is stored on the VM drive at `/var/world`.

```bash
# Stop the server from running
gcloud beta compute ssh ${CONFIG} --command "sudo systemctl stop minecraft"
# Remove the existing world on the server
gcloud beta compute ssh ${CONFIG} --command "rm -rf /var/world/*"

# Upload your own world
gcloud beta compute scp ${CONFIG} ./world/* ${NAME}:/var/world --recurse

# Restart the server
gcloud beta compute ssh ${CONFIG} --command "sudo systemctl start minecraft"
```

## Notes

* The docker image you use must be public
* The machine name will be the same as the name variable


