#!/bin/sh

set -e

resourceGroupName="diagnostics-activity-logs"
location="westeurope"
deploymentName="$(date +%Y%m%d_%H%M%S)-Diagnostics-ActivityLogs"

az account set --subscription $subscription

az group create --name $resourceGroupName --location $location

az deployment group create \
   --resource-group $resourceGroupName \
   --name $deploymentName \
   --mode Complete \
   --template-file logAnalyticsWorkspace.json \
   --parameters \
       logAnalyticsWorkspaceName=$resourceGroupName \
       location=$location

logAnalyticWorkspaceId=$(az monitor log-analytics workspace show --resource-group $resourceGroupName --workspace-name $resourceGroupName --output tsv --query "id")

az deployment sub create \
   --location $location \
   --name $deploymentName \
   --template-file diagnostics.json \
   --parameters \
       diagnosticSettingsName=$resourceGroupName \
       logAnalyticWorkspaceId=$logAnalyticWorkspaceId