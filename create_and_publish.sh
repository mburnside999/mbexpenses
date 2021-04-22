printf "\nGetting a token to DevHub CTA5\n"
export TOKEN=`sfdx force:org:display -u CTA5 --json  | grep -o '"accessToken": "[^"]*' | cut -d'"' -f4`
printf "\nToken: 	$TOKEN\n"

export PKGNAME=mbexpenses

printf "\ngetting packageid for $PKGNAME\n"
curl https://ctademo5.my.salesforce.com/services/data/v51.0/query?q="SELECT+Id+,+Name+,+NamespacePrefix+,+PackageCategory+,+SystemModstamp+FROM+MetadataPackage+where+Name+=+'$PKGNAME'" -H "Authorization: Bearer $TOKEN" | json_pp > y.tmp
export PKGID=`grep '"Id" : "[^"]*' y.tmp | cut  -d'"' -f4`
printf "\npackageid: $PKGID\n"
curl https://ctademo5.my.salesforce.com/services/data/v51.0/query?q="SELECT+BuildNumber+,+Id+,+IsDeprecated+,+MetadataPackageId+,+Name+,+MajorVersion+,+MinorVersion+,+PatchVersion+,+ReleaseState+,+SystemModstamp+FROM+MetadataPackageVersion+where+metadatapackageid=+'$PKGID'+order+by+systemmodstamp+desc+limit+1" -H "Authorization: Bearer $TOKEN" | json_pp > y2.tmp
export PKGV=`grep '"Id" : "[^"]*' y2.tmp | cut  -d'"' -f4`
printf "\nPackage VersionId: $PKGV\n"
printf "\nDone.\n"

#deprecated
#export PKGV=`sfdx force:package:version:list --json |  grep -o '"SubscriberPackageVersionId": "[^"]*' | tail -n 1 | cut -d'"' -f4`

printf "Creating tmp.json with package version:  $PKGV\n"
printf "\n"
printf "{\n\"PackageVersionId\":\"$PKGV\"\n}">tmp.json
printf "\nhere is the generated tmp.json file\n"
cat tmp.json

printf "\nCreating PackagePushRequest\n"
curl https://ctademo5.my.salesforce.com/services/data/v51.0/sobjects/packagepushrequest -H "Content-Type: application/json" -H "Authorization: Bearer $TOKEN" -d @tmp.json > temp
export ODV=`grep '"id":"[^"]*' temp | cut  -d'"' -f4`
printf "\nODV: $ODV\n"
printf "\ncreating the package push job json\n"
printf "{\n\"PackagePushRequestId\":\"$ODV\",\n\"SubscriberOrganizationKey\":\"00D17000000Qlgl\"\n}">tmp2.json
printf "\nhere is the generated tmp2.json file\n"
cat tmp2.json
printf "\ncreating package push job\n"
curl https://ctademo5.my.salesforce.com/services/data/v51.0/sobjects/packagepushjob/ -H "Content-Type: application/json" -H "Authorization: Bearer $TOKEN" -d @tmp2.json
printf "\nkicking off the job at packagepushrequest/$ODV\n"
printf "{\n\"Status\":\"Pending\"\n}">tmp3.json
printf "\nhere is the generated tmp3.json file\n"
cat tmp3.json
curl https://ctademo5.my.salesforce.com/services/data/v51.0/sobjects/packagepushrequest/$ODV -X PATCH -H "Content-Type: application/json" -H "Authorization: Bearer $TOKEN" -d @tmp3.json
printf "\nDone\n\n"
