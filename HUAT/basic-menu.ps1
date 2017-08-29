Try
{
    Import-Module ActiveDirectory -ErrorAction Stop
}
Catch
{
    Write-Host "[ERROR] ActiveDirectory PS Module not loaded!" -ForegroundColor Red -BackgroundColor Black
    Start-Sleep 3
    Write-Host "Program exiting..."
    Start-Sleep 2
    Exit 1
}

<#cd 
DECLARE GLOBAL VARIABLES
#>

$global:UserID = $NULL
$global:MACAddress2Add = $NULL


<#
NOTES

Assign folder lists to array
============================
$arr = Get-Childitem \\cluscbdfs02\user21\home\jamesd21 | Where-Object {$_.PSIsContainer } | Foreach-Object {$_.Name}
for($i=0;$i-le $arr.length-1;$i++){"`$arr[{0}] = {1}" -f $i,$arr[$i]}
#>

function Show-Menu
{
     param (
           [string]$Title = 'HUAT Main Menu v3.0'
     )
     cls
	 Write-Host ""
     Write-Host "================ $Title ================"
	 Write-Host ""
     Write-Host "1: Press '1' to add MAC Address"
     Write-Host "2: Press '3' to Create AD User"
     Write-Host "3: Press '4' to Delete AD User"
     Write-Host "4: Press '5' to Modify AD User"
	 Write-Host "5: Press '6' to Re-Issue WiFi Certificate"
	 Write-Host "Q: Press 'Q' to quit."
}




do
{
    Show-Menu
    $input = Read-Host "Please make a selection"
    switch ($input)
    {
        '1' {
                
            }
        '2' {
            cls
            'You chose option #2'
            }
        '3' {
            cls
            'You chose option #3'
            }
        'q' {
            return
            }
     }
     pause
}
until ($input -eq 'q')