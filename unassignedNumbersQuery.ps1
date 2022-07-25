Get-CsPhoneNumberAssignment -PstnAssignmentStatus Unassigned|
select TelephoneNumber|
Export-Csv -Path C:\Users\username\Desktop\numbers.csv -Encoding ascii -NoTypeInformation -Append
