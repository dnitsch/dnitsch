podman machine stop podman-machine-default && podman machine rm podman-machine-default
# for minikube
podman machine init -v $HOME:$HOME --cpus 2 --memory 2048 --disk-size 20

podman machine set --rootful

podman machine start

minikube config set driver podman

podman system connection default podman-machine-default-root

minikube start --driver=podman --container-runtime=cri-o

# Minikube
minikube start --driver=podman --container-runtime=containerd --network-plugin=cni --cni=auto

minikube update-context

