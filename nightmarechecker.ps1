# Run command to get the status of Spooler
write-host("`n====Checking if System is vulnerable to CVE-2021-34527====") -ForegroundColor Green
$result = @(Get-Service -Name Spooler)

# Now we get the object property Status to check if is running
$result2 = $result | Select -ExpandProperty "Status"

# Check if $result2 = Running if yes system is vulnerable else System is safe
if ($result2 -eq "Running"){
		#highlight syntax red
		write-host ("`nSystem printer spooler service is Running! `nSystem is") -ForegroundColor white -NoNewline; Write-host(" vulnerable!") -ForegroundColor Red -NoNewline; 
		# Prompt user to disable print spooler and disable service
		$enable = Read-Host -Prompt "`n`nDo you want to disable spooler service and disable service from starting up? `nWarning after enabling this you will not be able to use the printer ! [Y] [N]"
		if ($enable -like "Y"){
			write-output("`nDisabling printer service")
			Stop-Service -Name Spooler -Force
			write-output("Disabling startup for printer service")
			Set-Service -Name Spooler -StartupType Disabled
			write-host("`nSystem is ") -ForegroundColor white -NoNewline; write-host("not vulnerable") -ForegroundColor Green -NoNewline; Write-host(" to CVE-2021-34527") -ForegroundColor white -NoNewline;
		}else{
			write-host("`nYour system is ") -ForegroundColor white -NoNewline; Write-host("vulnerable!") -ForegroundColor Red -NoNewline; Write-host(" Please disable the printer service!") -ForegroundColor white -NoNewline;
		}

}else {
	#highlight syntax green
	write-host("`nSystem is ") -ForegroundColor white -NoNewline; write-host("not vulnerable") -ForegroundColor Green -NoNewline; Write-host(" to CVE-2021-34527") -ForegroundColor white -NoNewline;
	
}

