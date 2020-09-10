#!/bin/bash

# 建立结果文件

# IF $1 = "-h"
# 传参数顺序: 源apply_form_id,目标apply_id,目标create_user_id(例:sx,nj),目标create_user(例:南靖自来水有限公司),组ID(必选: NULL 或 "'b0a9d441f4cd44078710aebaa5973fda'")

# eg: ./dumpnjbd.sh b0a9d441f4cd44078710aebaa5973fda f7e121133d2d4992b2f5e51447bb4e5e nxsw 宁夏水务集团有限公司 "'b0a9d441f4cd44078710aebaa5973fda'"
DBIP=localhost
DBUSER=admin
DBPASSWD=123
DBPORT=3306
DBNAME=cs_y_run_nj



/usr/bin/mysqldump -P$DBPORT -u$DBUSER -p$DBPASSWD -h$DBIP --no-create-info --compact --where="id='$1'" $DBNAME cs_apply_form > tempsmbd.sql
# /usr/bin/mysqldump -H$DBPORT -usxadmin -psx@123 -h192.168.199.100 --no-create-info --compact --where="id='$1'" cs_y_run_dyy cs_apply_form > tempsmbd.sql

MAINTBNAME=`awk -F, 'NR==1{print $12}' ./tempsmbd.sql | sed "s/'//g"`

GROUPID=`awk -F, 'NR==1{print $3}' ./tempsmbd.sql | sed "s/'//g"`

OUTPUTSQL=`awk -F, 'NR=1{print $4}' ./tempsmbd.sql | sed "s/'//g" | sed "s/\///g"`

APPLYID=`awk -F, 'NR=1{print $2}' ./tempsmbd.sql | sed "s/'//g"`
# echo $APPLYID
CREATEUSERID=`awk -F, 'NR=1{print $(NF-5)}' ./tempsmbd.sql | sed "s/'//g"`
# echo $CREATEUSERID
CREATEUSER=`awk -F, 'NR=1{print $(NF-4)}' ./tempsmbd.sql | sed "s/'//g"`
# echo $CREATEUSER
# echo $3
PROCESSID=`awk -F, 'NR=1{print $8}' ./tempsmbd.sql | sed "s/'//g"`
# echo $PROCESSID


/usr/bin/mysqldump -P$DBPORT -u$DBUSER -p$DBPASSWD -h$DBIP --no-create-info --skip-extended-insert --compact --where="apply_form_id='$1'" $DBNAME cs_apply_form_field >> tempsmbd.sql

TBNAME=`awk -F, 'NR!=1{print $(NF-7)}' ./tempsmbd.sql | awk '!a[$0]++' | sed "s/'//g"`

COLID=`awk -F, '{print $1}' ./tempsmbd.sql | awk '{print $NF}' | cut -c3-34`



/usr/bin/mysqldump -P$DBPORT -u$DBUSER -p$DBPASSWD -h$DBIP  --skip-extended-insert --compact $DBNAME $MAINTBNAME >> tempsmbd.sql

# echo $TBNAME
#TBNAME=`echo $TBNAME | sed s/$MAINTBNAME//g`


# 如果表名为空,直接推出
# if [ ${#TBNAME} -lt 5 ]
#   then
#     exit
#    fi

ZITBNAME=`echo "$TBNAME" | sed s/$MAINTBNAME//g`

# echo $COLID

if [ ${#ZITBNAME} -gt 5 ]
     then
		/usr/bin/mysqldump -P$DBPORT -u$DBUSER -p$DBPASSWD -h$DBIP  --skip-extended-insert --compact $DBNAME $ZITBNAME >> tempsmbd.sql
	 fi

CONSTR=`grep CONSTRAINT ./tempsmbd.sql | awk '{print $2}' | sed 's/\`//g'`

# echo $CONSTR
# exit


# LOOPNUM=`echo $TBNAME | awk '{print NF}'`
# echo $LOOPNUM



LONGVAR=`cat ./tempsmbd.sql`
#cat ./tempsmbd.sql
#echo $LONGVAR

# echo $LONGVAR

if [ ${#ZITBNAME} -gt 5 ]
     then
		 LONGVAR=`echo "$LONGVAR" | sed s/$GROUPID/$5/g`
     fi


if [ ${#GROUPID} -gt 5 ]
     then
         LONGVAR=`echo "$LONGVAR" | sed s/$GROUPID/$5/g`
     fi

array=(${CONSTR// /})

 for var in ${array[@]}
	do
	# echo $var
	nvar=`cat /proc/sys/kernel/random/uuid |  sed 's/-//g'`
	nvar="cst_"$nvar
# 	echo $nvar
	#nvar=`echo $var | sed 's/1/2/g' | sed 's/$CREATEUSERID/$4/g'`
    LONGVAR=`echo "$LONGVAR" | sed s/$var/$nvar/g`
    done

# echo $LONGVAR


# 主表重命名
dt=`date +%s`
rd=`echo $RANDOM | cut -c1-3`
nvar=$3"_"$dt$rd
LONGVAR=`echo "$LONGVAR" | sed s/$MAINTBNAME/$nvar/g`

#子表重命名

array=(${ZITBNAME// /})

 for var in ${array[@]}
	do

	# echo $var
	dt=`date +%s`
    rd=`echo $RANDOM | cut -c1-3`
	nvar="w_"$dt$rd
	 
# 	echo $nvar
	#nvar=`echo $var | sed 's/1/2/g' | sed 's/$CREATEUSERID/$4/g'`
    LONGVAR=`echo "$LONGVAR" | sed s/$var/$nvar/g`
    done

# echo $LONGVAR

array=(${COLID// /})
 
 for var in ${array[@]}
	do
   #  echo $var
    nvar=`cat /proc/sys/kernel/random/uuid |  sed 's/-//g'`
    LONGVAR=`echo "$LONGVAR" | sed s/$var/$nvar/g`
    done

 LONGVAR=`echo "$LONGVAR" | sed s/$CREATEUSER/$4/g`
 LONGVAR=`echo "$LONGVAR" | sed s/$APPLYID/$2/g`
 LONGVAR=`echo "$LONGVAR" | sed s/\'$CREATEUSERID\'/\'$3\'/g`
 #  LONGVAR=`echo $LONGVAR | sed s/cst_/nst_/g`


 # LONGVAR=`echo "$LONGVAR" | awk 'BEGIN{FS=OFS=","}$3="'$5'"'`



 echo "$LONGVAR" >> ./appsql/apptodo.sql
#  echo "$LONGVAR" >> ./test.sql




# LOOPNUM=`echo $COLID | awk '{print NF}'`
# echo $LOOPNUM
# UUID=`cat /proc/sys/kernel/random/uuid | sed 's/-//g'`

#echo $UUID

# NTBNAME=`echo -e $TBNAME | sed 's/1/2/g'`

# echo $NTBNAME | awk '{print $3}'

# /usr/bin/mysqldump -usxadmin -psx@123 -h192.168.199.100  --skip-extended-insert --compact cs_y_run_dyy $TBNAME >> tempsmbd.sql

