
# scripts/simulate-ftp-deploy.ps1
param([string]$EnvName)

$Target = "C:\DeploySimulation\$EnvName"
Write-Host "🚀 Deploy $EnvName → $Target"

if (Test-Path $Target) { Remove-Item $Target -Recurse -Force }
New-Item -ItemType Directory -Path $Target | Out-Null
Copy-Item -Path dist\* -Destination $Target -Recurse

Write-Host "✅ Simulation terminée"
