#!/bin/bash
# 传参数顺序: 源apply_id,目标apply_id,目标create_user_id(例:sx,nj),目标create_user(例:南靖自来水有限公司)

# eg:  ./dumplcbd.sh c4928be4412a43fea75263a18c387f54 e9a8d125cd734dfdb6a53ee01b1c5fba nj 水系科技
DBIP=localhost
DBUSER=sxadmin
DBPASSWD=sx@123
DBPORT=3306
DBNAME=cs_y_run




/usr/bin/mysqldump -P$DBPORT -u$DBUSER -p$DBPASSWD -h$DBIP --no-create-info --skip-extended-insert --compact --where="apply_id='$1'" $DBNAME cs_apply_group > mgapp.sql

/usr/bin/mysqldump -P$DBPORT -u$DBUSER -p$DBPASSWD -h$DBIP --no-create-info --skip-extended-insert --compact --where="apply_id='$1'" $DBNAME cs_apply_form >> mgapp.sql

APPLYID=`awk -F, 'NR=1{print $2}' ./mgbd.sql | sed "s/'//g"`
# echo $APPLYID
CREATEUSERID=`awk -F, 'NR=1{print $(NF-5)}' ./mgbd.sql | sed "s/'//g"`
# echo $CREATEUSERID
CREATEUSER=`awk -F, 'NR=1{print $(NF-4)}' ./mgbd.sql | sed "s/'//g"`
#

APPFORMID=`sed -n '/cs_apply_form/,$p' ./mgapp.sql | awk -F, '{print $1,$8}' | awk '{print $5,$6}'`

GROUPID=`grep cs_apply_group ./mgapp.sql | awk -F, '{print $1}' | awk '{print $5}' | sed s/\'//g | sed s/\(//g`

echo "本应用包含如下表单ID:"

echo $APPFORMID

echo "本应用组ID替换如下:"

LONGVAR=`sed /cs_apply_form/d ./mgapp.sql`

# echo $LONGVAR

array=(${GROUPID// /})

  for var in ${array[@]}
    do
    #  echo $var
     nvar=`cat /proc/sys/kernel/random/uuid |  sed 's/-//g'`
     echo $var:$nvar
     LONGVAR=`echo $LONGVAR | sed s/$var/$nvar/g`
     done


   LONGVAR=`echo $LONGVAR | sed s/$CREATEUSER/$4/g`
   LONGVAR=`echo $LONGVAR | sed s/$APPLYID/$2/g`
   LONGVAR=`echo $LONGVAR | sed s/\'$CREATEUSERID\'/\'$3\'/g`

   echo $LONGVAR > mgappn.sql



exit
