From: Timo Rothenpieler <timo@...2669...>
Date: Wed, 17 Aug 2022 15:18:17 +0200
Message-Id: <20220817131817.467-1-timo@...2669...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] dco: disable DCO if --user specified but
 unable to retain capabilities
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
 src/openvpn/dco.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index caa4ce32..b7db23f4 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -44,6 +44,10 @@
 #include "ssl_ncp.h"
 #include "tun.h"
 
+#ifdef HAVE_LIBCAPNG
+#include <cap-ng.h>
+#endif
+
 static int
 dco_install_key(struct tls_multi *multi, struct key_state *ks,
                 const uint8_t *encrypt_key, const uint8_t *encrypt_iv,
@@ -247,6 +251,28 @@ dco_check_option_conflict_platform(int msglevel, const struct options *o)
         }
     }
 #endif /* if defined(TARGET_LINUX) */
+
+#if defined(HAVE_LIBCAPNG)
+    /* DCO can't operate without CAP_NET_ADMIN. To retain it when switching user
+     * we need CAP_SETPCAP. CAP_NET_ADMIN also needs to be part of the permitted set
+     * of capabilities in order to retain it.
+     */
+    if (o->username)
+    {
+        if (!capng_have_capability(CAPNG_EFFECTIVE, CAP_SETPCAP))
+        {
+            msg(msglevel, "--user specified but lacking CAP_SETPCAP. "
+                "Cannot retain CAP_NET_ADMIN. Disabling data channel offload");
+            return false;
+        }
+        if (!capng_have_capability(CAPNG_PERMITTED, CAP_NET_ADMIN))
+        {
+            msg(msglevel, "--user specified but not permitted to retain CAP_NET_ADMIN. "
+                "Disabling data channel offload");
+            return false;
+        }
+    }
+#endif /* if defined(HAVE_LIBCAPNG) */
     return true;
 }
 
-- 
2.34.1


