From: Selva Nair <selva.nair@...277...>
Date: Tue, 13 Dec 2016 11:11:38 -0500
Message-Id: <1481645498-22043-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH] Unhide a line in man page by fixing a typo
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

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 doc/openvpn.8 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index e5619c0..42ccd98 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -4575,8 +4575,8 @@ public.
 .B \-\-ecdh\-curve name
 Specify the curve to use for elliptic curve Diffie Hellman. Available
 curves can be listed with
-.B \-\-show\-curves
-. The specified curve will only be used for ECDH TLS-ciphers.
+.BR \-\-show\-curves .
+The specified curve will only be used for ECDH TLS-ciphers.
 .\"*********************************************************
 .TP
 .B \-\-cert file
-- 
2.1.4


