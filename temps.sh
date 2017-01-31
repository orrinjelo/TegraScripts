#!/bin/bash

for x in {0..5}
do
    echo "`cat /sys/devices/virtual/thermal/thermal_zone${x}/type`: `cat /sys/devices/virtual/thermal/thermal_zone${x}/temp`"
done