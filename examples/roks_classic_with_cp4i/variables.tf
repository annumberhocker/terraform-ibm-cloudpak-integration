#####################################################
# classic openshift single-zone cluster with CP4I
# Copyright 2022 IBM
#####################################################

variable "ibmcloud_api_key" {
  default     = ""
  description = "IBMCloud API Key for the account the resources will be provisioned on. Go here to create an ibmcloud_api_key: https://cloud.ibm.com/iam/apikeys"
}

variable "project_name" {
  description = "Used to tag the cluster i.e. 'project:{project_name}'"
}

variable "environment" {
  default     = "dev"
  description = "Used to tag the cluster i.e. 'env:{environment}'"
}

variable "owner" {
  default     = ""
  description = "Used to tag the cluster i.e. 'owner:{owner}'"
}

variable "region" {
  description = "The region where the cluster will be created. List all available regions with: `ibmcloud regions`"
  type        = string
}

variable "worker_zone" {
  description = "The data center where the worker node is created. List all available zones with `ibmcloud ks zone ls --provider classic`"
  type        = string
}

variable "workers_count" {
  description = "Number of worker nodes per zone"
  type        = number
  default     = null
}

variable "worker_pool_flavor" {
  description = "The machine type for your worker node."
  type        = string
}

variable "public_vlan" {
  description = "The ID of the public VLAN that you want to use for your worker nodes. List available VLANs in the zone: `ibmcloud target -g <resource-group>; ibmcloud ks vlan ls --zone <zone>`"
  type        = string
  default     = null
}

variable "private_vlan" {
  description = "The ID of the private VLAN that you want to use for your worker nodes. List available VLANs in the zone: `ibmcloud target -g <resource-group>; ibmcloud ks vlan ls --zone <zone>`"
  type        = string
  default     = null
}

variable "hardware" {
  description = "The level of hardware isolation for your worker node."
  type        = string
  default     = "shared"
}

variable "resource_group" {
  description = "Enter Name of the resource group"
  type        = string
}

variable "master_service_public_endpoint" {
  description = "Enable the public service endpoint to make the master publicly accessible."
  type        = bool
  default     = true
}

variable "entitlement" {
  description = "create your cluster with existing entitlement"
  type        = string
  default     = "cloud_pak"
}

variable "force_delete_storage" {
  description = "force the removal of persistent storage associated with the cluster during cluster deletion."
  type        = bool
  default     = null
}

variable "roks_version" {
  description = "The OpenShift version that you want to set up in your cluster."
  type        = string
  default     = null
}

variable "storage_class" {
  default     = "ibmc-file-gold-gid"
  type        = string
  description = "Storage class to use.  If running on VPC, set to `portworx-rwx-gp3-sc` and make sure Portworx is set up on cluster"
}

variable "entitled_registry_user_email" {
  type        = string
  description = "Email address of the user owner of the Entitled Registry Key"
}

variable "entitled_registry_key" {
  type        = string
  description = "Get the entitlement key from https://myibm.ibm.com/products-services/containerlibrary"
}

variable "config_dir" {
  type        = string
  description = "Path to store cluster config file"
  default     = "./.kube/config"
}

variable "namespace" {
  type        = string
  description = "Project to install Cloud Pak in"
  default     = "cp4i"
}

locals {
  cluster_name = "${var.project_name}-${var.environment}-classic"
  roks_version = format("%s_openshift", split("_", var.roks_version)[0])
}
