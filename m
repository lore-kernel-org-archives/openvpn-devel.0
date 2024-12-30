From: Gert Doering <gert@...1296...>
Date: Mon, 30 Dec 2024 20:32:04 +0100
Message-ID: <20241230193204.9897-1-gert@...1296...>
In-Reply-To: <gerrit.1732212459000.Iea4538cee075d50de836d1ef7652985186b2527c@...2715...>
References: <gerrit.1732212459000.Iea4538cee075d50de836d1ef7652985186b2527c@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v6] dco-win: enable mode server on supported
 configuration
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

From: Lev Stipakov <lev@...515...>

Enable dco-win with mode server if driver supports it.

Disable for proto TCP or older drivers.

Change-Id: Iea4538cee075d50de836d1ef7652985186b2527c
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/812
This mail reflects revision 6 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index dcc80d3..512da25 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -43,6 +43,10 @@
 #include "tun.h"
 #include "tun_afunix.h"
 
+#if defined(_WIN32)
+#include "dco_win.h"
+#endif
+
 #ifdef HAVE_LIBCAPNG
 #include <cap-ng.h>
 #endif
@@ -235,7 +239,7 @@
 }
 
 static bool
-dco_check_option_ce(const struct connection_entry *ce, int msglevel)
+dco_check_option_ce(const struct connection_entry *ce, int msglevel, int mode)
 {
     if (ce->fragment)
     {
@@ -264,9 +268,15 @@
 #endif
 
 #if defined(_WIN32)
-    if (!ce->remote)
+    if (!proto_is_udp(ce->proto) && mode == MODE_SERVER)
     {
-        msg(msglevel, "NOTE: --remote is not defined, disabling data channel offload.");
+        msg(msglevel, "NOTE: TCP transport disables data channel offload on Windows in server mode.");
+        return false;
+    }
+
+    if (!ce->remote && !dco_win_supports_multipeer())
+    {
+        msg(msglevel, "NOTE: --remote is not defined. This DCO version doesn't support multipeer. Disabling Data Channel Offload");
         return false;
     }
 #endif
@@ -316,7 +326,7 @@
         const struct connection_list *l = o->connection_list;
         for (int i = 0; i < l->len; ++i)
         {
-            if (!dco_check_option_ce(l->array[i], msglevel))
+            if (!dco_check_option_ce(l->array[i], msglevel, o->mode))
             {
                 return false;
             }
@@ -324,16 +334,16 @@
     }
     else
     {
-        if (!dco_check_option_ce(&o->ce, msglevel))
+        if (!dco_check_option_ce(&o->ce, msglevel, o->mode))
         {
             return false;
         }
     }
 
 #if defined(_WIN32)
-    if (o->mode == MODE_SERVER)
+    if ((o->mode == MODE_SERVER) && !dco_win_supports_multipeer())
     {
-        msg(msglevel, "--mode server is set. Disabling Data Channel Offload");
+        msg(msglevel, "--mode server is set. This DCO version doesn't support multipeer. Disabling Data Channel Offload");
         return false;
     }
 
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index f59bf8c..46b2d03 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -523,4 +523,11 @@
     }
 }
 
+bool
+dco_win_supports_multipeer(void)
+{
+    OVPN_VERSION ver = { 0 };
+    return dco_get_version(&ver) && ver.Major >= 2;
+}
+
 #endif /* defined(_WIN32) */
diff --git a/src/openvpn/dco_win.h b/src/openvpn/dco_win.h
index 4883629..7688516 100644
--- a/src/openvpn/dco_win.h
+++ b/src/openvpn/dco_win.h
@@ -48,6 +48,9 @@
 void
 dco_start_tun(struct tuntap *tt);
 
+bool
+dco_win_supports_multipeer(void);
+
 #else /* if defined(ENABLE_DCO) && defined(_WIN32) */
 
 static inline void

