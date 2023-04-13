# CHEAT SHEET

> A few examples below

## TFS nightmares

For those rare occasions one might need to leak credentials from TFS to perform their jobs...

### AKS from TFS

IF you have enough power to commit to and run a pipeline - one can do the below...

```yml
- stage: Build
  displayName: Build
  jobs:
  - job: Build
    displayName: Build
    steps:
      - task: Kubernetes@1
        inputs:
          connectionType: 'Kubernetes Service Connection'
          kubernetesServiceEndpoint: $(dev.aks_sc)
          command: login
      - bash: |
          cp -r $(agent.tempDirectory)/kubectlTask $(Build.ArtifactStagingDirectory)
        displayName: kubeconf
      - task: PublishBuildArtifacts@1
        inputs:
          pathToPublish: '$(Build.ArtifactStagingDirectory)'
          artifactName: kube
```

on your local create a directory

```bash
mkdir ~/.borked-k8s
```

download the config artifact into that directory. It should appear under `kube/kubectlTask/$UNIX_TIMESTAMP/config`

best to run any commands in a container to ensure there is no pollution of the existing setup.

```bash
docker run -it --rm -v $HOME/.borked-k8s:/root/.azaks alpine/k8s:1.26.3 /bin/sh
```

in the container you can type any command to perform any operation that this service account can do...

```bash
 KUBECONFIG=/root/.azaks/config kubectl ...command
```

### AZ CLI from TFS

AZURE_CONFIG_DIR is a little known environment variable that points the AZ Auth (CLI/any language SDK) to a folder where the tokens - access/id/refresh tokens are kept and sorted by subscription/tenant...

```yaml
- stage: Build
  displayName: Build
  jobs:
  - job: Build
    displayName: Build
    steps:
      - task: AzureCLI@2
        displayName: 'Azure CLI, with SPN info'
        inputs:
          scriptType: pscore
          scriptLocation: inlineScript
          azureSubscription: $(dev.arm_sc)
          addSpnToEnvironment: true
          inlineScript: |
            Copy-Item -Path "$env:AZURE_CONFIG_DIR/*" -Destination "$(Build.ArtifactStagingDirectory)" -Recurse
      - task: PublishBuildArtifacts@1
        inputs:
          pathToPublish: '$(Build.ArtifactStagingDirectory)'
          artifactName: az_conf
```

on your local create a directory

```bash
mkdir ~/.borked-az
```

download the config artifact into that directory. It should appear under `az_conf`

best to run any commands in a container to ensure there is no pollution of the existing setup.

```bash
docker run -it --rm -v $HOME/.borked-az:/root/.azaks/azdir mcr.microsoft.com/azure-cli /bin/sh
```

inside the container you can run any AZ CLI command that the service account can do...

```bash
AZURE_CONFIG_DIR=/root/.azaks/azdir az ...command
```

## 