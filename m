Message-Id: <200305080506.h48565110773@...41...>
From: "James Yonan" <jim@...41...>
Subject: [Openvpn-devel] 1.4.0 Released
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
Date: Wed May  7 22:07:08 2003
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-announce@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

Download:

http://sourceforge.net/projects/openvpn/

Release Notes:

This release adds options for persistence of replay protection information
across sessions, pass through of IPv4 TOS bits from the TUN/TAP device to the
UDP link, some advanced MTU control options, moderate revamping of the build
system to improve portability, and misc bug fixes and web site additions.

Also new is a major restructuring of MTU and fragmentation handling. Much of
this code is experimental and must be explicitly enabled by defining
FRAGMENT_ENABLE and rebuilding.

Change Log:

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
* Reorganization of debugging levels.
* Added a workaround in configure.ac for
  default SSL header location on Linux
  to fix RH9 build problem.
* Fixed potential deadlock when pthread support
  is used on OSes that allocate a small socketpair()
  message buffer.
* Fixed openvpn.init to be sh compliant
  (Bishop Clark).
* Changed --daemon to wait until all
  initialization is finished before becoming a
  daemon, for the benefit of initialization
  scripts that want a useful return status from
  the openvpn command.
* Made openvpn.init script more robust, including
  positive indication of initialization errors
  in the openvpn daemon and better sanity checks.
* Changed --chroot to wait until initialization
  is finished before calling chroot(), and allow
  the use of --user and --group with --chroot.
* When syslog logging is enabled (--daemon or
  --inetd), set stdin/stdout/stderr to point
  to /dev/null.
* For inetd instantiations, dup socket descriptor
  to a >2 value.
* Fixed bug in verify-cn script, where test would
  incorrectly fail if CN=x was the last component
  of the X509 composite string (Anonymous).
* Added Markus F.X.J. Oberhumer's special
  license exception to COPYING.

James




