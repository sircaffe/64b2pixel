#!/usr/bin/perl

use warnings;

@files = ("main.c");

sub usage {
    print "Usage: ./build.pl [option] <sub-command>\n";
    print "    test           - run all available tests\n";
    print "    test <which>   - test single unit\n";
    print "    check          - checks project integrity\n";
    print "    clean          - clean files generated by this script\n";
    print "    help           - show this help message\n";
}

sub compile {
    print `clang main.c`;
    my $exit_code = `echo $?`;
    if ($exit_code == 0) {
        printf "Compilation finished\n";
    } else {
        printf "Compilation exited abruptly with code %s\n", $exit_code;
    }
}

sub check_integrity {
    for (my $i = 0; $i < scalar(@files); ++$i) {
        if (-e $files[$i]) {
            print $files[$i], ": OK\n"
        } else {
            print $files[$i], ": MISSING\n"
        }
    }
}

if (scalar(@ARGV) > 2) {
    print "Too many arguments\n";
    exit(1);
} elsif (scalar(@ARGV) > 0) {
    if ($ARGV[0] eq "test") {
        if (scalar(@ARGV) > 1 ) {
            if ($ARGV[1] eq "bebop") {
                print "Bebop!\n";
                exit(0)
            } else {
                print "Invalid test: ", $ARGV[1], "\n";
                exit(1);
            }
        }
        print "No test available yet\n";
        exit(0);
    } elsif ($ARGV[0] eq "check") {
        check_integrity();
    } elsif ($ARGV[0] eq "clean") {
        print `rm a.out -v` or die("test");
    } elsif ($ARGV[0] eq "help") {
        usage();
    } else {
        print "Invalid option\n";
        usage();
        exit(1);
    }
} else {
    compile();
}
