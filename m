From: Steffan Karger <steffan@...1856...>
Date: Wed, 26 Feb 2014 00:27:58 +0100
Message-Id: <1393370880-28553-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Add ECDH support for OpenSSL builds of
	OpenVPN
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

Thanks to Piotr's contributions on the mailing list I picked up my earlier
ECDH work again. I believe they are ready to be reviewed and find their way
into master.

The following patches add support for ECDH(E) in OpenSSL builds, which in
practice means that people are able to use ECDSA certificate chains without
jumping through hoops, or just use ECDH(E) with their RSA certificates.

I started with the patch Jan Just Keijser posted (and reposted) to the
openvpn-devel list earlier, and worked from there to make the behaviour
TLS-compliant (i.e, extract the curve from the server key by default).

For OpenSSL 1.0.2+, we can let OpenSSL do the heavy lifting.

For older versions (which are at this moment used by almost everyone), we have
to select a curve ourselves. If dynamic selection fails, we fall back to the
strongest 'Suite B' curve: secp384r1.

For more details, check the commit messages from the patches, and README.ec.

A patch to add EC support for PolarSSL builds will follow soon.

Regards,
-Steffan


