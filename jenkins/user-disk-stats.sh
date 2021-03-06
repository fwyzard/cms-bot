#!/bin/bash
base=$1
[ "${base}" != "" ] || exit 1
[ -d "${base}" ] || exit 1
items=$(ls -l $base | grep '^d' | grep ' zh ' | awk '{print $3":"$9}' | sort ) 
for user in $(echo $items | tr ' ' '\n' | sed 's|:.*||' | uniq) ; do
  dirs=$(echo $items | tr ' ' '\n' | grep "^${user}:" | sed "s|.*:|${base}/|" | tr '\n' ' ')
  let size=$(du -csm $dirs | tail -1 | sed 's|\s.*||')/1024 || true
  if [ "${size}" != "" -a ${size} -gt 1 ] ; then
    echo "${size}:${user}:${dirs}"
  fi
done
