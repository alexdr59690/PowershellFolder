function UpdateData
{   
    #Recherche de mise à jour dans le catalogue windows update
    Write-Warning ("Research update..." + (Get-Date).ToLongTimeString())
    $update = Get-WUList
    #Totaliser le nombre mise à jour à faire
    $nbUpdateToDo = $update.count
    Write-Warning ("Number of updates found : " + $nbUpdateToDo)
    Write-Warning (Get-Date).ToLongTimeString()
    
    if($nbUpdateToDo -gt 0 ) 
    { 
    #Début de l'installation
        Write-Warning "...Starting installation..."
	    foreach($items in $update)
	    {
			try
			{
    
                Write-Warning (Get-Date).ToLongTimeString()
				Write-Warning ("---Starting update : " + $items.KB)
				Install-WindowsUpdate -AcceptAll -install
				Write-Warning ("---Update completed : " + $items.KB)
                Write-Warning (Get-Date).ToLongTimeString()
			}
			catch
			{
                Write-Warning (Get-Date).ToLongTimeString()
				Write-Error $_.Exception.Message
			}
	    }
#Message de fin de mise à jour
        write-Warning @{$true="--- Update is finished ---";$false="--- Updates are finished ---"}[$nbUpdateToDo -eq 1]
        Write-Warning (Get-Date).ToLongTimeString()

#Vérifier si le pc doit redémarre        
        $status = Get-WURebootStatus
        if($status.RebootRequired -eq 1)
        {
            Write-Warning "Redémarrage en cours"
            shutdown.exe /r /t 60 
        }
        else 
        { 
            Write-Warning "---Not necessary to restart computer ---";
            Write-Warning (Get-Date).ToLongTimeString()
        }   
    }
else
{ 
	Write-Warning "--- No update found , Pc is up to date ---" 
    Write-Warning (Get-Date).ToLongTimeString()
}
}