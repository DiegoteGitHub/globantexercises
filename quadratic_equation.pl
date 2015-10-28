#!/usr/bin/perl -w

use strict;
my ($A,$B,$C,$insqrt, $sqrt, $sol1, $sol2);

# Get arguments
$A = defined $ARGV[0] ? $ARGV[0] : 0;
$B = defined $ARGV[1] ? $ARGV[1] : 0;
$C = defined $ARGV[2] ? $ARGV[2] : 0;

# Validation: if we have characters that are not digits => INVALID
if ($A =~ /\D/ || $B =~ /\D/ || $C =~ /\D/) {
        print STDERR "Wrong input\n";
        exit(1);	
}

# Special case 1 => WRONG INPUT
if ($A == 0 && $B == 0 && $C == 0) {
	print STDERR "All zero or no numbers entered, Wrong input\n";
	exit(1);
}

# Special case 2 => B and C are zero => solution is zero
if ($B == 0 && $C == 0) {
        print "0\n";
        exit(0);
}

# Special case 3 => B is zero => only complex solutions => ERROR
if ($B == 0) {
	print STDERR "No real solutions\n";
        exit(1);
}

# Linear equation only one potential solution
if ($A == 0) {
	if ($B != 0) {
		$sol1 = -($C/$B);
		print "$sol1\n";
		exit(0);
	} else {
	        print STDERR "Wrong input\n";
	        exit(1);
	}
}

$insqrt = $B ** 2 - 4 * $A * $C; # inside part of square root
if ($insqrt >= 0)  {
	$sqrt = sqrt($insqrt);
	if ($sqrt == 0) {
		$sol2 = $sol1 = - $B / (2 * $A);
	} else {
		$sol1 = (-$B + $sqrt) / (2 * $A);
		$sol2 = (-$B - $sqrt) / (2 * $A);
	}
	print "$sol1 $sol2\n";	
	exit(0);
} else { 
	print STDERR "No real solution\n";
	exit(1);
}
