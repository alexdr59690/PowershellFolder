function UpdateData
{   
    #Recherche de mise à jour dans le catalogue windows update
    "[ "+((Get-Date)).ToLongTimeString()+" ]"+ " Research update"
    $update = Get-WUList
    #Totaliser le nombre mise à jour à faire
    $nbUpdateToDo = $update.count
    "[ "+((Get-Date)).ToLongTimeString()+" ]" + " Number of updates found : " + $nbUpdateToDo
    
    
    if($nbUpdateToDo -gt 0 ) 
    { 
    #Début de l'installation
       "[ "+((Get-Date)).ToLongTimeString() + " ]" + " Starting installation"
	    foreach($items in $update)
	    {
			try
			{
				"[ " +((Get-Date)).ToLongTimeString()+" ]"+ " Starting update : " + $items.Title
				$install = Install-WindowsUpdate -AcceptAll -install
                if($install[2] -eq "Installed")
                {
				    "[ "+((Get-Date)).ToLongTimeString()+" ]" + " Update completed : " + $items.KB
                }
                else
                {
                     "[ "+((Get-Date)).ToLongTimeString()+ " ]" + " Update failed : " + $items.KB
                }
			}
			catch
			{
                Write-Warning [(Get-Date).ToLongTimeString()] "Error : "
				Write-Error $_.Exception.Message
			}
	    }
#Message de fin de mise à jour
        "[ "+((Get-Date)).ToLongTimeString()+" ] " + @{$true="Update is finished";$false="Updates are finished"}[$nbUpdateToDo -eq 1]

#Vérifier si le pc doit redémarre        
        $status = Get-WURebootStatus
        if($status.RebootRequired -eq 1)
        {
            Write-Host "Redémarrage en cours"
            shutdown.exe /r /t 60 
        }
        else 
        { 
            "[ "+((Get-Date)).ToLongTimeString()+" ]" + " Not necessary to restart computer";
        }   
    }
else
{ 
	"[ "+((Get-Date)).ToLongTimeString()+" ]" + " No update found , Pc is up to date" 
}
}