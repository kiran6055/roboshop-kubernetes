source /parameter-store/params
mkdir /code
cd /code
git clone https://github.com/kiran6055/${COMPONENT}

# here is ${COMPONENT} is not working then try with out curly brases

if [ $? -ne 0 ]; then
  echo CLONE FAILED
  exit1
fi

cd /code/schema
if [ $SCHEMA_TYPE == "mongodb" ]; then
  curl -L -o https://truststore.pki.rds.amazonaws.com/us-east-1/us-east-1-bundle.pem
  mongo --ssl --host ${DOCDB.ENDPOINT}:27017 --sslCAFile rds-combined-ca-bundle.pem --username ${DOCDB_USER} --password  ${DOCDB_PASS} < /code/schema/${COMPONENT}.js


elif [ $SCHEMA_TYPE == "mysql" ]; then
  mysql -u${MYSQL_USER} -p${MYSQL_PASS} </code/schema/${COMPONENT}.sql
fi

# ${COMPONENT} is getting error then try $COMPONENT