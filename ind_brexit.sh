results=$(curl 'https://oap.ind.nl/oap/api/desks/f0ef3c8f0973875936329d713a68c5f3/slots/?productKey=c7fbba7eca171491f0e6ddb480a87065&persons=1' | tail -n 1 | jq '.data | length')
if (( $results != 0)); then
    first=$(curl 'https://oap.ind.nl/oap/api/desks/f0ef3c8f0973875936329d713a68c5f3/slots/?productKey=c7fbba7eca171491f0e6ddb480a87065&persons=1' | tail -n 1 | jq '.data[0]| "\(.date) \(.startTime)"')
    echo "Found stuff at ${first}"
    echo ${first} | cat ind_brexit_email_template.txt - | sendmail -vt your_email@example.com
else
    date >> ~/code/ind_brexit_status.txt
    echo "Nothing found" >> ~/code/ind_brexit_status.txt
fi
