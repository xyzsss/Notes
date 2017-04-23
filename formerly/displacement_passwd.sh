#!/bin/bash
#source：xpkvsbotijzfm displacement pasword for encrypt
#for continued

dc=([97]='a' [98]='b' [99]='c'  [100]='d'  [101]='e'  [102]='f'  [103]='g'  [104]='h'  [105]='i'  [106]='j'  [107]='k'  [108]='l'  [109]='m'  [110]='n'  [111]='o'  [112]='p'  [113]='q'  [114]='r'  [115]='s' [116]='t' [117]='u' [118]='v' [119]='w' [120]='x' [121]='y' [122]='z')
# number 
len=${#dc[@]}
#echo $len

var="abc"
#var="xpkvsbotijzfm"
var_len=${#var}

#for ((i=0;i<$len;i++));do
#    echo ${dc[$i]}
#done

#remove times.value between  1-25
t=1


s=""
for((i=0;i<$var_len;i++))
do
	#get letter ANSCII value, move times;if move results bigger than 122,than value of a reduce 26
	s=${var:$i:1}
	nu=`printf "%d\n"  "'$s"`
	nu=`expr $nu + $t`
	if [[ $nu > 122  ]]
	then
		nu=`expr $nu - 26 `
	fi

	# mapping number to alphabet  
	for((j=97;j<123 ;j++))
	do
		if [[ $j -eq $nu ]]
		then 
			#echo ${dc[$j]}
			ts=${dc[$j]}
		fi
	done
	echo ${var:$i:1}
	sleep 1
	echo $ts 
	sleep 1
	#printf "\t%d\n"  "'$s"
done
echo $s

#echo ${dc}
