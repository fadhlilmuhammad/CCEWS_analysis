
; load('$NCARG_ROOT/lib/ncarg/database/rangs')
diri = "/Users/fadhlilrizki/Documents/PhD/thesis/dataout/precip/"
diri2 = "/Users/fadhlilrizki/Documents/PhD/thesis/data/composite_wetter_drier/"
; diri = "/Users/fadhlilrizki/Documents/PhD/thesis/dataout/precip/gadi/"
diro = "/Users/fadhlilrizki/Documents/PhD/thesis/figures/precip/"

; waves  = (/"erw", "tdw","mjo","mrg"/)
; thresh = 1


stattype = ""

condition = "suppressed"
plttype = "png"
var1 = "mfc"
pltname = "Fig5_GRL_trial_all_"+var1+condition +"supplement"

minlv = -5.
maxlv = 5.
intlv = .5
;remaptype =  "025"
; remaptype =  "check_wTC"
remaptype1 =  "025_dailyanom"
; remaptype2 =  "025_dailyanom"

yearmode1 = "mid"
yearmode2 = "wet"


if (yearmode1.eq."wet") then
  plottitle1 = "WETTER DJF"
else if (yearmode1.eq."dry") then
  plottitle1 = "DRIER DJF"
else if (yearmode1.eq."mid") then
  plottitle1 = "MODERATE DJF"
end if
end if
end if

if (yearmode2.eq."wet") then
  plottitle2 = "WETTER DJF"
else if (yearmode2.eq."dry") then
  plottitle1 = "DRIER DJF"
else if (yearmode2.eq."mid") then
  plottitle2 = "MODERATE DJF"
end if
end if
end if

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

; statuses = (/"ER_MJO456","ER_MJO456","ER_suppMJO","ER_suppMJO","suppER_MJO456","suppER_MJO456","noER_noMJO","noER_noMJO"/)

w1 = "erw"
w2 = "mjo"

if condition.eq."weak" then
statuses = (/"ER_MJO456","ER_MJO456","ER_weakMJO","ER_weakMJO","weakER_MJO456","weakER_MJO456","noER_noMJO","noER_noMJO", "mjo456", "mjo456", "erw456", "erw456"/)

status_name = (/"wet ER & wet MJO", "wet ER & wet MJO", "wet ER & no MJO", "wet ER & no MJO",  \\
                "no ER & wet MJO", "no ER & wet MJO", "no ER & no MJO", "no ER & no MJO"/)

ndays = (/150,183,68,34,50,28,31,49/)

else if condition.eq."suppressed" then
statuses = (/ "mjo456", "mjo456", "erw456", "erw456", "ER_MJO456","ER_MJO456","ER_suppMJO","ER_suppMJO","suppER_MJO456","suppER_MJO456","noER_noMJO","noER_noMJO"/)
status_name = (/"MJO P4-6", "MJO P4-6", "ER P4-6", "ER P4-6", "wet ER & wet MJO", "wet ER & wet MJO", "wet ER & dry MJO", "wet ER & dry MJO",  \\
                "dry ER & wet MJO", "dry ER & wet MJO", "no ER & no MJO", "no ER & no MJO"/)

end if
end if

if (yearmode1.eq."wet").and.(yearmode2.eq."dry") then
ndays = (/335,441,347,364,150,184,98,114,115,160,31,49/)
  else if (yearmode1.eq."mid").and.(yearmode2.eq."wet") then
  ndays = (/433,335,424,347,142,150,162,98,171,115,34,31/);433,424,142,162,171,34,
end if
end if


status = "combi"
; perc = 90
fname_w1_a1  = var1+"_"+w1+"_"+statuses(0)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode1+".nc"
fname_w2_a1  = var1+"_"+w2+"_"+statuses(0)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode1+".nc"
fname_w1_b1  = "adv_q_"+w1+"_"+statuses(0)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode1+".nc"
fname_w2_b1  = "adv_q_"+w2+"_"+statuses(0)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode1+".nc"
fname_w1_u1  = "viwve_"+w1+"_"+statuses(0)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode1+".nc"
fname_w2_u1  = "viwve_"+w2+"_"+statuses(0)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode1+".nc"
fname_w1_v1  = "viwvn_"+w1+"_"+statuses(0)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode1+".nc"
fname_w2_v1  = "viwvn_"+w2+"_"+statuses(0)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode1+".nc"

fname_w1_a2  = var1+"_"+w1+"_"+statuses(1)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode2+".nc"
fname_w2_a2  = var1+"_"+w2+"_"+statuses(1)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode2+".nc"
fname_w1_b2  = "adv_q_"+w1+"_"+statuses(1)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode2+".nc"
fname_w2_b2  = "adv_q_"+w2+"_"+statuses(1)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode2+".nc"
fname_w1_u2  = "viwve_"+w1+"_"+statuses(1)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode2+".nc"
fname_w2_u2  = "viwve_"+w2+"_"+statuses(1)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode2+".nc"
fname_w1_v2  = "viwvn_"+w1+"_"+statuses(1)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode2+".nc"
fname_w2_v2  = "viwvn_"+w2+"_"+statuses(1)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode2+".nc"

fname_w1_a3  = var1+"_"+w1+"_"+statuses(2)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode1+".nc"
fname_w2_a3  = var1+"_"+w2+"_"+statuses(2)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode1+".nc"
fname_w1_b3  = "adv_q_"+w1+"_"+statuses(2)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode1+".nc"
fname_w2_b3  = "adv_q_"+w2+"_"+statuses(2)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode1+".nc"
fname_w1_u3  = "viwve_"+w1+"_"+statuses(2)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode1+".nc"
fname_w2_u3  = "viwve_"+w2+"_"+statuses(2)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode1+".nc"
fname_w1_v3  = "viwvn_"+w1+"_"+statuses(2)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode1+".nc"
fname_w2_v3  = "viwvn_"+w2+"_"+statuses(2)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode1+".nc"

fname_w1_a4  = var1+"_"+w1+"_"+statuses(3)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode2+".nc"
fname_w2_a4  = var1+"_"+w2+"_"+statuses(3)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode2+".nc"
fname_w1_b4  = "adv_q_"+w1+"_"+statuses(3)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode2+".nc"
fname_w2_b4  = "adv_q_"+w2+"_"+statuses(3)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode2+".nc"
fname_w1_u4  = "viwve_"+w1+"_"+statuses(3)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode2+".nc"
fname_w2_u4  = "viwve_"+w2+"_"+statuses(3)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode2+".nc"
fname_w1_v4  = "viwvn_"+w1+"_"+statuses(3)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode2+".nc"
fname_w2_v4  = "viwvn_"+w2+"_"+statuses(3)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode2+".nc"

fname_w1_a5  = var1+"_"+w1+"_"+statuses(4)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode1+".nc"
fname_w2_a5  = var1+"_"+w2+"_"+statuses(4)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode1+".nc"
fname_w1_b5  = "adv_q_"+w1+"_"+statuses(4)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode1+".nc"
fname_w2_b5  = "adv_q_"+w2+"_"+statuses(4)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode1+".nc"
fname_w1_u5  = "viwve_"+w1+"_"+statuses(4)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode1+".nc"
fname_w2_u5  = "viwve_"+w2+"_"+statuses(4)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode1+".nc"
fname_w1_v5  = "viwvn_"+w1+"_"+statuses(4)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode1+".nc"
fname_w2_v5  = "viwvn_"+w2+"_"+statuses(4)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode1+".nc"

fname_w1_a6  = var1+"_"+w1+"_"+statuses(5)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode2+".nc"
fname_w2_a6  = var1+"_"+w2+"_"+statuses(5)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode2+".nc"
fname_w1_b6  = "adv_q_"+w1+"_"+statuses(5)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode2+".nc"
fname_w2_b6  = "adv_q_"+w2+"_"+statuses(5)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode2+".nc"
fname_w1_u6  = "viwve_"+w1+"_"+statuses(5)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode2+".nc"
fname_w2_u6  = "viwve_"+w2+"_"+statuses(5)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode2+".nc"
fname_w1_v6  = "viwvn_"+w1+"_"+statuses(5)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode2+".nc"
fname_w2_v6  = "viwvn_"+w2+"_"+statuses(5)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode2+".nc"

fname_w1_a7  = var1+"_"+w1+"_"+statuses(6)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode1+".nc"
fname_w2_a7  = var1+"_"+w2+"_"+statuses(6)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode1+".nc"
fname_w1_b7  = "adv_q_"+w1+"_"+statuses(6)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode1+".nc"
fname_w2_b7  = "adv_q_"+w2+"_"+statuses(6)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode1+".nc"
fname_w1_u7  = "viwve_"+w1+"_"+statuses(6)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode1+".nc"
fname_w2_u7  = "viwve_"+w2+"_"+statuses(6)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode1+".nc"
fname_w1_v7  = "viwvn_"+w1+"_"+statuses(6)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode1+".nc"
fname_w2_v7  = "viwvn_"+w2+"_"+statuses(6)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode1+".nc"


fname_w1_a8  = var1+"_"+w1+"_"+statuses(7)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode2+".nc"
fname_w2_a8  = var1+"_"+w2+"_"+statuses(7)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode2+".nc"
fname_w1_b8  = "adv_q_"+w1+"_"+statuses(7)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode2+".nc"
fname_w2_b8  = "adv_q_"+w2+"_"+statuses(7)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode2+".nc"
fname_w1_u8  = "viwve_"+w1+"_"+statuses(7)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode2+".nc"
fname_w2_u8  = "viwve_"+w2+"_"+statuses(7)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode2+".nc"
fname_w1_v8  = "viwvn_"+w1+"_"+statuses(7)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode2+".nc"
fname_w2_v8  = "viwvn_"+w2+"_"+statuses(7)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode2+".nc"



fname_w1_a9  = var1+"_"+w1+"_"+statuses(8)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode1+".nc"
fname_w2_a9  = var1+"_"+w2+"_"+statuses(8)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode1+".nc"
fname_w1_b9  = "adv_q_"+w1+"_"+statuses(8)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode1+".nc"
fname_w2_b9  = "adv_q_"+w2+"_"+statuses(8)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode1+".nc"
fname_w1_u9  = "viwve_"+w1+"_"+statuses(8)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode1+".nc"
fname_w2_u9  = "viwve_"+w2+"_"+statuses(8)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode1+".nc"
fname_w1_v9  = "viwvn_"+w1+"_"+statuses(8)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode1+".nc"
fname_w2_v9  = "viwvn_"+w2+"_"+statuses(8)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode1+".nc"


fname_w1_a10  = var1+"_"+w1+"_"+statuses(9)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode2+".nc"
fname_w2_a10  = var1+"_"+w2+"_"+statuses(9)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode2+".nc"
fname_w1_b10  = "adv_q_"+w1+"_"+statuses(9)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode2+".nc"
fname_w2_b10  = "adv_q_"+w2+"_"+statuses(9)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode2+".nc"
fname_w1_u10  = "viwve_"+w1+"_"+statuses(9)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode2+".nc"
fname_w2_u10  = "viwve_"+w2+"_"+statuses(9)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode2+".nc"
fname_w1_v10  = "viwvn_"+w1+"_"+statuses(9)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode2+".nc"
fname_w2_v10  = "viwvn_"+w2+"_"+statuses(9)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode2+".nc"


fname_w1_a11  = var1+"_"+w1+"_"+statuses(10)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode1+".nc"
fname_w2_a11  = var1+"_"+w2+"_"+statuses(10)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode1+".nc"
fname_w1_b11  = "adv_q_"+w1+"_"+statuses(10)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode1+".nc"
fname_w2_b11  = "adv_q_"+w2+"_"+statuses(10)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode1+".nc"
fname_w1_u11  = "viwve_"+w1+"_"+statuses(10)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode1+".nc"
fname_w2_u11  = "viwve_"+w2+"_"+statuses(10)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode1+".nc"
fname_w1_v11  = "viwvn_"+w1+"_"+statuses(10)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode1+".nc"
fname_w2_v11  = "viwvn_"+w2+"_"+statuses(10)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode1+".nc"


fname_w1_a12  = var1+"_"+w1+"_"+statuses(11)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode2+".nc"
fname_w2_a12  = var1+"_"+w2+"_"+statuses(11)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode2+".nc"
fname_w1_b12  = "adv_q_"+w1+"_"+statuses(11)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode2+".nc"
fname_w2_b12  = "adv_q_"+w2+"_"+statuses(11)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode2+".nc"
fname_w1_u12  = "viwve_"+w1+"_"+statuses(11)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode2+".nc"
fname_w2_u12  = "viwve_"+w2+"_"+statuses(11)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode2+".nc"
fname_w1_v12  = "viwvn_"+w1+"_"+statuses(11)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode2+".nc"
fname_w2_v12  = "viwvn_"+w2+"_"+statuses(11)+"_wave_composite_"+seas+"ref"+ref+"."+remaptype1+"."+yearmode2+".nc"
; fname = "er_wave_composite_SHSummer_perc95_025_sig95.ref133.regrid.nc"
; fname = wave+"_wave_composite_"+seas+"ref"+ref+"."+remaptype+".nc"
; fname = "olr_er_wave_composite.nc"

; fmask = addfile("/Users/fadhlilrizki/Documents/PhD/thesis/data/"+"AGCD_025deg_Mask_comp.nc", "r")
; mnc   = fmask->mask({-43.5:-10.75}, {113:153.5})
; printVarSummary(mnc)

fw1a1     = addfile(diri2+fname_w1_a1, "r")
fw1b1    = addfile(diri2+fname_w1_b1, "r")
fw1u1     = addfile(diri2+fname_w1_u1, "r")
fw1v1     = addfile(diri2+fname_w1_v1, "r")

fw2a1     = addfile(diri2+fname_w2_a1, "r")
fw2b1    = addfile(diri2+fname_w2_b1, "r")
fw2u1     = addfile(diri2+fname_w2_u1, "r")
fw2v1    = addfile(diri2+fname_w2_v1, "r")

fw1a2     = addfile(diri2+fname_w1_a2, "r")
fw1b2    = addfile(diri2+fname_w1_b2, "r")
fw1u2     = addfile(diri2+fname_w1_u2, "r")
fw1v2     = addfile(diri2+fname_w1_v2, "r")

fw2a2     = addfile(diri2+fname_w2_a2, "r")
fw2b2    = addfile(diri2+fname_w2_b2, "r")
fw2u2     = addfile(diri2+fname_w2_u2, "r")
fw2v2    = addfile(diri2+fname_w2_v2, "r")

fw1a3     = addfile(diri2+fname_w1_a3, "r")
fw1b3    = addfile(diri2+fname_w1_b3, "r")
fw1u3     = addfile(diri2+fname_w1_u3, "r")
fw1v3     = addfile(diri2+fname_w1_v3, "r")

fw2a3     = addfile(diri2+fname_w2_a3, "r")
fw2b3    = addfile(diri2+fname_w2_b3, "r")
fw2u3     = addfile(diri2+fname_w2_u3, "r")
fw2v3    = addfile(diri2+fname_w2_v3, "r")

fw1a4     = addfile(diri2+fname_w1_a4, "r")
fw1b4    = addfile(diri2+fname_w1_b4, "r")
fw1u4     = addfile(diri2+fname_w1_u4, "r")
fw1v4     = addfile(diri2+fname_w1_v4, "r")

fw2a4     = addfile(diri2+fname_w2_a4, "r")
fw2b4    = addfile(diri2+fname_w2_b4, "r")
fw2u4     = addfile(diri2+fname_w2_u4, "r")
fw2v4    = addfile(diri2+fname_w2_v4, "r")

fw1a5     = addfile(diri2+fname_w1_a5, "r")
fw1b5    = addfile(diri2+fname_w1_b5, "r")
fw1u5     = addfile(diri2+fname_w1_u5, "r")
fw1v5     = addfile(diri2+fname_w1_v5, "r")

fw2a5     = addfile(diri2+fname_w2_a5, "r")
fw2b5    = addfile(diri2+fname_w2_b5, "r")
fw2u5     = addfile(diri2+fname_w2_u5, "r")
fw2v5    = addfile(diri2+fname_w2_v5, "r")

fw1a6     = addfile(diri2+fname_w1_a6, "r")
fw1b6    = addfile(diri2+fname_w1_b6, "r")
fw1u6     = addfile(diri2+fname_w1_u6, "r")
fw1v6     = addfile(diri2+fname_w1_v6, "r")

fw2a6     = addfile(diri2+fname_w2_a6, "r")
fw2b6    = addfile(diri2+fname_w2_b6, "r")
fw2u6     = addfile(diri2+fname_w2_u6, "r")
fw2v6    = addfile(diri2+fname_w2_v6, "r")

fw1a7     = addfile(diri2+fname_w1_a7, "r")
fw1b7    = addfile(diri2+fname_w1_b7, "r")
fw1u7     = addfile(diri2+fname_w1_u7, "r")
fw1v7     = addfile(diri2+fname_w1_v7, "r")

fw2a7     = addfile(diri2+fname_w2_a7, "r")
fw2b7    = addfile(diri2+fname_w2_b7, "r")
fw2u7     = addfile(diri2+fname_w2_u7, "r")
fw2v7    = addfile(diri2+fname_w2_v7, "r")

fw1a8     = addfile(diri2+fname_w1_a8, "r")
fw1b8    = addfile(diri2+fname_w1_b8, "r")
fw1u8     = addfile(diri2+fname_w1_u8, "r")
fw1v8     = addfile(diri2+fname_w1_v8, "r")

fw2a8     = addfile(diri2+fname_w2_a8, "r")
fw2b8    = addfile(diri2+fname_w2_b8, "r")
fw2u8     = addfile(diri2+fname_w2_u8, "r")
fw2v8    = addfile(diri2+fname_w2_v8, "r")


fw1a9     = addfile(diri2+fname_w1_a9, "r")
fw1b9    = addfile(diri2+fname_w1_b9, "r")
fw1u9     = addfile(diri2+fname_w1_u9, "r")
fw1v9     = addfile(diri2+fname_w1_v9, "r")

fw2a9     = addfile(diri2+fname_w2_a9, "r")
fw2b9    = addfile(diri2+fname_w2_b9, "r")
fw2u9     = addfile(diri2+fname_w2_u9, "r")
fw2v9    = addfile(diri2+fname_w2_v9, "r")


fw1a10     = addfile(diri2+fname_w1_a10, "r")
fw1b10    = addfile(diri2+fname_w1_b10, "r")
fw1u10     = addfile(diri2+fname_w1_u10, "r")
fw1v10     = addfile(diri2+fname_w1_v10, "r")

fw2a10     = addfile(diri2+fname_w2_a10, "r")
fw2b10    = addfile(diri2+fname_w2_b10, "r")
fw2u10     = addfile(diri2+fname_w2_u10, "r")
fw2v10    = addfile(diri2+fname_w2_v10, "r")


fw1a11     = addfile(diri2+fname_w1_a11, "r")
fw1b11    = addfile(diri2+fname_w1_b11, "r")
fw1u11     = addfile(diri2+fname_w1_u11, "r")
fw1v11     = addfile(diri2+fname_w1_v11, "r")

fw2a11     = addfile(diri2+fname_w2_a11, "r")
fw2b11    = addfile(diri2+fname_w2_b11, "r")
fw2u11     = addfile(diri2+fname_w2_u11, "r")
fw2v11    = addfile(diri2+fname_w2_v11, "r")


fw1a12     = addfile(diri2+fname_w1_a12, "r")
fw1b12    = addfile(diri2+fname_w1_b12, "r")
fw1u12     = addfile(diri2+fname_w1_u12, "r")
fw1v12     = addfile(diri2+fname_w1_v12, "r")

fw2a12     = addfile(diri2+fname_w2_a12, "r")
fw2b12    = addfile(diri2+fname_w2_b12, "r")
fw2u12     = addfile(diri2+fname_w2_u12, "r")
fw2v12    = addfile(diri2+fname_w2_v12, "r")

;CONV
x_in_w1a1  = short2flt(fw1a1->composite)
x_in_w1a2  = short2flt(fw1a2->composite)
x_in_w1a3  = short2flt(fw1a3->composite)
x_in_w1a4  = short2flt(fw1a4->composite)
x_in_w1a5  = short2flt(fw1a5->composite)
x_in_w1a6  = short2flt(fw1a6->composite)
x_in_w1a7  = short2flt(fw1a7->composite)
x_in_w1a8  = short2flt(fw1a8->composite)
x_in_w1a9  = short2flt(fw1a9->composite)
x_in_w1a10  = short2flt(fw1a10->composite)
x_in_w1a11  = short2flt(fw1a11->composite)
x_in_w1a12  = short2flt(fw1a12->composite)

x_in_w2a1  = short2flt(fw2a1->composite)
x_in_w2a2  = short2flt(fw2a2->composite)
x_in_w2a3  = short2flt(fw2a3->composite)
x_in_w2a4  = short2flt(fw2a4->composite)
x_in_w2a5  = short2flt(fw2a5->composite)
x_in_w2a6  = short2flt(fw2a6->composite)
x_in_w2a7  = short2flt(fw2a7->composite)
x_in_w2a8  = short2flt(fw2a8->composite)
x_in_w2a9  = short2flt(fw2a9->composite)
x_in_w2a10  = short2flt(fw2a10->composite)
x_in_w2a11  = short2flt(fw2a11->composite)
x_in_w2a12  = short2flt(fw2a12->composite)

;ADV
x_in_w1b1 = short2flt(fw1b1->composite)
x_in_w1b2 = short2flt(fw1b2->composite)
x_in_w1b3 = short2flt(fw1b3->composite)
x_in_w1b4 = short2flt(fw1b4->composite)
x_in_w1b5 = short2flt(fw1b5->composite)
x_in_w1b6 = short2flt(fw1b6->composite)
x_in_w1b7 = short2flt(fw1b7->composite)
x_in_w1b8 = short2flt(fw1b8->composite)
x_in_w1b9 = short2flt(fw1b9->composite)
x_in_w1b10 = short2flt(fw1b10->composite)
x_in_w1b11 = short2flt(fw1b11->composite)
x_in_w1b12 = short2flt(fw1b12->composite)

x_in_w2b1 = short2flt(fw2b1->composite)
x_in_w2b2 = short2flt(fw2b2->composite)
x_in_w2b3 = short2flt(fw2b3->composite)
x_in_w2b4 = short2flt(fw2b4->composite)
x_in_w2b5 = short2flt(fw2b5->composite)
x_in_w2b6 = short2flt(fw2b6->composite)
x_in_w2b7 = short2flt(fw2b7->composite)
x_in_w2b8 = short2flt(fw2b8->composite)
x_in_w2b9 = short2flt(fw2b9->composite)
x_in_w2b10 = short2flt(fw2b10->composite)
x_in_w2b11 = short2flt(fw2b11->composite)
x_in_w2b12 = short2flt(fw2b12->composite)

;VIWVE
x_in_w1u1 = short2flt(fw1u1->composite)
x_in_w1u2 = short2flt(fw1u2->composite)
x_in_w1u3 = short2flt(fw1u3->composite)
x_in_w1u4 = short2flt(fw1u4->composite)
x_in_w1u5 = short2flt(fw1u5->composite)
x_in_w1u6 = short2flt(fw1u6->composite)
x_in_w1u7 = short2flt(fw1u7->composite)
x_in_w1u8 = short2flt(fw1u8->composite)
x_in_w1u9 = short2flt(fw1u9->composite)
x_in_w1u10 = short2flt(fw1u10->composite)
x_in_w1u11 = short2flt(fw1u11->composite)
x_in_w1u12 = short2flt(fw1u12->composite)

x_in_w2u1 = short2flt(fw2u1->composite)
x_in_w2u2 = short2flt(fw2u2->composite)
x_in_w2u3 = short2flt(fw2u3->composite)
x_in_w2u4 = short2flt(fw2u4->composite)
x_in_w2u5 = short2flt(fw2u5->composite)
x_in_w2u6 = short2flt(fw2u6->composite)
x_in_w2u7 = short2flt(fw2u7->composite)
x_in_w2u8 = short2flt(fw2u8->composite)
x_in_w2u9 = short2flt(fw2u9->composite)
x_in_w2u10 = short2flt(fw2u10->composite)
x_in_w2u11 = short2flt(fw2u11->composite)
x_in_w2u12 = short2flt(fw2u12->composite)


;VIWVN
x_in_w1v1 = short2flt(fw1v1->composite)
x_in_w1v2 = short2flt(fw1v2->composite)
x_in_w1v3 = short2flt(fw1v3->composite)
x_in_w1v4 = short2flt(fw1v4->composite)
x_in_w1v5 = short2flt(fw1v5->composite)
x_in_w1v6 = short2flt(fw1v6->composite)
x_in_w1v7 = short2flt(fw1v7->composite)
x_in_w1v8 = short2flt(fw1v8->composite)
x_in_w1v9 = short2flt(fw1v9->composite)
x_in_w1v10 = short2flt(fw1v10->composite)
x_in_w1v11 = short2flt(fw1v11->composite)
x_in_w1v12 = short2flt(fw1v12->composite)

x_in_w2v1 = short2flt(fw2v1->composite)
x_in_w2v2 = short2flt(fw2v2->composite)
x_in_w2v3 = short2flt(fw2v3->composite)
x_in_w2v4 = short2flt(fw2v4->composite)
x_in_w2v5 = short2flt(fw2v5->composite)
x_in_w2v6 = short2flt(fw2v6->composite)
x_in_w2v7 = short2flt(fw2v7->composite)
x_in_w2v8 = short2flt(fw2v8->composite)
x_in_w2v9 = short2flt(fw2v9->composite)
x_in_w2v10 = short2flt(fw2v10->composite)
x_in_w2v11 = short2flt(fw2v11->composite)
x_in_w2v12 = short2flt(fw2v12->composite)


;;ALPHA
a_w1a1     = short2flt(fw1a1->alpha)
a_w1a2     = short2flt(fw1a2->alpha)
a_w1a3     = short2flt(fw1a3->alpha)
a_w1a4     = short2flt(fw1a4->alpha)
a_w1a5     = short2flt(fw1a5->alpha)
a_w1a6     = short2flt(fw1a6->alpha)
a_w1a7     = short2flt(fw1a7->alpha)
a_w1a8     = short2flt(fw1a8->alpha)
a_w1a9     = short2flt(fw1a9->alpha)
a_w1a10     = short2flt(fw1a10->alpha)
a_w1a11     = short2flt(fw1a11->alpha)
a_w1a12     = short2flt(fw1a12->alpha)

a_w2a1     = short2flt(fw2a1->alpha)
a_w2a2     = short2flt(fw2a2->alpha)
a_w2a3     = short2flt(fw2a3->alpha)
a_w2a4     = short2flt(fw2a4->alpha)
a_w2a5     = short2flt(fw2a5->alpha)
a_w2a6     = short2flt(fw2a6->alpha)
a_w2a7     = short2flt(fw2a7->alpha)
a_w2a8     = short2flt(fw2a8->alpha)
a_w2a9     = short2flt(fw2a9->alpha)
a_w2a10     = short2flt(fw2a10->alpha)
a_w2a11     = short2flt(fw2a11->alpha)
a_w2a12     = short2flt(fw2a12->alpha)

a_w1b1    = short2flt(fw1b1->alpha)
a_w1b2    = short2flt(fw1b2->alpha)
a_w1b3    = short2flt(fw1b3->alpha)
a_w1b4    = short2flt(fw1b4->alpha)
a_w1b5    = short2flt(fw1b5->alpha)
a_w1b6    = short2flt(fw1b6->alpha)
a_w1b7    = short2flt(fw1b7->alpha)
a_w1b8    = short2flt(fw1b8->alpha)
a_w1b9    = short2flt(fw1b9->alpha)
a_w1b10    = short2flt(fw1b10->alpha)
a_w1b11    = short2flt(fw1b11->alpha)
a_w1b12    = short2flt(fw1b12->alpha)

a_w2b1    = short2flt(fw2b1->alpha)
a_w2b2    = short2flt(fw2b2->alpha)
a_w2b3    = short2flt(fw2b3->alpha)
a_w2b4    = short2flt(fw2b4->alpha)
a_w2b5    = short2flt(fw2b5->alpha)
a_w2b6    = short2flt(fw2b6->alpha)
a_w2b7    = short2flt(fw2b7->alpha)
a_w2b8    = short2flt(fw2b8->alpha)
a_w2b9    = short2flt(fw2b9->alpha)
a_w2b10    = short2flt(fw2b10->alpha)
a_w2b11    = short2flt(fw2b11->alpha)
a_w2b12    = short2flt(fw2b12->alpha)

a_w1u1    = short2flt(fw1u1->alpha)
a_w1u2    = short2flt(fw1u2->alpha)
a_w1u3    = short2flt(fw1u3->alpha)
a_w1u4    = short2flt(fw1u4->alpha)
a_w1u5    = short2flt(fw1u5->alpha)
a_w1u6    = short2flt(fw1u6->alpha)
a_w1u7    = short2flt(fw1u7->alpha)
a_w1u8    = short2flt(fw1u8->alpha)
a_w1u9    = short2flt(fw1u9->alpha)
a_w1u10    = short2flt(fw1u10->alpha)
a_w1u11    = short2flt(fw1u11->alpha)
a_w1u12    = short2flt(fw1u12->alpha)

a_w2u1    = short2flt(fw2u1->alpha)
a_w2u2    = short2flt(fw2u2->alpha)
a_w2u3    = short2flt(fw2u3->alpha)
a_w2u4    = short2flt(fw2u4->alpha)
a_w2u5    = short2flt(fw2u5->alpha)
a_w2u6    = short2flt(fw2u6->alpha)
a_w2u7    = short2flt(fw2u7->alpha)
a_w2u8    = short2flt(fw2u8->alpha)
a_w2u9    = short2flt(fw2u9->alpha)
a_w2u10    = short2flt(fw2u10->alpha)
a_w2u11    = short2flt(fw2u11->alpha)
a_w2u12    = short2flt(fw2u12->alpha)

a_w1v1    = short2flt(fw1v1->alpha)
a_w1v2    = short2flt(fw1v2->alpha)
a_w1v3    = short2flt(fw1v3->alpha)
a_w1v4    = short2flt(fw1v4->alpha)
a_w1v5    = short2flt(fw1v5->alpha)
a_w1v6    = short2flt(fw1v6->alpha)
a_w1v7    = short2flt(fw1v7->alpha)
a_w1v8    = short2flt(fw1v8->alpha)
a_w1v9    = short2flt(fw1v9->alpha)
a_w1v10    = short2flt(fw1v10->alpha)
a_w1v11    = short2flt(fw1v11->alpha)
a_w1v12    = short2flt(fw1v12->alpha)

a_w2v1    = short2flt(fw2v1->alpha)
a_w2v2    = short2flt(fw2v2->alpha)
a_w2v3    = short2flt(fw2v3->alpha)
a_w2v4    = short2flt(fw2v4->alpha)
a_w2v5    = short2flt(fw2v5->alpha)
a_w2v6    = short2flt(fw2v6->alpha)
a_w2v7    = short2flt(fw2v7->alpha)
a_w2v8    = short2flt(fw2v8->alpha)
a_w2v9    = short2flt(fw2v9->alpha)
a_w2v10    = short2flt(fw2v10->alpha)
a_w2v11    = short2flt(fw2v11->alpha)
a_w2v12    = short2flt(fw2v12->alpha)

; dimmask = dimsizes(mnc)

x_w1a1      = where(a_w1a1+a_w2a1.ge.1., x_in_w1a1, x_in_w1a1@_FillValue)
x_w1a2      = where(a_w1a2+a_w2a2.ge.1., x_in_w1a2, x_in_w1a2@_FillValue)
x_w1a3      = where(a_w1a3+a_w2a3.ge.1., x_in_w1a3, x_in_w1a3@_FillValue)
x_w1a4      = where(a_w1a4+a_w2a4.ge.1., x_in_w1a4, x_in_w1a4@_FillValue)
x_w1a5      = where(a_w1a5+a_w2a5.ge.1., x_in_w1a5, x_in_w1a5@_FillValue)
x_w1a6      = where(a_w1a6+a_w2a6.ge.1., x_in_w1a6, x_in_w1a6@_FillValue)
x_w1a7      = where(a_w1a7+a_w2a7.ge.1., x_in_w1a7, x_in_w1a7@_FillValue)
x_w1a8      = where(a_w1a8+a_w2a8.ge.1., x_in_w1a8, x_in_w1a8@_FillValue)
x_w1a9      = where(a_w1a9.ge.1., x_in_w1a9, x_in_w1a9@_FillValue)
x_w1a10      = where(a_w1a10.ge.1., x_in_w1a10, x_in_w1a10@_FillValue)
x_w1a11      = where(a_w1a11.ge.1., x_in_w1a11, x_in_w1a11@_FillValue)
x_w1a12      = where(a_w1a12.ge.1., x_in_w1a12, x_in_w1a12@_FillValue)

x_w2a1      = where(a_w1a1+a_w2a1.ge.1., x_in_w2a1, x_in_w2a1@_FillValue)
x_w2a2      = where(a_w1a2+a_w2a2.ge.1., x_in_w2a2, x_in_w2a2@_FillValue)
x_w2a3      = where(a_w1a3+a_w2a3.ge.1., x_in_w2a3, x_in_w2a3@_FillValue)
x_w2a4      = where(a_w1a4+a_w2a4.ge.1., x_in_w2a4, x_in_w2a4@_FillValue)
x_w2a5      = where(a_w1a5+a_w2a5.ge.1., x_in_w2a5, x_in_w2a5@_FillValue)
x_w2a6      = where(a_w1a6+a_w2a6.ge.1., x_in_w2a6, x_in_w2a6@_FillValue)
x_w2a7      = where(a_w1a7+a_w2a7.ge.1., x_in_w2a7, x_in_w2a7@_FillValue)
x_w2a8      = where(a_w1a8+a_w2a8.ge.1., x_in_w2a8, x_in_w2a8@_FillValue)
x_w2a9      = where(a_w2a9.ge.1., x_in_w2a9, x_in_w2a9@_FillValue)
x_w2a10      = where(a_w2a10.ge.1., x_in_w2a10, x_in_w2a10@_FillValue)
x_w2a11      = where(a_w2a11.ge.1., x_in_w2a11, x_in_w2a11@_FillValue)
x_w2a12      = where(a_w2a12.ge.1., x_in_w2a12, x_in_w2a12@_FillValue)
printVarSummary(x_w1a1)

x_w1b1      = where(a_w1b1+a_w2b1.ge.1., x_in_w1b1, x_in_w1b1@_FillValue)
x_w1b2      = where(a_w1b2+a_w2b2.ge.1., x_in_w1b2, x_in_w1b2@_FillValue)
x_w1b3      = where(a_w1b3+a_w2b3.ge.1., x_in_w1b3, x_in_w1b3@_FillValue)
x_w1b4      = where(a_w1b4+a_w2b4.ge.1., x_in_w1b4, x_in_w1b4@_FillValue)
x_w1b5      = where(a_w1b5+a_w2b5.ge.1., x_in_w1b5, x_in_w1b5@_FillValue)
x_w1b6      = where(a_w1b6+a_w2b6.ge.1., x_in_w1b6, x_in_w1b6@_FillValue)
x_w1b7      = where(a_w1b7+a_w2b7.ge.1., x_in_w1b7, x_in_w1b7@_FillValue)
x_w1b8      = where(a_w1b8+a_w2b8.ge.1., x_in_w1b8, x_in_w1b8@_FillValue)
x_w1b9      = where(a_w1b9.ge.1., x_in_w1b9, x_in_w1b9@_FillValue)
x_w1b10      = where(a_w1b10.ge.1., x_in_w1b10, x_in_w1b10@_FillValue)
x_w1b11      = where(a_w1b11.ge.1., x_in_w1b11, x_in_w1b11@_FillValue)
x_w1b12      = where(a_w1b12.ge.1., x_in_w1b12, x_in_w1b12@_FillValue)

x_w2b1      = where(a_w2b1+a_w1b1.ge.1., x_in_w2b1, x_in_w2b1@_FillValue)
x_w2b2      = where(a_w2b2+a_w1b2.ge.1., x_in_w2b2, x_in_w2b2@_FillValue)
x_w2b3      = where(a_w2b3+a_w1b3.ge.1., x_in_w2b3, x_in_w2b3@_FillValue)
x_w2b4      = where(a_w2b4+a_w1b4.ge.1., x_in_w2b4, x_in_w2b4@_FillValue)
x_w2b5      = where(a_w2b5+a_w1b5.ge.1., x_in_w2b5, x_in_w2b5@_FillValue)
x_w2b6      = where(a_w2b6+a_w1b6.ge.1., x_in_w2b6, x_in_w2b6@_FillValue)
x_w2b7      = where(a_w2b7+a_w1b7.ge.1., x_in_w2b7, x_in_w2b7@_FillValue)
x_w2b8      = where(a_w2b8+a_w1b8.ge.1., x_in_w2b8, x_in_w2b8@_FillValue)
x_w2b9      = where(a_w2b9.ge.1., x_in_w2b9, x_in_w2b9@_FillValue)
x_w2b10      = where(a_w2b10.ge.1., x_in_w2b10, x_in_w2b10@_FillValue)
x_w2b11      = where(a_w2b11.ge.1., x_in_w2b11, x_in_w2b11@_FillValue)
x_w2b12      = where(a_w2b12.ge.1., x_in_w2b12, x_in_w2b12@_FillValue)

x_w1u1      = where(a_w1u1+a_w2u1.ge.1., x_in_w1u1, x_in_w1u1@_FillValue)
x_w1u2      = where(a_w1u2+a_w2u2.ge.1., x_in_w1u2, x_in_w1u2@_FillValue)
x_w1u3      = where(a_w1u3+a_w2u3.ge.1., x_in_w1u3, x_in_w1u3@_FillValue)
x_w1u4      = where(a_w1u4+a_w2u4.ge.1., x_in_w1u4, x_in_w1u4@_FillValue)
x_w1u5      = where(a_w1u5+a_w2u5.ge.1., x_in_w1u5, x_in_w1u5@_FillValue)
x_w1u6      = where(a_w1u6+a_w2u6.ge.1., x_in_w1u6, x_in_w1u6@_FillValue)
x_w1u7      = where(a_w1u7+a_w2u7.ge.1., x_in_w1u7, x_in_w1u7@_FillValue)
x_w1u8      = where(a_w1u8+a_w2u8.ge.1., x_in_w1u8, x_in_w1u8@_FillValue)
x_w1u9      = where(a_w1u9.ge.1., x_in_w1u9, x_in_w1u9@_FillValue)
x_w1u10      = where(a_w1u10.ge.1., x_in_w1u10, x_in_w1u10@_FillValue)
x_w1u11      = where(a_w1u11.ge.1., x_in_w1u11, x_in_w1u11@_FillValue)
x_w1u12      = where(a_w1u12.ge.1., x_in_w1u12, x_in_w1u12@_FillValue)

x_w2u1      = where(a_w2u1+a_w1u1.ge.1., x_in_w2u1, x_in_w2u1@_FillValue)
x_w2u2      = where(a_w2u2+a_w1u2.ge.1., x_in_w2u2, x_in_w2u2@_FillValue)
x_w2u3      = where(a_w2u3+a_w1u3.ge.1., x_in_w2u3, x_in_w2u3@_FillValue)
x_w2u4      = where(a_w2u4+a_w1u4.ge.1., x_in_w2u4, x_in_w2u4@_FillValue)
x_w2u5      = where(a_w2u5+a_w1u5.ge.1., x_in_w2u5, x_in_w2u5@_FillValue)
x_w2u6      = where(a_w2u6+a_w1u6.ge.1., x_in_w2u6, x_in_w2u6@_FillValue)
x_w2u7      = where(a_w2u7+a_w1u7.ge.1., x_in_w2u7, x_in_w2u7@_FillValue)
x_w2u8      = where(a_w2u8+a_w1u8.ge.1., x_in_w2u8, x_in_w2u8@_FillValue)
x_w2u9      = where(a_w2u9.ge.1., x_in_w2u9, x_in_w2u9@_FillValue)
x_w2u10      = where(a_w2u10.ge.1., x_in_w2u10, x_in_w2u10@_FillValue)
x_w2u11      = where(a_w2u11.ge.1., x_in_w2u11, x_in_w2u11@_FillValue)
x_w2u12      = where(a_w2u12.ge.1., x_in_w2u12, x_in_w2u12@_FillValue)

x_w1v1      = where(a_w1v1+a_w2v1.ge.1., x_in_w1v1, x_in_w1v1@_FillValue)
x_w1v2      = where(a_w1v2+a_w2v2.ge.1., x_in_w1v2, x_in_w1v2@_FillValue)
x_w1v3      = where(a_w1v3+a_w2v3.ge.1., x_in_w1v3, x_in_w1v3@_FillValue)
x_w1v4      = where(a_w1v4+a_w2v4.ge.1., x_in_w1v4, x_in_w1v4@_FillValue)
x_w1v5      = where(a_w1v5+a_w2v5.ge.1., x_in_w1v5, x_in_w1v5@_FillValue)
x_w1v6      = where(a_w1v6+a_w2v6.ge.1., x_in_w1v6, x_in_w1v6@_FillValue)
x_w1v7      = where(a_w1v7+a_w2v7.ge.1., x_in_w1v7, x_in_w1v7@_FillValue)
x_w1v8      = where(a_w1v8+a_w2v8.ge.1., x_in_w1v8, x_in_w1v8@_FillValue)
x_w1v9      = where(a_w1v9+a_w1v9.ge.1., x_in_w1v9, x_in_w1v9@_FillValue)
x_w1v10      = where(a_w1v10.ge.1., x_in_w1v10, x_in_w1v10@_FillValue)
x_w1v11      = where(a_w1v11.ge.1., x_in_w1v11, x_in_w1v11@_FillValue)
x_w1v12      = where(a_w1v12.ge.1., x_in_w1v12, x_in_w1v12@_FillValue)

x_w2v1      = where(a_w2v1+a_w1v1.ge.1., x_in_w2v1, x_in_w2v1@_FillValue)
x_w2v2      = where(a_w2v2+a_w1v2.ge.1., x_in_w2v2, x_in_w2v2@_FillValue)
x_w2v3      = where(a_w2v3+a_w1v3.ge.1., x_in_w2v3, x_in_w2v3@_FillValue)
x_w2v4      = where(a_w2v4+a_w1v4.ge.1., x_in_w2v4, x_in_w2v4@_FillValue)
x_w2v5      = where(a_w2v5+a_w1v5.ge.1., x_in_w2v5, x_in_w2v5@_FillValue)
x_w2v6      = where(a_w2v6+a_w1v6.ge.1., x_in_w2v6, x_in_w2v6@_FillValue)
x_w2v7      = where(a_w2v7+a_w1v7.ge.1., x_in_w2v7, x_in_w2v7@_FillValue)
x_w2v8      = where(a_w2v8+a_w1v8.ge.1., x_in_w2v8, x_in_w2v8@_FillValue)
x_w2v9      = where(a_w2v9.ge.1., x_in_w2v9, x_in_w2v9@_FillValue)
x_w2v10      = where(a_w2v10.ge.1., x_in_w2v10, x_in_w2v10@_FillValue)
x_w2v11      = where(a_w2v11.ge.1., x_in_w2v11, x_in_w2v11@_FillValue)
x_w2v12      = where(a_w2v12.ge.1., x_in_w2v12, x_in_w2v12@_FillValue)


; x_anom = x_in2

copy_VarMeta(x_in_w1a1, x_w1a1)
copy_VarMeta(x_in_w1a2, x_w1a2)
copy_VarMeta(x_in_w1a3, x_w1a3)
copy_VarMeta(x_in_w1a4, x_w1a4)
copy_VarMeta(x_in_w1a5, x_w1a5)
copy_VarMeta(x_in_w1a6, x_w1a6)
copy_VarMeta(x_in_w1a7, x_w1a7)
copy_VarMeta(x_in_w1a8, x_w1a8)
copy_VarMeta(x_in_w1a9, x_w1a9)
copy_VarMeta(x_in_w1a10, x_w1a10)
copy_VarMeta(x_in_w1a11, x_w1a11)
copy_VarMeta(x_in_w1a12, x_w1a12)

copy_VarMeta(x_in_w2a1, x_w2a1)
copy_VarMeta(x_in_w2a2, x_w2a2)
copy_VarMeta(x_in_w2a3, x_w2a3)
copy_VarMeta(x_in_w2a4, x_w2a4)
copy_VarMeta(x_in_w2a5, x_w2a5)
copy_VarMeta(x_in_w2a6, x_w2a6)
copy_VarMeta(x_in_w2a7, x_w2a7)
copy_VarMeta(x_in_w2a8, x_w2a8)
copy_VarMeta(x_in_w2a9, x_w2a9)
copy_VarMeta(x_in_w2a10, x_w2a10)
copy_VarMeta(x_in_w2a11, x_w2a11)
copy_VarMeta(x_in_w2a12, x_w2a12)

copy_VarMeta(x_in_w1b1, x_w1b1)
copy_VarMeta(x_in_w1b2, x_w1b2)
copy_VarMeta(x_in_w1b3, x_w1b3)
copy_VarMeta(x_in_w1b4, x_w1b4)
copy_VarMeta(x_in_w1b5, x_w1b5)
copy_VarMeta(x_in_w1b6, x_w1b6)
copy_VarMeta(x_in_w1b7, x_w1b7)
copy_VarMeta(x_in_w1b8, x_w1b8)
copy_VarMeta(x_in_w1b9, x_w1b9)
copy_VarMeta(x_in_w1b10, x_w1b10)
copy_VarMeta(x_in_w1b11, x_w1b11)
copy_VarMeta(x_in_w1b12, x_w1b12)


copy_VarMeta(x_in_w2b1, x_w2b1)
copy_VarMeta(x_in_w2b2, x_w2b2)
copy_VarMeta(x_in_w2b3, x_w2b3)
copy_VarMeta(x_in_w2b4, x_w2b4)
copy_VarMeta(x_in_w2b5, x_w2b5)
copy_VarMeta(x_in_w2b6, x_w2b6)
copy_VarMeta(x_in_w2b7, x_w2b7)
copy_VarMeta(x_in_w2b8, x_w2b8)
copy_VarMeta(x_in_w2b9, x_w2b9)
copy_VarMeta(x_in_w2b10, x_w2b10)
copy_VarMeta(x_in_w2b11, x_w2b11)
copy_VarMeta(x_in_w2b12, x_w2b12)


copy_VarMeta(x_in_w1u1, x_w1u1)
copy_VarMeta(x_in_w1u2, x_w1u2)
copy_VarMeta(x_in_w1u3, x_w1u3)
copy_VarMeta(x_in_w1u4, x_w1u4)
copy_VarMeta(x_in_w1u5, x_w1u5)
copy_VarMeta(x_in_w1u6, x_w1u6)
copy_VarMeta(x_in_w1u7, x_w1u7)
copy_VarMeta(x_in_w1u8, x_w1u8)
copy_VarMeta(x_in_w1u9, x_w1u9)
copy_VarMeta(x_in_w1u10, x_w1u10)
copy_VarMeta(x_in_w1u11, x_w1u11)
copy_VarMeta(x_in_w1u12, x_w1u12)


copy_VarMeta(x_in_w2u1, x_w2u1)
copy_VarMeta(x_in_w2u2, x_w2u2)
copy_VarMeta(x_in_w2u3, x_w2u3)
copy_VarMeta(x_in_w2u4, x_w2u4)
copy_VarMeta(x_in_w2u5, x_w2u5)
copy_VarMeta(x_in_w2u6, x_w2u6)
copy_VarMeta(x_in_w2u7, x_w2u7)
copy_VarMeta(x_in_w2u8, x_w2u8)
copy_VarMeta(x_in_w2u9, x_w2u9)
copy_VarMeta(x_in_w2u10, x_w2u10)
copy_VarMeta(x_in_w2u11, x_w2u11)
copy_VarMeta(x_in_w2u12, x_w2u12)


copy_VarMeta(x_in_w1v1, x_w1v1)
copy_VarMeta(x_in_w1v2, x_w1v2)
copy_VarMeta(x_in_w1v3, x_w1v3)
copy_VarMeta(x_in_w1v4, x_w1v4)
copy_VarMeta(x_in_w1v5, x_w1v5)
copy_VarMeta(x_in_w1v6, x_w1v6)
copy_VarMeta(x_in_w1v7, x_w1v7)
copy_VarMeta(x_in_w1v8, x_w1v8)
copy_VarMeta(x_in_w1v9, x_w1v9)
copy_VarMeta(x_in_w1v10, x_w1v10)
copy_VarMeta(x_in_w1v11, x_w1v11)
copy_VarMeta(x_in_w1v12, x_w1v12)


copy_VarMeta(x_in_w2v1, x_w2v1)
copy_VarMeta(x_in_w2v2, x_w2v2)
copy_VarMeta(x_in_w2v3, x_w2v3)
copy_VarMeta(x_in_w2v4, x_w2v4)
copy_VarMeta(x_in_w2v5, x_w2v5)
copy_VarMeta(x_in_w2v6, x_w2v6)
copy_VarMeta(x_in_w2v7, x_w2v7)
copy_VarMeta(x_in_w2v8, x_w2v8)
copy_VarMeta(x_in_w2v9, x_w2v9)
copy_VarMeta(x_in_w2v10, x_w2v10)
copy_VarMeta(x_in_w2v11, x_w2v11)
copy_VarMeta(x_in_w2v12, x_w2v12)

ndim = dimsizes(x_w1a1)
nlat = ndim(0)
nlon = ndim(1)

x_convq = new((/12, nlat, nlon/),"float")
x_advq  = new((/12, nlat, nlon/),"float")
x_viwve = new((/12, nlat, nlon/),"float")
x_viwvn = new((/12, nlat, nlon/),"float")


x_convq(0,:,:) = (x_w1a1 + x_w2a1)*10^5
x_convq(1,:,:) = (x_w1a2 + x_w2a2)*10^5
x_convq(2,:,:) = (x_w1a3 + x_w2a3)*10^5
x_convq(3,:,:) = (x_w1a4 + x_w2a4)*10^5
x_convq(4,:,:) = (x_w1a5 + x_w2a5)*10^5
x_convq(5,:,:) = (x_w1a6 + x_w2a6)*10^5
x_convq(6,:,:) = (x_w1a7 + x_w2a7)*10^5
x_convq(7,:,:) = (x_w1a8 + x_w2a8)*10^5
x_convq(8,:,:) = (x_w2a9)*10^5
x_convq(9,:,:) = (x_w2a10)*10^5
x_convq(10,:,:) = (x_w1a11)*10^5
x_convq(11,:,:) = (x_w1a12)*10^5
;
x_advq(0,:,:) = (x_w1b1 + x_w2b1)*10^5
x_advq(1,:,:) = (x_w1b2 + x_w2b2)*10^5
x_advq(2,:,:) = (x_w1b3 + x_w2b3)*10^5
x_advq(3,:,:) = (x_w1b4 + x_w2b4)*10^5
x_advq(4,:,:) = (x_w1b5 + x_w2b5)*10^5
x_advq(5,:,:) = (x_w1b6 + x_w2b6)*10^5
x_advq(6,:,:) = (x_w1b7 + x_w2b7)*10^5
x_advq(7,:,:) = (x_w1b8 + x_w2b8)*10^5
x_advq(8,:,:) = (x_w2b9)*10^5
x_advq(9,:,:) = (x_w2b10)*10^5
x_advq(10,:,:) = (x_w1b11)*10^5
x_advq(11,:,:) = (x_w1b12)*10^5

x_viwve(0,:,:) = x_w1u1 + x_w2u1
x_viwve(1,:,:) = x_w1u2 + x_w2u2
x_viwve(2,:,:) = x_w1u3 + x_w2u3
x_viwve(3,:,:) = x_w1u4 + x_w2u4
x_viwve(4,:,:) = x_w1u5 + x_w2u5
x_viwve(5,:,:) = x_w1u6 + x_w2u6
x_viwve(6,:,:) = x_w1u7 + x_w2u7
x_viwve(7,:,:) = x_w1u8 + x_w2u8
x_viwve(8,:,:) = x_w2u9
x_viwve(9,:,:) = x_w2u10
x_viwve(10,:,:) = x_w1u11
x_viwve(11,:,:) = x_w1u12

x_viwvn(0,:,:) = x_w1v1 + x_w2v1
x_viwvn(1,:,:) = x_w1v2 + x_w2v2
x_viwvn(2,:,:) = x_w1v3 + x_w2v3
x_viwvn(3,:,:) = x_w1v4 + x_w2v4
x_viwvn(4,:,:) = x_w1v5 + x_w2v5
x_viwvn(5,:,:) = x_w1v6 + x_w2v6
x_viwvn(6,:,:) = x_w1v7 + x_w2v7
x_viwvn(7,:,:) = x_w1v8 + x_w2v8
x_viwvn(8,:,:) = x_w2v9
x_viwvn(9,:,:) = x_w2v10
x_viwvn(10,:,:) = x_w1v11
x_viwvn(11,:,:) = x_w1v12

; copy_VarMeta(x_in, x_stat)
; copy_VarMeta(x_in2, x_anom)

do i = 0, 11
  copy_VarCoords(x_in_w1a1, x_convq(i,:,:))
  copy_VarCoords(x_in_w1b1, x_advq(i,:,:))
  copy_VarCoords(x_in_w1u1, x_viwve(i,:,:))
  copy_VarCoords(x_in_w1v1, x_viwvn(i,:,:))
end do

x_convq!0 = "status"
x_advq!0 = "status"
x_viwve!0 = "status"
x_viwvn!0 = "status"

x_convq!1 = "lat"
x_advq!1 = "lat"
x_viwve!1 = "lat"
x_viwvn!1 = "lat"

x_convq!2 = "lon"
x_advq!2 = "lon"
x_viwve!2 = "lon"
x_viwvn!2 = "lon"

x_convq&status = statuses
x_advq&status = statuses
x_viwve&status = statuses
x_viwvn&status = statuses

x_convq&lat = x_in_w1a1&latitude
x_advq&lat = x_in_w1a1&latitude
x_viwve&lat = x_in_w1a1&latitude
x_viwvn&lat = x_in_w1a1&latitude

x_convq&lon = x_in_w1a1&longitude
x_advq&lon = x_in_w1a1&longitude
x_viwve&lon = x_in_w1a1&longitude
x_viwvn&lon = x_in_w1a1&longitude

printVarSummary(x_convq)
printMinMax(x_convq,0)

n      = 12
;************************************************
; create plots
;************************************************
  wks = gsn_open_wks(plttype,diro+pltname)              ; send graphics to PNG file

  cmap = read_colormap_file("MPL_RdYlBu")
  ; cmap  = read_colormap_file("precip_diff_12lev")
    ; cmap  = read_colormap_file("precip4_diff_19lev")
    ; cmap  = read_colormap_file("WhViBlGrYeOrRe")
  ; cmap  = cmap(::-1,:)
  ; cmap(120:150,:) = 0
  ; cmap(7,:) = 0
  cmap(55:75,:) = 0
  ; ncmap = dimsizes(cmap(:,0))

  plot = new(n,graphic)                          ; create a plot array
  plotc = new(n, graphic)


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
  res@mpMaxLatF           = 0
  res@mpMinLatF           = -25

  res@mpMinLonF           = 88
  res@mpMaxLonF           = 160

  res@cnFillMode         = "AreaFill"

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

  res@mpOutlineSpecifiers      = (/"Indonesia", "Papua New Guinea", "Australia : Northern Territory", "Australia : Queensland", "Australia : Western Australia"/)  ; continents only
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

  res@vcRefAnnoString2On = True
  ; res@vcRefAnnoParallelPosF = 0.8
  res@vcRefAnnoOrthogonalPosF = -1
   res@vcRefAnnoJust = "TopRight"
  res@vcRefAnnoString2 = "kgm~S1~- ~S1~1 s~S1~- ~S1~1"
  ; res@cnFillMode = "CellFill"

  ; res@g
;
; Force both plots to have the same contour levels. This is necessary
; because the gsn_panel routine will based the labelbar on the first
; plot in the list.
;
  res@cnLevelSelectionMode =  "ManualLevels"
  res@cnMinLevelValF       =  minlv
  res@cnMaxLevelValF       =  maxlv
  res@cnLevelSpacingF      =  intlv


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

  plotsort = (/0,1,2,3,4,5,6,7,8,9,10,11/)

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
  ; res@cnMissingValFillColor = "gray90"
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



  do g = 0, n-1
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
    res@mpFillOn = False
    ; res@mpLandFillColor             = "transparent"
    ; res@mpOceanFillColor            = "white"
    res@cnFillOpacityF              = 0.8
    ; res@mpFillDrawOrder       = "Draw"                     ; fille the ocean, land, and inland water last, but do not

    res@gsnScalarContour = True
    res@vcRefMagnitudeF  = 100                      ; add a reference vector
    res@vcRefLengthF     = 0.045                     ; what the ref length is

    ; res@cnFillDrawOrder = "PreDraw"
    ; res@mpFillDrawOrder             = "PostDraw"
    ; res@gsnFrame                    = True
    ; res@mpFillAreaSpecifiers        = "Oceans"
    ; res@m
    ; res@mpMaskAreaSpecifiers        = "Australia"
    ; res@cnMissingValFillPattern = 0 ; missing value pattern is set to "SolidFill"
    ; res@mpAreaMaskingOn       = True          ; Indicate we want to
    ; res@mpOceanFillColor = 0                                   ; fill the oceans with index 0 (=white)
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

    res@lbLabelStride = 2
    res@gsnLeftStringFontHeightF = 0.016
    res@gsnLeftString = "ndays="+ndays(g)

    ; x_anom_smth = smth9_Wrap(x_anom, -0.25, -0.25, False)

    if g.gt.0 then
      res@vcRefAnnoOn = False
    end if
    plot(plotsort(g)) = gsn_csm_vector_scalar_map(wks,x_viwve(g,:,:),x_viwvn(g,:,:),x_convq(g,:,:),res)
    plotc(plotsort(g)) = gsn_csm_contour(wks, x_advq(g,:,:),res2)

    ; overlay(plot(plotsort(g)), plotc(plotsort(g)))
;

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
  ; resP@lbLabelStride        = 1
  resP@lbTitleFontHeightF = 0.008
  resP@lbLabelFontHeightF = 0.016

  resP@lbTitlePosition = "right"

  resP@lbTitleDirection = "across"
  resP@lbOrientation = "vertical"
  resP@lbLabelStride = 2
  ; resP@
 resP@lbTitleAngleF  = 90
  resP@lbTitleString  = "[ kgm~S1~- ~S1~2 s~S1~- ~S1~1 "+" x 10~S1~- ~S1~5 "+" ]"


  ; resP@lbTitlePosition = "right"
  ; resP@vpWidthF = 0.9
  ; resP@vpHeightF = 0.1
  ; resP@lbTitleFontHeightF = 0.2
  resP@lbAutoManage = False

  resP@pmLabelBarWidthF      = 0.05              ; default is shorter
  resP@pmLabelBarHeightF     = 0.7               ; default is taller
  ; resP@lbTitleOffsetF = 0.8

  ; print(wave+ "waves")
  ; print(x@ndays)
  resP@lbTopMarginF    = 0.5
  resP@lbBottomMarginF    = 0.1
  resP@lbLeftMarginF = 0.1
  resP@lbRightMarginF = 0.1
  ; resP@lbLabelOffsetF  = -1.0
  ; resP@lbBottomMarginF = 0.0001
  ; resP@pmLabelBarWidthF = 0.75
  ; resP@pmLabelBarHeightF = 0.04
  ; resP@lbTitleFontHeightF = 0.01

  ; resP@gsnPanelMainPosXF  = 0.1

  gsn_panel(wks,plot,(/6,2/),resP)               ; now draw as one plot



  txres               = True
  txres@txFontHeightF = 0.01
  ; gsn_text_ndc(wks,"Figure 1: A nifty panel plot",0.5,0.02,txres)
  frame(wks)
