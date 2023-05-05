function UpdateData
{   
    #Recherche de mise à jour dans le catalogue windows update
    Write-Warning "Research update"
    $update = Get-WUList
    #Totaliser le nombre mise à jour à faire
    $nbUpdateToDo = $update.count
    Write-Warning ("Number of updates found : " + $nbUpdateToDo)
    if($nbUpdateToDo -gt 0 ) 
    { 
    #Début de l'installation
        Write-host "...Starting installation..."
	    foreach($items in $update)
	    {
			try
			{
				Write-Warning ("---Starting update : " + $items.KB)
				Install-WindowsUpdate -AcceptAll -install
				Write-Warning ("---Update completed : " + $items.KB)
			}
			catch
			{
				Write-Error $_.Exception.Message
			}
	    }
#Message de fin de mise à jour
        write-host @{$true="--- Update is finished ---";$false="--- Updates are finished ---"}[$nbUpdateToDo -eq 1]

#Vérifier si le pc doit redémarre        
        $status = Get-WURebootStatus
        if($status.RebootRequired -eq 1)
        {
            Write-Host "Redémarrage en cours"
            shutdown.exe /r /t 60 
        }
        else { Write-Host "---Not necessary to restart computer ---";}   
    }
else
{ 
	Write-Host "--- No update found , Pc is up to date ---" 
}
}