#!/usr/bin/perl -w

use strict;
use Data::Dumper;


my ($line,@search_replace, $pattern_replacement, $pattern, $replacement, $prevpos);
my (%pattern_positions);

# Ask the user to enter a line of text
print "replace: Please, enter 1 line of text:\n";
$line = <STDIN>;

# Ask for string_to_replace => replacement values
print "replace: Please, enter space separated strings to match and replace (one pair per line).\n";
print "replace: Empty line will interrupt input and start execution:\n";
$pattern_replacement = <STDIN>;
chomp($pattern_replacement);
if ($pattern_replacement) {
	push @search_replace, $pattern_replacement;
} else {
	print "------ empty line -----\n";
}
while($pattern_replacement) {
	$pattern_replacement = <STDIN>;
	chomp($pattern_replacement);
	if ($pattern_replacement) {
	        push @search_replace, $pattern_replacement;
	} else {
		print "------ empty line -----\n";
	}
}

# Get the indexes of matches
foreach my $patternreplacement (@search_replace) {
	($pattern, $replacement) = split(' ', $patternreplacement);
	while($line =~ m/$pattern/g) {
		push (@{$pattern_positions{$pattern}}, pos($line) - length($pattern));
#		print "$pattern: " . (pos($line) - length($pattern)) . "\n";
	}
}

# Do the work
$prevpos = 0;
foreach my $patternreplacement (@search_replace) {
	($pattern, $replacement) = split(' ', $patternreplacement);
	foreach my $position(@{$pattern_positions{$pattern}}) {
		my ($aux1, $aux2);
		my $start_second_substr = $position + length($pattern);
		my $length_second_substr = length($line) - $start_second_substr;
		$aux1 = substr $line, 0, $position;
		$aux2 = substr $line, $start_second_substr, $length_second_substr;
		print "Start second substr: $start_second_substr length second substring: $length_second_substr\n";
		$line = join('', $aux1, $replacement, $aux2);
		#my $j = 0;
		#my $difference = length($replacement) - length($pattern);
		#if ($difference == 0) {
		#	substr $line, $position, length($replacement), $replacement;
		#}
                #for (my $i = $position; $i < $position + length($replacement); $i++) {
		#	my $char = substr $replacement, $j, 1;
                #        substr $line, $i, 1, $char;
                #	$j++;
		#}
		#if ($difference > 0) {
		#	substr $line, $position + length($replacement), $difference, " " x $difference;
		#} elsif($difference < 0) {
		#	substr $line, $position - $difference, -$difference, " " x -$difference;
		#}
	}
	print "replace: $line\n";
}

# Show resulting line
print "replace: $line\n";
