From: Lev Stipakov <lstipakov@...277...>
Date: Fri,  9 Nov 2018 11:59:33 +0200
Message-Id: <1541757573-30178-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] Remove extra token after #endif
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Commit ee80ce3d6f2ebc59068338757311e0488ae620fc wrapped
code in #ifdef/#endif and added extra token after #endif,
which produces compiler warning.

This removes unneeded extra token.

Signed-off-by: Lev Stipakov <lstipakov@...277...>
---
 src/openvpn/init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 586e4ca..1cdef31 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -624,7 +624,7 @@ save_ncp_options(struct context *c)
     c->c1.ciphername = c->options.ciphername;
     c->c1.authname = c->options.authname;
     c->c1.keysize = c->options.keysize;
-#endif ENABLE_CRYPTO
+#endif
 }
 
 /* Restores NCP-negotiable options to original values */
@@ -635,7 +635,7 @@ restore_ncp_options(struct context *c)
     c->options.ciphername = c->c1.ciphername;
     c->options.authname = c->c1.authname;
     c->options.keysize = c->c1.keysize;
-#endif ENABLE_CRYPTO
+#endif
 }
 
 void
-- 
2.7.4


