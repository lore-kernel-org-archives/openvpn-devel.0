Message-ID: <03a001c1e04e$78231300$1000000a@...4...>
From: "James Yonan" <jim@...3...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN 1.1.0 released
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
Date: Tue Apr  9 22:13:04 2002
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net

Download:

http://prdownloads.sourceforge.net/openvpn/openvpn-1.1.0.tar.gz

Change Log:

2002.04.09 -- Version 1.1.0

* Strengthened replay protection and IV handling,
  extending it fully to both static key and
  TLS dynamic key exchange modes.
* Added --mlock option to disable paging and ensure that key
  material and tunnel data is never paged to disk.
* Added optional traffic shaping feature to cap the maximum
  data rate of the tunnel.
* Converted to automake (The Platypus Brothers 2002-04-01).
* Ported to OpenBSD by Janne Johansson.
* Added --tun-af-inet option to work around an incompatibility
  between Linux and BSD tun drivers.
* Sequence number-based replay protection using the
  IPSec sliding window model is now the default,
  disable with --no-replay.
* Explicit IV is now the default, disable with --no-iv.
* Disabled all cipher modes except CBC, CFB, and OFB.
* In CBC mode, use explicit IV and carry forward residuals,
  using IPSec model.
* In CFB/OFB mode, IV is timestamp, sequence number.
* Eliminated --packet-id, --timestamp, and max-delta parameter to
  the --tls-auth option as they are now supplanted by improved
  replay code which is enabled by default.
* Eliminated --rand-iv as it is now obsolete with improved
  IV code.
* Eliminated --reneg-err option as it increases vulnerability
  to DoS attacks.
* Added weak key check for DES ciphers.
* --tls-freq option is no longer specified on the command line,
  instead it now inherits its parameter from the
  --tls-timeout option.
* Fixed bug that would try to free memory on exit that was
  never malloced if --comp-lzo was not specified.
* Errata fixed in the man page examples: "test-ca" should be
  "tmp-ca".
* Updated manual page.
* Preliminary work in porting to OpenSSL 0.9.7.
* Changed license to allowing linking with OpenSSL.



