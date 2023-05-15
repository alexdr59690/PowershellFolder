$dossier = "C:\users\manipulator\Desktop\Script_PS\PWS_v5"
$start = Get-Date
Write-Warning ("--- Start time of program : " + $start.ToLongTimeString())

#Execution de la fonction TestConnection

Write-Warning "Test internet connection is running" 
$TestConnection = powershell -command "& {. $dossier\TestConnection.ps1;TestConnection }"  

#Message de l'état de connection Internet
Write-Warning @{$True="Connection internet ok";$False="Internet connection failed - Update no executed "}[$TestConnection -eq "TRUE"]

switch($TestConnection)
{
#Connection réussi
    $True {
       #importation de la fonction de mise à jour
       powershell -command "& {. $dossier\Update.ps1;UpdateData }"
    }
#Connection erreur
    $False {
    Write-Error "Internet connection failed - No update founded"
    }
}
$end = Get-Date
Write-Warning ("--- End time of program : " + $end.ToLongTimeString())
$total = $end - $start
Write-Warning ($total.Hours.ToString()+" HH "+$total.Minutes.ToString()+" MM "+$total.Seconds.ToString()+" SS")