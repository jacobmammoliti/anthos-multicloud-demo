# Anthos Multicloud Demo

This repository is used to demo Anthos across multiple clouds. It contains Terraform code to stand up Google Kubernetes Engine (GKE) and Azure Kubernetes Service (AKS). It also provides a directory to demonstrate Anthos Config Management (ACM) as well as sample Python application to showcase different deployment scenarios.

## Setting Environment Variables Used Throughout Setup

```bash
export GOOGLE_CLOUD_PROJECT_ID="xxx"
export GOOGLE_CLOUD_LOCATION="us-central1-a"
export GOOGLE_CLOUD_CLUSTER_NAME="np-mgmt-cluster-gcp"

export AZURE_CLUSTER_NAME="np-mgmt-cluster-azure"
export AZURE_LOCATION="us-east4"
export AZURE_SUBSCRIPTION_ID="xxx"
export AZURE_TENANT_ID="xxx"
export AZURE_CLIENT_ID="xxx"

export ADMIN_USERS="xxx"
```

## Ensure Config Management is Enabled in Your Project

```bash
gcloud beta container hub config-management enable \
--project=$GOOGLE_CLOUD_PROJECT_ID
```

## Registering an AKS Cluster

More information on Anthos attached clusters [here](https://cloud.google.com/anthos/clusters/docs/multi-cloud/attached).

Run the following command to "attach" your AKS cluster to GCP:

```bash
gcloud container attached clusters register $AZURE_CLUSTER_NAME \
--location=$AZURE_LOCATION \
--fleet-project=$GOOGLE_CLOUD_PROJECT_ID \
--platform-version=1.25.0-gke.4 \
--distribution=aks \
--context=$AZURE_CLUSTER_NAME \
--has-private-issuer \
--admin-users=$ADMIN_USERS \
--project=$GOOGLE_CLOUD_PROJECT_ID
```

Sample output:

```bash
NAME                   PLATFORM_VERSION  KUBERNETES_VERSION  STATE
np-mgmt-cluster-azure  1.25.0-gke.4      1.25                RUNNING
```

The following command can be used to view all "attached" clusters:

```bash
gcloud container attached clusters list \
--location=$AZURE_LOCATION \
--project=$GOOGLE_CLOUD_PROJECT_ID
```

Sample output:

```bash
NAME                   PLATFORM_VERSION  KUBERNETES_VERSION  STATE
np-mgmt-cluster-azure  1.25.0-gke.4      1.25                RUNNING
```

You can unregister your AKS cluster with the following command:

```bash
gcloud container attached clusters delete $AZURE_CLUSTER_NAME \
--ignore-errors \
--allow-missing \
--location=$AZURE_LOCATION \
--project=$GOOGLE_CLOUD_PROJECT_ID
```

## Registering GKE clusters to Hub

Run the following command to register your GKE cluster to hub:

```bash
gcloud container hub memberships register $GOOGLE_CLOUD_CLUSTER_NAME \
--gke-cluster=$GOOGLE_CLOUD_LOCATION/$GOOGLE_CLOUD_CLUSTER_NAME \
--enable-workload-identity \
--project=$GOOGLE_CLOUD_PROJECT_ID
```

View all clusters in the [Fleet](https://cloud.google.com/anthos/fleet-management/docs#introducing_fleets):

```bash
gcloud container fleet memberships list --project=$GOOGLE_CLOUD_PROJECT_ID
```

Sample output:

```bash
NAME                   EXTERNAL_ID                           LOCATION
np-mgmt-cluster-azure  ec5bb28d-1ffa-4727-94bc-6000ecaa4a09  global
np-mgmt-cluster-gcp    58074047-ffe8-4fe7-8a8e-9065bfbdb2db  us-central1
```

## Install Anthos Config Management (ACM)

Run the following command to install ACM on your GKE cluster:

```bash
gcloud beta container fleet config-management apply \
--membership=$GOOGLE_CLOUD_CLUSTER_NAME \
--config=apply-spec.yaml \
--project=$GOOGLE_CLOUD_PROJECT_ID
```

Run the following command to install ACM on your AKS cluster:

```bash
gcloud beta container fleet config-management apply \
--membership=$AZURE_CLUSTER_NAME \
--config=apply-spec.yaml \
--project=$GOOGLE_CLOUD_PROJECT_ID
```
