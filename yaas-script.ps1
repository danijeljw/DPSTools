$creds = Get-Credential
$SCCMEval = 'C:\Windows\Build\CCMPolicyandInventoryEval.exe'

net stop w32time
w32tm /unregister
w32tm /register
net start w32time
w32tm /resync

New-PSDrive -Name 'Z' -PSProvider FileSystem -Root \\pirsapf2tr\user6\Refdata\Corp\Helpdesk\MAC_Dump -Credential $creds

Get-NetAdapter | select Name,MacAddress,InterfaceDescription > Z:\$env:computername.txt

Get-PSDrive 'Z' | Remove-PSDrive -Force

GPUpdate /Force

If(Test-Path -Path $SCCMEval){
	$SCCMEval
	Start-Sleep -s 60
	Shutdown /s /t 600
	Exit 0
}Else{
	Write-Host '=========================================='
	Write-Host 'CCMPolicyandInventoryEval not found!'
	Write-Host 'Advise Infrastructure and Desktop Support!'
	Write-Host '=========================================='
	Start-Sleep -s 2
}


