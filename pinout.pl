#!/usr/bin/perl -w 
#
# Pinouts for ATtiny45, ATtiny2313, ATmega8, ATmega32
#
# on Debian / Ubuntu you can install these packages:
#
# $ sudo apt-get -y install libxml-libxml-perl

use strict;
use warnings;

use utf8;

use Data::Dumper;

use File::Find;
use File::stat;
use File::Path;
use File::Basename;

use Getopt::Long qw(GetOptions);

use JSON -support_by_pp;

use Term::ANSIColor qw(:constants);

use XML::LibXML;

binmode(STDOUT, ":utf8");
binmode(STDERR, ":utf8");

local $| = 1; # auto flush

my $cmd; # cmd, see "cmds" above

my $res; # comma sep. list of resolutions for png output
my $out; # rel. dir path to output

GetOptions(
    "cmd=s" => \$cmd,
    "out=s" => \$out,
    );

my $cmds = "help|pinout|png2png|svg2svg|example";

sub u {
    my $app = $0; my $err = shift;
    print STDERR << "USAGE";
 usage:
      $app --cmd [$cmds] --out [dir]

USAGE
    if (defined $err) {
		stderr(" ".RED."error:".RESET." ".$err." Exiting.\n\n"); exit 1;
    }
	exit 0;
}

if (!$cmd)               {u("missing  --cmd.")}
if ($cmd eq "help")      {u()}
if ($cmd !~ /^($cmds)$/) {u("valid --cmd [$cmds]")}

# bg and fill
my $bg = "#f8f8f8"; my $fill = "#ffffff";

if ($cmd eq "pinout") {
	my $subcmd = shift || "list";

	if ($subcmd eq "list" or $subcmd eq "help") {
		stderr("Available --cmd pinout commands:\n\n");

		stderr(" m8      - ATmega8    pinout.\n");
		stderr(" m32     - ATmega32   pinout.\n");
		stderr(" t45      - ATtiny45   pinout.\n");
		stderr(" t2313    - ATtiny2313 pinout.\n");
		stderr("\n");
	} elsif ($subcmd eq "m8") {
		pinout_m8();
	} elsif ($subcmd eq "m32") {
		pinout_m32();
	} elsif ($subcmd eq "t45") {
		pinout_t45();
	} elsif ($subcmd eq "t2313") {
		pinout_t2313();
	}
}

sub pinout_t45 {
    if (!$out)   {u("missing --out [dir], eg.: build.")}
    if (!-d $out){u("--out dir \"".$out."\" does not exist.")}
	my $file = $out."/t45.svg";

    my $doc = XML::LibXML::Document->new("1.0", "UTF-8");
    my $svg = $doc->createElement("svg"); $doc->setDocumentElement($svg);
    $svg->setAttribute("id", "svg2"); $svg->setAttribute("version", "1.1");

	my ($resX, $resY) = (1180, 260);
    $svg->setAttribute("width", $resX); $svg->setAttribute("height", $resY);
    $svg->setAttribute("xmlns:svg",	"http://www.w3.org/2000/svg");
    $svg->setAttribute("xmlns:xlink", "http://www.w3.org/1999/xlink");

	# background
	$svg->appendChild(svg_rect(0, 0, $resX, $resY,undef,undef,"fill:".$bg));

	for my $x ((444, 609)) {
		for (my $y = 0; $y < 4; $y++) {
			$svg->appendChild(
				svg_rect($x, 103 + $y * 32, 16, 16, 0, 0,
						 "fill:".$fill.";stroke:#000000;stroke-width:2"));
		}
	}

	# pin names left
	my @pnl = ("(PCINT5/RESET/ADC0/dW) PB5",
			   "(PCINT3/XTAL1/CLKI/OC1B/ADC3) PB3",
			   "(PCINT4/XTAL2/CLKO/OC1B/ADC2) PB4",
			   "GND");
	for (my $p = 1; $p <= 4; $p++) {
		$svg->appendChild(svg_text(444-8, 102+($p-1)*32+16,$pnl[$p-1],"r"));
	}

	# pin names right
	my @pnr = ("VCC",
			   "PB2 (SCK/USCK/SCL/ADC1/T0/INT0/PCINT2)",
			   "PB1 (MISO/DO/AIN1/OC0B/OC1A/PCINT1)",
			   "PB0 (MOSI/DI/SDA/AIN0/OC0A/OC1A/AREF/PCINT0)");
	for (my $p = 1; $p <= 4; $p++) {
		$svg->appendChild(svg_text(610+24, 102+($p-1)*32+16,$pnr[$p-1],"l"));
	}

	my $case = svg_rect(460, 86, 150, 147, 5, 5,
						  "fill:#ffffff;stroke:#000000;stroke-width:3");
    $svg->appendChild($case);

	# pin numbers left
	for (my $p = 1; $p <= 4; $p++) {
		$svg->appendChild(svg_text(449+32-8, 102+($p-1)*32+16,$p));
	}
	# pin numbers right
	for (my $p = 1; $p <= 4; $p++) {
		$svg->appendChild(svg_text(606-32, 102+($p - 1)*32+16, 9-$p));
	}
	# title
	$svg->appendChild(svg_text(534, 62, "ATtiny45", "c"));
	# cut
	$svg->appendChild(svg_path("m 555,87 a 20,20 0 1 1 -40,0",
							   "fill:".$fill.";stroke:black;stroke-width:4"));
	# ^RESET (PB5)
	$svg->appendChild(svg_line(208, 98, 69, 0,"stroke:black;stroke-width:2"));
	# ^OC1B (PB3)
	$svg->appendChild(svg_line(258, 132, 60, 0,"stroke:black;stroke-width:2"));
	# ^OC1A (PB0)
	$svg->appendChild(svg_line(943, 195, 60, 0,"stroke:black;stroke-width:2"));

    writeFile($file, $doc->toString());

	stderr(" ".GREEN."ok".RESET.".\n\n");
}

sub pinout_t2313 {
    if (!$out)   {u("missing --out [dir], eg.: build.")}
    if (!-d $out){u("--out dir \"".$out."\" does not exist.")}
	my $file = $out."/t2313.svg";

    my $doc = XML::LibXML::Document->new("1.0", "UTF-8");
    my $svg = $doc->createElement("svg"); $doc->setDocumentElement($svg);
    $svg->setAttribute("id", "svg2"); $svg->setAttribute("version", "1.1");

	my ($resX, $resY) = (772, 460);
    $svg->setAttribute("width", $resX); $svg->setAttribute("height", $resY);
    $svg->setAttribute("xmlns:svg",	"http://www.w3.org/2000/svg");
    $svg->setAttribute("xmlns:xlink", "http://www.w3.org/1999/xlink");

	# background
	$svg->appendChild(svg_rect(0, 0, $resX, $resY,undef,undef,"fill:".$bg));

	for my $x ((294, 459)) {
		for (my $y = 0; $y <= 9; $y++) {
			$svg->appendChild(
				svg_rect($x, 103 + $y * 32, 16, 16, 0, 0,
						 "fill:".$fill.";stroke:#000000;stroke-width:2"));
		}
	}

	# pin names left
	my @pnl = ("(RESET/dW) PA2", "(RXD) PD0", "(TXD) PD1", "(XTAL2) PA1",
			   "(XTAL1) PA0", "(CKOUT/XCK/INT0) PD2", "(INT1) PD3",
			   "(T0) PD4", "(OC0B/T1) PB5", "GND" );
	for (my $p = 1; $p <= 10; $p++) {
		$svg->appendChild(svg_text(284-8, 102+($p-1)*32+16,$pnl[$p-1],"r"));
	}

	# pin names right
	my @pnr = ("VCC", "PB7 (UCSK/SCL/PCINT7)", "PB6 (MISO/DO/PCINT6)",
			   "PB5 (MOSI/DO/PCINT6)", "PB4 (OC1B/PCINT4)", "OC1A (PCINT3)",
			   "PB2 (PC0A/PCINT2)", "PB1 (AIN1/PCINT1)", "PB0 (AIN0/PCINT0)",
			   "PD6 (ICP)");
	for (my $p = 1; $p <= 10; $p++) {
		$svg->appendChild(svg_text(470+24, 102+($p-1)*32+16,$pnr[$p-1],"l"));
	}

	my $case = svg_rect(310, 94, 150, 323, 5, 5,
						  "fill:#ffffff;stroke:#000000;stroke-width:3");
    $svg->appendChild($case);

	# pin numbers left
	for (my $p = 1; $p <= 10; $p++) {
		$svg->appendChild(svg_text(294+32-8, 102+($p-1)*32+16,$p));
	}
	# pin numbers right
	for (my $p = 1; $p <= 10; $p++) {
		$svg->appendChild(svg_text(460-32, 102+($p - 1)*32+16, 21-$p));
	}
	# title
	$svg->appendChild(svg_text(384, 62, "ATtiny2313", "c"));
	# cut
	$svg->appendChild(svg_path("m 405,94 a 20,20 0 1 1 -40,0",
							   "fill:".$fill.";stroke:black;stroke-width:4"));
	# ^reset (PC6)
	$svg->appendChild(svg_line(112, 98, 69, 0,"stroke:black;stroke-width:2"));

    writeFile($file, $doc->toString());

	stderr(" ".GREEN."ok".RESET.".\n\n");
}

sub pinout_m8 {
    if (!$out)   {u("missing --out [dir], eg.: build.")}
    if (!-d $out){u("--out dir \"".$out."\" does not exist.")}
	my $file = $out."/m8.svg";

    my $doc = XML::LibXML::Document->new("1.0", "UTF-8");
    my $svg = $doc->createElement("svg"); $doc->setDocumentElement($svg);
    $svg->setAttribute("id", "svg2"); $svg->setAttribute("version", "1.1");

	my ($resX, $resY) = (792, 653);
    $svg->setAttribute("width", $resX); $svg->setAttribute("height", $resY);
    $svg->setAttribute("xmlns:svg",	"http://www.w3.org/2000/svg");
    $svg->setAttribute("xmlns:xlink", "http://www.w3.org/1999/xlink");

	# background
	$svg->appendChild(svg_rect(0, 0, $resX, $resY,undef,undef,"fill:".$bg));

	for my $x ((284, 470)) {
		for (my $y = 0; $y <= 13; $y++) {
			$svg->appendChild(
				svg_rect($x, 125 + $y * 34, 16, 16, 0, 0,
						 "fill:".$fill.";stroke:#000000;stroke-width:2"));
		}
	}

	# pin names left
	my @pnl = ("(RESET) PC6", "(RXD) PD0", "(TXD) PD1", "(INT0) PD2",
			   "(INT1) PD3", "(XCK/T0) PD4", "VCC", "GND", "(XTAL1/TOSC1) PB6",
			   "(XTAL2/TOSC2) PB7", "(T1) PD5", "(AIN0) PD6", "(AIN1) PD7",
				"(ICP1) PB0" );
	for (my $p = 1; $p <= 14; $p++) {
		$svg->appendChild(svg_text(284-8,   124+($p-1)*34+16,$pnl[$p-1],"r"));
	}

	# pin names right
	my @pnr = ("PC5 (ADC5/SCL)", "PC4 (ADC4/SDA)", "PC3 (ADC3)", "PC2 (ADC2)",
			   "PC1 (ACD1)", "PC0 (ADC0)", "GND", "AREF", "AVCC", "PB5 (SCK)",
			   "PB4 (MISO)", "PB3 (MOSI/OC2)", "PB2 (SS/OC1B)", "PB1 (OC1A)");
	for (my $p = 1; $p <= 14; $p++) {
		$svg->appendChild(svg_text(470+24, 124+($p-1)*34+16,$pnr[$p-1],"l"));
	}

	my $case = svg_rect(300, 93, 170, 522, 5, 5,
						"fill:#ffffff;stroke:#000000;stroke-width:3");
    $svg->appendChild($case);

	# pin numbers left
	for (my $p = 1; $p <= 14; $p++) {
		$svg->appendChild(svg_text(284+32-8,124+($p-1)*34+16,$p));
	}
	# pin numbers right
	for (my $p = 1; $p <= 14; $p++) {
		$svg->appendChild(svg_text(470-32, 124+($p - 1) * 34 + 16, 29-$p));
	}
	# title
	$svg->appendChild(svg_text(384, 62, "ATmega8", "c"));
	# cut
	$svg->appendChild(svg_path("m 405,94 a 20,20 0 1 1 -40,0",
							   "fill:".$fill.";stroke:black;stroke-width:4"));
	# ^reset (PC6)
	$svg->appendChild(svg_line(148, 120, 72, 0,"stroke:black;stroke-width:2"));
	# ^ss (PB2)
	$svg->appendChild(svg_line(549, 528, 29, 0,"stroke:black;stroke-width:2"));

    writeFile($file, $doc->toString());

	stderr(" ".GREEN."ok".RESET.".\n\n");
}

sub pinout_m32 {
    if (!$out)   {u("missing --out [dir], eg.: build.")}
    if (!-d $out){u("--out dir \"".$out."\" does not exist.")}
	my $file = $out."/m32.svg";

    my $doc = XML::LibXML::Document->new("1.0", "UTF-8");
    my $svg = $doc->createElement("svg"); $doc->setDocumentElement($svg);
    $svg->setAttribute("id", "svg2"); $svg->setAttribute("version", "1.1");

	my ($resX, $resY) = (610, 860);
    $svg->setAttribute("width", $resX); $svg->setAttribute("height", $resY);
    $svg->setAttribute("xmlns:svg",	"http://www.w3.org/2000/svg");
    $svg->setAttribute("xmlns:xlink", "http://www.w3.org/1999/xlink");

	# background
	$svg->appendChild(svg_rect(0, 0, $resX, $resY,undef,undef,"fill:".$bg));

	for my $x ((209, 395)) {
		for (my $y = 0; $y < 20; $y++) {
			$svg->appendChild(
				svg_rect($x, 125 + $y * 34, 16, 16, 0, 0,
						 "fill:".$fill.";stroke:#000000;stroke-width:2"));
		}
	}

	# pin names left
	my @pnl = ("(XCK/T0) PB0", "(T1) PB1", "(INT2/AIN0) PB2", "(OC0/AIN1) PB3",
			   "(SS) PB4", "(MOSI) PB5", "(MISO) PB6", "(SCK) PB7",
			   "RESET", "VCC", "GND", "XTAL2", "XTAL1", "(RXD) PD0",
			   "(TXD) PD1", "(INT0) PD2", "(INT1) PD3", "(OC1B) PD4",
			   "(OC1A) PD5", "(ICP1) PD6");
	for (my $p = 1; $p <= 20; $p++) {
		$svg->appendChild(svg_text(210-8,   124+($p-1)*34+16,$pnl[$p-1],"r"));
	}

	# pin names right
	my @pnr = ("PA0 (ADC0)", "PA1 (ADC1)", "PA2 (ADC2)", "PA3 (ADC3)",
			   "PA4 (ACD4)", "PA5 (ADC5)", "PA6 (ADC6)", "PA7 (ADC7)",
			   "AREF", "GND", "AVCC", "PC7 (TOSC2)", "PC6 (TOSC1)",
			   "PC5 (TDI)", "PC4 (TDO)", "PC3 (TMS)", "PC2 (TCK)",
			   "PC1 (SDA)", "PC0 (SCL)", "PD7 (OC2)");
	for (my $p = 1; $p <= 20; $p++) {
		$svg->appendChild(svg_text(400+24, 124+($p-1)*34+16,$pnr[$p-1],"l"));
	}

	my $case = svg_rect(225, 93, 170, 722, 5, 5,
						"fill:#ffffff;stroke:#000000;stroke-width:3");
    $svg->appendChild($case);

	# pin numbers left
	for (my $p = 1; $p <= 20; $p++) {
		$svg->appendChild(svg_text(214+32-8,124+($p-1)*34+16,$p));
	}
	# pin numbers right
	for (my $p = 1; $p <= 20; $p++) {
		$svg->appendChild(svg_text(390-32, 124+($p - 1) * 34 + 16, 41-$p));
	}
	# title
	$svg->appendChild(svg_text(308, 62, "ATmega32", "c"));
	# cut
	$svg->appendChild(svg_path("m 330,94 a 20,20 0 1 1 -40,0",
							   "fill:".$fill.";stroke:black;stroke-width:4"));
	# ^RESET
	$svg->appendChild(svg_line(130, 394, 72, 0,"stroke:black;stroke-width:2"));
	# ^SS PB4
	$svg->appendChild(svg_line(119, 258, 29, 0,"stroke:black;stroke-width:2"));

    writeFile($file, $doc->toString());

	stderr(" ".GREEN."ok".RESET.".\n\n");
}

sub svg_line {
	my ($x, $y, $w, $h, $s) = @_;

    my $l = XML::LibXML::Element->new("path");
    $l->setAttribute("d", "M ".$x.",".$y." ".($x+$w).",".($y+$h));
	$l->setAttribute("style", $s);

	return $l;
}

sub svg_text {
	my ($mX, $mY, $mT, $mS) = @_;

	my $ff = ";display:inline;font-family:FreeSans";

	if (!defined $mS) { $mS = "font-size:22.0;text-align:right;text-anchor:righ;fill:#000000".$ff; };

	if ($mS eq "r") {
		$mS = "font-size:22.0;text-align:end;text-anchor:end;fill:#000000;display:inline".$ff;
	} elsif ($mS eq "l") {
	  $mS = "font-size:22.0;text-align:left;text-anchor:left;fill:#000000".$ff;
	} elsif ($mS eq "c") {
	  $mS = "font-size:36.0;text-align:center;text-anchor:middle;fill:#000000;font-weight:bold".$ff;
	}

    my $text = XML::LibXML::Element->new("text");
#    $text->setAttribute("id",    "text_");
    $text->setAttribute("x", $mX);
    $text->setAttribute("y", $mY);
	$text->setAttribute("style", $mS);

	$text->appendText($mT);

	return $text;
}

sub svg_path {
	my ($mD, $mS) = @_;

	my $p = XML::LibXML::Element->new("path");

	$p->setAttribute("d", $mD);
	$p->setAttribute("style", $mS);

	return $p;
}

sub svg_rect {
	my ($mX, $mY, $mW, $mH, $mrX, $mrY, $mS) = @_;

	if (!defined $mS) { $mS = "fill:none;stroke:#000000;stroke-width:3";}

    my $rect = XML::LibXML::Element->new("rect");
    $rect->setAttribute("x", $mX);
    $rect->setAttribute("y", $mY);
    $rect->setAttribute("width", $mW);
    $rect->setAttribute("height", $mH);
	if (defined $mrX)  { $rect->setAttribute("rx", $mrX); }
    if (defined $mrY) { $rect->setAttribute("ry", $mrY); }
	$rect->setAttribute("style", $mS);
    
	return $rect;
}

sub sec2human {
    my $s = shift;
    if    ($s >= 365*24*60*60) { return sprintf '%.1fy', $s/(365+*24*60*60)}
    elsif ($s >=     24*60*60) { return sprintf '%.1fd', $s/(24*60*60) }
    elsif ($s >=        60*60) { return sprintf '%.1fh', $s/(60*60) }
    elsif ($s >=           60) { return sprintf '%.1fm', $s/(60) }
    else                       { return sprintf '%.1fs', $s  }
}

sub fileAge {
    my $fName = shift;

    my $age = -M $fName; $age *= 24*60*60;

#    return sec2human($age);
    return $age;
}

sub writeFile {
    my $fName = shift;
    my $content = shift;
    my $binmode = shift;

    stderr(" ".GREEN."writing ".$fName.RESET."\n");

    my ($filename, $dirs, $suffix) = fileparse($fName);
    if (! -d $dirs ) {
        mkpath($dirs);
    }

    open FILE, ">$fName" or die " Error writing file $fName: $!. Exiting.";
    if (defined $binmode) {
		binmode(FILE, $binmode);
    }
    print FILE $content;
    close FILE;
}

sub readFile {
    my $fName = shift;

    local $/=undef;

    open FILE, $fName or return undef;
    binmode FILE;

    my $string = <FILE>;
    close FILE;

    return $string;
}

sub cmd_exec {
    my $cmd = shift;

    my $out = `$cmd`; my $ret = ${^CHILD_ERROR_NATIVE};

    if ($ret eq 0) {
	print STDERR " ".$cmd." # ".GREEN."ok".RESET."\n";
    } else {
	print STDERR " ".$cmd." # ".RED."fail".RESET.": ".$out."\n";
	exit 1;
    }
}

sub stderr { print STDERR shift; } sub stdout { print STDOUT shift; }

1;
