if [[ -z "$STORM_HOME" ]]; then
        echo "STORM_HOME is not set ; using default path"
        STORM_HOME=/opt/storm-0.10.2
fi

dir="/home/mpuser/bin/jars/storm/"
if [ -d "$dir" -a ! -h "$dir" ]
then
        echo
else
        mkdir -p $dir
fi


if [ $# -lt 1 ]
then
        echo "Possible options : deploy , restart"
        echo "Current running topologies :"
        $STORM_HOME/bin/storm list
        exit
fi
case "$1" in
deploy)
if [ $# -lt 2 ]
then
        echo "deploy jarName TopologyName"
        exit
else
        file="/home/mpuser/bin/jars/storm/$3.txt"
        if [ -f "$file" ]
        then
                echo "$file found."
        else
                echo "Config file not found. Please create a default file in bin/jars/storm with 'jarName className propertyFile TopologyName'"
                exit
        fi
        echo "Deploying jar "$2
        echo "Topology : "$3
        echo "Killing existing topology"
        $STORM_HOME/bin/storm kill $3 -w 00
        echo "Sleeping for 1 minute to finish removing existing jar"
        #sleep 20s
        x=`cat $file`
        cut -d' ' -f2- $file > $file.temp
        cat $file.temp > $file
        u=`echo $2 | sed 's,/,\\\/,g'`
        sed 's/^/'$u' /' $file > $file.tmp
        cat $file.tmp > $file
        jarProps=`cat $file`
        $STORM_HOME/bin/storm jar $jarProps
        rm $file.tmp $file.temp
fi
;;
        restart)
        file="/home/mpuser/bin/jars/storm/$2.txt"
        if [ -f "$file" ]
        then
                echo "$file found."
        else
                echo "Config file not found. Please create a default file in bin/jars/storm with 'jarName className propertyFile TopologyName'"
                exit
        fi

        x=`cat $file`
        echo $x
        $STORM_HOME/bin/storm kill $2 -w 00
        echo "Sleeping for 1 minute to finish removing existing jar"
        sleep 20s
        jarProps=`cat $file`
        $STORM_HOME/bin/storm jar $jarProps

;;

esac
