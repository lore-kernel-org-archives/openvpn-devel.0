From: Arne Schwabe <arne@...1227...>
Date: Wed, 28 Jun 2017 23:05:21 +0200
Message-Id: <1498683921-432-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] show the right string for key-direction
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

---
 src/openvpn/options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 61af6e3a..d8049e76 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1697,7 +1697,7 @@ show_settings(const struct options *o)
 
 #ifdef ENABLE_CRYPTO
     SHOW_STR(shared_secret_file);
-    SHOW_INT(key_direction);
+    SHOW_PARM(key_direction, keydirection2ascii(o->key_direction, false), "%s");
     SHOW_STR(ciphername);
     SHOW_BOOL(ncp_enabled);
     SHOW_STR(ncp_ciphers);
-- 
2.11.0 (Apple Git-81)


