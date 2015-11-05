#!/usr/bin/perl

use strict;
use warnings FATAL => 'all';
use Data::Dumper;


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
    $num_text = shift;
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

my ($filename, $fh, $line, %num_line , @nums, $key, $num, @nums_sorted);

$filename = $ARGV[0];
open($fh, '<:encoding(UTF-8)', $filename)
    or die "Could not open file '$filename' $!";

while ($line = <$fh>) {
    chomp $line;
    $num = parse_number($line);
    push @nums, $num;
    $num_line{$num} = $line;
}

@nums_sorted = sort {$b <=> $a} @nums;

foreach $key (@nums_sorted) {
    print "$num_line{$key}\n"
}