# DBPASSWD=sx@123
# DBPORT=3306
# DBNAME=cs_y_run
DBIP=localhost
DBUSER=admin
DBPASSWD=123
DBPORT=3306
DBNAME=cs_y_run

/usr/bin/mysqldump -P$DBPORT -u$DBUSER -p$DBPASSWD -h$DBIP --no-create-info --skip-extended-insert --compact --where="id='$1'" $DBNAME cs_apply > tempapp.sql
/usr/bin/mysqldump -P$DBPORT -u$DBUSER -p$DBPASSWD -h$DBIP --no-create-info --skip-extended-insert --compact --where="apply_id='$1'" $DBNAME cs_apply_group >> tempapp.sql
/usr/bin/mysqldump -P$DBPORT -u$DBUSER -p$DBPASSWD -h$DBIP --no-create-info --skip-extended-insert --compact --where="apply_id='$1'  and type in(1,2)" $DBNAME cs_apply_form >> tempapp.sql

NEWAPPID=`cat /proc/sys/kernel/random/uuid | sed 's/-//g'`

echo ############## NOTICE ###########################
echo APPLY_ID替换:
echo $1:$NEWAPPID

CREATEUSERID=`awk -F, 'NR==1{print $12}' ./tempapp.sql | sed "s/'//g"`
# echo $CREATEUSERID
CREATEUSER=`awk -F, 'NR==1{print $13}' ./tempapp.sql | sed "s/'//g"`
# echo $CREATEUSERID

GROUPID=`grep cs_apply_group ./tempapp.sql | awk -F, '{print $1}' | awk '{print $5}' | sed s/\'//g | sed s/\(//g`


sed -n '/cs_apply_form/,$p' ./tempapp.sql | awk -F, '{print $1,$3,$8}' | sed s/[\(\']//g | awk '{if(length($7)>5) print "./dumpnjlcbd.sh",$5,"'$NEWAPPID'","'$2'","'$3'",$6}' > BDTODO
sed -n '/cs_apply_form/,$p' ./tempapp.sql | awk -F, '{print $1,$3,$8}' | sed s/[\(\']//g | awk '{if(length($7)<5) print "./dumpnjsmbd.sh",$5,"'$NEWAPPID'","'$2'","'$3'",$6}' >>BDTODO
#sed -n '/cs_apply_form/,$p' ./tempapp.sql | awk -F, '{print $1,$3,$8}' | awk '{print $7,$5,"'$NEWAPPID'","nj","水系科技",$6}' | sed s/[\(\']//g > dump.script
#echo $APPFORMID

echo ############## NOTICE ###########################
echo "本应用组ID替换如下:"

LONGVAR=`sed /cs_apply_form/d ./tempapp.sql`
BDTODOVAR=`cat ./BDTODO`

#  echo "$LONGVAR" > group.sql

# exit

# echo $LONGVAR

array=(${GROUPID// /})

for var in ${array[@]}
do
# echo $var
nvar=`cat /proc/sys/kernel/random/uuid | sed 's/-//g'`
echo $var:$nvar
LONGVAR=`echo  "$LONGVAR" | sed s/$var/$nvar/g`
BDTODOVAR=`echo  "$BDTODOVAR" | sed s/$var/$nvar/g`
done

LONGVAR=`echo  "$LONGVAR" | sed s/$CREATEUSER/$3/g`
LONGVAR=`echo  "$LONGVAR" | sed s/$CREATEUSERID/$2/g`
LONGVAR=`echo  "$LONGVAR" | sed s/$1/$NEWAPPID/g`

echo ############## NOTICE ###########################
echo "本应用包含如下表单ID:"
#echo "$BDTODOVAR" | sed s/\'/\"\'/g | sed s/..$/\'\"/g
echo "$BDTODOVAR"
echo "$BDTODOVAR" > BDTODO

# mkdir appsql
echo "$LONGVAR" > ./appsql/apptodo.sql
