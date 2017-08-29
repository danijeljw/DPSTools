function global:LoadADModule{
    Try
    {
      Import-Module ActiveDirectory -ErrorAction Stop
    }
    Catch
    {
      Write-Host ""
      Write-Warning "ActiveDirectory Module couldn't be loaded. Exiting!"
      Start-Sleep -s 5
      Exit 1
    }
}

function global:UnloadADModule{
    If(Get-Module ActiveDirectory){
        Remove-Module ActiveDirectory
    }
}
