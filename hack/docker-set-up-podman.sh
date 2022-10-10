podman machine stop podman-machine-default
podman machine rm podman-machine-default
# for minikube
podman machine init -v $HOME:$HOME --cpus 2 --memory 2048 --disk-size 20
podman machine start