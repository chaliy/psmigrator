push-location
$here = (Split-Path -parent $MyInvocation.MyCommand.Definition)
import-module -name $here\PsMigrator\PsMigrator.psm1

push-location
set-location $here\TestMigrations\SimpleMigration
start-migration -Verbose
#remove-item $here\TestMigrations\SimpleMigration\.PsMigrator
push-location


pop-location