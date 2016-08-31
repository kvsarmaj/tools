#! /usr/bin/perl

use Env;
use Getopt::Long;
use File::Basename;
use Cwd;
use Switch;
use strict;

my $proj_root = "/home/jkv/systemc_practice";
my $usage;
my $dump_log;
my $ifile;
my $mod;
my $top;
my $ofile;
my $dump_hier;
my $hier_file;

my @files;

GetOptions ("-help"            => \$usage,
            "-h"               => \$usage,
            "-log"             => \$dump_log,
	    "-m=s"             => \$mod,
	    "-i=s"             => \$ifile,
	    "-top"             => \$top,
	    "-o=s"             => \$ofile,
	    "-dump_hier"       => \$dump_hier,
	    "-hier_file=s"     => \$hier_file,
	);

if(defined $usage) { usage(); };
if(defined $dump_log) { $dump_log = 1; };
if(!(defined $ifile)) { 
    if(!(defined $mod)) { 
	die "Please specify file list\n"; 
    } else {
	$ifile = $proj_root."/rtl/".$mod.".rtl.files";
    };
};
if(!(defined $ofile)) {
    $ofile = "sig_list";
    if(!(defined $hier_file)) {
	$hier_file = "des_hier";
    };
};
if(!(defined $top)) {
    if(!(defined $mod)) {
	$top = $ifile;
	$top =~ s/.*\/(.*)$//;
	$top = $1;
	$top =~ s/\..*$//;
    } else {
	$top = $mod;
    }
    #print $top."\n";
    #find_hier_top();
}

#-------------------------------------------------------------------------------
#Build file list and hierarchy
#-------------------------------------------------------------------------------

build_file_list();
build_hier_tree();

#-------------------------------------------------------------------------------
#Build signal list
#-------------------------------------------------------------------------------


#-------------------------------------------------------------------------------
#Functions
#-------------------------------------------------------------------------------


#----------
#Help

sub usage() {
    print "Help meeeeee!\n";
    exit(1);
}

#----------
#build file list

sub build_file_list {
    gen_list("rtl");
    gen_list("tb");
    #print join "\n" => @files; print "\n";

}

sub gen_list {

    my $type = @_[0];
    my $fl = $proj_root."/".$top."/".$type."/".$top.".".$type.".files";

    open FRP, "<", $fl or die "Could not open $fl for reading : $!\n";
    my $cmt_blk = 0;
    my $cmt_line = 0;
    while(my $line = <FRP>) {
	if($cmt_blk == 0) {
	    if($line =~ m/^\/\*/) {
		$cmt_blk = 1;
	    } elsif($line =~ m/\/\*.*\*\//) {
		$line =~ s/\/\*.*\*\///;
		if($line =~ m/\*\//) {
		    $line =~ s/\/\*.*\*\///;
		}
	    } elsif($line =~ m/^\s*\/\//) {
		$cmt_line = 1;
	    }
	} elsif($cmt_blk == 1) {
	    if($line =~ m/\*\\$/) {
		$cmt_blk == 0;
	    }
	}
	if($cmt_blk == 0 && $cmt_line == 0) {
	    if($line =~ m/#include\s*/) {
		$line =~ s/#include\s*//;
		$line =~ s/<//;
		$line =~ s/\"//;
		$line =~ s/>$//;
		$line =~ s/"$//;
		chomp($line);
		$line = $proj_root."/".$top."/".$type."/".$line;
		push(@files, $line);
	    }
	}
	$cmt_line = 0;
    }
    close(FRP);
    my $line = $proj_root."/".$top."/".$type."/".$top.".cpp";
    push(@files, $line);

}

#----------
#build hierarchy tree

sub build_hier_tree {

    my $des_top = $proj_root."/".$top."/tb/".$top."_tb.cpp";
    my @lines;
    open FRP, "<", $des_top or die "Could not open $des_top for reading : $!\n";
    my $cmt_blk = 0;
    my $cmt_line = 0;
    while(my $line = <FRP>) {
	if($cmt_blk == 0) {
	    if($line =~ m/^\/\*/) {
		$cmt_blk = 1;
	    } elsif($line =~ m/\/\*.*\*\//) {
		$line =~ s/\/\*.*\*\///;
		if($line =~ m/\*\//) {
		    $line =~ s/\/\*.*\*\///;
		}
	    } elsif($line =~ m/^\s*\/\//) {
		$cmt_line = 1;
	    }
	} elsif($cmt_blk == 1) {
	    if($line =~ m/\*\\$/) {
		$cmt_blk == 0;
	    }
	}
	if($cmt_blk == 0 && $cmt_line == 0) {
	    #print $line."\n";
	    push(@lines, $line);
	    if($line =~ m/#include/) {
		my $inc_fl = $line;
		$inc_fl =~ s/#include\s*//;
		$inc_fl =~ s/>//;
		$inc_fl =~ s/<//;
		$inc_fl =~ s/"//;
		chomp($inc_fl);
		print $inc_fl."\n";
	    }
	}
	$cmt_line = 0;
    }
    close(FRP);
    #print @lines;

}

#----------
#build signal list

