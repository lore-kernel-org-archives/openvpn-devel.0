From: Gert Doering <gert@...1296...>
Date: Wed,  5 Feb 2025 13:23:41 +0100
Message-ID: <20250205122341.4944-1-gert@...1296...>
In-Reply-To: <gerrit.1738750933000.I8724eda269b816dd2cfd0833d467e6d24054e96f@...2715...>
References: <gerrit.1738750933000.I8724eda269b816dd2cfd0833d467e6d24054e96f@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] dco-win: disable dco in server mode if
 multiple --local options defined
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

dco-win doesn't yet support multisocket, so for the time
being we have to fallback to tap-windows6.

Change-Id: I8724eda269b816dd2cfd0833d467e6d24054e96f
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/885
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index b5a2136..c65aece 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -279,6 +279,12 @@
         msg(msglevel, "NOTE: --remote is not defined. This DCO version doesn't support multipeer. Disabling Data Channel Offload");
         return false;
     }
+
+    if ((mode == MODE_SERVER) && (ce->local_list->len > 1))
+    {
+        msg(msglevel, "NOTE: multiple --local options defined, disabling data channel offload");
+        return false;
+    }
 #endif
 
     return true;
@@ -355,6 +361,12 @@
         return false;
     }
 
+    if ((o->mode == MODE_SERVER) && o->ce.local_list->len > 1)
+    {
+        msg(msglevel, "multiple --local options defined, disabling data channel offload");
+        return false;
+    }
+
 #elif defined(TARGET_LINUX)
     /* if the device name is fixed, we need to check if an interface with this
      * name already exists. IF it does, it must be a DCO interface, otherwise

