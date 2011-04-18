PsMigrator Tool
===============

Set of commands to automate migrations.

Features
========

1. Any scriptable by PowerShell migrations supported.
2. Support for plain SQL migrations.

Examples
========

Typical migration is set of scripts, each script represents single step. For example content of the folder with migration can look as the following:

    01_InitApplicaitom.ps1
    02_AddFeature1.ps1
    03_MigrateData.sql

This migration has three steps, PsMigrator will execute them in order of the name. There is no special requirement about name, exept that it should be sortable in right way. You can see that first two has PS1 extension, this is ad-hock migration steps, could be anything that PowerShell supports. Last migration is SQL. By default, PsMigrator will just execute all SQL scripts against local SQL Server. Of course, this is configurable.

To run this migration. Change directory and run Start-Migration

    cd MyMigration
    start-migration

To configure migrator to run against other then local SQL Server, change connection string

    update-migrationconfig -ConnectionString "Server = FOO;Integrated Security=True"

Installation
============

With [PsGet](https://github.com/chaliy/psget/) run:

    install-module https://github.com/chaliy/psmigrator/raw/master/PsMigrator/PsMigrator.psm1

Roadmap
=======

Roadmap is not sorted in any order. This is just list what is think should be done.

1. Support WhatIf switch
2. Support rollback for steps
