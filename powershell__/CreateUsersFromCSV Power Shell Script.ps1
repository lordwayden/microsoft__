# CreateUsersFromCSV Power Shell Script for adding users to AD throug csv file
# Import required modules
Import-Module ActiveDirectory

# Create a new password
$securePssword = ConvertTo-SecureString "TESTpasswOrd!" -AsPlainText -Force

# Prompt user for CSV file path
$filepath = Read-Host -Prompt "Please enter the path to your CVS file"

# Import the file into a variable
$users = Improt-Csv $filepath

# Strt script and add path to file
# Loop the file into a veriable
ForEach ($user in $users) {

    # Gather the user's information
    $fname = $user.'First Name'
    $lname = $user.'Lirst Name'
    $jname = $user.'Job Title'
    $officephone = $user.'Office Phone'
    $emailaddress = $user.'Email Address'
    $description = $user.Description
    $OUpath = $user.'Organizational Unit'

    # Create new AD use for each user in CSV file
    New-ADUser -Name "$fname $lname" -GivenName $fname -Surname $lname -UserPrincipalName "$fname.$lname: -Path $OUpath -AccountPassword $securePassword -ChangePasswordAtLogon $True -OfficePhone $officephone -EmailAddress $emailaddress -Description $description -Enabled $True

    # Echo output for each new user
    echo "Account created for $fname $lname in $OUpath"
}