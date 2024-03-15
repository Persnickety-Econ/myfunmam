#!/bin/bash

export mam_id=<your.mam.id>

unsat=$(wget -O - -o /dev/null --header "Cookie: mam_id=${mam_id}" --save-cookies /your/path/to/MAM.cookies hXXps://~/jsonLoad.php?snatch_summary)
 
unsat=$(echo $unsat | jq .unsat.count)

echo "
Unsat Count: ${unsat}

"

comics=$(wget -O - -o /dev/null --load-cookies /your/path/to/MAM.cookies --save-cookies /your/path/to/MAM.cookies "hXXps://~/tor/js/loadSearchJSONbasic.php?tor[srchIn][title]=true&tor[srchIn][author]=true&tor[srchIn][series]=true&tor[searchType]=all&tor[searchIn]=torrents&tor[cat][]=61&tor[cat][]=0&tor[unit]=1&tor[startNumber]=0&tor[sortType]=dateAsc&perpage=1")

totalcomics=$(echo $comics | jq .found)

timenow=$(TZ=America/New_York jq -n -r 'now | strflocaltime("%a %b %d, %Y %Z %H:%M:%S")')

firstcomics=$(echo $comics | jq .data | jq .[0] | jq -r .added)

echo "
Total Comics Uploaded As Of ${timenow}: ${totalcomics}

First Comic Uploaded: ${firstcomics}
"