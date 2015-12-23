#!/bin/bash

if [ -z ${MIMIC_PASSWORD+x} ]; then
  echo "MIMIC_PASSWORD is unset";
  exit 1
else
  echo "MIMIC_PASSWORD is set";
fi

if [ -z ${MIMIC_DB+x} ]; then
  MIMIC_DB=MIMIC
  echo "MIMIC_DB is unset, using default '$MIMIC_DB'";
else
  echo "MIMIC_DB is set to '$MIMIC_DB'";
fi

if [ -z ${MIMIC_USER+x} ]; then
  MIMIC_USER=MIMIC
  echo "MIMIC_USER is unset, using default '$MIMIC_USER'";
else
  echo "MIMIC_USER is set to '$MIMIC_USER'";
fi

sudo -u postgres psql > /dev/null <<- EOSQL
                CREATE USER MIMIC WITH PASSWORD '$MIMIC_PASSWORD';
                CREATE DATABASE $MIMIC_DB OWNER $MIMIC_USER;
EOSQL
