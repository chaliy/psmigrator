function Start-Migration {
[CmdletBinding()]
Param(
    
)
    Get-ChildItem *.ps1 | %{
        Invoke-Expression (Get-Content $_.FullName)
    }
    
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
