 #REQUIRES -Version 2.0

<#
.SYNOPSIS
    Hung's User Admin Tool (HUAT) to manage and implement changes in AD for
	user accounts in the PISADOM01 domain
.DESCRIPTION
    Add and remove user accounts from AD on the Dept of Primary Industries SA
	PISADOM01 domain. Update WiFi certificate requirements by MAC Address. Filter
	the MAC Addresses assigned to user accounts to a report. Remove and add user
	accounts to AD Group Memberships.
.NOTES
    File Name      : HUAT.ps1
    Author         : Danijel James (danijel.james@gmail.com)
    Prerequisite   : PowerShell V2 over Vista and upper.
    Copyright 2017 - Danijel James/danijeljw
.LINK
    Script posted over:
    http://www.github.com
.EXAMPLE
    Example 1
.EXAMPLE
    Example 2
#>

<#
=================
1. IMPORT MODULES
=================
#>
import-module ActiveDirectory

<#
=====================
2. FOREGROUND COLOURS
=====================

Colours that can be used with the '-foreground' switch on the 'write-host' command

    Black
    Blue
    Cyan
    DarkBlue
    DarkCyan
    DarkGray
    DarkGreen
    DarkMagenta
    DarkRed
    DarkYellow
    Gray
    Green
    Magenta
    Red
    White
    Yellow
#>

<#
=========================
3. SET PARAMETER REQUIRED
=========================

	TestUserAdmin	bool test of elevated environment
	AdminDotAcct	op's PISADOM01\admin.XXX user admin account
	AdminDotPass	op's PISADOM01\admin.XXX network password as a secure string (revoked at this time)
	nl				New line for environment text (same ase '\n' in C)
#>
$nl = [Environment]::NewLine
$TestUserAdmin = [bool](([System.Security.Principal.WindowsIdentity]::GetCurrent()).groups -match "S-1-5-32-544")
$AdminDotAcct = Read-Host 'What is your PISADOM01 Admin account?'
#$AdminDotPass = Read-Host 'What is your PISADOM01 Admin password?' -AsSecureString


<#
====================
3. DECLARE FUNCTIONS
====================
#>
<#
function AdminDotAcct{
	$AdminDotAcct2 = Read-Host 'What is your admin account ID?'
}
#>



