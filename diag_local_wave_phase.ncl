

load "wave_phase_background.ncl"
load "utils.ncl"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Hann Function filtering, trying to replicate the result of :
; Influence of the basic state zonal flow on convectively coupled equatorial waves
; Juliana Dias and George Kiladis (2014)
; https://doi.org/10.1002/2014GL061476
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Hann Filtering
;; Fadhlil R. Muhammad (fadhlilrizki@student.unimelb.edu.au)
;; May 2023
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Still unsuccessful, might be missing something here
; Probably the fft function should be changed
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


undef("hann")
function hann(x,N) ;x = lon, c=central longitude, N=longitude window length
	begin

	N2 = N/2
	c = (N+1)/2

	xW = x(c-N2:c+N2)
	L  = dimsizes(xW)

	pi = get_pi("float")

	it = x
	print(it)
	w  = new((/dimsizes(x)/), "float")
	w = 0
	print(w)

	counter = 0
		do t = it, L+it-1
			rad = xW(counter)/L
			w(t) = 0.5 * (1 - cos(2*pi*rad))
			counter = counter+1
		end do

	copy_VarCoords(x,w)
	w@long_name = "hanning weights"
	return w
	end


undef("hann_lon")
function hann_lon(x,c,N) ;x = lon, c=central longitude, N=longitude window length
	begin

	N2 = N/2
	; L  = dimsizes(x)

	x!0 = "lon"
	x&lon = x
	; print(lonL)
	printVarSummary(x)

	xW = x({c-N2:c+N2})
	L  = dimsizes(xW)

	pi = get_pi("float")

	it = ind(x({c-N2}).eq.x)
	print(it)
	w  = new((/dimsizes(x)/), "float")
	w = 0
	print(w)

	counter = 0
		do t = it, L+it-1
			rad = xW(counter)/L
			w(t) = 0.5 * (1 - cos(2*pi*rad))
			counter = counter+1
		end do

	copy_VarCoords(x,w)
	w@long_name = "hanning weights"
	return w
	end


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Local phase diagnosis
;; Fadhlil R. Muhammad (fadhlilrizki@student.unimelb.edu.au)
;; Dec 2022 - 2023
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; local_phase_diag
;; lookup_phase_index
;; lookup_phase_index_rmvtc
;; group_waves
;; composite_waves
;; composite_waves_wetdays
;; composite_waves_1D
;; composite_waves_4D
;; stat_dispersion_3D
;; stat_dispersion_4D
;; signif_diff_percentiles
;; bootstrap_sigtest
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Getting the local phase.
;; Original code for 'local_phase_diag' is written by Sandro W.Lubis

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Author: Dr. Sandro Lubis (Jan 2020)
;         Local equatorial wave phase diagram
;         Lubis, SW, Respati, MR. Impacts of convectively coupled
;         equatorial waves on rainfall extremes in Java, Indonesia.
;         Int J Climatol. 2021; 41: 2418– 2440
; Contact: slubis.geomar@gmail.com
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


undef("local_phase_diag")

procedure local_phase_diag(dir,figdir,fname, wave_name,date_start,date_end,seas,central_lon,NC,PLOT, opt)
local time, ymdhms, date, time_seas, x, y, wave_std, d_wave_std, wave, iseason, dateplot, datestring

			begin

			f = addfile(dir+fname, "r")

			time = f->time
			ymdhms = cd_calendar(time, 0)

			iseason = choose_season(seas, ymdhms)
			wave = f->$wave_name$

			print("Calculating temporal tendency...")

			d_wave = center_finite_diff_n(wave, 1, False, 0, 0)
			copy_VarCoords(wave, d_wave)

			print("Standardizing...")

			if isatt(opt,"stdev_all") then
				wave_std = wave / stddev(wave)
				d_wave_std = d_wave / stddev(d_wave)
			else
				wave_std = wave / stddev(wave(iseason,:))
				d_wave_std = d_wave / stddev(d_wave(iseason,:))
			end if

			copy_VarCoords(wave, wave_std)
			; printVarSummary(wave_std(:,{central_lon}))

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
			phase!0 = "time"
			; phase&date = date

			do t = 0, (dimsizes(time(iseason)) - 1)
				if (r(t).le.1) then
					phase(t) = 0
				else
					if (theta(t).le.(1.0 * angle) .and. theta(t).gt.(-1.0 * angle)) then
						phase(t) = 1
						; print("fase=1")
					else if (theta(t).le.(-1.0 * angle) .and. theta(t).gt.(-3.0 * angle)) then
						phase(t) = 2
						; print("fase=2")
						; print
						; print("cektheta-"+(y(t)/x(t)))
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
				print("Making the netcdf....")
				; index = new((/dimsizes(date), dimsizes(amp)/))
				if opt then
					foutname = "local_"+wave_name+"_phase_"+seas+"."+opt@id+".nc"
				else
					foutname = "local_"+wave_name+"_phase_"+seas+".nc"
				end if
				system ("rm "+dir+foutname)
				fout     =  addfile(dir+foutname, "c")

				; phase!0 = "time"
				r!0   = "time"
				; print(phase)
				r@phase = phase

				r&time = wave&time(iseason)
				; printVarSummary(r)
				; printVarSummary(r&time)

				x!0   = "time"
				y!0   = "time"

				phase&time = wave&time(iseason)

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

			; print(time_start)
			; print(time_end)

			n_time = dimsizes(time_seas(time_start:time_end))

			wks = gsn_open_wks("pdf", figdir+"local_wave_phase_" + wave_name+"_"+seas+"_"+date_start+"-"+date_end+"_"+central_lon)

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
					resMarker@gsMarkerColor = cmap(6, :)
				end if
				if (x_plot(i).le.(-3.0) .and. x_plot(i).gt.(-3.5)) then
					resMarker@gsMarkerColor = cmap(10, :)
				end if
				if (x_plot(i).le.(-2.5) .and. x_plot(i).gt.(-3.0)) then
					resMarker@gsMarkerColor = cmap(14, :)
				end if
				if (x_plot(i).le.(-2.0) .and. x_plot(i).gt.(-2.5)) then
					resMarker@gsMarkerColor = cmap(18, :)
				end if
				if (x_plot(i).le.(-1.5) .and. x_plot(i).gt.(-2.0)) then
					resMarker@gsMarkerColor = cmap(22, :)
				end if
				if (x_plot(i).le.(-1.0) .and. x_plot(i).gt.(-1.5)) then
					resMarker@gsMarkerColor = cmap(26, :)
				end if
				if (x_plot(i).le.(1.0) .and. x_plot(i).gt.(-1.0)) then
					resMarker@gsMarkerColor = cmap(31, :)
				end if
				if (x_plot(i).le.(1.5) .and. x_plot(i).gt.(1.0)) then
					resMarker@gsMarkerColor = cmap(36, :)
				end if
				if (x_plot(i).le.(2.0) .and. x_plot(i).gt.(1.5)) then
					resMarker@gsMarkerColor = cmap(40, :)
				end if
				if (x_plot(i).le.(2.5) .and. x_plot(i).gt.(2.0)) then
					resMarker@gsMarkerColor = cmap(44, :)
				end if
				if (x_plot(i).le.(3.0) .and. x_plot(i).gt.(2.5)) then
					resMarker@gsMarkerColor = cmap(48, :)
				end if
				if (x_plot(i).le.(3.5) .and. x_plot(i).gt.(3.0)) then
					resMarker@gsMarkerColor = cmap(52, :)
				end if
				if (x_plot(i).le.(4.0) .and. x_plot(i).gt.(3.5)) then
					resMarker@gsMarkerColor = cmap(56, :)
				end if
				if (x_plot(i).gt.(4.0)) then
					resMarker@gsMarkerColor = cmap(60, :)
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



			datestring = cd_string(time_seas(time_start:time_end), "%D %c %Y")
			;==============================================
			; create color plot
			;=============================================
			  wks2  = gsn_open_wks ("png", figdir+"hovlong_"+wave_name+"_"+seas+"_"+date_start+"-"+date_end+"_"+central_lon )           ; send graphics to PNG file

				; delete(res)
			  res                      = True               ; plot mods desired
			  res@gsnFrame             = False
			  res@gsnDraw              = False
			  res@cnFillOn             = True               ; turn on color fill
			  res@cnFillPalette        = "BlWhRe"           ; set color map

			  res@tiMainString         = "North AU"   ; title

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

			  res@cnLinesOn = False
			  res@gsnMajorLonSpacing = 15.
			  res@tmYLLabelStride = 7
			  ; res@ttmFormat = "%Y %F %D"
			  ; res@cnLineDrawOrder      = "PostDraw"
			  res@trYReverse = True


			  res@gsnLeftString = str_capital(wave_name)
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

			  iLon = central_lon - 130 + 50
				print(ind(x_wave&lon.eq.130))
			  print(iLon)
			  dum  = gsn_add_polyline(wks, plot2,(/x_wave&lon(iLon-1),x_wave&lon(iLon-1)/),(/time_seas(time_start),time_seas(time_end)/), plres)


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



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Getting the phase dates
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

undef ("lookup_phase_index")
function lookup_phase_index(phase_data, amp,data_date ,nphase)
local ind_temp, date_ind
begin

	ind_temp 			 = ind(phase_data.eq.nphase)
	temp           = amp(ind_temp)

	date_ind = cd_calendar(temp&time,-2)
	; printVarSummary(date_ind)
	ind_active = new((/dimsizes(ind_temp)/),"integer")

	do j = 0, dimsizes(date_ind)-1
		ind_active(j)     = ind(data_date.eq.date_ind(j))
	end do

	return(ind_active)
end



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Getting the phase dates and remove the TC days
; input: phase data, amp, date of data, nphase, ftc
; ftc is csv with the date of the TC days in yyyymmdd format
; NO HEADER for the CSV
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

undef ("lookup_phase_index_rmvtc")
function lookup_phase_index_rmvtc(phase_data, amp,data_date ,nphase,ftc)
local ind_temp, date_ind
begin

	ind_temp 			 = ind(phase_data.eq.nphase)
	temp           = amp(ind_temp)

	date_ind = cd_calendar(temp&time,-2)
	; printVarSummary(date_ind)
	ind_active = new((/dimsizes(ind_temp)/),"integer", default_fillvalue("integer"))

	do j = 0, dimsizes(date_ind)-1
		do k=0, dimsizes(ftc)-1
			ind_active(j)     = ind(data_date.eq.date_ind(j) .and. data_date.ne.ftc(k))
		end do
	end do

	igood = ind(.not.ismissing(ind_active))
	xgood = ind_active(igood)

	return(xgood)
end


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Group the date of the waves based on phases
; Weak waves are grouped into phase 0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

undef("group_waves")
function group_waves(x,phase, amp, season,phasechoose)
local x_wave, alpha, boots, ymdhms, x_seas, ind_active, ndim
	begin

		ymdhms = cd_calendar(x&time, 0)
		iseason = choose_season(season, ymdhms)

		x_seas     = x(iseason,:,:)
		print(cd_calendar(x_seas&time,-2))
		phase_seas = phase
		; print(phase_seas)

		delete(ymdhms)
		delete(iseason)

		printVarSummary(x_seas)

		ymdhms = cd_calendar(amp&time, 0)
		iseason = choose_season(season, ymdhms)

		amp_seas   = amp
		printVarSummary(amp_seas)

		delete(ymdhms)
		delete(iseason)

		ndim = dimsizes(x_seas)
		; x_wave = new((/ndmi(0), ndim(1), ndim(2)/), "float")
		; x_wave@ndays = new((/9/),"integer")

		TIME = cd_calendar(x_seas&time, -2)



		ind_temp 			 = ind(phase_seas.eq.phasechoose)
		temp 					 = amp_seas(ind_temp)
		; printVarSummary(TIME)

		date_ind = cd_calendar(temp&time,-2)
		; printVarSummary(date_ind)
		ind_active = new((/dimsizes(date_ind)/),"integer")
		; print(date_ind)


		do j = 0, dimsizes(date_ind)-1
			ind_active(j)     = ind(TIME.eq.date_ind(j))
		end do

		x_wave = x_seas(ind_active,:,:)
		;
		x_wave@ndays = num(ind_active)
		delete(ind_active)
		delete(date_ind)
		delete(temp)
		delete(ind_temp)
		; copy_VarCoords(x_seas(0,:,:), x_wave(0,:,:))


		; x_wave!0 = "phase"
		; x_wave&phase = (/0,1,2,3,4,5,6,7,8/)
		; x_wave@units = x_seas@units
		x_wave@long_name = "grouped "+phasechoose

		return(x_wave)
end


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Make the wave composites
; can be anomalies or probability composites
; x = input data in 3D
; phase is the phase of the waves from local_wave_phase_seasonal.ncl
; amp  is like phase but for amplitude of the waves
; season-> choose from ("SHSummer", "SHSpring", "SHAutumn", "SHWinter", "NDJFMA", "MJJASO")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


undef("composite_waves")
function composite_waves(x,phase, amp, season)
local x_wave, alpha, boots, ymdhms, x_seas, ind_active, ndim
	begin

		ymdhms = cd_calendar(x&time, 0)
		iseason = choose_season(season, ymdhms)

		x_seas     = x(iseason,:,:)
		print(cd_calendar(x_seas&time,-2))
		phase_seas = phase
		; print(phase_seas)

		delete(ymdhms)
		delete(iseason)

		printVarSummary(x_seas)

		ymdhms = cd_calendar(amp&time, 0)
		iseason = choose_season(season, ymdhms)

		amp_seas   = amp
		printVarSummary(amp_seas)

		delete(ymdhms)
		delete(iseason)

		ndim = dimsizes(x_seas)
		x_wave = new((/9, ndim(1), ndim(2)/), "float")
		x_wave@ndays = new((/9/),"integer")

		TIME = cd_calendar(x_seas&time, -2)

		do i = 0, 8

			ind_temp 			 = ind(phase_seas.eq.i)
			temp 					 = amp_seas(ind_temp)
			; print(temp)
			; print(phase_seas(ind_temp))

			; print(TIME)
			; printVarSummary(TIME)

			date_ind = cd_calendar(temp&time,-2)
			; printVarSummary(date_ind)
			ind_active = new((/dimsizes(date_ind)/),"integer")
			; print(date_ind)


			do j = 0, dimsizes(date_ind)-1
				ind_active(j)     = ind(TIME.eq.date_ind(j))
				; print(date_ind(j))
				; print(ind(TIME.eq.date_ind(j)))
				; print(TIME(ind_active(j)))
				; print(ind_active(i))
			end do

			x_wave(i, :, :) = dim_avg_n_Wrap(x_seas(ind_active,:,:), 0)
			;
			x_wave@ndays(i) = num(ind_active)
			delete(ind_active)
			delete(date_ind)
			delete(temp)
			delete(ind_temp)
			copy_VarCoords(x_seas(0,:,:), x_wave(0,:,:))

		end do

		x_wave!0 = "phase"
		x_wave&phase = (/0,1,2,3,4,5,6,7,8/)
		; x_wave@units = x_seas@units
		x_wave@long_name = "composite for waves"

		return(x_wave)
	end


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Just like before but for wet days
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

undef("composite_waves_wetdays")
function composite_waves_wetdays(x,phase, amp, season)
local x_wave, alpha, boots, ymdhms, x_seas, ind_active, ndim
	begin

		ymdhms = cd_calendar(x&time, 0)
		iseason = choose_season(season, ymdhms)

		x_seas     = x(iseason,:,:)
		print(cd_calendar(x_seas&time,-2))
		phase_seas = phase
		; print(phase_seas)

		delete(ymdhms)
		delete(iseason)

		printVarSummary(x_seas)

		ymdhms = cd_calendar(amp&time, 0)
		iseason = choose_season(season, ymdhms)

		amp_seas   = amp
		printVarSummary(amp_seas)

		delete(ymdhms)
		delete(iseason)

		ndim = dimsizes(x_seas)
		x_wave = new((/9, ndim(1), ndim(2)/), "float")
		x_wave@ndays = new((/9/),"integer")

		TIME = cd_calendar(x_seas&time, -2)

		do i = 0, 8

			ind_temp 			 = ind(phase_seas.eq.i)
			temp 					 = amp_seas(ind_temp)
			; print(temp)
			; print(phase_seas(ind_temp))

			; print(TIME)
			; printVarSummary(TIME)

			date_ind = cd_calendar(temp&time,-2)
			; printVarSummary(date_ind)
			ind_active = new((/dimsizes(date_ind)/),"integer")
			; print(date_ind)


			do j = 0, dimsizes(date_ind)-1
				ind_active(j)     = ind(TIME.eq.date_ind(j))
				; print(date_ind(j))
				; print(ind(TIME.eq.date_ind(j)))
				; print(TIME(ind_active(j)))
				; print(ind_active(i))
			end do

			x_wave(i, :, :) = dim_sum_n_Wrap(x_seas(ind_active,:,:), 0)
			;
			x_wave@ndays(i) = num(ind_active)
			delete(ind_active)
			delete(date_ind)
			delete(temp)
			delete(ind_temp)
			copy_VarCoords(x_seas(0,:,:), x_wave(0,:,:))

		end do

		x_wave!0 = "phase"
		x_wave&phase = (/0,1,2,3,4,5,6,7,8/)
		; x_wave@units = x_seas@units
		x_wave@long_name = "composite for waves"

		return(x_wave)
end


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Just like 'composite_waves' but for 1D data
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


undef("composite_waves_1D")
function composite_waves_1D(x,phase, amp, season)
local x_wave, alpha, boots, ymdhms, x_seas, ind_active, ndim
	begin

		ymdhms = cd_calendar(x&time, 0)
		iseason = choose_season(season, ymdhms)

		x_seas     = x(iseason)
		print(cd_calendar(x_seas&time,-2))
		phase_seas = phase
		; print(phase_seas)

		delete(ymdhms)
		delete(iseason)

		printVarSummary(x_seas)

		ymdhms = cd_calendar(amp&time, 0)
		iseason = choose_season(season, ymdhms)

		amp_seas   = amp
		printVarSummary(amp_seas)

		delete(ymdhms)
		delete(iseason)

		ndim = dimsizes(x_seas)
		x_wave = new((/9/), "float")
		x_wave@ndays = new((/9/),"integer")

		TIME = cd_calendar(x_seas&time, -2)

		do i = 0, 8

			ind_temp 			 = ind(phase_seas.eq.i)
			temp 					 = amp_seas(ind_temp)
			date_ind = cd_calendar(temp&time,-2)
			; printVarSummary(date_ind)
			ind_active = new((/dimsizes(date_ind)/),"integer")
			; print(date_ind)


			do j = 0, dimsizes(date_ind)-1
				ind_active(j)     = ind(TIME.eq.date_ind(j))
				; print(date_ind(j))
				; print(ind(TIME.eq.date_ind(j)))
				; print(TIME(ind_active(j)))
				; print(ind_active(i))
			end do

			x_wave(i) = dim_avg_n_Wrap(x_seas(ind_active), 0)
			;
			x_wave@ndays(i) = num(ind_active)
			delete(ind_active)
			delete(date_ind)
			delete(temp)
			delete(ind_temp)
			; copy_VarCoords(x_seas(0), x_wave(0,:,:))

		end do

		x_wave!0 = "phase"
		x_wave&phase = (/0,1,2,3,4,5,6,7,8/)
		; x_wave@units = x_seas@units
		x_wave@long_name = "composite for waves"

		return(x_wave)
	end


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; getting the percentiles for 3D data using stat_dispersion function on NCL
; result might be not proper if the sample is too small
; percentile choice are 50, 95, 99, 5, and 1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


undef("stat_dispersion_3D")
function stat_dispersion_3D(x, perc)
local opt, i, j, ndim, ni, nj, temp

begin
ndim = dimsizes(x)
ni = ndim(1)
nj = ndim(2)

if (perc).eq.50 then
	nstat = 8
else if (perc).eq.95 then
	nstat = 25
else if perc.eq.99 then
	nstat = 26
else if perc.eq.5 then
	nstat = 24
else if perc.eq.1 then
	nstat = 23
else if perc.eq."mean" then
	nstat = 0
end if
end if
end if
end if
end if
end if

result = new((/ni, nj/), "float")

do i = 0, ni-1
	do j = 0, nj-1
		temp = stat_dispersion(x(:,i,j), False)
		; print("med-eq="+temp(nstat))
		result(i,j) = temp(nstat)
		delete(temp)
	end do
end do

copy_VarCoords(x(0,:,:),result(:,:) )
copy_VarAtts(x, result)
return (result)
end

; undef("stat_dispersion_3D")
; function stat_dispersion_3D(x, perc)
; local opt, i, j, ndim, ni, nj, temp
;
; begin
; ndim = dimsizes(x)
; ni = ndim(1)
; nj = ndim(2)
;
; if (perc).eq.50 then
; 	nstat = 8
; else if (perc).eq.95 then
; 	nstat = 25
; else if perc.eq.99 then
; 	nstat = 26
; else if perc.eq.5 then
; 	nstat = 24
; else if perc.eq.1 then
; 	nstat = 23
; else if perc.eq."mean" then
; 	nstat = 0
; end if
; end if
; end if
; end if
; end if
; end if
;
; result = new((/ni, nj/), "float")
;
; do i = 0, ni-1
; 	do j = 0, nj-1
; 		temp = stat_dispersion(x(:,i,j), False)
; 		; print("med-eq="+temp(nstat))
; 		result(i,j) = temp(nstat)
; 		delete(temp)
; 	end do
; end do
;
; copy_VarCoords(x(0,:,:),result(:,:) )
; copy_VarAtts(x, result)
; return (result)
; end


undef("composite_waves_4D")
function composite_waves_4D(x,phase, amp, season)
local x_wave, alpha, boots, ymdhms, x_seas, ind_active, ndim
	begin

		ymdhms = cd_calendar(x&time, 0)
		iseason = choose_season(season, ymdhms)

		x_seas     = x(iseason,:,:,:)
		print(cd_calendar(x_seas&time,-2))
		phase_seas = phase
		; print(phase_seas)

		delete(ymdhms)
		delete(iseason)

		printVarSummary(x_seas)

		ymdhms = cd_calendar(amp&time, 0)
		iseason = choose_season(season, ymdhms)

		amp_seas   = amp
		printVarSummary(amp_seas)

		delete(ymdhms)
		delete(iseason)

		ndim = dimsizes(x_seas)
		x_wave = new((/9, ndim(1), ndim(2),ndim(3)/), "float")
		x_wave@ndays = new((/9/),"integer")

		TIME = cd_calendar(x_seas&time, -2)

		do i = 0, 8

			ind_temp 			 = ind(phase_seas.eq.i)
			temp 					 = amp_seas(ind_temp)
			; print(temp)
			; print(phase_seas(ind_temp))

			; print(TIME)
			; printVarSummary(TIME)

			date_ind = cd_calendar(temp&time,-2)
			; printVarSummary(date_ind)
			ind_active = new((/dimsizes(date_ind)/),"integer")
			; print(date_ind)


			do j = 0, dimsizes(date_ind)-1
				ind_active(j)     = ind(TIME.eq.date_ind(j))
				; print(date_ind(j))
				; print(ind(TIME.eq.date_ind(j)))
				; print(TIME(ind_active(j)))
				; print(ind_active(i))
			end do

			x_wave(i, :,:, :) = dim_avg_n_Wrap(x_seas(ind_active,:,:,:), 0)
			;
			x_wave@ndays(i) = num(ind_active)
			delete(ind_active)
			delete(date_ind)
			delete(temp)
			delete(ind_temp)
			copy_VarCoords(x_seas(0,:,:,:), x_wave(0,:,:,:))

		end do

		x_wave!0 = "phase"
		x_wave&phase = (/0,1,2,3,4,5,6,7,8/)
		; x_wave@units = x_seas@units
		x_wave@long_name = "composite for waves"

		return(x_wave)
	end


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; getting the percentiles for 4D data using stat_dispersion function on NCL
; result might be not proper if the sample is too small
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


undef("stat_dispersion_4D")
function stat_dispersion_4D(x, perc)
local opt, i, j, ndim, ni, nj,nlev, temp

begin
ndim = dimsizes(x)
nlev = ndim(1)
ni   = ndim(2)
nj   = ndim(3)

if (perc).eq.50 then
	nstat = 8
else if (perc).eq.95 then
	nstat = 25
else if perc.eq.99 then
	nstat = 26
else if perc.eq.5 then
	nstat = 24
else if perc.eq.1 then
	nstat = 23
else if perc.eq."mean" then
	nstat = 0
end if
end if
end if
end if
end if
end if

result = new((/nl, ni, nj/), "float")

do i = 0, ni-1
	do l=0, nlev-1
		do j = 0, nj-1
			temp = stat_dispersion(x(:,l,i,j), False)
			print("med-eq="+temp(nstat))
			result(l,i,j) = temp(nstat)
			delete(temp)
		end do
	end do
end do

copy_VarCoords(x(0,:,:,:),result(:,:,:) )
copy_VarAtts(x, result)
return (result)
end


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; percentiles.ncl
;; Carl Schreck (carl@cicsnc.org)
;; August 2012
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; percent_to_value
;; percent_to_value_2d
;; value_to_percent
;; signif_diff_percentiles
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
;load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"
;load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
;load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/diagnostics_cam.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/ut_string.ncl"
;load "/home/carl/lib/print_clock.ncl"


undef ( "percent_to_value" )
function percent_to_value( \
  i_data           : numeric, \
  i_percentiles[*] : numeric  \
)
local None
begin

  retVal = new( dimsizes(i_percentiles), float )

  data1d = ndtooned( i_data )
  notMissing = data1d( ind(.not.ismissing(data1d) ) )

  qsort(notMissing)

  do p = 0, dimsizes(i_percentiles)-1
;   pInd = round( i_percentiles(p) * .01 * dimsizes(notMissing) + 0.5, 3 ) -1
;   pInd = where( pInd.ge.dimsizes(notMissing), dimsizes(notMissing)-1, pInd )
    floatInd = i_percentiles(p) * .01 * dimsizes(notMissing) - 0.5
    floorInd = toint( floor(floatInd) )
    floorInd = where( floorInd.lt.0, 0, floorInd )
    ceilInd = toint( ceil(floatInd) )
    ceilInd = where( ceilInd.ge.dimsizes(notMissing), \
        dimsizes(notMissing)-1, ceilInd )
;   print(pInd + " " + dimsizes(notMissing))
    if( ceilInd.eq.floorInd ) then
      retVal(p) = notMissing(floorInd)
    else
      retVal(p) = notMissing(floorInd) * ( ceilInd - floatInd ) \
          + notMissing(ceilInd) * ( floatInd - floorInd )
    end if
  end do

  return(retVal)
end ; percent_to_value


undef ( "percent_to_value_2d" )
function percent_to_value_2d( \
  i_data[*][*][*]  : numeric, \
  i_percentile[1]  : numeric  \
)
local None
begin

  dims = dimsizes(i_data)
  sorted = i_data
  ip = dim_pqsort_n( sorted, 2, 0 )

  pInd = round( i_percentile * .01 * dims(0) + 0.5, 3 ) -1
  pInd = where( pInd.ge.dims(0), dims(0)-1, pInd )
  retVal = sorted(pInd,:,:)
  copy_VarAtts( i_data, retVal )
  copy_VarCoords( i_data(0,:,:), retVal )

  return(retVal)
end ; percent_to_value_2d


undef ( "value_to_percent" )
function value_to_percent( \
  i_data      : numeric, \
  i_values[*] : numeric  \
)
local None
begin

  retVal = new( dimsizes(i_values), float )

  data1d = ndtooned( i_data )
  notMissing = data1d( ind(.not.ismissing(data1d) ) )

  qsort(notMissing)

  do v = 0, dimsizes(i_values)-1
    vInd = 1 + max( ind( notMissing.le.i_values(v) ) )
    if( ismissing(vInd) ) then
      retVal(v) = 0
    else
      retVal(v) = ( vInd - 0.5 ) * 100. / ( dimsizes(notMissing) )
    end if
  end do

  return(retVal)
end ; value_to_percent


undef ( "signif_diff_percentiles" )
function signif_diff_percentiles( \
  i_dataA[*]      : numeric, \
  i_dataB[*]      : numeric, \
  i_percentiles[*] : numeric, \
  i_nTests[1]     : integer  \
)
local None
begin

  nA = dimsizes(i_dataA)
  nB = dimsizes(i_dataB)

  pValue = 0. * i_percentiles

  do iTest = 0, i_nTests-1

    randIndA = toint( floor( random_uniform( 0, nA, nA ) ) )
    randIndB = toint( floor( random_uniform( 0, nB, nB ) ) )

    valueA = percent_to_value( i_dataA(randIndA), i_percentiles )
    valueB = percent_to_value( i_dataB(randIndB), i_percentiles )

    pValue = pValue + where( valueA.gt.valueB, 1, 0 )
  end do
  pValue = pValue / i_nTests

  retVal = -1 + ( 2 * dim_max_n( (/ (pValue), (1-pValue) /), 0 ) )
  retVal = pValue

  return(retVal)

end ; signif_diff_percentiles



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Using bootstrap to test statistical significance, sampling with replacement
; x = input
; sigval = significant value (95% is the most common)
; index  = the sample number per phase. The output of lookup_phase_index
; nBoot = number of bootstrap samples (1000 is a decent choice, 500 is alright)
; opt = set to False
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


undef("bootstrap_sigtest")
function bootstrap_sigtest(x, sigval,index,nBoot, opt)
local BootStrap, iflag,tester,xBoot,siglow,sighi,xBootHi,xBootLow, alpha

opt = False

begin
if opt.eq.False then
	opt = True
	opt@nboot = 500
end if
				optboot   = True
				optboot@sample_method = 1
				optboot@sample_size = dimsizes(index)
				;BootStrap  = bootstrap_stat(rain_extreme_season_phase, 0, nBoot, 0, opt )
				BootStrap  = bootstrap_stat(x, 0, nBoot, 0, optboot )

				xBoot      = BootStrap[0]

				siglow      = (100. - sigval)/200.
				sighi       = (1. - siglow)

				xBootLow   = bootstrap_estimate(xBoot, siglow, False)   ;  2.5% lower confidence bound
				xBootHi    = bootstrap_estimate(xBoot, sighi, False)   ; 97.5% upper confidence bound

				tester     = dim_avg_n_Wrap(x(index,:,:),0)
				print(tester(0:10,0:10,0:10))
				iflag = True
				;  alpha(n, :, :) = 100* (1-ttest(tester,xVar,xN,yAve,yVar,yN,iflag,False))
				alpha       = where(tester.ge.xBootHi .or. tester.le.xBootLow, 1., 0.)
				print(alpha(0:10,0:10,0:10))

				; print("selesai fase ke-"+(n+1))

return(alpha)
end
