push-location
$here = (Split-Path -parent $MyInvocation.MyCommand.Definition)
Write-Host $here
set-location $here
import-module -name .\PsMigrator\PsMigrator.psm1

push-location
set-location .\TestMigrations\SimpleMigration
start-migration -Verbose
remove-item .\.PsMigrator -ErrorAction Continue
pop-location

pop-location