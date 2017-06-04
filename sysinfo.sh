#!/bin/bash

echo "$(tput setaf 2)
     .~~.   .~~.       $(tput setaf 6)Processors           : `cat /proc/cpuinfo | grep '^processor' | wc -l`$(tput setaf 2)
    '. \ ' ' / .'      $(tput setaf 6)Serial               : `cat /proc/cpuinfo | grep '^Serial' | awk '{ printf $3 }'`$(tput setaf 1)
     .~ .~~~..~.       $(tput setaf 6)Hardware             : `cat /proc/cpuinfo | grep '^Hardware' | awk '{ printf $3 }'`$(tput setaf 1)
    : .~.'~'.~. :      $(tput setaf 6)Revision             : `cat /proc/cpuinfo | grep '^Revision' | awk '{ printf $3 }'`$(tput setaf 1)
   ~ (   ) (   ) ~     $(tput setaf 6)CORE / ARM frequency : `vcgencmd measure_clock core | awk -F= '/=/{print($2 / 1000000)}'` MHz / `vcgencmd measure_clock arm | awk -F= '/=/{print($2 / 1000000)}'` MHz$(tput setaf 1)
  ( : '~'.~.'~' : )    $(tput setaf 6)CORE voltage         : `vcgencmd measure_volts core`$(tput setaf 1)
   ~ .~ (   ) ~. ~     $(tput setaf 6)CPU temperature      : `vcgencmd measure_temp`$(tput setaf 1)
    (  : '~' :  )      $(tput setaf 6)IP / Hostname        : `hostname -I` / `hostname -f`$(tput setaf 1)
     '~ .~~~. ~'       $(tput setaf 6)Firmware date        : `vcgencmd version | head -1`$(tput setaf 1)
         '~'           $(tput setaf 6)Firmware version     : `vcgencmd version | grep ^version | awk '{ print($2) }'`
                       Codecs enabled       : `for codec in H264 MPG2 WVC1 MPG4 MJPG WMV9; do echo "$(vcgencmd codec_enabled $codec)"; done | grep enabled | awk -F= '/=/{print $1}' | tr '\n' ' '`
                       Codecs disabled      : `for codec in H264 MPG2 WVC1 MPG4 MJPG WMV9; do echo "$(vcgencmd codec_enabled $codec)"; done | grep disabled | awk -F= '/=/{print $1}' | tr '\n' ' '`
$(tput sgr0)"
