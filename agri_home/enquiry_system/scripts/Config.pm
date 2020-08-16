#!/usr/bin/perl
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


# Settings ==============================


@SET        = ('cmp','dur');
@cmp        = ('mgc','lf0');
@dur        = ('dur');
$ref{'cmp'} = \@cmp;
$ref{'dur'} = \@dur;

%vflr = ('mgc' => '0.01',           # variance floors
         'lf0' => '0.01',
         'dur' => '0.01');

%thr  = ('mgc' => '000',            # minimum likelihood gain in clustering
         'lf0' => '000',
         'dur' => '000');

%mdlf = ('mgc' => '1.0',            # tree size control param. for MDL
         'lf0' => '1.0',
         'dur' => '1.0');

%mocc = ('mgc' => '10.0',           # minimum occupancy counts
         'lf0' => '10.0',
         'dur' => ' 5.0');

%gam  = ('mgc' => '000',            # stats load threshold
         'lf0' => '000',
         'dur' => '000');

%t2s  = ('mgc' => 'cmp',            # feature type to mmf conversion
         'lf0' => 'cmp',
         'dur' => 'dur');

%strb = ('mgc' => '1',              # stream start
         'lf0' => '2',
         'dur' => '1');

%stre = ('mgc' => '1',              # stream end
         'lf0' => '4',
         'dur' => '5');

%msdi = ('mgc' => '0',              # msd information
         'lf0' => '1',
         'dur' => '0');

%strw = ('mgc' => '1.0',            # stream weights
         'lf0' => '1.0',
         'dur' => '1.0');

%ordr = ('mgc' => '35',     # feature order
         'lf0' => '1',
         'dur' => '5');

%nwin = ('mgc' => '3',      # number of windows
         'lf0' => '3',
         'dur' => '0');

%nblk = ('mgc' => '3', # number of blocks for transforms
         'lf0' => '1',
         'dur' => '1');

%band = ('mgc' => '35', # band width for transforms
         'lf0' => '1',
         'dur' => '0');

%gvthr  = ('mgc' => '000',          # minimum likelihood gain in clustering for GV
           'lf0' => '000');

%gvmdlf = ('mgc' => '1.0',          # tree size control for GV
           'lf0' => '1.0');

%gvgam  = ('mgc' => '000',          # stats load threshold for GV
           'lf0' => '000');

@slnt = ('pau','h#','brth');        # silent and pause phoneme

#%mdcp = ('dy' => 'd',              # model copy
#         'A'  => 'a',
#         'I'  => 'i',
#         'U'  => 'u',
#         'E'  => 'e',
#         'O'  => 'o');


# Speech Analysis/Synthesis Setting ==============
# speech analysis
$sr = 48000;   # sampling rate (Hz)
$fs = 240; # frame period (point)
$fw = 0.55;   # frequency warping
$gm = 0;      # pole/zero representation weight
$lg = 1;     # use log gain instead of linear gain
$fr = $fs/$sr;      # frame period (sec)

# speech synthesis
$pf = 1.4; # postfiltering factor
$fl = 4096;    # length of impulse response
$co = 2047;        # order of cepstrum to approximate mel-generalized cepstrum


# Modeling/Generation Setting ==============
# modeling
$nState     = 5;        # number of states
$nIte       = 5;         # number of iterations for embedded training
$beam       = '1500 100 5000'; # initial, inc, and upper limit of beam width
$maxdev     = 10;        # max standard dev coef to control HSMM maximum duration
$mindur     = 5;        # min state duration to be evaluated
$wf         = 5000;        # mixture weight flooring
$daem       = 0;          # DAEM algorithm based parameter estimation
$daem_nIte  = 10;     # number of iterations of DAEM-based embedded training
$daem_alpha = 1.0;     # schedule of updating temperature parameter for DAEM

# generation
$maxEMiter  = 20;  # max EM iteration
$EMepsilon  = 0.0001;  # convergence factor for EM iteration
$useGV      = 1;      # turn on GV
$maxGViter  = 50;  # max GV iteration
$GVepsilon  = 0.0001;  # convergence factor for GV iteration
$minEucNorm = 0.01; # minimum Euclid norm for GV iteration
$stepInit   = 1.0;   # initial step size
$stepInc    = 1.2;    # step size acceleration factor
$stepDec    = 0.5;    # step size deceleration factor
$hmmWeight  = 1.0;  # weight for HMM output prob.
$gvWeight   = 1.0;   # weight for GV output prob.
$optKind    = 'NEWTON';  # optimization method (STEEPEST, NEWTON, or LBFGS)
$nosilgv    = 1;    # GV without silent and pause phoneme
$cdgv       = 1;       # context-dependent GV


# Directories & Commands ===============
# project directories
$prjdir = '/var/www/html/agri_0324/enquiry_system';

# Perl
$PERL = '/usr/bin/perl';

# wc
$WC = '/usr/bin/wc';

# tee
$TEE = '/usr/bin/tee';

# HTS commands
$ENGINE    = '/home/jjoysingh/speech/hts_engine_API-1.06/bin/hts_engine';


# SoX (to add RIFF header)
$SOX       = '/usr/bin/sox';
$SOXOPTION = '2';


# model structure
$vSize{'total'}   = 0;
$nstream{'total'} = 0;
$nPdfStreams      = 0;
foreach $type (@cmp) {
   $vSize{$type} = $nwin{$type} * $ordr{$type};
   $vSize{'total'} += $vSize{$type};
   $nstream{$type} = $stre{$type} - $strb{$type} + 1;
   $nstream{'total'} += $nstream{$type};
   $nPdfStreams++;
}

# File locations =========================

# data location file
$scp{'gen'} = "lists/gen.scp";

# model list files



# converted model & tree files for hts_engine
$voice = "$prjdir/voices/";
foreach $set (@SET) {
   foreach $type ( @{ $ref{$set} } ) {
      $trv{$type} = "$voice/tree-${type}.inf";
      $pdf{$type} = "$voice/${type}.pdf";
   }
}
$type       = 'lpf';
$trv{$type} = "$voice/tree-${type}.inf";
$pdf{$type} = "$voice/${type}.pdf";

foreach $type (@cmp) {
   for ( $d = 1 ; $d <= $nwin{$type} ; $d++ ) {
      $win{$type}[ $d - 1 ] = "${type}.win${d}";
   }
}
$type                 = 'lpf';
$d                    = 1;
$win{$type}[ $d - 1 ] = "${type}.win${d}";

foreach $type (@cmp) {
   $gvpdf{$type} = "$voice/gv-${type}.pdf";
   $gvtrv{$type} = "$voice/tree-gv-${type}.inf";
}


# HTS Commands & Options ========================
$HCompV{'cmp'} = "$HCOMPV    -A    -C $cfg{'trn'} -D -T 1 -S $scp{'trn'} -m ";
$HCompV{'gv'}  = "$HCOMPV    -A    -C $cfg{'trn'} -D -T 1 -S $scp{'gv'}  -m ";
$HList         = "$HLIST     -A    -C $cfg{'trn'} -D -T 1 -S $scp{'trn'} -h -z ";
$HInit         = "$HINIT     -A    -C $cfg{'trn'} -D -T 1 -S $scp{'trn'}                -m 1 -u tmvw    -w $wf ";
$HRest         = "$HREST     -A    -C $cfg{'trn'} -D -T 1 -S $scp{'trn'}                -m 1 -u tmvw    -w $wf ";
$HERest{'mon'} = "$HEREST    -A    -C $cfg{'trn'} -D -T 1 -S $scp{'trn'} -I $mlf{'mon'} -m 1 -u tmvwdmv -w $wf -t $beam ";
$HERest{'ful'} = "$HEREST    -A -B -C $cfg{'trn'} -D -T 1 -S $scp{'trn'} -I $mlf{'ful'} -m 1 -u tmvwdmv -w $wf -t $beam ";
$HERest{'gv'}  = "$HEREST    -A    -C $cfg{'trn'} -D -T 1 -S $scp{'gv'}  -I $mlf{'gv'}  -m 1 ";
$HHEd{'trn'}   = "$HHED      -A -B -C $cfg{'trn'} -D -T 1 -p -i ";
$HHEd{'cnv'}   = "$HHED      -A -B -C $cfg{'cnv'} -D -T 1 -p -i ";
$HSMMAlign     = "$HSMMALIGN -A    -C $cfg{'trn'} -D -T 1 -S $scp{'trn'} -I $mlf{'mon'} -t $beam -w 1.0 ";

