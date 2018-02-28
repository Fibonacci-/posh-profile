
Import-Module posh-git
Set-Location C:\git\
Function ffdeploy {firebase deploy --only functions}
Function gitsend([string]$commitmessage){
	git add .
	git commit -m $commitmessage
	git push
}