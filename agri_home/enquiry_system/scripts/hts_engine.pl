#!/usr/bin/perl
#
$| = 1;
if (@ARGV != 1) {
	print "Arg - config file";
	exit(0);
}

require($ARGV[0]);

# hts_engine (synthesizing waveforms using hts_engine)

   $dir = "${prjdir}/wav";

   # hts_engine command line & options
   # model file & trees
   # $hts_engine = "$ENGINE -td $trv{'dur'} -tf $trv{'lf0'} -tm $trv{'mgc'} -tl $trv{'lpf'} -md $pdf{'dur'} -mf $pdf{'lf0'} -mm $pdf{'mgc'} -ml $pdf{'lpf'} ";

	#used the hts_engine from usr/bin instead of the explicitly specified directory
	$hts_engine = "hts_engine -td $trv{'dur'} -tf $trv{'lf0'} -tm $trv{'mgc'} -tl $trv{'lpf'} -md $pdf{'dur'} -mf $pdf{'lf0'} -mm $pdf{'mgc'} -ml $pdf{'lpf'} ";
   # window coefficients
   $type = 'mgc';
   for ( $d = 1 ; $d <= $nwin{$type} ; $d++ ) {
      $hts_engine .= "-dm $voice/$win{$type}[$d-1] ";
   }
   $type = 'lf0';
   for ( $d = 1 ; $d <= $nwin{$type} ; $d++ ) {
      $hts_engine .= "-df $voice/$win{$type}[$d-1] ";
   }
   $type = 'lpf';
   $d    = 1;
   $hts_engine .= "-dl $voice/$win{$type}[$d-1] ";

   # control parameters (sampling rate, frame shift, frequency warping, etc.)
   $lgopt = "-l" if ($lg);
   $hts_engine .= "-s $sr -p $fs -a $fw -g $gm $lgopt -b " . ( $pf - 1.0 ) . " ";



   # GV pdfs
   if ($useGV) {
      $hts_engine .= "-cm $gvpdf{'mgc'} -cf $gvpdf{'lf0'} ";
      if ( $nosilgv && @slnt > 0 ) {
         $hts_engine .= "-k $voice/gv-switch.inf ";
      }
      if ($cdgv) {
         $hts_engine .= "-em $gvtrv{'mgc'} -ef $gvtrv{'lf0'} ";
      }
      $hts_engine .= "-b 0.0 ";    # turn off postfiltering
   }



   # generate waveform using hts_engine
   open( SCP, $scp{'gen'} ) || die "Cannot open $!";
   print "File: ", __FILE__, " Line: ", __LINE__, $scp{'gen'} ,"\n";
   while (<SCP>) {
	   print "File: ", __FILE__, " Line: ", __LINE__, "\n";
      $lab = $_;
      chomp($lab);
	  print "File: ", __FILE__, " Line: ", __LINE__, "\n";
      $base = `basename $lab .lab`;
      chomp($base);
	  print "File: ", __FILE__, " Line: ", __LINE__, "\n";

      print "Synthesizing a speech waveform from $lab using hts_engine...\n";
      shell("$hts_engine -ow ${dir}/${base}.wav $lab\n");
	#print "$hts_engine -or ${dir}/${base}.raw -ot ${dir}/${base}.trace $lab";
      #shell("$SOX -c 1 -s -$SOXOPTION -t raw -r $sr ${dir}/${base}.raw -c 1 -s -$SOXOPTION -t wav -r $sr ${dir}/${base}.wav");
      print "done.\n";
  }
   close(SCP);

sub shell($) {
   my ($command) = @_;
   my ($exit);

   $exit = system($command);

   if ( $exit / 256 != 0 ) {
      die "Error in $command\n";
   }
}
