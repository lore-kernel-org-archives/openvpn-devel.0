From: Arne Schwabe <arne@...1227...>
Date: Tue,  7 Dec 2021 18:02:01 +0100
Message-Id: <20211207170211.3275837-12-arne@...1227...>
In-Reply-To: <20211207170211.3275837-1-arne@...1227...>
References: <20211207170211.3275837-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 11/21] Remove pointless do_init_frame_tls
 function
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

This function is static and just calls another functions.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/init.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 2ce963663..0287dda35 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -3045,7 +3045,7 @@ do_init_crypto_tls(struct context *c, const unsigned int flags)
 }
 
 static void
-do_init_finalize_tls_frame(struct context *c)
+do_init_frame_tls(struct context *c)
 {
     if (c->c2.tls_multi)
     {
@@ -3302,12 +3302,6 @@ do_option_warnings(struct context *c)
     }
 }
 
-static void
-do_init_frame_tls(struct context *c)
-{
-    do_init_finalize_tls_frame(c);
-}
-
 struct context_buffers *
 init_context_buffers(struct frame *frame)
 {
-- 
2.33.0


