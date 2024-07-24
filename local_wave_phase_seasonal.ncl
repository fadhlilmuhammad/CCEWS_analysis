; Author: Dr. Sandro Lubis (Jan 2020)
;         Local equatorial wave phase diagram
;         Lubis, SW, Respati, MR. Impacts of convectively coupled
;         equatorial waves on rainfall extremes in Java, Indonesia.
;         Int J Climatol. 2021; 41: 2418– 2440
; Contact: slubis.geomar@gmail.com

; Modified by: Fadhlil R. Muhammad
; Added function for standardising based on seasons
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

load "wave_phase_background.ncl"
load "utils.ncl"

begin

NC = False
PLOT = True

dir = "/Users/fadhlilrizki/Documents/PhD/thesis/dataout/"

diro = ""
wave_name = "er"; input variable (kelvin, er, mrg)
seas = "SHSummer" ;input season (SHSummer, SHAutumn, SHSpring, SHWinter, NDJFMA, MJJASO)


date_start = 20170101; input variable (yyyymmdd)
date_end = 20170131; input variable (yyyymmdd)


central_lon = 133
f = addfile(dir+"local_wave_phase/waves.northAU.nc", "r")

time = f->time
ymdhms = cd_calendar(time, 0)

iseason = choose_season(seas, ymdhms)
wave = f->$wave_name$

print("Calculating temporal tendency...")

d_wave = center_finite_diff_n(wave, 1, False, 0, 0)
copy_VarCoords(wave, d_wave)

print("Standardizing...")

wave_std = wave / stddev(wave(iseason,:))
copy_VarCoords(wave, wave_std)

d_wave_std = d_wave / stddev(d_wave(iseason,:))
copy_VarCoords(d_wave, d_wave_std)

print("Tracking phases...")

x = wave_std(time|iseason, {lon|central_lon})
y = d_wave_std(time|iseason, {lon|central_lon})

; print(x)

r = sqrt(x ^ 2 + y ^ 2)
theta = atan2(y, x)

pi = 4.0 * atan(1.0)
angle = 22.5 * pi / 180.0

date = cd_calendar(time(iseason), -2)
date!0 = "date"
date&date = date


phase = new(dimsizes(time(iseason)), integer, -999)
phase!0 = "date"
phase&date = date

do t = 0, (dimsizes(time(iseason)) - 1)
	if (r(t).le.1) then
		phase(t) = 0
	else
		if (theta(t).le.(1.0 * angle) .and. theta(t).gt.(-1.0 * angle)) then
			phase(t) = 1
		else if (theta(t).le.(-1.0 * angle) .and. theta(t).gt.(-3.0 * angle)) then
			phase(t) = 2
		else if (theta(t).le.(-3.0 * angle) .and. theta(t).gt.(-5.0 * angle)) then
			phase(t) = 3
		else if (theta(t).le.(-5.0 * angle) .and. theta(t).gt.(-7.0 * angle)) then
			phase(t) = 4
		else if (theta(t).le.(-7.0 * angle) .or. theta(t).gt.(7.0 * angle)) then
			phase(t) = 5
		else if (theta(t).le.(7.0 * angle) .and. theta(t).gt.(5.0 * angle)) then
			phase(t) = 6
		else if (theta(t).le.(5.0 * angle) .and. theta(t).gt.(3.0 * angle)) then
			phase(t) = 7
		else if (theta(t).le.(3.0 * angle) .and. theta(t).gt.(1.0 * angle)) then
			phase(t) = 8
		end if
		end if
		end if
		end if
		end if
		end if
		end if
		end if
	end if
end do

if NC then
	foutname = "local_"+wave_name+"_phase_"+seas+".nc"
	system ("rm "+"dataout/"+foutname)
	fout     =  addfile("dataout/"+foutname, "c")

	fout->x = x
	fout->y = y
	fout->amp = r
	fout->phase = phase
end if

if PLOT then
print("Plotting...")

time_seas = time(iseason)
; printVarSummary(date)
time_start = ind(date.eq.date_start)
time_end   = ind(date.eq.date_end)

print(time_start)
print(time_end)

n_time = dimsizes(time_seas(time_start:time_end))

wks = gsn_open_wks("pdf", diro + wave_name+"_"+seas)

plot = wave_phase_background(wks, True)

resLine = True

resLine@gsLineThicknessF = 2.0
resLine@gsLineDashPattern = 2
resLine@gsLineColor = "black"

resMarker = True

cmap = read_colormap_file("cmp_b2r")

x_plot = x(time|time_start:time_end)
y_plot = y(time|time_start:time_end)

line = new((n_time - 1), graphic)
border = new(n_time, graphic)
marker = new(n_time, graphic)

do i = 0, (n_time - 1)
	if (i.lt.(n_time - 1)) then
		line(i) = gsn_add_polyline(wks, plot, (/x_plot(i), x_plot(i + 1)/), (/y_plot(i), y_plot(i + 1)/), resLine)
	end if

	resMarker@gsMarkerIndex = 4
	resMarker@gsMarkerSizeF = 0.015
	resMarker@gsMarkerColor = "black"
	resMarker@gsMarkerThicknessF = 5.0

	border(i) = gsn_add_polymarker(wks, plot, x_plot(i), y_plot(i), resMarker)

	delete(resMarker@gsMarkerColor)
	delete(resMarker@gsMarkerThicknessF)

	resMarker@gsMarkerIndex = 16
	resMarker@gsMarkerSizeF = 0.0125

	if (x_plot(i).le.(-4.0)) then
		resMarker@gsMarkerColor = cmap(2, :)
	end if
	if (x_plot(i).le.(-3.5) .and. x_plot(i).gt.(-4.0)) then
		resMarker@gsMarkerColor = cmap(3, :)
	end if
	if (x_plot(i).le.(-3.0) .and. x_plot(i).gt.(-3.5)) then
		resMarker@gsMarkerColor = cmap(4, :)
	end if
	if (x_plot(i).le.(-2.5) .and. x_plot(i).gt.(-3.0)) then
		resMarker@gsMarkerColor = cmap(5, :)
	end if
	if (x_plot(i).le.(-2.0) .and. x_plot(i).gt.(-2.5)) then
		resMarker@gsMarkerColor = cmap(8, :)
	end if
	if (x_plot(i).le.(-1.5) .and. x_plot(i).gt.(-2.0)) then
		resMarker@gsMarkerColor = cmap(12, :)
	end if
	if (x_plot(i).le.(-1.0) .and. x_plot(i).gt.(-1.5)) then
		resMarker@gsMarkerColor = cmap(16, :)
	end if
	if (x_plot(i).le.(1.0) .and. x_plot(i).gt.(-1.0)) then
		resMarker@gsMarkerColor = cmap(31, :)
	end if
	if (x_plot(i).le.(1.5) .and. x_plot(i).gt.(1.0)) then
		resMarker@gsMarkerColor = cmap(41, :)
	end if
	if (x_plot(i).le.(2.0) .and. x_plot(i).gt.(1.5)) then
		resMarker@gsMarkerColor = cmap(45, :)
	end if
	if (x_plot(i).le.(2.5) .and. x_plot(i).gt.(2.0)) then
		resMarker@gsMarkerColor = cmap(49, :)
	end if
	if (x_plot(i).le.(3.0) .and. x_plot(i).gt.(2.5)) then
		resMarker@gsMarkerColor = cmap(53, :)
	end if
	if (x_plot(i).le.(3.5) .and. x_plot(i).gt.(3.0)) then
		resMarker@gsMarkerColor = cmap(57, :)
	end if
	if (x_plot(i).le.(4.0) .and. x_plot(i).gt.(3.5)) then
		resMarker@gsMarkerColor = cmap(61, :)
	end if
	if (x_plot(i).gt.(4.0)) then
		resMarker@gsMarkerColor = cmap(65, :)
	end if

	if (i.eq.0) then
		delete(resMarker@gsMarkerColor)
		resMarker@gsMarkerColor = "green"
	else if i.eq.(n_time - 1) then
		delete(resMarker@gsMarkerColor)
		resMarker@gsMarkerColor = "black"
	end if
	end if

	marker(i) = gsn_add_polymarker(wks, plot, x_plot(i), y_plot(i), resMarker)

	delete(resMarker@gsMarkerColor)
end do

resP = True
resP@gsnMaximize = True
resP@gsnFrame = False
resP@tiMainString = seas

gsn_panel(wks, plot, (/1, 1/), resP)

frame(wks)



datestring = cd_string(time_seas(time_start:time_end), "%D/%N/%y")
;==============================================
; create color plot
;=============================================
  wks2  = gsn_open_wks ("png", diro+wave_name+"_"+seas )           ; send graphics to PNG file

	; delete(res)
  res                      = True               ; plot mods desired
  res@gsnFrame             = False
  res@gsnDraw              = False
  res@cnFillOn             = True               ; turn on color fill
  res@cnFillPalette        = "cmp_b2r"           ; set color map

  res@tiMainString         = "Tropical Australia"   ; title

  res@cnLevelSelectionMode = "ManualLevels"     ; manual contour levels
  res@cnMinLevelValF       = -4.	        ; min level
  res@cnMaxLevelValF       =  4.               ; max level
  res@cnLevelSpacingF      = .5                 ; contour level spacing

  res@tmYLMode      = "Explicit"                ; Define own tick mark labels.
  res@tmYLValues  = time_seas(time_start:time_end)
  res@tmYLLabels  = datestring

  res@tmYROn = False
  res@tmXTOn = False

  res@tmYLTickSpacingF = 7
	res@tmYLLabelFontHeightF = 0.015

  res@cnLinesOn = False
  res@gsnMajorLonSpacing = 15.
  res@tmYLLabelStride = 7
  ; res@ttmFormat = "%Y %F %D"
  ; res@cnLineDrawOrder      = "PostDraw"
  res@trYReverse = True
	res@lbOrientation = "vertical"
	res@lbLabelStride = 2


  res@gsnLeftString = str_upper(wave_name) +" waves"
	x_wave_in = wave(iseason,:)
	x_wave = x_wave_in / stddev(x_wave_in)

	copy_VarMeta(x_wave_in, x_wave)
	x_wave@units = "Standardized OLR"

  plot2 = gsn_csm_hov(wks2, x_wave(time_start:time_end,{100:165}), res)

  plres = True
  plres@gsLineThicknessF = 2
  plres@gsLineColor = "black"   ; Set the line color.
  plres@cnLineDrawOrder      = "PostDraw"
  plres@gsLineDashPattern = 1

  ; gsn_polyline_ndc(wks,(/10,10/),(/0,500/),plres)


  ; x!0  = "time"
  ; x&time = date

  dateplot = time_seas(time_start:time_end)

  iLon = ind(x_wave&lon.eq.130)
  print(iLon)
  dum  = gsn_add_polyline(wks, plot2,(/x_wave&lon(iLon),x_wave&lon(iLon)/),(/time_seas(time_start),time_seas(time_end)/), plres)


  resMarker = True
	resMarker@gsMarkerIndex = 4
	resMarker@gsMarkerSizeF = 0.015
	resMarker@gsMarkerColor = "black"
	resMarker@gsMarkerThicknessF = 5.0
  ; dum2 = gsn_add_polymarker(wks, plot, x&lon(iLon), time(iStrt), resMarker)
  ; gsn_polyline(wks,plot,(/iLon,iLon/),(/iStrt,iLast/),plres)
  print("OYY")
  ; draw(dum)
  ; draw(plot)
  draw(plot2)
  frame(wks2)


end if

end
