printf "\ngetting packageid for $PKGNAME\n"
curl https://ctademo5.my.salesforce.com/services/data/v51.0/query?q="SELECT+Id+,+Name+,+NamespacePrefix+,+PackageCategory+,+SystemModstamp+FROM+MetadataPackage+where+Name+=+'$PKGNAME'" -H "Authorization: Bearer $TOKEN" | json_pp > y.tmp
export PKGID=`grep '"Id" : "[^"]*' y.tmp | cut  -d'"' -f4`
printf "\npackageid: $PKGID\n"
curl https://ctademo5.my.salesforce.com/services/data/v51.0/query?q="SELECT+BuildNumber+,+Id+,+IsDeprecated+,+MetadataPackageId+,+Name+,+MajorVersion+,+MinorVersion+,+PatchVersion+,+ReleaseState+,+SystemModstamp+FROM+MetadataPackageVersion+where+metadatapackageid=+'$PKGID'+order+by+systemmodstamp+desc+limit+1" -H "Authorization: Bearer $TOKEN" | json_pp > y2.tmp
export PKGV=`grep '"Id" : "[^"]*' y2.tmp | cut  -d'"' -f4`
printf "\nPackage VersionId: $PKGV\n"
printf "\nDone\n"
