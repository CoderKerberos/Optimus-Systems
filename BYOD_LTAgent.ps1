#timeout=12000000
#maxlength=9000000
"C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe"
Set-ExecutionPolicy unrestricted -Force
Write-Output '-----------------------------------------'
Write-Output '-----------------------------------------'
Write-Output '-----Unrestricing the Execution Policy----'
Write-Output '-----------------------------------------'
Write-Output '-----------------------------------------'
$folderName = (Get-Date).tostring("dd-MM-yyyy")
$Path="C:\Temp\"+$folderName
if (!(Test-Path $Path))
{
New-Item -itemType Directory -Path C:\Temp -Name $FolderName
}
else
{
write-host "Folder already exists"
}
Write-Output '-----------------------------------------'
Write-Output '-----------------------------------------'
Write-Output '-----Downloading the Required Files------'
Write-Output '-----------------------------------------'
Write-Output '-----------------------------------------'
Invoke-WebRequest 'https://optimus.hostedrmm.com/labtech/Transfer/Software/BYOD_LTAgent/Agent_Install.MSI' -O 'C:\Temp\Agent_Install.MSI'
Write-Output '-----------------------------------------'
Write-Output '-----------------------------------------'
Write-Output '-----Installing LT Agent on the Machine----'
Write-Output '-----------------------------------------'
Write-Output '-----------------------------------------'
Start-Process msiexec.exe -Wait -ArgumentList '/I C:\Temp\Agent_Install.MSI /quiet'
Write-Output '-----------------------------------------'
Write-Output '-----------------------------------------'
Write-Output '-----Checking if LT Agent is Installed or not-----'
Write-Output '-----------------------------------------'
Write-Output '-----------------------------------------'
$software = "ConnectWise Automate Software";
$installed = (Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Where { $_.DisplayName -eq $software }) -ne $null

If(-Not $installed) {
	Write-Host "'$software' NOT is installed.";
} else {
	Write-Host "'$software' is installed."
}
Write-Output '-----------------------------------------'
Write-Output '-----------------------------------------'
Write-Output '------Verifying Services are Started-----'
Write-Output '-----------------------------------------'
Write-Output '-----------------------------------------'
Restart-Service -Name "LTService"
Write-Output '-----------------------------------------'
Write-Output '-----------------------------------------'
Restart-Service -Name "LTSvcMon"
Write-Output '-----------------------------------------'
Write-Output '-----------------------------------------'
Write-Output '------Restricing back the Execution Policy-----'
Write-Output '-----------------------------------------'
Write-Output '-----------------------------------------'
Set-ExecutionPolicy restricted -Force