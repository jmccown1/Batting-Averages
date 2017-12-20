# McCownProgram5.awk -- finds batting average, slugging percentage, and
# on base percentage.
# By Jenna McCown

BEGIN {
#print the beginning of statistics report
print "\n----- BEGIN STATISTICS REPORT -----\n"
print "LASTNAME, FIRSTNAME\t   AVG\t  SLG\t OBP\t"
}

#for each line:
{
#calculate the total of hits (singles, doubles, triples, and homeruns)
btotal = 0
for (i = 5; i <= 8; ++i)
{
if ($i ~ /^[0-9]{1}/)
	btotal += $i
}
#calculate the batting average:
if ($4 ~ /^[0-9]{1}/) #to avoid dividing by 0, make sure $4 is at least 1 number
	batavg = btotal/$4

#calculate the total of singlesx1, doubles x 2, triples x 3, homeruns x4
stotal = 0
	stotal += $5
	stotal += $6 * 2
	stotal += $7 * 3
	stotal += $8 * 4

#calculate the slugging percentage:
if ($4>0)
	slavg = stotal/$4

#calculate the on base percentage
obtotal=btotal+$9
if ($3>0)
	obptg=obtotal/$3

#print the results:
#if all variables are at least two digit long numbers
if ($3 ~ /^[0-9]+$/ && $4 ~ /^[0-9]+$/ && $5 ~ /^[0-9]+$/ && $6 ~ /^[0-9]+$/ && $7 ~ /^[0-9]+$/ && $8 ~ /^[0-9]+$/ && $9 ~ /^[0-9]+$/)
	printf ("\t%s, %s \t: %.3lf  %.3lf  %.3lf\n", $2, $1, batavg, slavg, obptg);
else { #then error message
#if first variable is not a name, print next line
	if($1 ~ /^[aA-zZ]/)
	printf ("\t%s, %s : Unable to compute result. Invalid numeric data. ***\n", $2, $1);
	else
	printf("\n");
}

#show end of report
}
END {
print "\n----- END STATISTICS REPORT -----\n"
}
