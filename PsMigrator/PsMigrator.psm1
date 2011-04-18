function Start-Migration {
[CmdletBinding()]
Param(
    
)
	function StoreState($state){
		$buffer = New-Object Text.StringBuilder
        foreach($key in $state.Keys){			
            $buffer.AppendLine( $key + "=" + $state[$key] ) | Out-Null  
        }
		Set-Content ".PsMigrator" ( $buffer.ToString() )	
	}
	
	function LoadState(){
		if (Test-Path .PsMigrator) {       
			Write-Verbose "Load migration state from .PsMigrator file"
			$psMigratorFullPath = Resolve-Path .PsMigrator
			return ConvertFrom-StringData ([IO.File]::ReadAllText($psMigratorFullPath))    
		}	
		return @{}
	}
   	
		
	# Actual execution
    $state = LoadState
	    
    $runNextMigration = ( $state.LastMigration -eq $null )
    Get-ChildItem *.ps1 | where-object {$_.Extension -match ".ps1|.sql" } | sort Name | %{
		$migrationName = ($_.Name)
        if ($runNextMigration){
            Write-Host "Running migration $migrationName"
            Write-Verbose "Migration full path is $_"			
			if ($_.Extension -eq ".sql" ) {
            	# Let's execute 
				Import-Module PsSql
				Invoke-Sql $_.FullName
			} else {
				& $_.FullName
			}
            Write-Verbose "Migration $migrationName compelted"
            $state.LastMigration = $migrationName
        }
        if ($migrationName -eq $state.LastMigration){
            $runNextMigration = $true
        }
    }
    
    StoreState $state
    
<#
.Synopsis
    Migrate stuff from current directory.
.Description
.Example
    Start-Migration

    Description
    -----------
    Starts migration

#>
}


Export-ModuleMember Start-Migration
