Message-ID: <436A53B1.8040306@...277...>
From: Alon Bar-Lev <alon.barlev@...277...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] pkcs11-protected-authentication not working in
 2.1beta4 ?
References: <43662220.3000807@...486...> <43665747.5000502@...277...> <436739A2.7020702@...486...> <4367A449.8000105@...277...> <4368D5B8.9040204@...486...>
In-Reply-To: <4368D5B8.9040204@...486...>
Content-Type: multipart/mixed;
 boundary="------------050000050201090403090106"
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
Date: Thu Nov  3 10:19:52 2005
To: Albert Siersema <appie@...486...>
Cc: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------050000050201090403090106
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Albert Siersema wrote:
>>I will write a simple perl script that does it for you soon...
> 
> If I come up with a non-perl but GUI-y like solution i'll post it to the
> list as well.

Well... I don't work with Windows...
So attached is a simple perl script that helps me interact 
with OpenVPN.

I hope some will find it useful!

-----------------------------------------------------------

This script provides a simple interface for OpenVPN management.
It allows a KDE user to handle the following commands:
- hold
- need-ok
- password

In order to use this script specify the following options at
OpenVPN configuration file:
     management-hold
     management 127.0.0.1 2222
     management-query-passwords

The best place to run this script is at .kde/Autostart, put
the following script at this location:
     #!/bin/sh
     exec openvpn-kde-dialogs.pl 2222

The script will signal openvpn into hold state when the
user logoffs.

Best Regards,
Alon Bar-Lev.

--------------050000050201090403090106
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

$SIG{'INT'} = $SIG{'STOP'} = $SIG{'TERM'} = $SIG{'QUIT'} = $SIG{'HUP'} = sub {
	$t->print ("signal SIGUSR1");
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
			timeout => 2
		);
		if ($match eq undef) {
			my $msg = $t->errmsg;
			if ($msg =~ /eof/) {
				$fShouldConnect = $TRUE;
			}
		}
		elsif ($match eq ">HOLD:") {
			do {
				`kdialog --title \"OpenVPN\" --yesno \"Release hold\"`;
			} while ($? != 0);
			$t->print ("hold release");
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


--------------050000050201090403090106--

