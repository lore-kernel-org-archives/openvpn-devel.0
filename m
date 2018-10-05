From: Steffan Karger <steffan@...1856...>
Date: Fri,  5 Oct 2018 15:58:49 +0200
Message-Id: <20181005135849.28718-1-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH (2.4)] Fix --disable-crypto build
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

Commit d2ff5164 was fine for the master branch, but broke the 2.4 build if
the --disable-crypto configure options was used (which is removed in the
master branch).

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/init.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 0950f07e..2d201c44 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -621,9 +621,11 @@ uninit_proxy(struct context *c)
 static void
 do_set_ncp_options(struct context *c)
 {
+#ifdef ENABLE_CRYPTO
     c->c1.ciphername = c->options.ciphername;
     c->c1.authname = c->options.authname;
     c->c1.keysize = c->options.keysize;
+#endif ENABLE_CRYPTO
 }
 
 /*
@@ -635,9 +637,11 @@ do_set_ncp_options(struct context *c)
 static void
 do_unset_ncp_options(struct context *c)
 {
+#ifdef ENABLE_CRYPTO
     c->options.ciphername = c->c1.ciphername;
     c->options.authname = c->c1.authname;
     c->options.keysize = c->c1.keysize;
+#endif ENABLE_CRYPTO
 }
 
 void
-- 
2.17.1


