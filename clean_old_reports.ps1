#clean out paths provided
#THIS DELETES THINGS

#change this to whatever you like
#i find 35 leaves ~1mo worth of dailies/weeklies and 2mo worth of monthly reports
$numDays = 35

$paths = @()

$paths += "C:\Junk"
$paths += "C:\Reports"
#add any other paths here

function Write-Message{
    param(
        [String]$message,
        [String]$path = "C:\Junk\cleanlog.txt"
    )
	$timestamp = "[{0:MM/dd/yy} {0:HH:mm:ss}]" -f (Get-Date)
    Write-Output "$timestamp $message" | Out-File $path -Append

}



$today = Get-Date
$deletiondate = $today.AddDays(-$numDays)

Write-Message "New run initializing under user context $($env:USERNAME)"

foreach($path in $paths){
	$deletelist = Get-ChildItem $path | Where-Object { $_.LastWriteTime -lt $deletiondate }
	Write-Message "Deleting the following files from $path :"
	Write-Message $deletelist
	$deletelist | Remove-Item
}