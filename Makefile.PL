
use strict;
use warnings;



use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  "ABSTRACT" => "API to access a directory which can be served as CPAN repository",
  "AUTHOR" => "Torsten Raudssus <torsten\@raudss.us> L<http://raudss.us/>",
  "BUILD_REQUIRES" => {
    "File::Temp" => "0.22",
    "Test::More" => "0.96"
  },
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.30"
  },
  "DISTNAME" => "CPAN-Repository",
  "EXE_FILES" => [],
  "LICENSE" => "perl",
  "NAME" => "CPAN::Repository",
  "PREREQ_PM" => {
    "DateTime" => "0.72",
    "Dist::Data" => "0.002",
    "File::Path" => "2.08",
    "IO::File" => "1.25",
    "IO::Zlib" => "1.10",
    "Moo" => "0.009013",
    "PathTools" => "3.33",
    "utf8::all" => 0
  },
  "VERSION" => "0.001",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



