From: "James Yonan" <jim@...41...>
Message-ID: <twig.1057855711.85674@...41...>
Subject: [Openvpn-devel] OpenVPN 1.4.2 release candidate, please test
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
Date: Thu Jul 10 11:48:34 2003
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

This is a maintenance release which (a) fixes the previously discussed ISO C99
vararg efficiency bug, and (b) further stabilizes the experimental
--mtu-dynamic option which causes OpenVPN to perform internal datagram
fragmentation in cases where native IP fragmentation is broken.

Testing will be helpful at this point, especially for non-x86-linux platforms.    

Download:

http://openvpn.sourceforge.net/beta/openvpn-1.4.1.9.tar.gz (or CVS)

Change Log:

* Removed adaptive bandwidth from
  --mtu-dynamic -- its absence appears
  to work better than its existence (1.4.1.2).
* Minor changes to --shaper to fix long
  retransmit timeouts at low bandwidth
  (1.4.1.2).
* Added LOG_RW flag to openvpn.h for
  debugging (1.4.1.2).
* Silenced spurious configure warnings (1.4.1.2).
* Backed out --dev-name patch, modified --dev
  to offer equivalent functionality (1.4.1.4).
* Added an optional parameter to --daemon and
  --inetd to support the passing of a custom
  program name to the system logger (1.4.1.5).
* Add compiled-in options to the program title
  (1.4.1.5).
* Coded the beginnings of a WIN32 port (1.4.1.5).
* Succeeded in porting to Win32 Mingw environment
  and running loopback tests (1.4.1.6).  Still
  need a kernel driver for full Win32
  functionality.
* Fixed a bug in error.h where
  HAVE_CPP_VARARG_MACRO_GCC was misspelled.
  This would have caused a significant slowdown
  of OpenVPN when built by compilers that
  lack ISO C99 vararg macros (1.4.1.6).
* Created an init script for Gentoo Linux
  in ./gentoo directory (1.4.1.6).

James


