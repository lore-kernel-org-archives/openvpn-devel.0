From: Frank Lichtenheld <frank@...2641...>
Date: Fri,  1 Aug 2025 15:03:02 +0200
Message-Id: <20250801130302.372311-1-frank@...2641...>
In-Reply-To: <gerrit.1753960651000.I41c5dfc7489352a9534ff6b1585a5a81e0623ab1@...2715...>
References: <gerrit.1753960651000.I41c5dfc7489352a9534ff6b1585a5a81e0623ab1@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] dco linux: avoid redefining ovpn enums
 (2.6)
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
Cc: Antonio Quartulli <antonio@...2726...>

Starting with Linux kernel version 6.16, a couple of ovpn-related enum
definitions were introduced in the `include/uapi/linux/if_link.h`
header. Redefining them in openvpn when they are already present in the
system headers can lead to conflicts or build issues.

This commit ensures that enum redefinitions are avoided by conditionally
using the existing definitions from the system header when available.

This is the port to release/2.6 based on commit
1d3c2b67a73a0aa011c13e62f876d24e49d41df0.

Change-Id: I41c5dfc7489352a9534ff6b1585a5a81e0623ab1
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Antonio Quartulli <antonio@...2726...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to release/2.6.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1122
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Antonio Quartulli <antonio@...2726...>

        
diff --git a/src/openvpn/dco_linux.h b/src/openvpn/dco_linux.h
index 511519a..5179912 100644
--- a/src/openvpn/dco_linux.h
+++ b/src/openvpn/dco_linux.h
@@ -26,11 +26,13 @@
 
 #include "event.h"
 
-#include "ovpn_dco_linux.h"
-
 #include <netlink/socket.h>
 #include <netlink/netlink.h>
 
+/* include last since we need to behave differently if the kernel headers
+ * are from 6.16+ */
+#include "ovpn_dco_linux.h"
+
 typedef enum ovpn_key_slot dco_key_slot_t;
 typedef enum ovpn_cipher_alg dco_cipher_t;
 
diff --git a/src/openvpn/ovpn_dco_linux.h b/src/openvpn/ovpn_dco_linux.h
index 73e19b5..34abc6a 100644
--- a/src/openvpn/ovpn_dco_linux.h
+++ b/src/openvpn/ovpn_dco_linux.h
@@ -237,14 +237,17 @@
 	OVPN_PACKET_ATTR_MAX = __OVPN_PACKET_ATTR_AFTER_LAST - 1,
 };
 
+#ifndef IFLA_OVPN_MAX
+
 enum ovpn_ifla_attrs {
 	IFLA_OVPN_UNSPEC = 0,
 	IFLA_OVPN_MODE,
 
-	__IFLA_OVPN_AFTER_LAST,
-	IFLA_OVPN_MAX = __IFLA_OVPN_AFTER_LAST - 1,
+	__IFLA_OVPN_MAX,
 };
 
+#define IFLA_OVPN_MAX (__IFLA_OVPN_MAX - 1)
+
 enum ovpn_mode {
 	__OVPN_MODE_FIRST = 0,
 	OVPN_MODE_P2P = __OVPN_MODE_FIRST,
@@ -253,4 +256,6 @@
 	__OVPN_MODE_AFTER_LAST,
 };
 
+#endif /* ifndef IFLA_OVPN_MAX */
+
 #endif /* _UAPI_LINUX_OVPN_DCO_H_ */

