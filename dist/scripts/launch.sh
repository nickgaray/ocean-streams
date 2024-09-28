#!/bin/bash

# Make sure all the necessary certificates are trusted by the system.
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
"$SCRIPT_DIR/load_trusted_certs.sh"

# Start the node
java -Xmx2g \
-Dlogback.configurationFile=./config/logback.xml \
-cp "lib/*" \
-Djavax.net.ssl.keyStore="./config/osh-keystore.p12" \
-Djavax.net.ssl.keyStorePassword="osh-keystore" \
-Djavax.net.ssl.trustStore="$SCRIPT_DIR/trustStore.jks" \
-Djavax.net.ssl.trustStorePassword="changeit" \
-Djava.system.class.loader="org.sensorhub.utils.NativeClassLoader" \
org.sensorhub.impl.SensorHub ./config/config.json ./db