podman machine stop podman-machine-default
podman machine rm podman-machine-default
podman machine init -v $HOME:$HOME
podman machine start