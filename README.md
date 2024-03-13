# network_patlite

This script is a simple utility for controlling a network-enabled Patlite signal tower. It allows you to turn on or off the red, green, and yellow lights, and set the operational hours during which the lights can be active.


## Usage
```
./network_patlite.sh [-i IPADDRESS] [-r VALUE] [-g VALUE] [-y VALUE] [-s STARTHOUR] [-e ENDHOUR]
```

## Parameters:
- -i IPADDRESS: Optional. The IP address of the Patlite signal tower. Default is "192.168.10.1"
- -r VALUE: Optional. The value for the red light (0: off, 1: on). Default is 1.
- -g VALUE: Optional. The value for the green light (0: off, 1: on). Default is 1.
- -y VALUE: Optional. The value for the yellow light (0: off, 1: on). Default is 1.
- -s STARTHOUR: Optional. The start hour (in 24-hour format) for the operational period. Default is 0.
- -e ENDHOUR: Optional. The end hour (in 24-hour format) for the operational period. Default is 24.

## Example:
To turn on the red and green lights, but keep the yellow light off, between 7 AM and 9 PM, use the following command:
```
./network_patlite.sh -i 192.168.10.1 -r 1 -g 1 -y 0 -s 7 -e 21
```

## Requirements

The script requires nc (netcat) to be installed on the system.
The Patlite signal tower must be connected to the network and reachable at the specified IP address.

## License

This script is provided under the GNU General Public License (GPL).