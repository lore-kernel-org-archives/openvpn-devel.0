Message-ID: <001901c1ea83$d0b961b0$1000000a@...4...>
From: "James Yonan" <jim@...3...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN 1.1.1 Released
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
Date: Mon Apr 22 22:00:03 2002
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net, openvpn-announce@lists.sourceforge.net

Download:

http://prdownloads.sourceforge.net/openvpn/openvpn-1.1.1.tar.gz

Release Notes:

OpenVPN 1.1.1 is mostly a bugfix release, but also adds some new options for
keeping connections through stateful firewalls alive and specifying an
inactivity disconnect for dynamic VPN sessions.  The new --ifconfig option
calls ifconfig to configure the tunnel automatically, eliminating the need
for an --up script.  Also added a loopback test mode (--test-crypto) to
allow testing of OpenVPN's crypto component independently of its network
component.  1.1.1 is protocol compatible with 1.1.0.

Change Log:

2002.04.22 -- Version 1.1.1

* Added --ifconfig option to automatically configure
  TUN device.
* Added inactivity disconnect (--inactive
  and --ping-exit options).
* Added --ping option to keep stateful firewalls
  from timing out.
* Added sanity check to command line parser to
  err if any TLS options are used in non-TLS mode.
* Fixed build problem with compiler environments that
  define printf as a macro.
* Fixed build problem on linux systems that have
  an integrated TUN/TAP driver but lack the persistent
  tunnel feature (TUNSETPERSIST).  Some linux kernels
  >= 2.4.0 and < 2.4.7 fall into this category.
* Changed all calls to EVP_CipherInit to use explicit
  encrypt/decrypt mode in order to fix problem with
  IDEA-CBC and AES-256-CBC ciphers.
* Minor changes to control channel transmit limiter
  algorithm to fix problem where TLS control channel
  might not renegotiate within the default 60 second window.
* Simplified man page examples by taking advantage
  of the new --ifconfig option.
* Minor changes to configure.in to check more
  rigourously for OpenSSL 0.9.6 or greater.
* Put back openvpn.spec, eliminated
  openvpn.spec.in.
* Modified openvpn.spec to reflect new automake-based
  build environment (Bishop Clark).
* Other documentation changes.
* Added --test-crypto option for debugging.
* Added "missing" and "mkinstalldirs" automake
  support files.

James



