From: Benny Amorsen <benny+usenet@...1175...>
Date: Mon, 29 Dec 2008 13:07:43 +0100
Message-ID: <m3iqp39oc0.fsf@...1176...>
Mime-Version: 1.0
Sender: news <news@...1062...>
Subject: [Openvpn-devel] Raw RSA authentication
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Would it be possible to add raw RSA authentication to OpenVPN, like
Openswan has for IPSEC?

Openswan automatically generates a private key in the format:

#pubkey=0sAQOdODm...Yog5rTj3V2AsI/
Modulus: 0x9d38399...9ad38f757602c23f
PublicExponent: 0x03
# everything after this point is secret
PrivateExponent: ...
Prime1: ...
Prime2: ...
Exponent1: ...
Exponent2: ...
Coefficient: ...

All you need to do to get RSA authentication is to add this at the
other end of the connection:

rightrsasigkey=0sAQOdODm...Yog5rTj3V2AsI/

This is much easier than managing a certificate server. The drawback
is that each client needs to exist in the configuration file of the
OpenVPN server, but that also means that if a client key is
compromised, it is simple to generate a new one or remove the client.
No more fiddling with CRL's...


/Benny


