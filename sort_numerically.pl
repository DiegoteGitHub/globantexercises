#!/usr/bin/perl

use strict;
use warnings FATAL => 'all';

my %small = (
    one => '1',
    two => '2',
    three => '3',
    four => '4',
    five => '5',
    six => '6',
    seven => '7',
    eight => '8',
    nine => '9',
    ten => '10',
    eleven => '11',
    twelve => '12',
    thirteen => '13',
    fourteen => '14',
    fifteen => '15',
    sixteen => '16',
    seventeen => '17',
    eighteen => '18',
    nineteen => '19',
    twenty => '20',
    thirty => '30',
    forty => '40',
    fifty => '50',
    sixty => '60',
    seventy => '70',
    eighty => '80',
    ninety => '90');

my %magnitude = (
    thousand => '1000',
    million => '1000000');

sub parse_number {
    my ($num_text, @text_numbers, $g, $x, $w, $n);
    $num_text = "nine hundred ninety nine thousand nine hundred ninety nine";
    @text_numbers = split(' ', $num_text);
    $g = 0;
    $n = 0;
    foreach $w (@text_numbers) {
        $x = $small{$w};
        if ($x) {
            $g += $x;
        } elsif ($w eq "hundred") {
            $g *= 100;
        } else {
            $x = $magnitude{$w};
            if ($x) {
                $n += $g * $x;
                $g = 0;
            }
        }
    }
    return $n + $g;
}

print parse_number();