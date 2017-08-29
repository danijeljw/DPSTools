# Source - http://www.tomsitpro.com/articles/powershell-interactive-menu,2-961.html

function Show-Menu
{
     param (
           [string]$Title = 'My Menu'
     )
     Clear-host
     Write-Host "================ $Title ================"
    
     Write-Host "1: Press '1' for this option."
     Write-Host "2: Press '2' for this option."
     Write-Host "3: Press '3' for this option."
     Write-Host "Q: Press 'Q' to quit."
}

do
{
     Show-Menu
     $input = Read-Host "Please make a selection"
     switch ($input)
     {
           '1' {
                Clear-Host
                'You chose option #1'
           } '2' {
                Clear-Host
                'You chose option #2'
           } '3' {
                Clear-Host
                'You chose option #3'
           } 'q' {
                return
           }
     }
     pause
}
until ($input -eq 'q')
