#!/bin/bash

# 建立结果文件

# 传参数顺序: 源apply_form_id,目标apply_id,目标create_user_id(例:sx,nj),目标create_user(例:南靖自来水有限公司)

# eg:  ./dumplcbd.sh c4928be4412a43fea75263a18c387f54 e9a8d125cd734dfdb6a53ee01b1c5fba nj 水系科技
DBIP=192.168.199.100
DBUSER=sxadmin
DBPASSWD=sx@123
DBPORT=3306


touch mgbd.sql

/usr/bin/mysqldump -P$DBPORT -u$DBUSER -p$DBPASSWD -h$DBIP --no-create-info --compact --where="id='$1'" cs_y_run_dyy cs_apply_form > mgbd.sql
# /usr/bin/mysqldump -H$DBPORT -usxadmin -psx@123 -h192.168.199.100 --no-create-info --compact --where="id='$1'" cs_y_run_dyy cs_apply_form > mgbd.sql

APPLYID=`awk -F, 'NR=1{print $2}' ./mgbd.sql | sed "s/'//g"`
# echo $APPLYID
CREATEUSERID=`awk -F, 'NR=1{print $(NF-5)}' ./mgbd.sql | sed "s/'//g"`
# echo $CREATEUSERID
CREATEUSER=`awk -F, 'NR=1{print $(NF-4)}' ./mgbd.sql | sed "s/'//g"`
# echo $CREATEUSER
# echo $3
PROCESSID=`awk -F, 'NR=1{print $8}' ./mgbd.sql | sed "s/'//g"`
# echo $PROCESSID


/usr/bin/mysqldump -P$DBPORT -u$DBUSER -p$DBPASSWD -h$DBIP --no-create-info --skip-extended-insert --compact --where="apply_form_id='$1'" cs_y_run_dyy cs_apply_form_field >> mgbd.sql

TBNAME=`awk -F, 'NR!=1{print $(NF-7)}' ./mgbd.sql | awk '!a[$0]++' | sed "s/'//g"`
# echo $TBNAME


COLID=`awk -F, '{print $1}' ./mgbd.sql | awk '{print $NF}' | cut -c3-34`
# echo $COLID


/usr/bin/mysqldump -P$DBPORT -u$DBUSER -p$DBPASSWD -h$DBIP  --skip-extended-insert --compact cs_y_run_dyy $TBNAME >> mgbd.sql

CONSTR=`grep CONSTRAINT ./mgbd.sql | awk '{print $2}' | sed 's/\`//g'`

# echo $CONSTR
# exit


# LOOPNUM=`echo $TBNAME | awk '{print NF}'`
# echo $LOOPNUM

/usr/bin/mysqldump -P$DBPORT -u$DBUSER -p$DBPASSWD -h$DBIP --no-create-info --skip-extended-insert --compact --where="id='$PROCESSID'" cs_y_run_dyy wf_process >> mgbd.sql
/usr/bin/mysqldump -P$DBPORT -u$DBUSER -p$DBPASSWD -h$DBIP --no-create-info  --skip-extended-insert --compact --where="apply_form_id='$1'" cs_y_run_dyy cs_flow_attr >> mgbd.sql
/usr/bin/mysqldump -P$DBPORT -u$DBUSER -p$DBPASSWD -h$DBIP --no-create-info --skip-extended-insert --compact --where="apply_form_id='$1'" cs_y_run_dyy cs_flow_node >> mgbd.sql
/usr/bin/mysqldump -P$DBPORT -u$DBUSER -p$DBPASSWD -h$DBIP  --no-create-info --skip-extended-insert --compact --where="apply_form_id='$1'" cs_y_run_dyy cs_flow_node_field >> mgbd.sql

LASTCOLID=`sed -n '/wf_process/,$p' ./mgbd.sql | awk -F, '{print $1}' | awk '{print $5}' | sed s/\'//g | sed s/\(//g`
# echo $LASTCOLID


LONGVAR=`cat ./mgbd.sql`
#cat ./mgbd.sql
#echo $LONGVAR

array=(${CONSTR// /})

 for var in ${array[@]}
	do
	# echo $var
	nvar=`cat /proc/sys/kernel/random/uuid |  sed 's/-//g'`
	nvar="cst_"$nvar
# 	echo $nvar
	#nvar=`echo $var | sed 's/1/2/g' | sed 's/$CREATEUSERID/$4/g'`
    LONGVAR=`echo $LONGVAR | sed s/$var/$nvar/g`
    done

# echo $LONGVAR


array=(${TBNAME// /})

 for var in ${array[@]}
	do
	# echo $var
	dt=`date +%s`
    rd=`echo $RANDOM | cut -c1-3`
	nvar=$3"_"$dt$rd
	 
# 	echo $nvar
	#nvar=`echo $var | sed 's/1/2/g' | sed 's/$CREATEUSERID/$4/g'`
    LONGVAR=`echo $LONGVAR | sed s/$var/$nvar/g`
    done

# echo $LONGVAR

array=(${COLID// /})
 
 for var in ${array[@]}
	do
   #  echo $var
    nvar=`cat /proc/sys/kernel/random/uuid |  sed 's/-//g'`
    LONGVAR=`echo $LONGVAR | sed s/$var/$nvar/g`
    done


 array=(${LASTCOLID// /})
 
   for var in ${array[@]}
     do
     #  echo $var
     nvar=`cat /proc/sys/kernel/random/uuid |  sed 's/-//g'`
     LONGVAR=`echo $LONGVAR | sed s/$var/$nvar/g`
     done


 LONGVAR=`echo $LONGVAR | sed s/$CREATEUSER/$4/g`
 LONGVAR=`echo $LONGVAR | sed s/$APPLYID/$2/g`
 LONGVAR=`echo $LONGVAR | sed s/\'$CREATEUSERID\'/\'$3\'/g`
 LONGVAR=`echo $LONGVAR | sed s/cst_/nst_/g`

 nvar=`cat /proc/sys/kernel/random/uuid |  sed 's/-//g'`
 LONGVAR=`echo $LONGVAR | sed s/$PROCESSID/$nvar/g`

 echo $LONGVAR > mgbdn.sql




LOOPNUM=`echo $COLID | awk '{print NF}'`
# echo $LOOPNUM
UUID=`cat /proc/sys/kernel/random/uuid | sed 's/-//g'`

#echo $UUID

NTBNAME=`echo -e $TBNAME | sed 's/1/2/g'`

# echo $NTBNAME | awk '{print $3}'

# /usr/bin/mysqldump -usxadmin -psx@123 -h192.168.199.100  --skip-extended-insert --compact cs_y_run_dyy $TBNAME >> mgbd.sql

