; Author: Dr. Sandro Lubis (Jan 2020)
;         Wave phase background
;         Lubis, SW, Respati, MR. Impacts of convectively coupled
;         equatorial waves on rainfall extremes in Java, Indonesia.
;         Int J Climatol. 2021; 41: 2418– 2440
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

undef("wave_phase_background")
function wave_phase_background(wks: graphic, opt[1]: logical)
begin

if (opt .and. isatt(opt, "axisExtent") .and. opt@axisExtent.gt.0) then
	axisExtent = opt@axisExtent
else
	axisExtent = 4
end if
nPhase = 8

res = True
res@gsnDraw = False
res@gsnFrame = False

res@vpXF = 0.1
res@vpYF = 0.8

res@trYMinF = -axisExtent
res@trYMaxF = axisExtent
res@trXMinF = -axisExtent
res@trXMaxF = axisExtent

vpExtent = 0.45
res@vpWidthF = vpExtent
res@vpHeightF = vpExtent

res@tmXBFormat = "f"
res@tmYLFormat = "f"

res@tmXBLabelDeltaF = -0.75
res@tmYLLabelDeltaF = -0.75

labelFontHeightF = 0.015
res@tiXAxisFontHeightF = labelFontHeightF
res@tiYAxisFontHeightF = labelFontHeightF
res@tiDeltaF = 1.25

res@xyLineThicknessF = 1

rad = 4.0 * atan(1.0) / 180.0
nCirc = 361
xCirc = cos(fspan(0, 360, nCirc) * rad)
yCirc = sin(fspan(0, 360, nCirc) * rad)

xCirc@long_name = "Standardized OLR'"
yCirc@long_name = "Standardized d(OLR')/dt"

plot = gsn_csm_xy(wks, xCirc, yCirc, res)

resLine = True
resLine@gsLineThicknessF = 1.0
resLine@gsLineDashPattern = 1
resLine@gsLineColor = "darkgreen"

c = axisExtent * tan(22.5 * rad)

phaseLine = new((/nPhase, 4/), float, "No_FillValue")
phaseLine(0, :) = (/0, axisExtent, 0, c/)
phaseLine(1, :) = (/0, c, 0, axisExtent/)
phaseLine(2, :) = (/0, -c, 0, axisExtent/)
phaseLine(3, :) = (/0, -axisExtent, 0, c/)
phaseLine(4, :) = (/0, -axisExtent, 0, -c/)
phaseLine(5, :) = (/0, -c, 0, -axisExtent/)
phaseLine(6, :) = (/0, c, 0, -axisExtent/)
phaseLine(7, :) = (/0, axisExtent, 0, -c/)

do i = 0, (nPhase - 1)
	plot@$unique_string("line")$ = gsn_add_polyline(wks, plot, (/phaseLine(i, 0), phaseLine(i, 1)/), \\
		(/phaseLine(i, 2), phaseLine(i, 3)/), resLine)
end do

resMarker = True
resMarker@gsMarkerIndex = 16
resMarker@gsMarkerSizeF = 0.21
resMarker@gsMarkerColor = "grey80"

plot@$unique_string("marker")$ = gsn_add_polymarker(wks, plot, 0.0, 0.0, resMarker)

resText = True
resText@txFontHeightF = labelFontHeightF * 1.25

phaseText = new((/nPhase, 2/), float, "No_FillValue")
phaseText(0, :) = (/7.0 * 0.125 * axisExtent, 0/)
phaseText(1, :) = (/5.0 * 0.125 * axisExtent, -5.0 * 0.125 * axisExtent/)
phaseText(2, :) = (/0, -7.0 * 0.125 * axisExtent/)
phaseText(3, :) = (/-5.0 * 0.125 * axisExtent, -5.0 * 0.125 * axisExtent/)
phaseText(4, :) = (/-7.0 * 0.125 * axisExtent, 0/)
phaseText(5, :) = (/-5.0 * 0.125 * axisExtent, 5.0 * 0.125 * axisExtent/)
phaseText(6, :) = (/0, 7.0 * 0.125 * axisExtent/)
phaseText(7, :) = (/5.0 * 0.125 * axisExtent, 5.0 * 0.125 * axisExtent/)

do i = 0, (nPhase - 1)
	phase = i + 1
	plot@$unique_string("text")$ = gsn_add_text(wks, plot, "P" + phase, phaseText(i, 0), phaseText(i, 1), resText)
end do

return(plot)

end
