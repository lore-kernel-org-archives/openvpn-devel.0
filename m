Message-ID: <00e901c20193$54b62a40$1000000a@...4...>
From: "James Yonan" <jim@...3...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN 1.2.0 Released
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=openvpn-devel>
Date: Wed May 22 06:19:12 2002
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net, openvpn-announce@lists.sourceforge.net

Download:

http://prdownloads.sourceforge.net/openvpn/openvpn-1.2.0.tar.gz

Release Notes:

OpenVPN 1.2.0 adds pthread support for background processing of SSL/TLS key
negotiations, allowing efficient usage of large RSA keys (i.e. 2048 bits or
larger). The OpenVPN web site has been considerably expanded, including a
new HOWTO page that gives detailed instructions for setting up a complete
telecommuting solution with firewall, VPN, NAT, and DHCP support. OpenVPN
1.2.0 has additional feature improvements including configuration file
support and running daemon statistics via SIGUSR2.

Since version 1.1.1, OpenVPN has seen extensive porting activity, including
ports to Solaris, OpenBSD, Mac OS X (Darwin), and 64-bit Linux.

ChangeLog from 1.1.1 -> 1.2.0

* Added configuration file support via
  the --config option.
* Added pthread support to improve latency.
  With pthread support, OpenVPN
  will offload CPU-intensive tasks such as RSA
  key number crunching to a background thread
  to improve tunnel packet forwarding
  latency.  pthread support can be enabled
  with the --enable-pthread configure option.
  Pthread support is currently available
  only for Linux and Solaris.
* Added --dev-type option so that tun/tap
  device names don't need to begin with
  "tun" or "tap".
* Added --writepid option to write main
  process ID to a file.
* Numerous portability fixes to ease
  porting to other OSes including changing
  all network types to uint8_t and uint32_t,
  and not assuming that time_t is 32 bits.
* Backported to OpenSSL 0.9.5.
* Ported to Solaris.
* Finished OpenBSD port except for
  pthread support.
* Added initialization script:
  sample-scripts/openvpn.init
  (Douglas Keller)
* Ported to Mac OS X (Christoph Pfisterer).
* Improved resilience to DoS attacks when
  TLS mode is used without --remote or
  --tls-auth, or when --float is used
  with --remote.  Note however that the best
  defense against DoS attacks in TLS mode
  is to use --tls-auth.
* Eliminated automake/autoconf dependency
  for non-developers.
* Ported configure.in to configure.ac
  and autoconf 2.50+.
* SIGHUP signal now causes OpenVPN to restart
  and re-read command line and or config file,
  in conformance with canonical daemon behaviour.
* SIGUSR1 now does what SIGHUP did in
  version 1.1.1 and earlier -- close and reopen
  the UDP socket for use when DHCP changes
  host's IP address and preserve most recently
  authenticated peer address without rereading
  config file.
* SIGUSR2 added -- outputs current statistics,
  including compression statistics.
* All changes maintain protocol compatibility
  with 1.1.1 and 1.1.0.

James



