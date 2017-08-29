Import-Module ActiveDirectory
$PC2Delete = Read-Host "Computer name to remove"
$whoami = $env:USERNAME
$r = "PISADOM01\admin." + $whoami
$CredRequest = Get-Credential -UserName $r
Remove-ADComputer -Identity $PC2Delete -Credential $CredRequest -Server "PISADOM01" -Confirm