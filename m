From: Steffan Karger <steffan@...1856...>
Date: Tue, 13 Dec 2016 20:51:12 +0100
Message-Id: <1481658672-5110-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] man: mention that --ecdh-curve does not
	work on mbed TLS builds
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

Not needed either, because mbed TLS automatically selects the curve based
on the certificate.

Trac: #789

Signed-off-by: Steffan Karger <steffan@...1856...>
---

Note: this patch requires the 'unhide line' patch from Selva to be applied
first.

 doc/openvpn.8 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 42ccd98..f079799 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -4577,6 +4577,8 @@ Specify the curve to use for elliptic curve Diffie Hellman. Available
 curves can be listed with
 .BR \-\-show\-curves .
 The specified curve will only be used for ECDH TLS-ciphers.
+
+This option is not supported in mbed TLS builds of OpenVPN.
 .\"*********************************************************
 .TP
 .B \-\-cert file
-- 
2.7.4


