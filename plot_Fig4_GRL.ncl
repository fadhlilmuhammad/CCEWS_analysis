
; load('$NCARG_ROOT/lib/ncarg/database/rangs')
diri = "/Users/fadhlilrizki/Documents/PhD/thesis/dataout/precip/"
diri2 = "/Users/fadhlilrizki/Documents/PhD/thesis/data/composite_wetter_drier/"
; diri = "/Users/fadhlilrizki/Documents/PhD/thesis/dataout/precip/gadi/"
diro = "/Users/fadhlilrizki/Documents/PhD/thesis/figures/precip/"

; waves  = (/"erw", "tdw","mjo","mrg"/)
; thresh = 1

condition = "suppressed"
stattype = "wetdaysanom"
pltname = "Fig4_GRL_"+condition
if stattype.eq."wetdays" then
minlv = 0.
maxlv = 10.
intlv = 1.

end if

;remaptype =  "025"
; remaptype =  "check_wTC"
remaptype1 =  "025_wetdays_10mm"
remaptype2 =  "025_dailyanom"

yearmode1 = "wet"
yearmode2 = "dry"

seas = "SHSummer"
ref = 133

if seas.eq."SHSummer" then
  seasmon = "DJF"
else if seas.eq."SHSpring" then
  seasmon = "SON"
else if seas.eq."SHAutumn" then
  seasmon = "MAM"
else if seas.eq."SHWinter" then
  seasmon = "JJA"
else
  seasmon = seas
end if
end if
end if
end if
; mjo_wave_composite_SHSummer_perc95_025_sig95.ref133.check_wTC.nc
; fname = wave+"_wave_composite_"+seas+"_perc95_025_sig95.ref"+ref+".regrid.nc"
; fname = wave+"_wave_composite_"+seas+"_perc95_025_sig95.ref"+ref+".check_wTC.nc"


if condition.eq."weak" then
statuses = (/"ER_MJO456","ER_MJO456","ER_weakMJO","ER_weakMJO","weakER_MJO456","weakER_MJO456","noER_noMJO","noER_noMJO", "mjo456", "mjo456", "erw456", "erw456"/)

status_name = (/"wet ER & wet MJO", "wet ER & wet MJO", "wet ER & no MJO", "wet ER & no MJO",  \\
                "no ER & wet MJO", "no ER & wet MJO", "no ER & no MJO", "no ER & no MJO"/)

ndays = (/150,183,68,34,50,28,31,49/)

else if condition.eq."suppressed" then
statuses = (/"ER_MJO456","ER_MJO456","ER_suppMJO","ER_suppMJO","suppER_MJO456","suppER_MJO456","noER_noMJO","noER_noMJO"/)
status_name = (/"wet ER & wet MJO", "wet ER & wet MJO", "wet ER & dry MJO", "wet ER & dry MJO",  \\
                "dry ER & wet MJO", "dry ER & wet MJO", "no ER & no MJO", "no ER & no MJO"/)
ndays = (/150,183,98,114,115,160,31,49/)
end if
end if


status = "combi"
; perc = 90
fname_a1  = "prec_"+stattype+"_"+statuses(0)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode1+".nc"
fname_b1 = "prec_anom_"+statuses(0)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype2+"."+yearmode1+".nc"

fname_a2  = "prec_"+stattype+"_"+statuses(1)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode2+".nc"
fname_b2 = "prec_anom_"+statuses(1)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype2+"."+yearmode2+".nc"

fname_a3  = "prec_"+stattype+"_"+statuses(2)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode1+".nc"
fname_b3 = "prec_anom_"+statuses(2)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype2+"."+yearmode1+".nc"

fname_a4  = "prec_"+stattype+"_"+statuses(3)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode2+".nc"
fname_b4 = "prec_anom_"+statuses(3)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype2+"."+yearmode2+".nc"

fname_a5  = "prec_"+stattype+"_"+statuses(4)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode1+".nc"
fname_b5 = "prec_anom_"+statuses(4)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype2+"."+yearmode1+".nc"

fname_a6  = "prec_"+stattype+"_"+statuses(5)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode2+".nc"
fname_b6 = "prec_anom_"+statuses(5)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype2+"."+yearmode2+".nc"

fname_a7  = "prec_"+stattype+"_"+statuses(6)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode1+".nc"
fname_b7 = "prec_anom_"+statuses(6)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype2+"."+yearmode1+".nc"

fname_a8  = "prec_"+stattype+"_"+statuses(7)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode2+".nc"
fname_b8 = "prec_anom_"+statuses(7)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype2+"."+yearmode2+".nc"
; fname = "er_wave_composite_SHSummer_perc95_025_sig95.ref133.regrid.nc"
; fname = wave+"_wave_composite_"+seas+"ref"+ref+"."+remaptype+".nc"
; fname = "olr_er_wave_composite.nc"


fmask = addfile("/Users/fadhlilrizki/Documents/PhD/thesis/data/"+"AGCD_025deg_Mask_comp.nc", "r")
mnc   = fmask->mask({-43.5:-10.75}, {113:153.5})
printVarSummary(mnc)

fa1     = addfile(diri2+fname_a1, "r")
fb1    = addfile(diri2+fname_b1, "r")

fa2     = addfile(diri2+fname_a2, "r")
fb2    = addfile(diri2+fname_b2, "r")

fa3     = addfile(diri2+fname_a3, "r")
fb3    = addfile(diri2+fname_b3, "r")

fa4     = addfile(diri2+fname_a4, "r")
fb4    = addfile(diri2+fname_b4, "r")

fa5     = addfile(diri2+fname_a5, "r")
fb5    = addfile(diri2+fname_b5, "r")

fa6     = addfile(diri2+fname_a6, "r")
fb6    = addfile(diri2+fname_b6, "r")

fa7     = addfile(diri2+fname_a7, "r")
fb7    = addfile(diri2+fname_b7, "r")

fa8     = addfile(diri2+fname_a8, "r")
fb8    = addfile(diri2+fname_b8, "r")


x_in_a1  = short2flt(fa1->composite)
x_in_a2  = short2flt(fa2->composite)
x_in_a3  = short2flt(fa3->composite)
x_in_a4  = short2flt(fa4->composite)
x_in_a5  = short2flt(fa5->composite)
x_in_a6  = short2flt(fa6->composite)
x_in_a7  = short2flt(fa7->composite)
x_in_a8  = short2flt(fa8->composite)

x_in_b1 = short2flt(fb1->composite)
x_in_b2 = short2flt(fb2->composite)
x_in_b3 = short2flt(fb3->composite)
x_in_b4 = short2flt(fb4->composite)
x_in_b5 = short2flt(fb5->composite)
x_in_b6 = short2flt(fb6->composite)
x_in_b7 = short2flt(fb7->composite)
x_in_b8 = short2flt(fb8->composite)

a_a1     = short2flt(fa1->alpha)
a_a2     = short2flt(fa2->alpha)
a_a3     = short2flt(fa3->alpha)
a_a4     = short2flt(fa4->alpha)
a_a5     = short2flt(fa5->alpha)
a_a6     = short2flt(fa6->alpha)
a_a7     = short2flt(fa7->alpha)
a_a8     = short2flt(fa8->alpha)

a_b1    = short2flt(fb1->alpha)
a_b2    = short2flt(fb2->alpha)
a_b3    = short2flt(fb3->alpha)
a_b4    = short2flt(fb4->alpha)
a_b5    = short2flt(fb5->alpha)
a_b6    = short2flt(fb6->alpha)
a_b7    = short2flt(fb7->alpha)
a_b8    = short2flt(fb8->alpha)

dimmask = dimsizes(mnc)
; mnc_p = new((/ dimmask(0), dimmask(1)/), float)
;
;
; do i = 0, 0
;   mnc_p(:,:) = mnc; write loop content
;   copy_VarCoords(mnc, mnc_p(i,:,:))
; end do
mnc_p = mnc

printVarSummary(mnc_p)
; printVarSummary(x_in)
; printVarSummary(a)
; x      = where(a.eq.1., x_in, 1)
; x      = where(mnc_p.eq.1, x, x_in@_FillValue)
; x_stat      = where(a.eq.1., x_in, x_in@_FillValue)
; x_stat      = where(mnc_p.eq.1, x, x_in@_FillValue)
;
; x_anom = where(mnc_p.eq.1., x_in2, x_in2@_FillValue)
; x_anom_stat = where(mnc_p.eq.1., x_in2, x_in2@_FillValue)

x_a1      = where(a_a1.ge.1., x_in_a1, x_in_a1@_FillValue)
x_a2      = where(a_a2.ge.1., x_in_a2, x_in_a2@_FillValue)
x_a3      = where(a_a3.ge.1., x_in_a3, x_in_a3@_FillValue)
x_a4      = where(a_a4.ge.1., x_in_a4, x_in_a4@_FillValue)
x_a5      = where(a_a5.ge.1., x_in_a5, x_in_a5@_FillValue)
x_a6      = where(a_a6.ge.1., x_in_a6, x_in_a6@_FillValue)
x_a7      = where(a_a7.ge.1., x_in_a7, x_in_a7@_FillValue)
x_a8      = where(a_a8.ge.1., x_in_a8, x_in_a8@_FillValue)

printVarSummary(x_a1)

x_b1      = where(a_b1.ge.0., x_in_b1, x_in_b1@_FillValue)
x_b2      = where(a_b2.ge.0., x_in_b2, x_in_b2@_FillValue)
x_b3      = where(a_b3.ge.0., x_in_b3, x_in_b3@_FillValue)
x_b4      = where(a_b4.ge.0., x_in_b4, x_in_b4@_FillValue)
x_b5      = where(a_b5.ge.0., x_in_b5, x_in_b5@_FillValue)
x_b6      = where(a_b6.ge.0., x_in_b6, x_in_b6@_FillValue)
x_b7      = where(a_b7.ge.0., x_in_b7, x_in_b7@_FillValue)
x_b8      = where(a_b8.ge.0., x_in_b8, x_in_b8@_FillValue)

if stattype.eq."wetdays" then
  if yearmode1.eq."wet" then
    print("divider")

    x_stat_a1      = where(mnc_p.ge.1, x_a1/11., x_in_a1@_FillValue)
    x_stat_a2      = where(mnc_p.ge.1, x_a2/11., x_in_a2@_FillValue)
    x_stat_a3      = where(mnc_p.ge.1, x_a3/11., x_in_a3@_FillValue)
    x_stat_a4      = where(mnc_p.ge.1, x_a4/11., x_in_a4@_FillValue)
    x_stat_a5      = where(mnc_p.ge.1, x_a5/11., x_in_a5@_FillValue)
    x_stat_a6      = where(mnc_p.ge.1, x_a6/11., x_in_a6@_FillValue)
    x_stat_a7      = where(mnc_p.ge.1, x_a7/11., x_in_a7@_FillValue)
    x_stat_a8      = where(mnc_p.ge.1, x_a8/11., x_in_a8@_FillValue)

    ; x      = where(mnc_p.ge.1, x/11., x_in@_FillValue)
  else if yearmode1.eq."dry" then
    print("divider")

    x_stat_a1      = where(mnc_p.ge.1, x_a1/14., x_in_a1@_FillValue)
    x_stat_a2      = where(mnc_p.ge.1, x_a2/14., x_in_a2@_FillValue)
    x_stat_a3      = where(mnc_p.ge.1, x_a3/14., x_in_a3@_FillValue)
    x_stat_a4      = where(mnc_p.ge.1, x_a4/14., x_in_a4@_FillValue)
    x_stat_a5      = where(mnc_p.ge.1, x_a5/14., x_in_a5@_FillValue)
    x_stat_a6      = where(mnc_p.ge.1, x_a6/14., x_in_a6@_FillValue)
    x_stat_a7      = where(mnc_p.ge.1, x_a7/14., x_in_a6@_FillValue)
    x_stat_a8      = where(mnc_p.ge.1, x_a8/14., x_in_a6@_FillValue)

    ; x      = where(mnc_p.ge.1, x/14., x_in@_FillValue)
  else if yearmode1.eq."mid" then

  x_stat_a1      = where(mnc_p.ge.1, x_a1/15., x_in_a1@_FillValue)
  x_stat_a2      = where(mnc_p.ge.1, x_a2/15., x_in_a2@_FillValue)
  x_stat_a3      = where(mnc_p.ge.1, x_a3/15., x_in_a3@_FillValue)
  x_stat_a4      = where(mnc_p.ge.1, x_a4/15., x_in_a4@_FillValue)
  x_stat_a5      = where(mnc_p.ge.1, x_a5/15., x_in_a5@_FillValue)
  x_stat_a6      = where(mnc_p.ge.1, x_a6/15., x_in_a6@_FillValue)
  x_stat_a7      = where(mnc_p.ge.1, x_a7/15., x_in_a6@_FillValue)
  x_stat_a8      = where(mnc_p.ge.1, x_a8/15., x_in_a6@_FillValue)

    ; x      = where(mnc_p.ge.1, x/15., x_in@_FillValue)
  end if
  end if
  end if
else
  x_stat_a1      = where(mnc_p.ge.1, x_a1, x_in_a1@_FillValue)
  x_stat_a2      = where(mnc_p.ge.1, x_a2, x_in_a2@_FillValue)
  x_stat_a3      = where(mnc_p.ge.1, x_a3, x_in_a3@_FillValue)
  x_stat_a4      = where(mnc_p.ge.1, x_a4, x_in_a4@_FillValue)
  x_stat_a5      = where(mnc_p.ge.1, x_a5, x_in_a5@_FillValue)
  x_stat_a6      = where(mnc_p.ge.1, x_a6, x_in_a6@_FillValue)
  x_stat_a7      = where(mnc_p.ge.1, x_a7, x_in_a7@_FillValue)
  x_stat_a8      = where(mnc_p.ge.1, x_a8, x_in_a8@_FillValue)
end if

; x_stat_a1      = where(a.ge.1., x_in, x_in@_FillValue)

x_stat_b1      = where(mnc_p.ge.1, x_b1, x_in_b1@_FillValue)
x_stat_b2      = where(mnc_p.ge.1, x_b2, x_in_b2@_FillValue)
x_stat_b3      = where(mnc_p.ge.1, x_b3, x_in_b3@_FillValue)
x_stat_b4      = where(mnc_p.ge.1, x_b4, x_in_b4@_FillValue)
x_stat_b5      = where(mnc_p.ge.1, x_b5, x_in_b5@_FillValue)
x_stat_b6      = where(mnc_p.ge.1, x_b6, x_in_b6@_FillValue)
x_stat_b7      = where(mnc_p.ge.1, x_b7, x_in_b7@_FillValue)
x_stat_b8      = where(mnc_p.ge.1, x_b8, x_in_b8@_FillValue)


; x_anom = x_in2

copy_VarMeta(x_in_a1, x_stat_a1)
copy_VarMeta(x_in_a2, x_stat_a2)
copy_VarMeta(x_in_a3, x_stat_a3)
copy_VarMeta(x_in_a4, x_stat_a4)
copy_VarMeta(x_in_a5, x_stat_a5)
copy_VarMeta(x_in_a6, x_stat_a6)
copy_VarMeta(x_in_a7, x_stat_a7)
copy_VarMeta(x_in_a8, x_stat_a8)

copy_VarMeta(x_in_b1, x_stat_b1)
copy_VarMeta(x_in_b2, x_stat_b2)
copy_VarMeta(x_in_b3, x_stat_b3)
copy_VarMeta(x_in_b4, x_stat_b4)
copy_VarMeta(x_in_b5, x_stat_b5)
copy_VarMeta(x_in_b6, x_stat_b6)
copy_VarMeta(x_in_b7, x_stat_b7)
copy_VarMeta(x_in_b8, x_stat_b8)

ndim = dimsizes(x_stat_a1)
nlat = ndim(0)
nlon = ndim(1)

x_anom_stat = new((/8, nlat, nlon/),"float")
x_stat = new((/8, nlat, nlon/),"float")

printVarSummary(x_anom_stat)
printVarSummary(x_stat_a1)

x_stat(0,:,:) = x_stat_a1
x_stat(1,:,:) = x_stat_a2
x_stat(2,:,:) = x_stat_a3
x_stat(3,:,:) = x_stat_a4
x_stat(4,:,:) = x_stat_a5
x_stat(5,:,:) = x_stat_a6
x_stat(6,:,:) = x_stat_a7
x_stat(7,:,:) = x_stat_a8
;

x_anom_stat(0,:,:) = x_stat_b1
x_anom_stat(1,:,:) = x_stat_b2
x_anom_stat(2,:,:) = x_stat_b3
x_anom_stat(3,:,:) = x_stat_b4
x_anom_stat(4,:,:) = x_stat_b5
x_anom_stat(5,:,:) = x_stat_b6
x_anom_stat(6,:,:) = x_stat_b7
x_anom_stat(7,:,:) = x_stat_b8


; copy_VarMeta(x_in, x_stat)
; copy_VarMeta(x_in2, x_anom)

do i = 0, 7
  copy_VarCoords(x_stat_b1, x_anom_stat(i,:,:))
  copy_VarCoords(x_stat_a1, x_stat(i,:,:))
end do

x_anom_stat!0 = "status"
x_stat!0 = "status"
x_anom_stat!1 = "lat"
x_stat!1 = "lat"
x_anom_stat!2 = "lon"
x_stat!2 = "lon"


x_anom_stat&status = statuses
x_stat&status = statuses

x_anom_stat&lat = x_stat_a1&lat
x_stat&lat = x_stat_a1&lat

x_anom_stat&lon = x_stat_a1&lon
x_stat&lon = x_stat_a1&lon

printVarSummary(x_anom_stat)
; x_in   = where(x_in.gt.0., x_in, x_in@_FillValue)
; copy_VarMeta(x, x_in)

; printVarSummary(x)


; max_rr = new((/9/), string)
; min_rr = new((/9/), string)
; max_Pr = new((/9/), string)
; min_Pr = new((/9/), string)
; do i = 0, 8
;   valmaxrr  = local_max(x_anom_stat(i,{-25:-10},{112:155}), 0, 0)
;   valminrr  = local_min(x_anom_stat(i,{-25:-10},{112:155}),0 , 0)
;   ; printVarSummary(valmax)
;   max_rr(i) = tostring(max(valmaxrr@maxval))
;   min_rr(i) = tostring(min(valminrr@minval))
;
;
;   valmaxpr  = local_max(x_stat(i,{-25:-10},{112:155}), 0, 0)
;   valminpr  = local_min(x_stat(i,{-25:-10},{112:155}),0 , 0)
;   ; printVarSummary(valmax)
;   max_Pr(i) = tostring(max(valmaxpr@maxval))
;   min_Pr(i) = tostring(min(valminpr@minval))
; end do

; print(max_Pr)

lonLuse = 112
lonRuse = 155

coords_rr = wgt_areaave_Wrap(x_anom_stat(:,{-25:-10},{lonLuse:lonRuse}),1,1,0)
; mean_rr  =  tostring_with_format(decimalPlaces(wgt_areaave_Wrap(x_anom_stat(:,{-25:-10},{lonLuse:lonRuse}), 1.,1., 0),1,False), "%2.1f")
mean_rr   =  tostring_with_format(decimalPlaces(dim_median(dim_median(x_anom_stat(:,{-25:-10},{lonLuse:lonRuse}))),1,False), "%2.1f")
max_rr   =  tostring_with_format(decimalPlaces(dim_max(dim_max(x_anom_stat(:,{-25:-10},{lonLuse:lonRuse}))),1,False), "%2.1f")
min_rr   =  tostring_with_format(decimalPlaces(dim_min(dim_min(x_anom_stat(:,{-25:-10},{lonLuse:lonRuse}))),1,False), "%2.1f")

mean_Pr  =  tostring_with_format(decimalPlaces(wgt_areaave_Wrap(x_stat(:,{-25:-10},{lonLuse:lonRuse}), 1.,1., 0),1,False), "%2.1f")
; mean_Pr   =  tostring_with_format(decimalPlaces(dim_median(dim_median(x_stat(:,{-25:-10},{lonLuse:lonRuse}))),1,False), "%2.1f")
max_Pr   =  tostring_with_format(decimalPlaces(dim_max(dim_max(x_stat(:,{-25:-10},{lonLuse:lonRuse}))),1,False), "%2.1f")
min_Pr   =  tostring_with_format(decimalPlaces(dim_min(dim_min(x_stat(:,{-25:-10},{lonLuse:lonRuse}))),1,False), "%2.1f")

;#altfix remove missing value
; mean_Pr(0) = 0
; max_Pr(0) = 0
; min_Pr(0) = 0

;#CEK RR
do i = 0, 7
  ck_mean = tofloat(mean_rr(i)); write loop content
  ck_max  = tofloat(max_rr(i))
  ck_min  = tofloat(min_rr(i))

  if ck_mean.ge.0 then
    mean_rr(i) = "+"+tostring_with_format(abs(tofloat(mean_rr(i))), "%2.1f")
  else
    mean_rr(i) = "- "+tostring_with_format(abs(tofloat(mean_rr(i))), "%2.1f")
  end if
  if ck_max.ge.0 then
    max_rr(i) = "+"+tostring_with_format(abs(tofloat(max_rr(i))), "%2.1f")
  else
    max_rr(i) = "- "+tostring_with_format(abs(tofloat(max_rr(i))), "%2.1f")
  end if
  if ck_min.ge.0 then
    min_rr(i) = "+"+tostring_with_format(abs(tofloat(min_rr(i))), "%2.1f")
  else
    min_rr(i) = "- "+tostring_with_format(abs(tofloat(min_rr(i))), "%2.1f")
  end if
end do


;#CEK PR
; do i = 0, 8
;   ck_mean = tofloat(mean_Pr(i)); write loop content
;   ck_max  = tofloat(max_Pr(i))
;   ck_min  = tofloat(min_Pr(i))
;
;   print(ck_mean)
;   if ck_mean.ge.0 then
;     mean_Pr(i) = ""+tostring_with_format(abs(tofloat(mean_Pr(i))), "%2.1f")
;   else
;     mean_Pr(i) = "- "+tostring_with_format(abs(tofloat(mean_Pr(i))), "%2.1f")
;   end if
;   if ck_max.ge.0 then
;     max_Pr(i) = "+"+tostring_with_format(abs(tofloat(max_Pr(i))), "%2.1f")
;   else
;     max_Pr(i) = "- "+tostring_with_format(abs(tofloat(max_Pr(i))), "%2.1f")
;   end if
;   if ck_min.ge.0 then
;     min_Pr(i) = "+"+tostring_with_format(abs(tofloat(min_Pr(i))), "%2.1f")
;   else
;     min_Pr(i) = "- "+tostring_with_format(abs(tofloat(min_Pr(i))), "%2.1f")
;   end if
; end do

copy_VarMeta(coords_rr,mean_rr)
copy_VarMeta(coords_rr, max_rr)
copy_VarMeta(mean_rr, min_rr)


copy_VarMeta(coords_rr,mean_Pr)
copy_VarMeta(coords_rr, max_Pr)
copy_VarMeta(coords_rr, min_Pr)


print(mean_rr)

n      = 8
;************************************************
; create plots
;************************************************
  wks = gsn_open_wks("png",diro+pltname)              ; send graphics to PNG file

  if stattype.eq."wetdays" then
  cmap  = read_colormap_file("WhiteBlueGreenYellowRed")
else if stattype.eq."wetdaysanom" then
  cmap  = read_colormap_file("precip4_diff_19lev")
  end if
end if
  ; cmap  = read_colormap_file("precip_diff_12lev")
    ; cmap  = read_colormap_file("precip4_diff_19lev")
    ; cmap  = read_colormap_file("WhViBlGrYeOrRe")
  ; cmap  = cmap(::-1,:)
  ; cmap(120:150,:) = 0
  ; cmap(7,:) = 0
  ; cmap(55:70,:) = 0
  ; ncmap = dimsizes(cmap(:,0))

  plot = new(n,graphic)                          ; create a plot array
  plotc = new(n, graphic)
  text_mean = new(n,graphic)
  text_max = new(n,graphic)
  text_min = new(n,graphic)

  rr_txtmean = new(n, graphic)
  rr_txtmax = new(n, graphic)
  rr_txtmin = new(n, graphic)

  Pr_txtmean = new(n, graphic)
  Pr_txtmax = new(n, graphic)
  Pr_txtmin = new(n, graphic)

  txt_title1 = new(n, graphic)
  txt_title2 = new(n, graphic)




  res                     = True
  res@gsnDraw             = False            ; don't draw
  res@gsnFrame            = False            ; don't advance frame
  res@cnInfoLabelOn       = False            ; turn off cn info label
  res@cnFillOn            = True             ; turn on color
  res@cnFillPalette       = cmap
  res@lbLabelBarOn        = False            ; turn off individual cb's
  res@cnLinesOn           = False

  res@mpFillOn            = True
  res@mpMaxLatF           = -10
  res@mpMinLatF           = -25

  res@mpMaxLonF           = 155
  res@mpMinLonF           = 112

  res@tmXBMinorOn         = False
  res@tmYLMinorOn         = False

  res@tmYLLabelFontHeightF = 0.02

  res@cnLineLabelsOn = False
  res@tmYROn = False
  res@tmXTOn = False


  ;---Set resources for better map outlines
  res@mpOutlineOn                 = True
  res@mpFillOn = 0
  ; res@mpOutlineBoundarySets       = "AllBoundaries"
  ; res@mpOutlineBoundarySets = "GeophysicalAndUSStates"
  res@mpOutlineBoundarySets     = "NoBoundaries"

  res@mpOutlineSpecifiers      = (/"Australia : Northern Territory", "Australia : Queensland", "Australia : Western Australia"/)  ; continents only
  res@mpDataBaseVersion           = "MediumRes"
  res@mpDataSetName               = "Earth..4"       ; gives us some provincial boundaries

  ; res@mpDataResolution            = "Coarse"


;---Increase thickness of map outlines
  res@mpPerimOn                   =False
  res@mpPerimLineThicknessF       = 0.3
  res@mpNationalLineThicknessF    = 0.5
  res@mpProvincialLineThicknessF  = 1.
  res@mpGeophysicalLineThicknessF = 0.5
  ; res@mp
  res@mpPerimLineColor = "darkgreen"
  res@mpGeophysicalLineColor = "black"
  ; res@mpNationalLineColor = "gray70"
  res@mpCountyLineColor ="gray70"
  res@mpUSStateLineColor = "gray70"
  ; res@cnFillMode = "CellFill"

  ; res@g
;
; Force both plots to have the same contour levels. This is necessary
; because the gsn_panel routine will based the labelbar on the first
; plot in the list.
;
  ; res@cnLevelSelectionMode =  "ManualLevels"
  ; res@cnMinLevelValF       =  minlv
  ; res@cnMaxLevelValF       =  maxlv
  ; res@cnLevelSpacingF      =  intlv


  if stattype.eq."wetdays" then
      res@cnLevelSelectionMode =  "ManualLevels"
      res@cnMinLevelValF       =  minlv
      res@cnMaxLevelValF       =  maxlv
      res@cnLevelSpacingF      =  intlv
  else if stattype.eq."wetdaysanom" then
    res@cnLevelSelectionMode =  "ExplicitLevels"
    ; res@cnLevels = (/0.2,0.3,0.4, 0.5, 0.6, 0.7,0.8,0.9, 1.0, 1.1, 1.25,1.5, 1.8, 2.,2.5,2.8,3.0/)
    res@cnLevels = (/0.4, 0.5, 0.6, 0.7,0.8,0.9, 1.0, 1.1, 1.25,1.5, 1.8, 2.,2.5/)
    end if
  end if
  res@cnFillOpacityF = 0.65
  ; res@cnMinLevelValF       =  minlv
  ; res@cnMaxLevelValF       =  maxlv
  ; res@cnLevelSpacingF      =  intlv
  ; res@cnLevels = (/0.1, 0.2, 0.33, 0.5, 0.65, 0.8, 1.0,  1.25, 1.5, 2.0, 3.0, 3.5, 4.0/)
  ; res@cnLevels = (/0.005,0.01,0.02, 0.025, 0.03, 0.035,0.04,0.045, 0.05, 0.055, 0.06, 0.065, 0.07, 0.1,0.15,0.18,0.2/)

  ; res@cnLevels = (/0.2,0.3,0.4, 0.5, 0.6, 0.7,0.8, 1.0,1.25,1.4, 1.5, 1.6,1.7,1.8,2.0/)
  ; res@cnLevels = (/ 0.4, 0.5, 0.6, 0.7,0.8, 0.9, 1.0, 1.1, 1.25, 1.4, 1.67, 2.0, 2.5/)
  ; res@cnLevels = (/ 0.4, 0.5, 0.6, 0.7,0.8,0.9, 0.925,0.95,0.97,0.98, 0.99, 1.0, 1.01, 1.02, 1.03, 1.05, 1.08, 1.1, 1.25, 1.4, 1.67, 2.0, 2.5/)
  ; res@cnLevels = (/ 0.4, 0.5, 0.6, 0.7,0.8,0.9, 0.925,0.95,0.97,0.98, 0.99, 1.0, 1.01, 1.02, 1.03, 1.05, 1.08, 1.1, 1.25, 1.4, 1.67, 2.0, 2.5/)
  ; res@cnLevels = (/ 0.4,  1.0,  2.5/)
  res@gsnAddCyclic         = False
  res@gsnLeftString        = ""
  res@gsnRightString        = ""

  plotsort = (/0,1,2,3,4,5,6,7/)

  pres               = True
  pres@gsLineColor   = "blue"
  pres@gsMarkerIndex = 16
  ; pres@gsMarkerColor = "thistle2"

  res2 = True
  res2@cnInfoLabelOn       = False            ; turn off cn info label
  res2@gsnDraw             = False
  res2@gsnFrame            = False
  res2@cnFillOn            = False             ; turn on color
  res2@lbLabelBarOn        = False            ; turn off individual cb's
  res2@cnLinesOn           = True
  res2@cnLineColor         = "black"
  ; res2@cnFillIndex         = 6
  ; res2@cnFillPattern       = 6
  res@cnMissingValFillColor = "gray90"
  ; res@cnMissingValFillColor = "white"
  ; res@cnFillMode = "AreaFill"
  ; res@cnMissingValFillPattern = 3
  ; res@cnMissingValPerimColor  = "gray80"
  ; res@cnMissingValPerimOn  = True

  res2@cnLevelSelectionMode =  "ManualLevels"

  ; if wave.eq."er" .or. wave.eq."mjo" then
  res2@cnMinLevelValF       =  -5.
  res2@cnMaxLevelValF       =  5.
  res2@cnLevelSpacingF      =  2.
  ; ; else
  ; res2@cnMinLevelValF       =  -5.
  ; res2@cnMaxLevelValF       =  5.
  ; res2@cnLevelSpacingF      =  1.
  ; end if
  ; res2@gsnContourZeroLineThicknessF = 1.1

  ; res2@cnLevelSelectionMode =  "ExplicitLevels"
  ; res@cnMinLevelValF       =  minlv
  ; res@cnMaxLevelValF       =  maxlv
  ; res@cnLevelSpacingF      =  intlv
  res2@gsnLeftString         = ""
  ; res2@cnLevels = (/0.2,0.3,0.4, 0.5, 0.6, 0.7,0.8, 1.0,1.25,1.4, 1.5, 1.6,1.7,1.8,2.0/)
  ; 2/10,3/10,4/10,5/10,6/10,7/10,8/10,9/10,1,
  res2@gsnAddCyclic         = False
  ; res2@cnFillPalette = False
  ; res2@cnFillPattern        = 17
  ; res2@cnFillScaleF         = 1.2
  ; res2@cnMonoFillColor = True
  ; res2@cnFillColorOn        = True
  ; res2@cnFillColor          = "black"
  ; res2@cnFillDotSizeF       = 0.003
  res2@gsnRightString       = ""
  res2@cnLineLabelsOn    = True
  ; res2@cnLineLabelDensityF = 1.0
  res2@cnLineLabelPlacementMode = "constant"
  res2@cnLineDashSegLenF = 0.1
  res2@cnLineLabelInterval = 1
  ; res2@cnLineLabelConstantSpacingF =

  res@cnFillMode = "RasterFill"

  ; res2@cnFillMode = "RasterFill"
  res2@gsnContourNegLineDashPattern = 2
  res2@gsnContourLineThicknessesScale  = 1
  res2@gsnContourZeroLineThicknessF = 0.

  ; res2@cnLineLabel


  ; res2@gsnContourNegLineDashPattern = 2
  ; res2@gsnContourZeroLineThicknessF = 2.5

  ; x_con = x
  ; copy_VarCoords(x_in,x_con)

; ndays = (/150,183,98,114,115,160,31,49/)


  do g = 0, 7
  ; if g.eq.4 then
    res2@cnInfoLabelOn = 0
    res2@cnInfoLabelSide    = "Top"
    res2@cnInfoLabelJust     = "TopRight"

  ; else
    ; res2@cnInfoLabelOn = False
  ; end if

  ; if g.gt.3 then
    ; res@tmYLOn = False
  ; else
    res@tmYLOn = True
  ; end if

    res@gsnFrame                    = False
    res@gsnLeftString = ""; x@ndays(g+1) + " )"
    res@mpFillOn = True
    res@mpLandFillColor             = "transparent"
    res@mpOceanFillColor            = "white"
    res@cnFillOpacityF              = 0.8
    res@mpFillDrawOrder       = "Draw"                     ; fille the ocean, land, and inland water last, but do not

    res@cnFillDrawOrder = "PreDraw"
    ; res@mpFillDrawOrder             = "PostDraw"
    ; res@gsnFrame                    = True
    ; res@mpFillAreaSpecifiers        = "Oceans"
    ; res@m
    ; res@mpMaskAreaSpecifiers        = "Australia"
    res@cnMissingValFillPattern = 0 ; missing value pattern is set to "SolidFill"
    res@mpAreaMaskingOn       = True          ; Indicate we want to
    res@mpOceanFillColor = 0                                   ; fill the oceans with index 0 (=white)
    ; res@mpMaskAreaSpecifiers  = "Australia"  ; mask land.
    ; res@cnFillDrawOrder             = "PreDraw"

    ; res@gsnFrame = True
    ; res@gsnDraw  = False

    res@gsnRightStringFontHeightF = 0.04
    if g.eq.0 then
      res@gsnRightString = "WETTER DJF"
    else if g.eq. 1 then
      res@gsnRightString = "DRIER DJF"
    else
      res@gsnRightString = ""
    end if
    end if

    res@gsnLeftStringFontHeightF = 0.016
    res@gsnLeftString = "ndays="+ndays(g)

    ; x_anom_smth = smth9_Wrap(x_anom, -0.25, -0.25, False)
    plot(plotsort(g)) = gsn_csm_contour_map(wks,x_stat(g,:,:),res)
    plotc(plotsort(g)) = gsn_csm_contour(wks, x_anom_stat(g,:,:),res2)

  ;---Attach some dummy text strings
    txres               = True
    txres@txFontHeightF = 0.015
    txres@txJust        = "CenterLeft"



    txt_title1(g) = gsn_add_text(wks,plot(plotsort(g)),"RA",149.5,-11,txres)
    txt_title2(g) = gsn_add_text(wks,plot(plotsort(g)),"WD",152.5,-11,txres)

    text_mean(g) = gsn_add_text(wks,plot(plotsort(g)),"Med",146,-12,txres)
    text_max(g)  = gsn_add_text(wks,plot(plotsort(g)),"Max ",146,-13,txres)
    text_min(g)  = gsn_add_text(wks,plot(plotsort(g)),"Min ",146,-14,txres)

    rr_txtmean(g) = gsn_add_text(wks,plot(plotsort(g)),mean_rr(g),149,-12,txres)
    rr_txtmax(g)  = gsn_add_text(wks,plot(plotsort(g)),max_rr(g),149,-13,txres)
    rr_txtmax(g)  = gsn_add_text(wks,plot(plotsort(g)),min_rr(g),149,-14,txres)

    Pr_txtmean(g) = gsn_add_text(wks,plot(plotsort(g)),mean_Pr(g),152.5,-12,txres)
    Pr_txtmax(g)  = gsn_add_text(wks,plot(plotsort(g)),max_Pr(g),152.5,-13,txres)
    Pr_txtmax(g)  = gsn_add_text(wks,plot(plotsort(g)),min_Pr(g),152.5,-14,txres)

    overlay(plot(plotsort(g)), plotc(plotsort(g)))


    ; res@gsnDraw                     = True

    ; plot(plotsort(g)) = gsn_csm_contour_map(wks,x({g+1},:,:),res)
    ; print("Adding polygons...")
    ; poly(plotsort(g)) = gsn_add_shapefile_polylines(wks,plot(plotsort(g)),"AUS_2021_AUST_SHP_GDA2020/AUS_2021_AUST_GDA2020.shp",pres)

  end do
;************************************************
; create panel
;************************************************
  resP                  = True                   ; modify the panel plot
  resP@gsnFrame         = False                  ; don't advance panel plot
  resP@gsnPanelLabelBar = True                   ; add common colorbar
  ; if (wave) .eq. "td" then
  ;   resP@gsnPanelMainString = str_upper(wave) + "-type waves: "+seasmon     ; set main title
  ; else if (wave) .eq. "mjo" then
  ;   resP@gsnPanelMainString = str_upper(wave)+ ": "+seasmon     ; set main title
  ; else
  ;   resP@gsnPanelMainString = str_upper(wave) + " waves: "+seasmon     ; set main title
  ; end if
  ; end if
  ; resP@gsnPanelMainString = str_upper(status) + ": "+seasmon     ; set main title
  ; resP@gsnPanelBottom   = 0.6                   ; add space at bottom
  resP@gsnPanelFigureStrings = (/"(a) "+status_name(0),"(b) "+status_name(1),"(c) "+status_name(2),\\
                              "(d) "+status_name(3),"(e) "+status_name(4),"(f) "+status_name(5), \\
                              "(g) "+status_name(6), "(h) "+status_name(7)  /)
  ; resP@gsnPanelFigureStrings= (/"(a) P1 ("+x@ndays(1) + ")","(e) P5 ("+x@ndays(5) + ")","(b) P2 ("+x@ndays(2) + ")","(f) P6 ("+x@ndays(6) + ")", \\
  ;                             "(c) P3 ("+x@ndays(3) + ")","(g) P7 ("+x@ndays(7) + ")","(d) P4 ("+x@ndays(4) + ")","(h) P8 ("+x@ndays(8) + ")"/) ; add strings to panel
  resP@gsnPanelFigureStringsFontHeightF = 0.01
  resP@amJust   = "TopLeft"
  resP@lbLabelStride        = 1
  resP@lbTitleFontHeightF = 0.011
  resP@lbLabelFontHeightF = 0.011

  if stattype.eq."wetdays" then
    resP@lbTitleString  = "[ number of rainfall > 10 mm/day PER SEASON ]"
  else if stattype.eq."wetdaysanom" then
    resP@lbTitleString  = "[ P(x > 10mm/day) / Pseason  ]"
  end if
end if

  resP@lbTitlePosition = "bottom"
  ; resP@lbTitleOffsetF = 0.8

  ; print(wave+ "waves")
  ; print(x@ndays)
  resP@lbTopMarginF    = 0.4
  ; resP@lbLabelOffsetF  = -1.0
  ; resP@lbBottomMarginF = 0.0001
  ; resP@pmLabelBarWidthF = 0.75
  ; resP@pmLabelBarHeightF = 0.04
  ; resP@lbTitleFontHeightF = 0.01

  ; resP@gsnPanelMainPosXF  = 0.1

  gsn_panel(wks,plot,(/4,2/),resP)               ; now draw as one plot



  txres               = True
  txres@txFontHeightF = 0.01
  ; gsn_text_ndc(wks,"Figure 1: A nifty panel plot",0.5,0.02,txres)
  frame(wks)
