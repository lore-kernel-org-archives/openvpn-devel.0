From: Arne Schwabe <arne@...1227...>
Date: Wed, 31 Jan 2018 10:49:22 +0100
Message-Id: <1517392162-21501-1-git-send-email-arne@...1227...>
In-Reply-To: <d7604f16-8385-f0de-9d87-77d954a3c0cc@...1856...>
References: <d7604f16-8385-f0de-9d87-77d954a3c0cc@...1856...>
Subject: [Openvpn-devel] [PATCH v2] show the right string for key-direction
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

V2: print also a nice string if direction is not set
---
 src/openvpn/options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 66e1f9d1..f405d8a2 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1706,7 +1706,7 @@ show_settings(const struct options *o)
 #endif
 
     SHOW_STR(shared_secret_file);
-    SHOW_INT(key_direction);
+    SHOW_PARM(key_direction, keydirection2ascii(o->key_direction, false), "%s");
     SHOW_STR(ciphername);
     SHOW_BOOL(ncp_enabled);
     SHOW_STR(ncp_ciphers);
-- 
2.15.1


