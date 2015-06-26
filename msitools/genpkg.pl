#!/usr/bin/env perl
use strict;
use warnings;

use Template;
my $tt = Template->new(STRICT => 1);
open my $fh, '>', 'installer.wxs' or die $!;
$tt->process('installer.tt2', {
  product => {
   name => "Some app",
   description => "Description re",
   version => "1.0.0",
   uuid => uc("fffa9f1b-448f-4e30-8118-0eb906e33b21"),
   upgrade_uuid => uc("d684f3e1-d4b5-4e73-baaa-5650456b56cf"),
   company => "Some company",
   copyright => "copyright info",
  },
  program => {
   uuid => uc("dd2bc45b-4eb1-40aa-ab7e-f4bbed38f7b2"),
   executable => "someapp.exe",
  }
}, $fh) or die $tt->error;
system(qw{wixl -v installer.wxs}) and die $!;
die 'not output' unless -r 'installer.msi';

