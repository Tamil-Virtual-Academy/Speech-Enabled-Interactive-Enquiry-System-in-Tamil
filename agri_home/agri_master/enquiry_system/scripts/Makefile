# ----------------------------------------------------------------- #
#           The HMM-Based Speech Synthesis System (HTS)             #
#           developed by HTS Working Group                          #
#           http://hts.sp.nitech.ac.jp/                             #
# ----------------------------------------------------------------- #
#                                                                   #
#  Copyright (c) 2001-2011  Nagoya Institute of Technology          #
#                           Department of Computer Science          #
#                                                                   #
#                2001-2008  Tokyo Institute of Technology           #
#                           Interdisciplinary Graduate School of    #
#                           Science and Engineering                 #
#                                                                   #
# All rights reserved.                                              #
#                                                                   #
# Redistribution and use in source and binary forms, with or        #
# without modification, are permitted provided that the following   #
# conditions are met:                                               #
#                                                                   #
# - Redistributions of source code must retain the above copyright  #
#   notice, this list of conditions and the following disclaimer.   #
# - Redistributions in binary form must reproduce the above         #
#   copyright notice, this list of conditions and the following     #
#   disclaimer in the documentation and/or other materials provided #
#   with the distribution.                                          #
# - Neither the name of the HTS working group nor the names of its  #
#   contributors may be used to endorse or promote products derived #
#   from this software without specific prior written permission.   #
#                                                                   #
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND            #
# CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,       #
# INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF          #
# MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE          #
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS #
# BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,          #
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED   #
# TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,     #
# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON #
# ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,   #
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY    #
# OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE           #
# POSSIBILITY OF SUCH DAMAGE.                                       #
# ----------------------------------------------------------------- #

# awk, perl, bc and tcl
AWK   = gawk
PERL  = /usr/bin/perl
BC    = /usr/bin/bc
TCLSH = 
WC    = /usr/bin/wc


# dumpfeats to extract utterance information
DUMPFEATS = /home/jjoysingh/speech/festival/examples/dumpfeats

# speech analysis conditions
SAMPFREQ    = 48000   # Sampling frequency (48kHz)
FRAMELEN    = 1200   # Frame length in point (1200 = 48000 * 0.025)
FRAMESHIFT  = 240 # Frame shift in point (240 = 48000 * 0.005)
WINDOWTYPE  = 1 # Window type -> 0: Blackman 1: Hamming 2: Hanning
NORMALIZE   = 1  # Normalization -> 0: none  1: by power  2: by magnitude
FFTLEN      = 2048     # FFT length in point
FREQWARP    = 0.55   # frequency warping factor
GAMMA       = 0      # pole/zero weight for mel-generalized cepstral (MGC) analysis
MGCORDER    = 34   # order of MGC analysis
LNGAIN      = 1     # use logarithmic gain rather than linear gain
LOWERF0     = 110    # lower limit for f0 extraction (Hz)
UPPERF0     = 280    # upper limit for f0 extraction (Hz)
NOISEMASK   = 50  # standard deviation of white noise to mask noises in f0 extraction

# windows for calculating delta features
MGCWIN      = win/mgc.win
LF0WIN      = win/lf0.win
NMGCWIN     = 3
NLF0WIN     = 3


all: labels


labels: label scp


label:
	# Extracting monophone and fullcontext labels from utterance files

	for utt in ../prompt-utt/*.utt; do \
		base=`basename $${utt} .utt`; \
		if [ -s $${utt} ]; then \
			$(DUMPFEATS)    -eval     extra_feats.scm \
					-relation Segment \
					-eval ../utts_for_hts_phoneset.scm \
					-feats    label.feats \
					-output   tmp \
					$${utt}; \
		fi; \
		$(AWK) -f label-full.awk tmp > ../lab/$${base}.lab; \
	done
	rm -f tmp


scp:

	# Generating a generation label script
	for lab in /var/www/html/agri_0324/enquiry_system/lab/*.lab; do \
		echo $${lab} >> ../lists/gen.scp; \
	done



distclean: clean
	rm -f Makefile

.PHONY: all analysis labels mgc lf0 cmp label mlf list scp clean
