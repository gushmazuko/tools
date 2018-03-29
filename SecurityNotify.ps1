<#
.SYNOPSIS
	This is script for Control (disable|enable) the Security and Maintenance Notifications on Windows 10
.NOTES
	Function   : SecurityNotify
	File Name  : SecurityNotify.ps1
	Author     : Gushmazuko
.LINK
	https://github.com/gushmazuko/tools/blob/master/SecurityNotify.ps1
.EXAMPLE
	powershell.exe IEX(New-Object Net.WebClient).DownloadString('http://192.168.0.30/SecurityNotify.ps1'); SecurityNotify -set 0
	
	set 0 = disable & set 1 = enable
#>

function SecurityNotify(){
	Param (

		[String]$set
	)


	#Remove registry structure
	#Remove-Item "HKCU:\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.SecurityAndMaintenance" -Recurse -Force

	#Create registry structure
	#Start-Sleep 6
	New-Item "HKCU:\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.SecurityAndMaintenance" -Force
	New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.SecurityAndMaintenance" -Name "Enabled" -Type "DWORD" -Value $set -Force

	#Check egistry structure
	#Get-ItemProperty -Path Registry::HKCU\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.SecurityAndMaintenance
}
