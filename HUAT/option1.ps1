<#
################################################################################
    Declare Global Variables (as $NULL)
################################################################################
#>

$global:ADUserID = $NULL
$global:MACAddress2Add = $NULL
$global:MACAddressFormatted = $NULL
$global:regen = $NULL
# Current Date/Time
$global:CurrDateTime = (Get-Date -UFormat "%Y-%m-%d @ %H:%M:%S")


<#
################################################################################
    Declare Global Functions
################################################################################
#>

# Grab the user details to update in AD
function global:GetUserDetails{
    $global:ADUserID = Read-Host "UserID to update"
    $global:MACAddress2Add = Read-Host "MAC Address (no dashes) to add"
}

# Format the captured MAC Address to the PIRSA AD requirements
function global:FormatMACAddress{
    $global:MACAddressFormatted = $global:MACAddress2Add -replace '(..(?!$))','$1:'
}

# Check UserID in ActiveDirectory or Exit here
function global:UserIDExistCheck {
    # $CheckUserID is a local function only within this global function
    $CheckUserID = Get-ADUser -LDAPFilter "(sAMAccountName=$global:ADUserID)"
    If ($CheckUserID -eq $NULL) {
        Write-Host "User account does not exist in AD!" -ForegroundColor Red -BackgroundColor Black
        Write-Host "Check spelling!" -ForegroundColor Yellow -BackgroundColor Black
        Start-Sleep 3
        Return 0
    }Else{
        Write-Host ""
        Clear-Host
        Write-Host "User account OK, continuing." -ForegroundColor Yellow
        Start-Sleep 1
        Clear-Host
        Write-Host "User account OK, continuing.." -ForegroundColor Green
        Start-Sleep 1
        Clear-Host
        Write-Host "User account OK, continuing..." -ForegroundColor Yellow
        Start-Sleep 1
        Clear-Host
        Write-Host "User account OK, continuing...." -ForegroundColor Green
        Start-Sleep 1
        Clear-Host
        #Return 1

    }
}

# Regenerate WiFi certificate request option 1 - clear the certificate
function global:regenTest1{
    Start-Sleep -s 1
    Write-Host "Regenerating certificate..."
    Set-ADUser -Identity $ADUserID -Clear userCertificates
    # alternative is -> Set-ADUser -Identity $ADUserID -Certificates $Null
    Start-Sleep -s 3
    Write-Host ""
    Write-Host "Actioned. WiFi certificate clear request received at" $global:CurrDateTime -ForegroundColor Black -BackgroundColor Green
    Start-Sleep 5
    clear-host
}

# Regenerate WiFi certificate request option 2 - take no action
function global:regenTest2{
    Write-Host ""
    Write-Host "No action taken!" -ForegroundColor Red -BackgroundColor Black
    Start-Sleep 3
    Clear-Host
}

# Regenerate WiFi certificate request option 3 - invalid response, exit
function global:regenTest3{
    Write-Host "Invalid response received. Exiting." -ForegroundColor Red -BackgroundColor Black
    Start-Sleep 2
    clear-host
}


<#
################################################################################
    Main - Option 1
################################################################################
#>

GetUserDetails

FormatMACAddress

UserIDExistCheck

# MACOnUserID comparison operator for MAC Address on UserID
$MACOnUserID = (Get-ADUser -filter 'networkaddress -Like $global:MACAddressFormatted').Name

If ( $MACOnUserID -eq $global:ADUserID) {
    Write-Host ""
    Write-Host "MAC Address" $global:MACAddressFormatted "already exists on" $global:ADUserID -ForegroundColor Yellow
    Write-Host ""
    Write-Host ""
    Start-Sleep -s 1
    Write-Host "Press " -NoNewline
    Write-Host "[1]" -ForegroundColor DarkYellow -NoNewline
    Write-Host " to regenerate certificate or " -NoNewLine
    Write-Host "[2]" -ForegroundColor DarkYellow -NoNewLine
    $global:regen = Read-Host " to ignore"
    If ($global:regen -eq 1){
        regenTest1
    }
    ElseIf ($global:regen -eq 2){
        regenTest2
    }
    Else{
        regenTest3
    }
}ELSE{
    Set-ADUser $global:ADUserID -add @{networkaddress="$global:MACAddressFormatted"}
    Write-Host "MAC Address" $global:MACAddressFormatted "added to user" $global:ADUserID  "at" $global:CurrDateTime -ForegroundColor Green -BackgroundColor Black
    Start-Sleep 2
}




