#!/bin/bash

yearmodes=("dry")


statuses=("ER_MJO456" "noER_noMJO" "suppER_MJO456" "ER_suppMJO" "weakER_MJO456" "ER_weakMJO" "erw456" "mjo456" "erw456_nonina" "mjo456_nonina")

for status in ${statuses[@]}; do
  echo $status
  for yearmode in ${yearmodes[@]}; do
      echo $yearmode
      ncl yearmode=\"$yearmode\" status=\"$status\" "composite_wetdays_combi_GRL.ncl"
  done
done
