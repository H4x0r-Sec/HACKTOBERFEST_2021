#!/bin/bash
remove(){
	delete=$(echo $1 | sed 's/https\?:\/\///' | sed 's/http\?:\/\///')
	printf "Remove HTTP/HTTPS => $1\n"
	echo "$delete">>$saved
}
cat << "EOF"
HAYUKK!
EOF
echo ""
read -p "Pilih List : " listo;
read -p "Simpan (Nama.txt) : " saved;

multithread_limit=5
IFS=$'\r\n' GLOBIGNORE='*' command eval 'list=($(cat $listo))'
for (( i = 0; i < "${#list[@]}"; i++ )); 
do
	target="${list[$i]}"
	((cthread=cthread%multithread_limit)); ((cthread++==0)) && wait
	remove ${target} ${saved}&
done
wait
