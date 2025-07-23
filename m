From: Gert Doering <gert@...1296...>
Date: Wed, 23 Jul 2025 08:30:30 +0200
Message-ID: <20250723063039.25449-1-gert@...1296...>
In-Reply-To: <gerrit.1753215725000.Ifc442b4426c02de7282d0f69629e8a10b679c589@...2715...>
References: <gerrit.1753215725000.Ifc442b4426c02de7282d0f69629e8a10b679c589@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] dco_linux: use M_FATAL instead of M_ERR
 in netlink error code paths
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

From: Antonio Quartulli <antonio@...2726...>

Netlink code doesn't set errno upon error (with the exception of
any *alloc() function which probably inherits the errno=ENOMEM
from the underlying malloc call), therefore we should not print
error messages with M_ERR, but rather rely on M_FATAL.

M_ERR is equivalent to M_FATAL with the addition of appending
": $errno" to the error string.

Since errno is not meaningful in this context, we can just opt
for the less confusing M_FATAL.

Change-Id: Ifc442b4426c02de7282d0f69629e8a10b679c589
Signed-off-by: Antonio Quartulli <antonio@...2726...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1096
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 58051f5..13506a1 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -114,7 +114,7 @@
     struct nl_msg *nl_msg = nlmsg_alloc();
     if (!nl_msg)
     {
-        msg(M_ERR, "cannot allocate netlink message");
+        msg(M_FATAL, "cannot allocate netlink message");
         return NULL;
     }
 
@@ -140,7 +140,7 @@
             break;
 
         case -NLE_NOMEM:
-            msg(M_ERR, "%s: netlink out of memory error", prefix);
+            msg(M_FATAL, "%s: netlink out of memory error", prefix);
             break;
 
         case -NLE_AGAIN:
@@ -148,7 +148,7 @@
             break;
 
         case -NLE_NODEV:
-            msg(M_ERR, "%s: netlink reports device not found:", prefix);
+            msg(M_FATAL, "%s: netlink reports device not found:", prefix);
             break;
 
         case -NLE_OBJ_NOTFOUND:
@@ -387,19 +387,19 @@
 static void
 ovpn_dco_init_netlink(dco_context_t *dco)
 {
-    dco->ovpn_dco_id = resolve_ovpn_netlink_id(M_ERR);
+    dco->ovpn_dco_id = resolve_ovpn_netlink_id(M_FATAL);
 
     dco->nl_sock = nl_socket_alloc();
 
     if (!dco->nl_sock)
     {
-        msg(M_ERR, "Cannot create netlink socket");
+        msg(M_FATAL, "Cannot create netlink socket");
     }
 
     int ret = genl_connect(dco->nl_sock);
     if (ret)
     {
-        msg(M_ERR, "Cannot connect to generic netlink: %s",
+        msg(M_FATAL, "Cannot connect to generic netlink: %s",
             nl_geterror(ret));
     }
 
@@ -415,7 +415,7 @@
     dco->nl_cb = nl_cb_alloc(NL_CB_DEFAULT);
     if (!dco->nl_cb)
     {
-        msg(M_ERR, "failed to allocate netlink callback");
+        msg(M_FATAL, "failed to allocate netlink callback");
     }
 
     nl_socket_set_cb(dco->nl_sock, dco->nl_cb);
@@ -484,7 +484,7 @@
 
     if (dco->ovpn_dco_mcast_id < 0)
     {
-        msg(M_ERR, "cannot get mcast group: %s",  nl_geterror(dco->ovpn_dco_mcast_id));
+        msg(M_FATAL, "cannot get mcast group: %s",  nl_geterror(dco->ovpn_dco_mcast_id));
     }
 
     /* Register for ovpn-dco specific multicast messages that the kernel may
@@ -493,7 +493,7 @@
     int ret = nl_socket_add_membership(dco->nl_sock, dco->ovpn_dco_mcast_id);
     if (ret)
     {
-        msg(M_ERR, "%s: failed to join groups: %d", __func__, ret);
+        msg(M_FATAL, "%s: failed to join groups: %d", __func__, ret);
     }
 }
 

