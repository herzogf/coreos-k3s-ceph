## OpenShift binaries

Run `install.sh` to download the required binary files.

## Initialize the cluster config

```
./bin/openshift-install --dir=./cluster create install-config
```

## Generate the manifests

```
./bin/openshift-install --dir=./cluster create manifests
```
NOTE: this will consume the `install-config.yaml` file!

## Generate the ignition files

```
./bin/openshift-install --dir=./cluster create ignition-configs
```
NOTE: this will consume the manifest files!
