Message-ID: <00f201c1de7e$018e40b0$1000000a@...4...>
From: "James Yonan" <jim@...3...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN 1.1 beta available
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
Date: Sun Apr  7 14:48:05 2002
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net
Cc: Janne Johansson <jan.johansson@...1...>, Alberto Gonzalez Iniesta <agi@...5...>, bishop <bishop@...7...>

Here's the latest beta...  Contains a lot of cool stuff including automake
configuration, a BSD 3.0 port, fixes for CFB/OFB IV, reworked replay
protection and IV based on IPSec,  --mlock (to disable paging), special
handling for all DES keys wrt. parity and weak keys, and an updated manual
page.

The only known issue right now is that for some reason (on my machine) "make
install" only installs the binary, not the man page.  I'm an automake newbie
and haven't really tried to figure it out yet.

Anyway, build it, test it, beat on it, etc.

http://openvpn.sourceforge.net/beta/openvpn-1.1-pre1.tar.gz

James

************************************

ChangeLog

2002.04.07 -- Version 1.1-pre1

* Strengthened replay protection and IV handling,
  extending it fully to both static key and
  TLS dynamic key exchange modes.
* Added --mlock option to disable paging and ensure that key
  material and tunnel data is never paged to disk.
* Converted to automake by The Platypus Brothers 2002-04-01.
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
* Errata fixed in the man page examples: "test-ca" should be
  "tmp-ca".
* Other manual page changes.
* Preliminary work in porting to OpenSSL 0.9.7.



