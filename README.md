# stormDeployer
Makes deployment of Storm jobs much simpler and adds a restart option to existing jobs .

-Please set STORM_HOME environment variable.

-Move script to /usr/local/sbin/

-Make script executable - sudo chmod +x /usr/local/sbin/stormDeployer

-Change ownership of the file - sudo chown muzammilm /usr/local/sbin/stormDeployer

Execution Steps :
 --$stormDeployer

Running the above command returns a list of existing topologies.

 --$stormDeployer deploy
 
Running the above command without any arguments returns a base error message.

 --$stormDeployer deploy jarName topologyName

Running the above command will cause deployment of the said jar for the said topology. This can be used when upgrading a topology with a more recent jar executable.

It will however return an error if a configuration file is missing. The configuration file consists of the execution command that is used to start the storm job . 

Starting an example Storm Job : 

$STORM_HOME/bin/storm jar /home/muzammilm/bin/jars/stormExample.jar className propertyFile topologyName

The configuration file can be created by executing the following command :

 --$echo "/home/muzammilm/bin/jars/stormExample.jar className propertyFile topologyName" > bin/jars/topologyName.txt
 
 --$stormDeployer restart topologyName

Running the above command will restart the topology . 

PS : Any contribution and constructive criticism is greatly appreciated. 

