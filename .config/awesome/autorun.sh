#!/usr/bin/env bash

function run {
   if ! pgrep -f $1 ;
   then
      $@&
   fi
}

run firefox
run lutris
run mpd
run discord
run cantata
