# Import required modules
Import-Module -Name MicrosoftTeams

Connect-MicrosoftTeams

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

foreach($user in $CSV) {
$name = $user.UserName
$number = $user.Number

Set-CsPhoneNumberAssignment -Identity $name -PhoneNumber $number -PhoneNumberType CallingPlan

echo ($user.UserName + " has been assigned " + $user.Number)
}
