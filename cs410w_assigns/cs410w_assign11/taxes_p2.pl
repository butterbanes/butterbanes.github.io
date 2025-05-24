#!/usr/bin/perl
use strict;
use warnings;
use CGI qw(:standard);

# This program is designed to do taxes for sinlg or married residents under
# Alabama state income tax
#
# Author: Ethan Smith
# Date: 02/16/2025
# Course: CS410W - Programming Languages
# Professor: Dr. Mark Terwilliger

print header();
print start_html(
    -title => "AL State Income Taxer",
    -head  => [ qq(<link rel="stylesheet" type="text/css" href="../../styles/style_main.css">) ]
    );

print "<div class=\"topnav\">\n";
print "<a href=\"../../index.html\">Home</a>\n";
print "<a href=\"../../cs410w_subpages/about.html\">About Me</a>\n";
print "<a href=\"../assignments.html\">Assignments</a>\n";
print "</div>\n";

print "<div class=\"tax_perl_form\">\n";
    my $firstName = param("fname");
    my $lastName = param("lname");
    my $filing = param("choice") // "";
    my $total_income = param("wages") // 0;
    my $tax_withheld = param("withheld") // 0;

    my $deduct = 0;
    my $tax_income = 0;
    my $tax_due = 0;
    my $refund = 0;
    my $oops_refund = 0;

    #ensure numeric data types
    $total_income += 0;
    $tax_withheld += 0;

    if ($filing eq "single") {
        $deduct = 1500;
    } else {
        $deduct = 3000;
    }

    #div: calc_tax
    print "<div class=\"calc_tax\">\n";
        
        $tax_income = $total_income - $deduct;
        if($tax_income < 0){
            $tax_income = 0;
            $tax_due = 0;
        }

        if($filing eq "single" && $tax_income > 0) {
 
            if ($tax_income <= 500) {
                $tax_due = $tax_income * 0.02;
            } elsif ($tax_income <= 3000) {
                $tax_due = ($tax_income-500) * 0.04 + 10;
            } else {
                $tax_due = (($tax_income-3000) * 0.05) + 110;
            }
  
        } elsif($filing eq "married" && $tax_income > 0) {
            
            if ($tax_income <= 1000) {
                $tax_due = $tax_income * 0.02;
            } elsif ($tax_income <= 6000) {
                $tax_due = ($tax_income-1000) * 0.04 + 20;
            } else {
                $tax_due = ($tax_income-6000) * 0.05 + 220;
            }

        }

    #end div class calc_tax
    print "</div>\n";

    
    #div: output_vars
    print "<div class=\"output_vars\">\n";
        print "<p>Deductions: \$$deduct</p>\n";
        print "<p>Taxable Income: \$$tax_income</p>\n";
        print "<p>Taxes Due: \$$tax_due</p>\n";
    #end div class output_vars
    print "</div>\n";
    
    #div: calc_refund
        
        print "<div class=\"calc_refund\">\n";
        $refund = $tax_withheld - $tax_due;
        if($refund >= 0) {
            print "<p>Your refund is: \$$refund</p>\n";
        }

        #check if user owes money or not
        if($refund < 0) {
            $oops_refund = (-1) * $refund;
            print "<p>Your refund is: -\$$oops_refund</p>\n";
            print "<p>Refund Negative | You Owe: \$$oops_refund to the state of Alabama</p>\n";
        }
    
    #end div class calc_refund
    print "</div>\n";

print "<p>Thank you for using TAXES $firstName $lastName\!</p><br><br>\n";

#end div class tax_perl_form
print "</div>\n";
print "<p>Go back to the <a href=\"../cs410w_assign10/part_b/taxes_form.html\">previous page</a> to start again</p>\n";
print end_html();
print "\n";
