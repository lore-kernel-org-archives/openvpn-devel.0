Message-ID: <55882EBE.9030503@...1147...>
Date: Mon, 22 Jun 2015 17:50:22 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
Subject: [Openvpn-devel] about client-cert-not-required
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

hi all,

just found out that when you use 'client-cert-not-required' that the 
client certificate is not checked at all, even if one is presented. I'm 
not sure if that's by design but I think it would be handy to check the 
client certificate if presented by the client.
This allows an admin to set up a server with multiple levels of access
- username+password only
- certificate only
- certificate + username for extra security

Right now , two separate instances of OpenVPN are needed for this. 
Patching this in for the OpenSSL version is trivial. If you set up the 
verify callback to use SSL_VERIFY_PEER (instead of SSL_VERIFY_PEER | 
SSL_VERIFY_FAIL_IF_NO_PEER_CERT)  it *will* check the client side cert, 
if present, but it will not fail if not present. I can submit a patch 
for this anytime (tested it already), if people think this is the way 
forward.
Also note that if you present an invalid certificate (wrong CA etc) the 
connection is rejected by the OpenSSL lib.

However, for the polarssl (excuse me, mbedtls) build of OpenVPN this is 
not so trivial: there is a call to make the verification option, but the 
docs for the function ssl_set_authmode state:

Note
     On client, SSL_VERIFY_REQUIRED is the recommended mode. With 
SSL_VERIFY_OPTIONAL, the user needs to call ssl_get_verify_result() at 
the right time(s), which may not be obvious, while REQUIRED always 
perform the verification as soon as possible. For example, REQUIRED was 
protecting against the "triple handshake" attack even before it was found.

and indeed, you can set SSL_VERIFY_OPTIONAL but then there is *NO* 
certificate check at all unless you call get_verify_result at some point 
- and the problem is, I have no clue which point that would be....

Thus, this mail boils down to two linked questions

1) do we think it's valuable to add something like this (currently NO 
cert checks are done when 'client-cert-not-required' is used) ?

2) how do we implement this in mbedtls  ?


thx,

JJK


