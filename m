Message-Id: <200808081133.m78BXp4S030182@...1119...>
Date: Fri, 08 Aug 2008 13:33:51 +0200
From: Jos Vos <jos@...1120...>
Subject: [Openvpn-devel] OpenVPN and OpenSSL compatibility
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,

I'm trying to "port" OpenVPN to a rather old Linux system (for
certain reasons...).  I tried both 2.0.9 and 2.1_rc9.  What I found:

Compiling works ok for both versions (after a few trivial compiler
compatibility fixes).

But when testing a loopback connection with the loopback-{client,server}
sample config files, this works ok for 2.0.9, but it fails for 2.1rc9 and
the error I get is "could not extract Common Name from X509 subject":

Fri Aug  8 10:33:40 2008 TLS: Initial packet from 127.0.0.1:56975, sid=2ca3e519 1141a566
Fri Aug  8 10:33:40 2008 TLS: Initial packet from 127.0.0.1:56974, sid=ec182881 010bc533
Fri Aug  8 10:33:40 2008 VERIFY OK: depth=1, /C=KG/ST=NA/L=BISHKEK/O=OpenVPN-TEST/Email=me@...430...
Fri Aug  8 10:33:40 2008 VERIFY ERROR: could not extract Common Name from X509 subject string ('/C=KG/ST=NA/O=OpenVPN-TEST/CN=Test-Server/Email=me@...430...') -- note that the Common Name length is limited to 64 characters
Fri Aug  8 10:33:40 2008 TLS_ERROR: BIO read tls_read_plaintext error: error:14090086:SSL routines:SSL3_GET_SERVER_CERTIFICATE:certificate verify failed
Fri Aug  8 10:33:40 2008 TLS Error: TLS object -> incoming plaintext read error
Fri Aug  8 10:33:40 2008 TLS Error: TLS handshake failed
Fri Aug  8 10:33:40 2008 TCP/UDP: Closing socket
Fri Aug  8 10:33:40 2008 Closing TUN/TAP interface

Looking at the code (ssl.c, verify_callback()) I see that in the 2.0.9
version the code is somewhat different and that no error checking is
done after the extract_x509_field() call.

The OpenSSL version used on the old system is 0.9.6b.  Does this mean
that OpenVPN is not compatible with OpenSSL 0.9.6b and that I also
should not use 2.0.9 with that version (although at first sight the
test does not show any problems)?  Or should I look somewhere else?

Thanks for any suggestion to solve this,

--
--    Jos Vos <jos@...1120...>
--    X/OS Experts in Open Systems BV   |   Phone: +31 20 6938364
--    Amsterdam, The Netherlands        |     Fax: +31 20 6948204

