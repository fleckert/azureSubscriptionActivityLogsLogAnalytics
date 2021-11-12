#!/bin/sh

set -e

logAnalyticWorkspaceSubscriptionId="<<fill_in>>"
logAnalyticWorkspaceResourceGroupName="diagnostics-activity-logs"
logAnalyticWorkspaceName="diagnostics-activity-logs"
diagnosticSettingsName="diagnostics-activity-logs"
location="westeurope"
deploymentName="$(date +%Y%m%d_%H%M%S)-Diagnostics-ActivityLogs"

az account set --subscription $logAnalyticWorkspaceSubscriptionId

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