#!/usr/bin/perl -w

use strict;
use POSIX;

sub is_prime {
	my $number = shift;
	if ($number % 2 == 0 || $number % 3 == 0) {
		return 0;
	} else {
		my $sqrt_rounded_up = floor(sqrt($number));
		for (my $i = 5; $i <= $sqrt_rounded_up; $i++) {
			if ($number % $i == 0) {
				return 0;
			}
		}
		return 1;
	}
}

my $number;

# Ask user to enter a number
print STDOUT "prime: Enter a number from 2 to 1000000: ";
$number = <STDIN>;

# Remove \n
chomp($number);

# Check if the input is a number
if ($number =~ /\D/) {
        print STDERR "Wrong input\n";
        exit(1);
}

# Check if the number is in the range
if ($number < 2 || $number > 1000000) {
	print "Out of range\n";
	exit(1);
}

# Check what numbers are primes and print to STDOUT
for (my $i = 1; $i < $number; $i++) {
	if ($i == 1 || $i == 2 || $i == 3) {
		print "$i ";
	} else {
		if (is_prime($i)) {
			print "$i ";		
		}	
	}
}
print "\n";
