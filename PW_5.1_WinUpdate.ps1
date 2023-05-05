$dossier = "C:\users\manipulator\Desktop\Script_PS\PWS_v5"
#importation de la fonction TestConnection
$TestConnection = powershell -command "& {. $dossier\TestConnection.ps1;TestConnection }"  

#Message de l'état de connection Internet
@{$True="Connection internet ok";$False="Internet connection failed - Update no executed "}[$TestConnection -eq "TRUE"]

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