Message-ID: <43B3B3A4.4080807@...277...>
From: Alon Bar-Lev <alon.barlev@...277...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Reading PIN for PKCS#11 from file
References: <20051228134659.GA5600@...522...>
In-Reply-To: <20051228134659.GA5600@...522...>
Content-Type: multipart/mixed;
 boundary="------------010006010709050703030102"
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Thu Dec 29 02:02:09 2005
To: Ondra Medek <ondrejm@...522...>
Cc: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------010006010709050703030102
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ondra Medek wrote:
> Hi,
> 
> I like PKCS#11 support in new OpenVPN 2.1beta7. But I need to start client
> using eToken without user interaction, i.e. to read the user PIN from a
> file. A have already made a very simple hack to the pkcs11.c - the name of
> the file storing the PIN is hardcoded, see end of the post. I like to have
> this feature in the future releases of the OpenVPN. If you want, I can try
> to implemented it better. My ideas are

Hello,

Why don't you use the management interface?
I use this interface in order to graphically prompt for 
PIN... You can easily adjust this to reply a static PIN.

Best Regards,
Alon Bar-Lev.

--------------010006010709050703030102
Content-Type: text/plain; name="openvpn-kde-dialogs.pl.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="openvpn-kde-dialogs.pl.txt"

#!/usr/bin/perl
#
# This script provides a simple interface for OpenVPN management.
# It allows a KDE user to handle the following commands:
# - hold
# - need-ok
# - password
#
# In order to use this script specify the following options at
# OpenVPN configuration file:
#     management-hold
#     management 127.0.0.1 2222
#     management-query-passwords
#
# The best place to run this script is at .kde/Autostart, put
# the following script at this location:
#     #!/bin/sh
#     exec openvpn-kde-dialogs.pl 2222
#
# The script will signal openvpn into hold state when the
# user logoffs.
#
# History:
# 2005-11-03, Alon Bar-Lev (alon.barlev@...277...)
#     Written.
#

use strict;
use Net::Telnet;

my $FALSE = 0;
my $TRUE = (!$FALSE);

my $t = new Net::Telnet;
my $fInHold = $FALSE;

$SIG{'INT'} = $SIG{'STOP'} = $SIG{'TERM'} = $SIG{'QUIT'} = $SIG{'HUP'} = sub {
	if (!$fInHold) {
		$t->print ("signal SIGUSR1");
	}
	exit (1);
};

main (@ARGV);

sub main {
	my (
		$port
	) = @_;

	my $fShouldConnect = $TRUE;

	if ($port eq undef) {
		printf STDERR ("usage: $0 port\n");
		exit (1);
	}

	while ($TRUE) {
		while ($fShouldConnect) {
			my $r = $t->open (
				host => "localhost",
				port => $port,
				errmode => "return"
			);

			if ($r == undef) {
				sleep (5);
			}
			else {
				$fShouldConnect = $FALSE;
			}
		}

		my ($pre, $match) = $t->waitfor (
			string => ">HOLD:",
			string => ">PASSWORD:",
			string => ">NEED-OK:",
			errmode => "return",
			timeout => 60
		);
		if ($match eq undef) {
			my $msg = $t->errmsg;
			if ($msg =~ /eof/) {
				$fShouldConnect = $TRUE;
			}
		}
		elsif ($match eq ">HOLD:") {
			$fInHold = $TRUE;
			do {
				`kdialog --title \"OpenVPN\" --yesno \"Release hold\"`;
			} while ($? != 0);
			$t->print ("hold release");
			$fInHold = $FALSE;
		}
		elsif ($match eq ">NEED-OK:") {
			my $line = $t->getline ();
			$line =~ /.*'(.*)'.* MSG:(.*)/;
			my $req = $1;
			my $msg = $2;

			`kdialog --title \"OpenVPN\" --yesno \"$msg\"`;
			if ($? == 0) {
				$t->print ("needok \"$req\" ok");
			}
			else {
				$t->print ("needok \"$req\" cancel");
			}
		}
		elsif ($match eq ">PASSWORD:") {
			my $line = $t->getline ();
			$line =~ /.*'(.*)'.*/;
			my $req = $1;
			my $pass = `kdialog --title \"OpenVPN\" --password \"$req password:\"`;
			if ($? == 0) {
				$pass =~ s/[\r\n]//g;
			}
			else {
				$pass = "";
			}
			$t->print ("password \"$req\" \"$pass\"");
		}
	}
}


--------------010006010709050703030102--

