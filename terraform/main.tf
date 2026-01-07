terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.57.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {}
}

resource "azurerm_resource_group" "aks-store-demo-rg" {
  name     = "aks-store-demo-rg"
  location = "southeastasia"
}

resource "azurerm_kubernetes_cluster" "aks-store-demo-cluster" {
  name                = "aks-store-demo-cluster"
  location            = azurerm_resource_group.aks-store-demo-rg.location
  resource_group_name = azurerm_resource_group.aks-store-demo-rg.name
  dns_prefix          = "aks-store-demo"

  network_profile {
    network_plugin     = "azure"
    network_policy     = "cilium"
    network_data_plane = "cilium"
  }

  default_node_pool {
    name       = "standardd2v2"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }
}