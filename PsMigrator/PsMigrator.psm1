function Start-Migration {
[CmdletBinding()]
Param(
    
)
    function ConvertTo-StringData($Data)
    { 
        $buffer = New-Object Text.StringBuilder
        foreach($key in $Data.Keys){    
            $buffer.AppendLine( $key + "=" + $Data[$key] ) | Out-Null  
        }        
        $buffer.ToString()   
    }
    
    
    $state = @{}
    if (Test-Path .PsMigrator) {        
        Write-Verbose "Load migration state from .PsMigrator file"
        $psMigratorFullPath = Resolve-Path .PsMigrator
        $state = ConvertFrom-StringData ([IO.File]::ReadAllText($psMigratorFullPath))    
    }
    $lastMigration = $null
    if ($state.LastMigration){        
        $lastMigration = $state.LastMigration
    }
    
    $runNextMigration = ( $lastMigration -eq $null )
    Get-ChildItem *.ps1 | sort Name | %{
        if ($runNextMigration){
            Write-Host "Running migration $_.Name"
            Write-Verbose "Migration full path is $_.FullName"
            & $_.FullName
            Write-Verbose "Migration $_.Name compelted"
            $lastMigration = $_.Name
        }
        if ($_.Name -eq $lastMigration){
            $runNextMigration = $true
        }
    }
    
    Set-Content .PsMigrator (ConvertTo-StringData @{ LastMigration = $lastMigration } )
    
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
