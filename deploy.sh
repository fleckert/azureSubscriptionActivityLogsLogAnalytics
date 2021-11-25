#!/bin/sh

set -e

logAnalyticWorkspaceResourceGroupName="diagnostics-activity-logs"
logAnalyticWorkspaceName="activity-logs"
diagnosticSettingsName="la-$logAnalyticWorkspaceName"
location="westeurope"
deploymentName="$(date +%Y%m%d_%H%M%S)-Diagnostics-ActivityLogs"

logAnalyticWorkspaceSubscriptionId=$(az account show --output tsv --query id)

az group create --name $logAnalyticWorkspaceResourceGroupName --location $location

az deployment group create \
   --resource-group $logAnalyticWorkspaceResourceGroupName \
   --name $deploymentName \
   --mode Complete \
   --template-file logAnalyticsWorkspace.json \
   --parameters \
       logAnalyticsWorkspaceName=$logAnalyticWorkspaceName \
       location=$location

az deployment sub create \
   --location $location \
   --name $deploymentName \
   --template-file diagnostics.json \
   --parameters \
       diagnosticSettingsName=$diagnosticSettingsName \
       logAnalyticWorkspaceSubscriptionId=$logAnalyticWorkspaceSubscriptionId \
       logAnalyticWorkspaceResourceGroupName=$logAnalyticWorkspaceResourceGroupName \
       logAnalyticWorkspaceName=$logAnalyticWorkspaceName