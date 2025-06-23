From: Gert Doering <gert@...1296...>
Date: Mon, 23 Jun 2025 16:07:43 +0200
Message-ID: <20250623140748.13960-1-gert@...1296...>
In-Reply-To: <gerrit.1750684356000.I4fa2d578f9c0a5a8aa24ca1d396102ef2ed9a425@...2715...>
References: <gerrit.1750684356000.I4fa2d578f9c0a5a8aa24ca1d396102ef2ed9a425@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] dco linux: avoid redefining ovpn enums
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

From: Ralf Lici <ralf@...2726...>

Starting with Linux kernel version 6.16, a couple of ovpn-related enum
definitions were introduced in the `include/uapi/linux/if_link.h`
header. Redefining them in openvpn when they are already present in the
system headers can lead to conflicts or build issues.

This commit ensures that enum redefinitions are avoided by conditionally
using the existing definitions from the system header when available.

Change-Id: I4fa2d578f9c0a5a8aa24ca1d396102ef2ed9a425
Signed-off-by: Ralf Lici <ralf@...2726...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1064
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):

        
diff --git a/src/openvpn/dco_linux.h b/src/openvpn/dco_linux.h
index 273a6ad..4e441ec 100644
--- a/src/openvpn/dco_linux.h
+++ b/src/openvpn/dco_linux.h
@@ -40,6 +40,8 @@
 
 /* OVPN section */
 
+#ifndef IFLA_OVPN_MAX
+
 enum ovpn_mode {
     OVPN_MODE_P2P,
     OVPN_MODE_MP,
@@ -49,10 +51,13 @@
     IFLA_OVPN_UNSPEC = 0,
     IFLA_OVPN_MODE,
 
-    __IFLA_OVPN_AFTER_LAST,
-    IFLA_OVPN_MAX = __IFLA_OVPN_AFTER_LAST - 1,
+    __IFLA_OVPN_MAX,
 };
 
+#define IFLA_OVPN_MAX (__IFLA_OVPN_MAX - 1)
+
+#endif /* ifndef IFLA_OVPN_MAX */
+
 typedef struct
 {
     struct nl_sock *nl_sock;

