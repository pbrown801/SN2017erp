pro plotphot_17erp

T_Bpeak=57933.0   ; snoopy fit to konkoly data


w2_offset=1
m2_offset=0
w1_offset=1.5
SwiftU_offset=+2.3
U_offset=+2
B_offset=+1
g_offset=+0.5
V_offset=0
R_offset=-0.5
sloanr_offset=-1.1
I_offset=-2.5
sloani_offset=-2.2





;; Swift data
; .run pjb_phot_array_B141.pro
pjb_phot_array_B141, '$SOUSA/data/SN2017erp_uvotB15.1.dat', dt=dt

;;;;;;;;;;;;;;;;;;;; read in LCO data

lcofile='SN2017erp_lcophot.txt'
;  2017-06-14 2457919.2019      16.2481       0.0210 1m0-10  V

readcol, lcofile, date_lco, mjd_lco, mag_lco, magerr_lco, tel_lco, band_lco, format='A,D,F,F,A,A'

bmjd_lco=mjd_lco[where(band_lco eq 'B')]-2400000.5
bmag_lco=mag_lco[where(band_lco eq 'B')]
bmagerr_lco=magerr_lco[where(band_lco eq 'B')]

umjd_lco=mjd_lco[where(band_lco eq 'U')]-2400000.5
umag_lco=mag_lco[where(band_lco eq 'U')]
umagerr_lco=magerr_lco[where(band_lco eq 'U')]

vmjd_lco=mjd_lco[where(band_lco eq 'V')]-2400000.5
vmag_lco=mag_lco[where(band_lco eq 'V')]
vmagerr_lco=magerr_lco[where(band_lco eq 'V')]

gmjd_lco=mjd_lco[where(band_lco eq 'g')]-2400000.5
gmag_lco=mag_lco[where(band_lco eq 'g')]
gmagerr_lco=magerr_lco[where(band_lco eq 'g')]

rmjd_lco=mjd_lco[where(band_lco eq 'r')]-2400000.5
rmag_lco=mag_lco[where(band_lco eq 'r')]
rmagerr_lco=magerr_lco[where(band_lco eq 'r')]

imjd_lco=mjd_lco[where(band_lco eq 'i')]-2400000.5
imag_lco=mag_lco[where(band_lco eq 'i')]
imagerr_lco=magerr_lco[where(band_lco eq 'i')]


;;;;;;;;;;;;;;;

readcol, 'SN2017erp_psf_cal_AZT.dat', jd_azt, umag_azt, umag_err_azt, utel_azt, Bmag_azt, Bmag_err_azt, Btel_azt, Vmag_azt, Vmag_err_azt, Vtel_azt, Rmag_azt, Rmag_err_azt, Rtel_azt, Imag_azt, Imag_err_azt, Itel_azt, format='F, A, A, A, F, F, I, F, F, I, F, F, I, F, F, I'


mjd_azt=jd_azt-2400000.5


nplots=1
; from http://www.iluvatar.org/~dwijn/idlfigures
!p.font = 1
!p.thick = 2
!x.thick = 2
!y.thick = 2
!z.thick = 2
; the default size is given in centimeters
; 8.8 is made to match a journal column width
xsize = 18
wall = 0.03
margin=0.12
a = xsize/8.8 - (margin + wall)
b =  a * 2d / (1 + sqrt(5))
xrange=[(-10),25]
yrange=[0,15]
ysize = (margin + nplots*(b + wall ) )*xsize
ticklen = 0.01
xticklen = ticklen/b
yticklen = ticklen/a

x1 = margin*8.8/xsize
x2 = x1 + a*8.8/xsize
xc = x2 + wall*8.8/xsize
y1 = margin*8.8/ysize
y2 = y1 + b*8.8/ysize

figurename='photometry_17erp.eps'

SET_PLOT, 'PS'

device, filename=figurename, /encapsulated, xsize=xsize, ysize=ysize, $
/tt_font, set_font='Times', font_size=12, bits_per_pixel=8, /color


cgplot, vmjd_lco - T_Bpeak, vmag_lco, err_ylow=vmagerr_lco, err_yhigh=vmagerr_lco, err_width=0.005, psym=-46, color='forest green', /err_clip, linestyle=2, xrange=[-20,100], yrange=[21,11], xtitle=' Days from B-band Maximum', ytitle='Observed Magnitude + Offset'

cgplot, dt.vv[0,*] - T_Bpeak, dt.vv[1,*], err_ylow=dt.vv[2,*], err_yhigh=dt.vv[2,*], err_width=0.005, psym=2, color='forest green', /overplot, /err_clip, linestyle=2

cgplot, mjd_azt[0:1] - T_Bpeak, Vmag_azt[0:1], err_ylow=vmag_err_azt[0:1], err_yhigh=vmag_err_azt[0:1], err_width=0.005, psym=15, color='forest green', /overplot, /err_clip, linestyle=2

cgplot, mjd_azt[2:18] - T_Bpeak, Vmag_azt[2:18], err_ylow=vmag_err_azt[2:18], err_yhigh=vmag_err_azt[2:18], err_width=0.005, psym=6, color='forest green', /overplot, /err_clip, linestyle=2

;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;



cgplot, bmjd_lco - T_Bpeak, bmag_lco+b_offset, err_ylow=bmagerr_lco, err_yhigh=bmagerr_lco, err_width=0.005, psym=-46, color='royal blue', /overplot, /err_clip, linestyle=2

cgplot, dt.bb[0,*] - T_Bpeak, dt.bb[1,*] + B_offset, err_ylow=dt.bb[2,*], err_yhigh=dt.bb[2,*], err_width=0.005, psym=2, color='royal blue', /overplot, /err_clip, linestyle=2



cgplot, mjd_azt[0:1] - T_Bpeak, Bmag_azt[0:1]+B_offset, err_ylow=Bmag_err_azt[0:1], err_yhigh=Bmag_err_azt[0:1], err_width=0.005, psym=15, color='royal blue', /overplot, /err_clip, linestyle=2
cgplot, mjd_azt[2:18] - T_Bpeak, Bmag_azt[2:18]+B_offset, err_ylow=Bmag_err_azt[2:18], err_yhigh=Bmag_err_azt[2:18], err_width=0.005, psym=6, color='royal blue', /overplot, /err_clip, linestyle=2

;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;


cgplot, gmjd_lco - T_Bpeak, gmag_lco+g_offset, err_ylow=gmagerr_lco, err_yhigh=gmagerr_lco, err_width=0.005, psym=-46, color='grey', /overplot, /err_clip, linestyle=2


cgplot, rmjd_lco - T_Bpeak, rmag_lco+sloanr_offset, err_ylow=rmagerr_lco, err_yhigh=rmagerr_lco, err_width=0.005, psym=-46, color='indian red', /overplot, /err_clip, linestyle=2


;;;;;;;;;;;;;;;;;;;;;;



cgplot, mjd_azt[0:1] - T_Bpeak, Rmag_azt[0:1]+R_offset, err_ylow=Rmag_err_azt[0:1], err_yhigh=Rmag_err_azt, err_width=0.005, psym=15, color='red', /overplot, /err_clip, linestyle=2


cgplot, mjd_azt[0:1] - T_Bpeak, Imag_azt[0:1]+I_offset, err_ylow=Imag_err_azt[0:1], err_yhigh=Imag_err_azt[0:1], err_width=0.005, psym=15, color='charcoal', /overplot, /err_clip, linestyle=2


cgplot, mjd_azt[2:18] - T_Bpeak, Rmag_azt[2:18]+R_offset, err_ylow=Rmag_err_azt[2:18], err_yhigh=Rmag_err_azt[2:18], err_width=0.005, psym=-6, color='red', /overplot, /err_clip, linestyle=2


cgplot, mjd_azt[2:18] - T_Bpeak, Imag_azt[2:18]+I_offset, err_ylow=Imag_err_azt[2:18], err_yhigh=Imag_err_azt[2:18], err_width=0.005, psym=-6, color='charcoal', /overplot, /err_clip, linestyle=2


;;;;;;;;;;;


cgplot, imjd_lco - T_Bpeak, imag_lco+ sloani_offset, err_ylow=imagerr_lco, err_yhigh=imagerr_lco, err_width=0.005, psym=-46, color='maroon', /overplot, /err_clip, linestyle=2

cgplot, umjd_lco - T_Bpeak, umag_lco+ u_offset, err_ylow=umagerr_lco, err_yhigh=umagerr_lco, err_width=0.005, psym=-46, color='violet', /overplot, /err_clip, linestyle=2

;;;;;

;;;;;;
cgplot, dt.uu[0,*] - T_Bpeak, dt.uu[1,*]+ swiftu_offset, err_ylow=dt.uu[2,*], err_yhigh=dt.uu[2,*], err_width=0.005, psym=-2, color='purple', /overplot, /err_clip, linestyle=2 ;, yrange=[18,16], xrange=[-20,20],

cgplot, dt.w1[0,*] - T_Bpeak, dt.w1[1,*]+ w1_offset, err_ylow=dt.w1[2,*], err_yhigh=dt.w1[2,*], err_width=0.005, psym=-2, color='medium grey', /overplot, /err_clip, linestyle=2 ;, yrange=[18,16], xrange=[-20,20],

;;;;;;
cgplot, dt.m2[0,*] - T_Bpeak, dt.m2[1,*]+ m2_offset, err_ylow=dt.m2[2,*], err_yhigh=dt.m2[2,*], err_width=0.005, psym=-2, color='dark khaki', /overplot, /err_clip, linestyle=2 ;, yrange=[18,16], xrange=[-20,20],

;;;;;;
cgplot, dt.w2[0,*] - T_Bpeak, dt.w2[1,*]+ w2_offset, err_ylow=dt.w2[2,*], err_yhigh=dt.w2[2,*], err_width=0.005, psym=-2, color='black', /overplot, /err_clip, linestyle=2 ;, yrange=[18,16], xrange=[-20,20],

xyouts, 45, 12.8, 'I - 2.5', charsize=1.5
xyouts, 40, 15, 'R - 0.5', charsize=1.5
xyouts, 70, 14, 'i - 2.2', charsize=1.5
xyouts, 70, 15.5, 'r - 1.1', charsize=1.5
xyouts, 70, 16.5, 'V', charsize=1.5
xyouts,  70, 17.5, 'g +0.5', charsize=1.5
xyouts,  80, 18.5, 'B + 1', charsize=1.5
xyouts, 80, 19.5 , 'U + 2', charsize=1.5
xyouts, 50, 19.8, 'Swift U + 2.3', charsize=1.5
xyouts, 45, 20.2, 'w1 + 1.5', charsize=1.5
xyouts, 0, 19.5, 'm2 ', charsize=1.5
xyouts, 40, 20.7, 'w2 + 1', charsize=1.5


al_legend, ['Las Cumbres Observatory', 'Swift/UVOT', 'TNT', 'AZT'], psym=[46, 2, 15, 6], charsize=1.5, position=[47,11.0], box=1



device, /close
SET_PLOT, 'X'


spawn, 'open photometry_17erp.eps'
$open photometry_17erp.eps 




print, 'final stop'
stop
end