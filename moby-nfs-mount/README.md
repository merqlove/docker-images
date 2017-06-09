A Simple Docker image to automate mounting a remote NFS share into the Docker host.

### Usage

[![Usage Example on Amazon AWS](https://img.youtube.com/vi/glZs9SEa-_U/0.jpg)](https://youtu.be/glZs9SEa-_U "The video is a step by step tutorial")

```
docker run -d \
    --privileged --pid=host \
    --restart=unless-stopped \
    -e SERVER=$NFS_SERVER:/  \
    -e MOUNTPOINT=/host/mount/folder cnsa/moby-nfs-mount
```
- SERVER : the remote NFS server (it is set for nfs4)
- MOUNTPOINT : local host folder used for the mounting
  
**Optional settings (with defaults):**

- WSIZE : 1048576
- RSIZE : 1048576
- MOUNT_OPTS : hard
- RETRANS : 2
- VERSION : 4
- LOG : null
- AFTER: "/bin/true"

and then to use it inside a container
```
  docker run -v /host/mount/folder:/container/folder
```
It support all Docker platforms that use the Moby Linux.<br>
  - Docker for Mac<br>
  - Docker for AWS<br/>
  - Docker for Windows (unsure)<br/>
  - Should work on any Alpine docker host

### To mount it on all swarm nodes run using :<br/>
docker service create doesn't support --privileged so we need to run it using swarm-exec which runs a single command on every node cluster including every new node that joins
```
swarm-exec \
    docker run -d \
    --privileged --pid=host \
    --restart=unless-stopped \
    -e SERVER=$NFS_SERVER:/  \
    -e MOUNTPOINT=/host/mount/folder cnsa/moby-nfs-mount 
```
https://github.com/mavenugo/swarm-exec

to use it in a service 
```
--mount type=bind,src=/host/mount/folder,dst=/container/folder
```

### Here is how it works:<br/>
  nsenter to access the host namespace<br>
  install the nfs client on the host<br>
  mount the NFS on the hostusing the -e MOUNT env from the run command<br>
  inotifywait to output logs for any folder changes
  
### NOTES: 
  the nfs server should support nfs4
  this technique will be replaced by distributed docker volumes plugins and automated docker plugin installation
