#!/bin/bash

# yearmodes=("wet" "dry")
yearmodes=("mid")
waves=("erw" "mjo")


statuses=("ER_MJO456" "noER_noMJO" "suppER_MJO456" "ER_suppMJO" "weakER_MJO456" "ER_weakMJO" "erw456" "mjo456")
# vars=("conv_q" "adv_q" "viwvn" "viwve")
vars=("conv_q" "adv_q" "viwvn" "viwve")
# vars=("mfc" "dq_dt" "q2")
# vars=("olr")

for status in ${statuses[@]}; do
  for wave in ${waves[@]}; do
    for yearmode in ${yearmodes[@]}; do
      for var in ${vars[@]}; do
        echo $var
        if [[ $var == "olr" ]] ;then
          echo "composite_olr_anom_combi_GRL.ncl"
          ncl yearmode=\"$yearmode\" wave=\"$wave\" var=\"$var\" status=\"$status\" "composite_olr_anom_combi_GRL.ncl"
        else
          echo "composite_dyn_anom_combi_GRL.ncl"
          ncl yearmode=\"$yearmode\" wave=\"$wave\" var=\"$var\" status=\"$status\" "composite_dyn_anom_combi_GRL.ncl"
        fi
        # echo $wave $var $yearmode $status
      done
    done
  done
done
