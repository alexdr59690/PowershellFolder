$dossier = "C:\users\manipulator\Desktop\Script_PS\PWS_v5"
$start = Get-Date
"[ "+((Get-Date)).ToLongTimeString()+" ]" + " Start time of program " 

#Execution de la fonction TestConnection

"[ "+((Get-Date)).ToLongTimeString()+" ]" + " Test internet connection is running" 
$TestConnection = powershell -command "& {. $dossier\TestConnection.ps1;TestConnection }"  

"[ "+((Get-Date)).ToLongTimeString()+" ]" + @{$True=" Internet ok";$False=" Not Connected"}[$TestConnection -eq "True"]


switch($TestConnection)
{
#Connection réussi
   $True {
       #importation de la fonction de mise à jour
      powershell -command "& {. $dossier\Update.ps1;UpdateData }"
    }
#Connection erreur
    $False {
    "[ "+((Get-Date)).ToLongTimeString()+" ]" + " Internet connection failed - No update founded"
   }
}
$end = Get-Date
"[ "+((Get-Date)).ToLongTimeString()+" ]" + " End time of program"
$total = $end - $start
Write-Host ($total.Hours.ToString()+" HH "+$total.Minutes.ToString()+" MM "+$total.Seconds.ToString()+" SS")