# OCEAN STREAMS

![Ocean Streams](/logo/ocean-streams-nobg.png)

## About Ocean Streams

Ocean Streams in an [OpenSensorHub](http://www.opensensorhub.org) powered project for maritime and oceanographic systems
and
platforms employing Open Geospatial Consortium's globally recognized Connected Systems standard enabling collecting,
recording, and processing sensor observations and tasking.

### Repositories

https://github.com/nickgaray/ocean-streams.git

#### Requirements

This project requires Java 17 or higher.

For quick download and installation: [OpenLogic OpenJDK Downloads](https://www.openlogic.com/openjdk-downloads)

#### Synopsis

The current “node” source code of OpenSensorHub is located at GitHub. The repositories contain the source code necessary
to build a new OSH node, driver, processes, and libraries, but they also make use of the OpenSensorHub open source core
and addons. These open source technologies are referred to by the respective repositories they are employed in as "
submodules." Therefore, it is important to note that when using git commands to “checkout” any one of these
repositories, you do so with the following command:

         git clone -–recursive https://github.com/nickgaray/ocean-streams.git

## Setting the Keystore

To set a keystore for Java in the PKCS12 (.p12) format, you can use the keytool command. Here are the steps:

### Generate a Keystore

If you don’t already have a keystore, you can create one using the following command:

    keytool -genkeypair -alias mykey -keyalg RSA -keystore keystore.jks -storetype JKS

This command generates a keystore in the JKS format.

### Convert the Keystore to PKCS12

To convert the JKS keystore to PKCS12, use the following command:

    keytool -importkeystore -srckeystore keystore.jks -destkeystore keystore.p12 -srcstoretype JKS -deststoretype PKCS12 -deststorepass [password] -srcalias mykey

- **password**: The password set when generating the keystore

Replace keystore.jks with the path to your JKS keystore, keystore.p12 with the desired path for your PKCS12 keystore,
and password with your desired password1.

### Verify the Keystore

You can verify the contents of your new PKCS12 keystore using:

    keytool -list -v -keystore keystore.p12 -storetype PKCS12

### Update OSH Distribution Artifact

1. Copy the ```keystore.p12``` file to ./dist/keystores/osh-keystore.p12
2. Change the ```-Djavax.net.ssl.keyStorePassword="osh-keystore"``` in the launch scripts to password assigned when
   creating the keystore file

## Building and Deploying the Node

### Gradle

Building the Node with Jetty deployable web server from the command line is as simple as checking the repository out and
building with a simple command

         git clone --recursive https://github.com/nickgaray/ocean-streams.git
         cd ocean-streams
         ./gradlew build -x test

The resulting build will be contained in /ocean-streams/build/distributions/osh-node-*.*.*.zip

Deploying is as simple as copying the zip file to the target destination and unzipping the file. You can then run
./launch.sh in Linux or ./launch.bat in Windows environment to startup OpenSensorHub.

#### Default OSH Configuration

With the deployment package, there is a ***config.json*** file containing a default configuration of
OpenSensorHub. Within this configuration, only default users and services are configured.
The default administrative credentials are

    uname: admin
    password: admin

The default port is

    port: 8080

The default URL to access the admin panel is:

    https://<address>/sensorhub/admin

where **address** is the URL or IP address of the system hosting OpenSensorHub

The deployment name can be see in the about section of the admin panel. This string can be changed by editing the
config.json **AdminUIConfig** section **deploymentName** value.  The default value is shown below.

    {
        "objClass": "org.sensorhub.ui.AdminUIConfig",
        "widgetSet": "org.sensorhub.ui.SensorHubWidgetSet",
        "bundleRepoUrls": [],
        "customPanels": [],
        "customForms": [],
        "id": "5cb05c9c-9123-4fa1-8731-ffaa51489678",
        "moduleClass": "org.sensorhub.ui.AdminUIModule",
        "name": "Admin UI",
        "deploymentName": "Ocean Streams",
        "autoStart": true
    },

## Viewing Log Files

The general log file is accessible through the external volumes at

    .moduledata/log.txt

Log files for drivers, services, etc. are accessible through

    /home/osh/osh_config/.moduledata

For a specific module, the log files are contained within subdirectory given the module's unique identifier
