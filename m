Date: Mon, 02 Apr 2007 23:31:11 -0400
From: Nilij <nilij@...1013...>
Message-id: <1175571071.940.16.camel@...1014...>
MIME-version: 1.0
Subject: [Openvpn-devel] making openvpn fips compliant
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi, 

  Now that openssl is FIPS certified, is there any plan to have a fips
compliant version of OpenVPN?

  My understanding is that there are two steps here:

  1. Forcing OpenVPN to use FIPS crypto module from OpenSSL.

  2. Make sure non-FIPS-compliant algorithms are not used.

  A while back, we tried OpenVPN 2.0 with OpenSSL fips 1.0 (2004), got
it to compile but failed at random number generator ... 

    Mon May 1 22:26:44 2006 us=97732 TLS_ERROR: BIO read
tls_read_plaintext
    error: error:24066067:random number generator:FIPS_RAND_BYTES:prng not
rekeyed

  I am a novice to openvpn internal, but I can imagine that step #2 might
be considerably harder.

  I would like to know if there is any plan for FIPS and how hard it is.

  Thanks in advance

- Nilij


