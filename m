Message-Id: <200304170843.h3H8h0121046@...41...>
From: "James Yonan" <jim@...41...>
Subject: [Openvpn-devel] New beta available + progress update
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Thu Apr 17 01:45:39 2003
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net
Cc: Matthias Andree <matthias.andree@...68...>

OpenVPN continues to evolve, and I thought I would take this opportunity to
briefly describe some of the current directions in the project (which,
incidentally, has passed its 1 year milestone).

For one, a new OpenVPN beta is available and testing would be appreciated.

http://openvpn.sourceforge.net/beta/openvpn-1.3.2.21.tar.gz (or CVS)

Thanks to the stability of 1.3.2, I've held off on making a new release that's
composed entirely of minor changes, and have instead focussed on some bigger
issues such as making the handling of MTU and fragmentation more dynamic and
automatic.  To this end, the new beta contains a number of improvements to
allow for dynamic MTU resizing.  This code is still experimental, and must be
explicitly enabled by defining FRAGMENT_ENABLE and rebuilding.

What the FRAGMENT_ENABLE code does is to add an extra 4 byte header to each
datagram that includes, among other things, feedback on the number of
datagrams received as well as the maximum datagram size received.  This
information can then be used by an OpenVPN peer to dynamically set the MTU
size as well as the datagram transmit rate independently of the OS and the
proper functioning of path MTU discovery.  Ultimately this code can make
OpenVPN more robust in situations where fragmentation is necessary (such as in
TAP-based bridged ethernets) when firewalls or routers in the path break PMTU
discovery.

My thinking right now is to make the next release 1.4.0 but leave the
FRAGMENT_ENABLE code off by default.  Even with the FRAGMENT_ENABLE code
disabled, there's enough new stuff here to justify a point release.

As well, there are a fair number of minor changes as well (see the ChangeLog
at the end of this message).

Looking post-1.4.0, the latest wishlist appears to be:

(1) Simplify configuration for setups that involve one server and numerous
roving clients (some of this has already been addressed by the --inetd option).

(2) Dynamic MTU support.  Ultimately, the FRAGMENT_ENABLE code will do this,
but it still needs testing and more developer input.

(3) Porting to Windows.  Judging by email I receive, there seems to be a lot
of demand for this.  In addition, a lot of developers have come forward who
are interested in working on a TUN/TAP driver for Windows (which is the
missing link), but so far I haven't seen much progress.  I may jump into the
fray and work on this myself, though due to the higher costs of developing for
Windows, I would need some corporate sponsorship to help defray costs.  Let me
know if you are interested in sponsoring such an undertaking.

If there are wishlist items I have missed, or if there is something you would
like to add, please let us know.

And also, please be reminded that the OpenVPN project is financially supported
by the user community.  Please consider donating to the project.  More info is
available here:

http://openvpn.sourceforge.net/donate.html

James

**************

ChangeLog:

$Id: ChangeLog,v 1.69 2003/04/17 07:12:02 jimyonan Exp $

Upcoming version 1.4.0

* Added --replay-persist feature to allow replay
  protection across sessions.
* Fixed bug where --ifconfig could not be used
  with --tun-mtu.
* Added --tun-mtu-extra parameter to deal with
  the situation where a read on a TUN/TAP device
  returns more data than the device's MTU size.
* Fixed bug where some IPv6 support code for
  Linux was not being properly ifdefed out for
  Linux 2.2, causing compile errors.
* Added OPENVPN_EXIT_STATUS_x codes to
  openvpn.h to control which status value
  openvpn returns to its caller (such as
  a shell or inetd/xinetd) for various conditions.
* Added OPENVPN_DEBUG_COMMAND_LINE flag to
  openvpn.h to allow debugging in situations
  where stdout, stderr, and syslog cannot be used
  for message output, such as when OpenVPN is
  instantiated by inetd/xinetd.
* Removed owner-execute permission from file
  created by static key generator (Herbert Xu
  and Alberto Gonzalez Iniesta).
* Added --passtos option to allow IPv4 TOS bits
  to be passed from TUN/TAP input packets to
  the outgoing UDP socket (Craig Knox).
* Added code to prevent open socket file descriptors
  from being accessible to called scripts.
* Added --dev-name option (Christian Lademann).
* Added --mtu-disc option for manual control
  over MTU options.
* Show OS MTU value on UDP socket write failures
  (linux only).
* Numerous build system and portability
  fixes (Matthias Andree).
* Added better sensing of compiler support for
  variable argument macros, including (a) gcc
  style, (b) ISO C 1999 style, and (c) no support.
* Removed generated files from CVS.  Note INSTALL
  file for new CVS build commands.
* Changed all internal _* symbols to x_*
  for C standards compliance.
* Added TUN/TAP open code to cycle dynamically
  through unit numbers until it finds a free
  unit (based on code from Thomas Gielfeldt
  and VTun).
* Added dynamic MTU and fragmenting infrastructure
  (Experimental).  Rebuild with FRAGMENT_ENABLE
  defined to enable.
* Minor changes to SSL/TLS negotiation, use
  exponential backoff on retransmits, and use
  a smaller MTU size (note that no protocol
  changes have been made which would break
  compatibility with 1.3.x).
* Added --enable-strict-options flag
  to ./configure.  This option will cause
  a more strict check for options compatibility
  between peers when SSL/TLS negotiation is used,
  but should only be used when both OpenVPN peers
  are of the same version.
* Reorganization of debugging levels >= 5.



