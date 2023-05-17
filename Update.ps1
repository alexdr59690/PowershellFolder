function UpdateData
{   
    #Recherche de mise à jour dans le catalogue windows update
    Write-Host  [(Get-Date).ToLongTimeString()] "Research update"
    $update = Get-WUList
    #Totaliser le nombre mise à jour à faire
    $nbUpdateToDo = $update.count
    Write-Host [(Get-Date).ToLongTimeString()] "Number of updates found : " $nbUpdateToDo
    
    
    if($nbUpdateToDo -gt 0 ) 
    { 
    #Début de l'installation
        Write-Host [(Get-Date).ToLongTimeString()] "Starting installation"
	    foreach($items in $update)
	    {
			try
			{
				Write-Host [(Get-Date).ToLongTimeString()] "Starting update : " $items.KB
				Install-WindowsUpdate -AcceptAll -install
				Write-Host [(Get-Date).ToLongTimeString()] "Update completed : " $items.KB
			}
			catch
			{
                Write-Warning [(Get-Date).ToLongTimeString()] "Error : "
				Write-Error $_.Exception.Message
			}
	    }
#Message de fin de mise à jour
        write-Host [(Get-Date).ToLongTimeString()] @{$true="Update is finished";$false="Updates are finished"}[$nbUpdateToDo -eq 1]

#Vérifier si le pc doit redémarre        
        $status = Get-WURebootStatus
        if($status.RebootRequired -eq 1)
        {
            Write-Host "Redémarrage en cours"
            shutdown.exe /r /t 60 
        }
        else 
        { 
            Write-Host [(Get-Date).ToLongTimeString()] "Not necessary to restart computer";
        }   
    }
else
{ 
	Write-Host [(Get-Date).ToLongTimeString()] "No update found , Pc is up to date" 
}
}