Date: Thu, 29 Oct 2009 17:43:19 +0300
From: Victor Wagner <vitus@...1066...>
Message-ID: <20091029144319.GA23394@...1066...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN and modern cryptography
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Now openvpn in tls-server mode requires specification of Diffie-Hellman
parameters for ephemeral key. This is probably good thing for SSLv3 when
only RSA and DSA ciphersuites are supported. 

DSA ciphersuites always require DH parameters, and RSA ciphersuites
without DHE key exchange do not provide perfect forward secrecy.

But with release of OpenSSL 1.0.0 lot of new ciphersuites based on
elliptic curve algorithms (ECDSA, ECDH, GOST2001) become available.

These ciphersuites do not need dh paramters, but ECDSA ciphersuites
need ECDH parameters (typically, just curve name). GOST2001 do not need
parameters - its parameter sets are hardcoded into RFC 4357 and draft
for GOST tls specifes that same parameter set as used for server
certificate should be used for ephemeral keys.

So, for people which use these ciphersuites only, dh parameters are not
nessessary (but curve name might be nesseccary, and there is no option
for it in the OpenVPN 2.1 rc19).

I've developed patch which changed handling of dh configuration
directive.

Check for notnull(dh_file) is removed, but
check for list of available ciphersuites is added.
If after applying tls-cipher argument any of ciphersuites with key
exchange algorithm DH is left in the context's list of ciphersuites,
openvpn complains about missing dh parameters.

This patch can be easily extended for checking for ECDH ciphersuites
and paramters as well.

Is anybody interested in this functionality?




