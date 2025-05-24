#!/usr/bin/perl
use CGI qw(:standard);

print header();
print start_html();
    $length = param("length");

    $width = param("width");

    $choice = param("choice");

    print "<h1>Computed Rectangle</h1>\n";

    if($choice eq "A"){
        $area = $length * $width;
        print "<h2>Area: $area</h2>\n";
    } else {
        $perimeter = (2 * $length) + (2 * $width);
        print "<h2>Perimeter: $perimeter</h2>\n";
    }
print end_html();
