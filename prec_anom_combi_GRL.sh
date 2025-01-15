#!/bin/bash

yearmodes=("wet" "dry")


statuses=("ER_MJO456" "noER_noMJO" "suppER_MJO456" "ER_suppMJO" "weakER_MJO456" "ER_weakMJO" "erw456" "mjo456" "erw456_nonina" "mjo456_nonina")

for status in ${statuses[@]}; do
  for yearmode in ${yearmodes[@]}; do
      ncl yearmode=\"$yearmode\" status=\"$status\" "composite_prec_anom_combi_GRL.ncl"
  done
done
