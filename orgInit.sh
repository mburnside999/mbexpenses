sfdx shane:org:create --verbose --userprefix=mike --userdomain=mbexp.com -f config/project-scratch-def.json -d 30 -s -a mbexpenses 
sfdx force:source:push
sfdx shane:user:password:set -p sfdx1234 -g User -l User
sfdx force:org:open -p /lightning/o/Contact/list?filterName=AllContacts
