#Prerequisites
#AD Cmdlet module on server running this command
#SCCM Console and powershell cmdlets installed on server running this command

#source : https://community.spiceworks.com/topic/1947438-delete-sccm-device-and-ad-computer-account-in-1-step

$computername = Read-Host -Prompt "Enter computer to delete from AD and SCCM: "
#Your SCCM Site
$SCCMSite = "CBD"
$SCCMSitePath = $SCCMSite + ":"

if (($env:SMS_ADMIN_UI_PATH) -ne $null)
{
  Write-Host "SCCM Environment path exists:" $env:SMS_ADMIN_UI_PATH -ForegroundColor Green
}
else
{
  Write-Error "You have not run up the SCCM Console before .... please run up SCCM console first and then re-run script  exiting........"
  break
}

<#
#check to see if user acocunt has rights to SCCM to carry out function 
if ((Get-ADPrincipalGroupMembership -Identity $env:USERNAME |where name -eq "SEC_SCCM_Admin") )
{
    Write-Host "$env:USERNAME belongs to SEC_SCCM_Admin AD Group" -ForegroundColor Green
}
else
{
  Write-Error "You do not belong to the SEC_SCCM_Admin group.. Gain access and then re-run script  exiting........"
  break
}
#>

#Check for the fact the user has run SCCM Console once
#If they have then the "HKCU:\Software\Microsoft\ConfigMgr10" registry entry will exist
try
{
Set-Location "HKCU:\Software\Microsoft\ConfigMgr10" -ErrorAction Stop
}

catch [System.Net.WebException],[System.Exception]
{
    Write-error "User: $env:Username has NOT SCCM Console before ... Exiting"
    Break
}

Write-Output "User: $env:Username has run SCCM Console before carrying on"

Import-Module (Join-Path $(Split-Path $env:SMS_ADMIN_UI_PATH) ConfigurationManager.psd1)
#Set current directory to SCCM site
Set-Location -Path $SCCMSitePath

try
{
$ResourceIDOfComputername = Get-CMDevice -name $computername -ErrorAction Stop
}

catch 
{
    Write-error "Computername: $Computername not found"
    #Break
}

Remove-CMDevice -DeviceName $computername
Write-output "$computername removed from SCCM"




try
{
Remove-ADComputer -identity $computername -ErrorAction Stop
}

catch 
{
    Write-error "Computername: $Computername not found in AD"
    #Break
}