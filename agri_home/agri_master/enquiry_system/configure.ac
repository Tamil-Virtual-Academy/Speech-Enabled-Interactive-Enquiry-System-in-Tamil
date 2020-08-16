# Process this file with autoconf to produce a configure script.
AC_INIT(HTS-demo_CMU-ARCTIC-SLT,2.2,hts-users@sp.nitech.ac.jp)
AC_COPYRIGHT(Copyright 2001-2011 Nagoya Institute of Technology)
AC_COPYRIGHT(Copyright 2001-2008 Tokyo Institute of Technology)



# Checks for programs.
# awk
AC_PROG_AWK



# perl
AC_PATH_PROG([PERL], [perl], [/usr/bin], [$PATH:/usr/bin])
if test ! -f "$PERL"; then
	AC_MSG_ERROR(Can't find perl)
fi





# bc
AC_PATH_PROG([BC], [bc], [/usr/bin], [$PATH:/usr/bin])
if test ! -f "$BC"; then
	AC_MSG_ERROR(Can't find bc)
fi

# wc
AC_PATH_PROG([WC], [wc], [/usr/bin], [$PATH:/usr/bin])
if test ! -f "$WC"; then
	AC_MSG_ERROR(Can't find wc)
fi

# tee
AC_PATH_PROG([TEE], [tee], [/usr/bin], [$PATH:/usr/bin])
if test ! -f "$TEE"; then
	AC_MSG_ERROR(Can't find tee)
fi



# festival
# festival search path
AC_ARG_WITH(fest-search-path,
		AS_HELP_STRING([--with-fest-search-path],[specify the additional festival search path]),
		[fest_search_path=$withval])

# dumpfeats (festival)
AC_PATH_PROG([DUMPFEATS], [dumpfeats], [:], [${fest_search_path}:$PATH])
if test ! -f "$DUMPFEATS"; then
	AC_MSG_ERROR(Can't find dumpfeats of festival)
fi




# sox (Sound eXchange)
# sox search path
AC_ARG_WITH(sox-search-path,
		AS_HELP_STRING([--with-sox-search-path],[specify the additional sox (Sound eXchange) search path]),
		[sox_search_path=$withval])

# sox
AC_PATH_PROG([SOX], [sox], [:], [${sox_search_path}:$PATH])
if test ! -f "$SOX"; then
	AC_MSG_ERROR(Can't find sox)
fi

# sox option
$SOX -h > sox.option 2>&1
soxversion=`head -1 sox.option | sed -e s/v//g | awk '{printf "%d\n",$NF}'`
if test $soxversion -gt 13; then
	SOXOPTION=2
else
	SOXOPTION=w
fi
rm -f sox.option
AC_SUBST(SOXOPTION)



# HTS commands
# hts_engine API
# hts_engine search path
AC_ARG_WITH(hts-engine-search-path,
		AS_HELP_STRING([--with-hts-engine-search-path],[specify the additional hts_engine binary search path]),
		[hts_engine_search_path=$withval])

# hts_engine
AC_PATH_PROG([ENGINE], [hts_engine], [:], [${hts_engine_search_path}:$PATH])
if test ! -f "$ENGINE"; then
	AC_MSG_ERROR(Can't find hts_engine)
fi



# speaker and dataset names
AC_ARG_VAR([SPEAKER],[speaker name (default=slt)])
AC_ARG_VAR([DATASET],[dataset (default=cmu_us_arctic)])

if test -z "$SPEAKER"; then
	SPEAKER=slt
fi

if test -z "$DATASET"; then
	DATASET=cmu_us_arctic
fi

AC_SUBST(SPEAKER)
AC_SUBST(DATASET)



# version number and question set name
AC_ARG_VAR([VER],[version number of this setting (default=1)])
AC_ARG_VAR([QNUM],[question set number (default='001')])

if test -z "$VER"; then
	VER=1
fi

if test -z "$QNUM"; then
	QNUM='001'
fi

AC_SUBST(VER)
AC_SUBST(QNUM)



# current directory
AC_SUBST(PWD)



# setting of mel-generalized cepstral analysis, F0 extraction, and postfiltering related settings
# parse command-line arguments
AC_ARG_VAR([FRAMELEN],[Frame length in point (default=1200)])
AC_ARG_VAR([FRAMESHIFT],[Frame shift in point (default=240)])
AC_ARG_VAR([WINDOWTYPE],[Window type -> 0: Blackman  1: Hamming  2: Hanning (default=1)])
AC_ARG_VAR([NORMALIZE],[Normalization -> 0: none  1: by power  2: by magnitude (default=1)])
AC_ARG_VAR([FFTLEN],[FFT length in point (default=2048)])
AC_ARG_VAR([FREQWARP],[Frequency warping factor (default=0.55)])
AC_ARG_VAR([GAMMA],[Pole/Zero weight factor (0: mel-cepstral analysis  1: LPC analysis  2,3,...,N: mel-generalized cepstral (MGC) analysis) (default=0)])
AC_ARG_VAR([MGCORDER],[Order of MGC analysis (default=34 for cepstral form, default=12 for LSP form)])
AC_ARG_VAR([LNGAIN],[Use logarithmic gain instead of linear gain (default=1)])
AC_ARG_VAR([LOWERF0],[Lower limit for F0 extraction in Hz (default=110)])
AC_ARG_VAR([UPPERF0],[Upper limit for F0 extraction in Hz (default=280)])
AC_ARG_VAR([NOISEMASK],[Standard deviation of white noise to mask noise in f0 extraction (default=50)])
AC_ARG_VAR([PSTFILTER],[Postfiltering factor (default=1.4)])
AC_ARG_VAR([IMPLEN],[Length of impulse response (default=4096)])
AC_ARG_VAR([SAMPFREQ],[Sampling frequency in Hz (default=48000)])

# default values
if test -z "$FRAMELEN"; then
	FRAMELEN=1200
fi

if test -z "$FRAMESHIFT"; then
	FRAMESHIFT=240
fi

if test -z "$WINDOWTYPE"; then
	WINDOWTYPE=1
fi

if test -z "$NORMALIZE"; then
	NORMALIZE=1
fi

if test -z "$FFTLEN"; then
	FFTLEN=2048
fi

if test -z "$SAMPFREQ"; then
	SAMPFREQ=48000
fi

if test -z "$FREQWARP"; then
	case $SAMPFREQ in
		8000)  FREQWARP=0.31 ;;
		10000) FREQWARP=0.35 ;;
		12000) FREQWARP=0.37 ;;
		16000) FREQWARP=0.42 ;;
		22050) FREQWARP=0.45 ;;
		32000) FREQWARP=0.45 ;;
		44100) FREQWARP=0.53 ;;
		48000) FREQWARP=0.55 ;;
		*)     FREQWARP=0.00 ;;
	esac
fi

if test -z "$GAMMA"; then
	GAMMA=0
fi

if test -z "$MGCORDER"; then
	if test $GAMMA -eq 0; then
		MGCORDER=34
	else
		MGCORDER=12
	fi
fi

if test -z "$LNGAIN"; then
	LNGAIN=1
fi

if test -z "$LOWERF0"; then
	LOWERF0=110
fi 

if test -z "$UPPERF0"; then
	UPPERF0=280
fi 

if test -z "$NOISEMASK"; then
	NOISEMASK=50
fi

if test -z "$PSTFILTER"; then
	PSTFILTER=1.4
fi

if test -z "$IMPLEN"; then
	IMPLEN=4096
fi

MGCVSIZE=`expr $MGCORDER + 1`

if test $GAMMA -lt 0; then
	AC_MSG_ERROR(Cannot use MGC coefficients if GAMMA<0!)
fi



# substitute variables
AC_SUBST(FRAMELEN)
AC_SUBST(FRAMESHIFT)
AC_SUBST(WINDOWTYPE)
AC_SUBST(NORMALIZE)
AC_SUBST(FFTLEN)
AC_SUBST(FREQWARP)
AC_SUBST(GAMMA)
AC_SUBST(MGCORDER)
AC_SUBST(LOWERF0)
AC_SUBST(UPPERF0)
AC_SUBST(NOISEMASK)
AC_SUBST(PSTFILTER)
AC_SUBST(IMPLEN)
AC_SUBST(SAMPFREQ)
AC_SUBST(MGCVSIZE)



# number of windows
# parse command-line arguments
AC_ARG_VAR([NMGCWIN],[number of delta windows for MGC coefficients (default=3)])
AC_ARG_VAR([NLF0WIN],[number of delta windows for log F0 values (default=3)])

# default values
if test -z "$NMGCWIN"; then
	NMGCWIN=3
fi

if test -z "$NLF0WIN"; then
	NLF0WIN=3
fi

F0STREN=`expr $NLF0WIN + 1`

# substitute variables
AC_SUBST(NMGCWIN)
AC_SUBST(NLF0WIN)
AC_SUBST(F0STREN)



# model training settings
# parse command-line arguments
AC_ARG_VAR([NSTATE],[number of HMM states (default=5)])
AC_ARG_VAR([NITER],[number of iterations of embedded training (default=5)])
AC_ARG_VAR([WFLOOR],[mixture weight flooring scale (default=5000)])
AC_ARG_VAR([DAEM],[DAEM algorithm for parameter estimation (0:off or 1:on, default=0)])
AC_ARG_VAR([DAEMNITER],[number of iterations of DAEM-based embedded training (default=10)])
AC_ARG_VAR([DAEMALPHA],[schedule of updating temperature parameter for DAEM (default=1.0)])
AC_ARG_VAR([MAXDEV],[maximum duration scaling factor (default=10)])
AC_ARG_VAR([MINDUR],[minimum duration to be evaluated (default=5)])
AC_ARG_VAR([NMGCTRANSBLK],[number of blocks for MGC transforms (default=3)])
AC_ARG_VAR([NLF0TRANSBLK],[number of blocks for log F0 transforms (default=1)])
AC_ARG_VAR([MGCBANDWIDTH],[band width for MGC transforms (default=35 for cepstral form, derault=2 for LSP form)])
AC_ARG_VAR([LF0BANDWIDTH],[band width for log F0 transforms (default=1)])

# default values
if test -z "$NSTATE"; then
	NSTATE=5
fi

if test -z "$NITER"; then
	NITER=5
fi

if test -z "$WFLOOR"; then
	WFLOOR=5000
fi

if test -z "$DAEM"; then
	DAEM=0
fi

if test -z "$DAEMNITER"; then
	DAEMNITER=10
fi

if test -z "$DAEMALPHA"; then
	DAEMALPHA=1.0
fi

if test -z "$MAXDEV"; then
	MAXDEV=10
fi

if test -z "$MINDUR"; then
	MINDUR=5
fi

if test -z "$NMGCTRANSBLK"; then
	NMGCTRANSBLK=3
fi

if test -z "$NLF0TRANSBLK"; then
	NLF0TRANSBLK=1
fi

if test -z "$MGCBANDWIDTH"; then
	if test $GAMMA -eq 0; then
		MGCBANDWIDTH=$MGCVSIZE
	else
		MGCBANDWIDTH=2
	fi
fi

if test -z "$LF0BANDWIDTH"; then
	LF0BANDWIDTH=1
fi

# substitute variables
AC_SUBST(NSTATE)
AC_SUBST(NITER)
AC_SUBST(WFLOOR)
AC_SUBST(DAEM)
AC_SUBST(DAEMNITER)
AC_SUBST(DAEMALPHA)
AC_SUBST(MAXDEV)
AC_SUBST(MINDUR)
AC_SUBST(NMGCTRANSBLK)
AC_SUBST(NLF0TRANSBLK)
AC_SUBST(MGCBANDWIDTH)
AC_SUBST(LF0BANDWIDTH)


# parameter generation algorithm settings
# parse command-line arguments
AC_ARG_VAR([MAXEMITER],[max EM iteration (default=20)])
AC_ARG_VAR([EMEPSILON],[convergence factor for EM iteration (default=0.0001)])
AC_ARG_VAR([USEGV],[turn on GV-based parameter generation algorithm (0:off or 1:on, default=1)])
AC_ARG_VAR([MAXGVITER],[maximum number of iterations of GV-based parameter generation algorithm (default=50)])
AC_ARG_VAR([GVEPSILON],[convergence factor for GV iteration (default=0.0001)])
AC_ARG_VAR([MINEUCNORM],[minimum Euclid norm for GV iteration (default=0.01)])
AC_ARG_VAR([STEPINIT],[initial step size (default=1.0)])
AC_ARG_VAR([STEPINC],[step size acceleration factor (default=1.2)])
AC_ARG_VAR([STEPDEC],[step size deceleration factor (default=0.5)])
AC_ARG_VAR([HMMWEIGHT],[weight for HMM output prob. (default=1.0)])
AC_ARG_VAR([GVWEIGHT],[weight for GV output prob. (default=1.0)])
AC_ARG_VAR([OPTKIND],[optimization method (STEEPEST, NEWTON, or LBFGS) (default=NEWTON)])
AC_ARG_VAR([NOSILGV],[turn on GV without silent and pause phoneme (0:off or 1:on, default=1)])
AC_ARG_VAR([CDGV],[turn on context-dependent GV (0:off or 1:on, default=1)])

# default values
if test -z "$MAXEMITER"; then
	MAXEMITER=20
fi

if test -z "$EMEPSILON"; then
	EMEPSILON=0.0001
fi

if test -z "$USEGV"; then
	USEGV=1
fi

if test -z "$MAXGVITER"; then
	MAXGVITER=50
fi

if test -z "$GVEPSILON"; then
	GVEPSILON=0.0001
fi

if test -z "$MINEUCNORM"; then
	MINEUCNORM=0.01
fi

if test -z "$STEPINIT"; then
	STEPINIT=1.0
fi

if test -z "$STEPINC"; then
	STEPINC=1.2
fi

if test -z "$STEPDEC"; then
	STEPDEC=0.5
fi

if test -z "$HMMWEIGHT"; then
	HMMWEIGHT=1.0
fi

if test -z "$GVWEIGHT"; then
	GVWEIGHT=1.0
fi

if test -z "$OPTKIND"; then
	OPTKIND=NEWTON
fi

if test -z "$NOSILGV"; then
	NOSILGV=1
fi

if test -z "$CDGV"; then
	CDGV=1
fi

# substitute variables
AC_SUBST(MAXEMITER)
AC_SUBST(EMEPSILON)
AC_SUBST(USEGV)
AC_SUBST(MAXGVITER)
AC_SUBST(GVEPSILON)
AC_SUBST(MINEUCNORM)
AC_SUBST(STEPINIT)
AC_SUBST(STEPINC)
AC_SUBST(STEPDEC)
AC_SUBST(HMMWEIGHT)
AC_SUBST(GVWEIGHT)
AC_SUBST(OPTKIND)
AC_SUBST(NOSILGV)
AC_SUBST(CDGV)



# output data/Makefile and scripts/Config.pm
AC_OUTPUT(data/Makefile scripts/Config.pm Makefile)
