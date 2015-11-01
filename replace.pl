#!/usr/bin/perl -w

use strict;


my ($line,@search_replace, $pattern_replacement, $pattern, $replacement);
my (%pattern_positions);

# Ask the user to enter a line of text
print "replace: Please, enter 1 line of text:\n";
$line = <STDIN>;
chomp($line);

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
sub create_indexes {
	my $diff = shift;
	foreach my $patternreplacement (@search_replace) {
	($pattern, $replacement) = split(' ', $patternreplacement);
		while($line =~ m/$pattern/g) {
			push (@{$pattern_positions{$pattern}}, pos($line) - length($pattern));
		}
	}
}

sub update_indexes {
	my ($diff, $start_pos) = @_;
	foreach $pattern (keys(%pattern_positions)) {
	        for(my $i = 0; $i < scalar(@{$pattern_positions{$pattern}}); $i++) {
			if (${$pattern_positions{$pattern}}[$i] > $start_pos) {
	                        if ($diff < 0) {
          	                      ${$pattern_positions{$pattern}}[$i] -= $diff;
                	        } elsif($diff > 0) {
                        	        ${$pattern_positions{$pattern}}[$i] += $diff
                        	}

			}
        	}
	}	
}

# Do the work
create_indexes();
foreach my $patternreplacement (@search_replace) {
	($pattern, $replacement) = split(' ', $patternreplacement);
	print "Pattern $pattern, replacement $replacement\n";
	my ($aux1, $aux2, $start_second_substr, $length_second_substr, $dff);
	foreach my $position(@{$pattern_positions{$pattern}}) {
		$start_second_substr = $position + length($pattern);
		$aux1 = substr $line, 0, $position;
		$length_second_substr = length($line) - $start_second_substr;
		if($start_second_substr < length($line)) {
			$aux2 = substr $line, $start_second_substr, $length_second_substr;
		} else {
			$aux2 = "";
		}
		$line = join('', $aux1, $replacement, $aux2);
		print "replace: $line\n\n";
		$dff = length($pattern) - length($replacement);
		update_indexes($dff, $position);		
	}
}

# Show resulting line
print "replace: $line\n";
