# Import required modules
Import-Module ActiveDirectory

#File Path
[System.Reflection.Assembly]::LoadWithPartialName("system.windows.forms") | Out-Null

#Dialog box and open file
$dialog = New-Object System.Windows.Forms.OpenFileDialog
$dialog.InitialDirectory = "C:\"
$dialog.Filter = "CSV (*.csv) | *.csv"
$dialog.ShowDialog() | Out-Null

# store file path in variable
$CSVFile = $dialog.FileName

# validate file path
# if not valid exit
if([System.IO.File]::Exists($CSVFile)) {
    Write-Host "Importing CSV...."
    $CSV = Import-Csv -LiteralPath "$CSVFile"
} else {
    Write-Host "File specified was invalid"
    Exit
}
#Loop through each user in the CSV and add appropriate group
foreach($user in $CSV) {

#setup variable - Please use the appropriate input form with UserNames & Group as headers exactly!
$name = $user.UserName

#if a user needs multiple groups, please add the user on multiple lines.
Add-ADGroupMember -Identity "teams_ad_group_License" -Members $name
echo ($user.Username + " added to App Group - teams_ad_group_License")
}
