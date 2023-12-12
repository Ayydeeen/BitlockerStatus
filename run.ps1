$names = @()
$data = Get-ADObject -Filter {ObjectClass -eq 'msFVE-RecoveryInformation'} -SearchBase "OU=Your OU,DC=Domain,DC=local" | Select-Object -ExpandProperty DistinguishedName

foreach ($i in $data) {
    $n = ([adsi]"LDAP://$i").Parent.Replace('LDAP://','')
    $names += (Get-ADComputer -Identity $n).Name
}

$uniqueNames = $names | Get-Unique
$uniqueNames | Out-File -FilePath "C:\temp\bitlocker.csv" -Force
