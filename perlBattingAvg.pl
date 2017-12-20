#!/usr/bin/perl
# Jenna McCown
# perl program to calculate batting average, slugging percentage, and on base percentage
$filename = $ARGV[0];
my $btotal, $bavg, $stotal, $slavg, $obtotal, $obptg, $prints, %hArray, %batAvg;

printf "\n----- BEGIN STATISTICS REPORT -----\nLASTNAME, FIRSTNAME\t   AVG\t  SLG\t OBP\t\n\n";
open(FILE, $filename) or die "Could not read from $filename, program halting.";
while(<FILE>)
{ # get rid of the newline character
  chomp;
  # read the fields in the current record as separate variables
  ($firstname,$lastname,$plateA,$atBat,$single,$double,$triple,$homerun,$walks) = split(' ', $_);

  #calculate the total of hits (singles, doubles, triples, and homeruns)
  $btotal = $single+$double+$triple+$homerun;
  $bavg = $btotal/$atBat;

  #calculate the total of singlesx1, doublesx2, triplesx3, homerunx4
  $stotal=$single+($double*2)+($triple*3)+($homerun*4);

  #calculate the slugging percentage:
  $slavg=$stotal/$atBat;

  #calculate the on base percentage:
  $obtotal=$btotal+$walks;
  $obptg=$obtotal/$plateA;

  #Put the data into a hash for last name sort display
  $hArray{$lastname}{"first"}=$firstname;
  $hArray{$lastname}{"bat"}=$bavg;
  $hArray{$lastname}{"slug"}=$slavg;
  $hArray{$lastname}{"onBat"}=$obptg;
  #Put data in a hash for bat average
  $batAvg{$bavg}{"last"}=$lastname;
  $batAvg{$bavg}{"first"}=$firstname;

  #print the results:
#if all variables are numbers
if ($plateA =~ /^[0-9]+$/ && $atBat =~ /^[0-9]+$/ && $single =~ /^[0-9]+$/ && $double =~ /^[0-9]+$/ && $triple =~ /^[0-9]+$/ && $homerun =~ /^[0-9]+$/ && $walks =~ /^[0-9]+$/)
	{
  $hArray{$lastname}{"error"}=1; #no errors
  $batAvg{$bavg}{"error"}=1; #no errors
  }elsif ($plateA =~ /[0-9][aA-zZ]/ || $atBat =~ /[0-9][aA-zZ]/ || $single =~ /[0-9][aA-zZ]/ || $double =~ /[0-9][aA-zZ]/ || $triple =~ /[0-9][aA-zZ]/ || $homerun =~ /[0-9][aA-zZ]/ || $walks =~ /[0-9][aA-zZ]/) { #then error message
  #if first variable is not a name, print next line
  $hArray{$lastname}{"error"}=2; #invalid data
  }else {
    $hArray{$lastname}{"error"}=3; #not enough data
  }
}

foreach my $name (sort keys %hArray) {#sort hash by last name
  sort $hArray{$name}{first}; #sort by first name
  if($hArray{$name}{error}==1){ #if no errors
    $prints = sprintf ("\t%s, %s \t: %.3f  %.3f  %.3f \n",$name, $hArray{$name}{first}, $hArray{$name}{bat}, $hArray{$name}{slug}, $hArray{$name}{onBat});
    print "$prints";
   }
   elsif($hArray{$name}{error}==2){ #if invalid numeric data
     $prints = sprintf ("\t%s, %s : Unable to compute result. Invalid numeric data. ***\n",$name, $hArray{$name}{first});
     print "$prints";
   }
   else{ #not enough data.
     $prints = sprintf ("\t%s, %s : Unable to compute result. Not Enough data. ***\n",$name, $hArray{$name}{first});
     print "$prints";
   }
}printf "\n----- END STATISTICS REPORT -----\n";

#Just show the batting averages without errors. Sorted by batting average.
printf "\n----- Batting Average Report -----\nLASTNAME, FIRSTNAME\t   AVG\t\n\n";
foreach my $bnum (reverse sort %batAvg) { #for each player, sort hash
    if($batAvg{$bnum}{error}==1){ #if no errors
    $prints = sprintf ("\t%s, %s \t: %.3f \n", $batAvg{$bnum}{last}, $batAvg{$bnum}{first}, $bnum);
    print "$prints";
  }
}
printf "\n----- END STATISTICS REPORT -----\n";
close FILE;
