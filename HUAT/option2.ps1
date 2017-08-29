
$global:ADUserID = $NULL
$global:CurrDay = (Get-Date -UFormat "%d%m")
$global:TempUserPassGen = 'Pirsa_' + $CurrDay




# Obtain AD User account only
function global:GetUserIDOnly{
    $global:ADUserID = Read-Host "UserID to update"
}


function ResetUserPassword{
    GetUserIDOnly
    Set-ADAccountPassword -Identity $ADUserID -Reset -NewPassword (ConvertTo-SecureString -AsPlainText $TempUserPassGen -Force)
    Write-Host "UserID" $ADUserID "password changed to '" $TempUserPassGen "'"
    Set-ADUser -Identity $ADUserID -ChangePasswordAtLogon $TRUE
    Write-Host "Advise" (Get-ADUser $ADUserID).GivenName "password will require change at next logon!"
    Start-Sleep 5
    Clear-Host
}

ResetUserPassword







