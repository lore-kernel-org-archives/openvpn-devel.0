Message-Id: <200303150747.h2F7lE427908@...41...>
From: "James Yonan" <jim@...41...>
Subject: [Openvpn-devel] New pre-1.3.3 beta
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
Date: Fri Mar 14 23:48:09 2003
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

If you have a chance, please test this beta.  I mostly use linux 2.4 for
development, so I don't have much of a chance to test on linux 2.2 and
non-linux OSes.

Since the last beta announcement on this list, there's been a bunch of changes
including build system portability fixes, --dev-name, and --mtu-disc.  The
latter gives access to a linux system call that allows some manual control
over how and whether Path MTU Discovery is implemented on the UDP socket.

You can download via CVS or from a tarball:

http://openvpn.sourceforge.net/beta/openvpn-1.3.2.17.tar.gz

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

James


