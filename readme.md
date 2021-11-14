

The Azure Activity Log is accessible via the [Azure Portal](https://portal.azure.com/#blade/Microsoft_Azure_Monitoring/AzureMonitoringBrowseBlade/activityLog).

As Azure Log Analytics queries are imho more powerful than the [Azure Portal](https://portal.azure.com/#blade/Microsoft_Azure_Monitoring/AzureMonitoringBrowseBlade/activityLog), please see the [documentation](https://docs.microsoft.com/en-us/azure/azure-monitor/essentials/activity-log#send-to-log-analytics-workspace) to send the Azure Activity Log to an Azure Log Analytics workspace.


Here is the official [Azure Resource Manager template sample](https://docs.microsoft.com/en-us/azure/azure-monitor/essentials/resource-manager-diagnostic-settings#diagnostic-setting-for-activity-log).

Kind of nice is the [pricing model](https://docs.microsoft.com/en-us/azure/azure-monitor/logs/manage-cost-storage#pricing-model)
> *Some data types are free from data ingestion charges altogether, for example the AzureActivity, Heartbeat, Usage and Operation types.*

The files in this repository are my 'opinionated' take on [this](https://docs.microsoft.com/en-us/azure/azure-monitor/essentials/diagnostic-settings).

## Usage
- `az login`
- `deploy.sh`

## what it does...
this creates a resourceGroup `logAnalyticWorkspaceResourceGroupName` in `location` with a Log Analytics Workspace `logAnalyticWorkspaceName`.

! please check if the deploymentMode `complete` meets your situation !

all categories of the Activity Log is send to this Log Analytics Workspace