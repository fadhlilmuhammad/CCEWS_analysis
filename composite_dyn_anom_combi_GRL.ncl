load "diag_local_wave_phase.ncl"


;LOOP with dyn_anom_combi_GRL.sh
; diro     = "/scratch/w40/fm6730/era5/composite/"
diro     = "/Users/fadhlilrizki/Documents/PhD/thesis/data/composite_wetter_drier/"

system("mkdir -p "+diro)
diri     = "/Users/fadhlilrizki/Documents/PhD/thesis/data/"

; waves = (/"erw","mjo","mrg","tdw"/)
; waves = (/"mjo","mrg","tdw"/)
; waves = (/"mjo","mrg","td"/)
;waves = (/"mjo"/)


; ensotype = "ntrl"
remaptype = "025_dailyanom"

startwave = 0
; do k = startwave, dimsizes(waves)-1
; wave = waves(k)

; yearmode = "dry"
; if yearmode.eq."wet" then
;   if wave.eq."mjo" then
;     nrow = 1444
;     ncol =

; var = "mfc"
; wave = "erw"
fin = var+"_"+wave+".30.nc"
; fin = "agcd_v1_precip_calib_r025_daily_1978-2020.maskedshp.shift1day.nc"
;

filter = False

; print(str_upper(wave))
ref = 133
seas = "SHSummer"
ystrt    = 1979
ylast    = 2020

; yearmode = "mid"
; status = "erw456"
; status1 = "ER"
; status2 = "MJO456"
f        = addfile(diri+fin, "r")
; g        = addfile(diro+"local_wave_phase/"+"local_"+wave+"_phase_"+seas+"."+ref+".noTC.nc", "r")
; ncol = 19
g_status = asciiread("/Users/fadhlilrizki/Documents/PhD/thesis/dataout/local_wave_phase/index_"+status+"_"+yearmode+".csv",-1, "integer")
; print(g)
; ncol = 19
; g        = asciiread("/Users/fadhlilrizki/Documents/PhD/thesis/dataout/local_wave_phase/djf_dates_19801201_to_20200229.csv",-1, "integer")
g        = asciiread("/Users/fadhlilrizki/Documents/PhD/thesis/dataout/local_wave_phase/index_"+wave+"_"+yearmode+".csv",-1, "integer")

nrow = dimsizes(g)/2
findex = onedtond(g,(/nrow,2/))

nstatus = dimsizes(g_status)
findex_status = onedtond(g_status,(/nstatus/))

; print(findex)

; printVarSummary(f)
; var = "precip"
x_in        = f->$wave$
nlat = dimsizes(x_in&latitude)
nlon = dimsizes(x_in&longitude)
; x           = runave_n_Wrap(x_in/stddev(x_in),7,0, 0)
x           = x_in
copy_VarMeta(x_in,x)

TIME      = x&time
DATE      = cd_calendar(TIME, -2)
ymdStrt   = 19801201
ymdLast   = 20200530

iStrt     = ind(DATE.eq.ymdStrt)
; print(iStrt)
iLast     = ind(DATE.eq.ymdLast)

time        = x&time(iStrt:iLast)
ymdhms      = cd_calendar(time, 0)

; iseason     = choose_season(seas, ymdhms)
iseason   = new(nrow,integer)

do i = 0, nrow-1
  iseason(i) = ind(DATE.eq.findex(i,0)); write loop content
end do

isel = new(nstatus,integer)

do i = 0, nstatus-1
  isel(i) = ind(DATE.eq.findex_status(i)); write loop content
  ; write loop content
end do

print(findex_status)


wd          = x(isel, :,:)
; copy_VarMeta(x, wd)

wd_seas        = dim_avg_n_Wrap(x(iseason,:,:), 0)

; copy_VarMeta(x_sel,x)
; x@long_name = "Anomalies from seasonal Climatology"
; printVarSummary(x)
; printMinMax(x, True)
;

; wd_aave = wgt_areaave_Wrap(wd_seas_raw({-10.75:-25},:),1.,1.,0)
; print(wd_aave)

; wd_seas = where(wd_seas_raw.eq.0, wd_aave,wd_seas_raw)
; copy_VarMeta(wd_seas_raw,wd_seas)

; wd_sel =
stat = "prob"
; comp = composite_waves_wetdays_csvindex(x, findex, threshold,stat)
ndim = dimsizes(x)
printVarSummary(ndim)

; comp = new((/ndim(1), ndim(2)/),"float")

printVarSummary(wd)
comp = dim_avg_n_Wrap(wd,0)  ; write loop content



; printVarSummary(x)

x_wet = x(iseason,:,:)
; copy_VarMeta(x, x_wet)

; alpha       = new((/ndim(1),ndim(2)/),"float")

; xphase            = x(iseason,:,:)

; pall     =
nBoot = 1000
sigval = 95
optboot   = True
optboot@sample_method = 1
optboot@sample_size = dimsizes(isel)
;BootStrap  = bootstrap_stat(rain_extreme_season_phase, 0, nBoot, 0, opt )
BootStrap  = bootstrap_stat(x_wet, 0, nBoot, 0, optboot )

xBoot      = BootStrap[0]

siglow      = (100. - sigval)/200.
; print(siglow)
sighi       = (1. - siglow)
; print(sighi)

xBootLow   = bootstrap_estimate(xBoot, siglow, False)   ;  2.5% lower confidence bound
xBootHi    = bootstrap_estimate(xBoot, sighi, False)   ; 97.5% upper confidence bound

iflag = True

alpha    = where(((comp.ge.xBootHi) .or. (comp.le.xBootLow)), 1., 0.)
; print(alpha(0:10,0:10,0:10))

; alpha(i+1,:,:)    = bootstrap_sigtest(xphase, 90, indactive, 500,False)


; delete(time)
; delete(phase)
; delete(amp)
; delete(x_in)
; delete(x)
printVarSummary(comp)

comp_anom = comp
copy_VarMeta(comp, comp_anom)

foutname = var+"_"+wave+"_"+status+"_wave_composite_"+seas+"ref"+ref+"."+remaptype+"."+yearmode+".nc"
system("rm "+diro+foutname)

fout = addfile(diro+foutname,"c")
fout->composite = comp_anom
fout->alpha = alpha

delete(yearmode)
; end do