pro readLCOfile
;;;;;;;;;;;;;;;;;;;; read in LCO data

lcofile='$DROPSN/SN2017erp/lcodata/SN2017erp_lcophot.txt'
;  2017-06-14 2457919.2019      16.2481       0.0210 1m0-10  V

readcol, lcofile, date_lco, mjd_lco, mag_lco, magerr_lco, tel_lco, band_lco, format='A,D,F,F,A,A'

bmjd_lco=mjd_lco[where(band_lco eq 'B')]-2400000.5
bmag_lco=mag_lco[where(band_lco eq 'B')]
bmagerr_lco=magerr_lco[where(band_lco eq 'B')]


vmjd_lco=mjd_lco[where(band_lco eq 'V')]-2400000.5
vmag_lco=mag_lco[where(band_lco eq 'V')]
vmagerr_lco=magerr_lco[where(band_lco eq 'V')]

;;;;;;;;;;;;;;;; spit out in snoopy format like this named SNname.lcs
;;;; SN2009Y 0.009353 14.7068194444 -17.2461944444
;;;; filter u
;;;; 54869.84030   15.303 0.008
;;;; 54884.9792 19.175  0.212
;;;; filter UVW1
;;;; 54868.3879 16.496  0.060
;;;; 54870.1087 16.117  0.051
;;;; 54918.9908 19.380  0.335
;;;; filter U_UVOT
;;;; 54868.3893 14.770  0.039
;;;; 54872.2490 14.266  0.037

filters=['U', 'B', 'V', 'g', 'r', 'i' ]

SNname='SN2017erp'

if keyword_set(outfile) eq 0 then outfile=SNname+'.lcs'

openw,lun2, outfile, /get_lun

redshift=0.006174
ra='15:09:14.81	'
dec='-11:20:03.20'
printf, lun2, SNname, ' ', redshift, ' ', ra, ' ', dec

for f=0,5 do begin

	printf, lun2, 'filter ', filters[f]

	range=where(band_lco eq filters[f])

	for e=0,n_elements(range)-1 do begin
		printf, lun2, mjd_lco[range[e]], mag_lco[range[e]], magerr_lco[range[e]]
	endfor
endfor

close, lun2
free_lun, lun2

;;;

openw,lun2, 'SN2017erp_bb_ground.dat', /get_lun

printf, lun2, '# LCOGT data'


	range=where(band_lco eq 'B')

	for e=0,n_elements(range)-1 do begin
		printf, lun2, mjd_lco[range[e]], mag_lco[range[e]], magerr_lco[range[e]]
	endfor

close, lun2
free_lun, lun2

openw,lun2, 'SN2017erp_vv_ground.dat', /get_lun

printf, lun2, '# LCOGT data'


	range=where(band_lco eq 'V')

	for e=0,n_elements(range)-1 do begin
		printf, lun2, mjd_lco[range[e]], mag_lco[range[e]], magerr_lco[range[e]]
	endfor

close, lun2
free_lun, lun2



stop
end
