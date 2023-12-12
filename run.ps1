$data = Get-ADObject -Filter {ObjectClass -eq 'msFVE-RecoveryInformation'} -SearchBase "OU=Your OU,DC=Domain,DC=local" | select -ExpandProperty distinguishedname
foreach ($i in $data) {$n = ([adsi]"LDAP://$i").Parent.Replace('LDAP://',''); echo $n >> C:\temp\distinguished.csv}
foreach ($i in (get-content C:\temp\distinguished.csv)) {$name = get-adcomputer -identity $i | select Name -ExpandProperty Name; $names += (echo $name',')}
echo $names > C:\temp\bitlocker.csv
