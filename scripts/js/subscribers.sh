export TOKEN=`sfdx force:org:display -u CTA5 --json  | grep -o '"accessToken": "[^"]*' | cut -d'"' -f4`
# select from packagesubscriber
curl https://ctademo5.my.salesforce.com/services/data/v51.0/query?q='select+id+,+installedstatus+,+orgkey+,+orgName+from+packagesubscriber' -H "Authorization: Bearer $TOKEN" | json_pp
