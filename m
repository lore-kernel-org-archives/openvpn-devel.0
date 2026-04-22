From: Gert Doering <gert@...1296...>
Date: Wed, 22 Apr 2026 07:56:30 +0200
Message-ID: <20260422055636.20691-1-gert@...1296...>
In-Reply-To: <gerrit.1776803704000.I9b1f4fd06c8a02d3f51b6a3bdea2f92191669660@...2715...>
References: <gerrit.1776803704000.I9b1f4fd06c8a02d3f51b6a3bdea2f92191669660@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] dco-linux: enforce ifindex only for
 DEL_PEER notifications
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

The unconditional ifindex check introduced by commit e78a8af2f5ce
rejects legitimate kernel replies, specifically peer stats responses,
because those messages do not carry OVPN_ATTR_IFINDEX.

Move the check into ovpn_handle_del_peer() so it applies only to
spontaneous DEL_PEER notifications from the kernel. This keeps
response handling working while still filtering foreign-instance
notifications.

Fixes: e78a8af2f5ce ("dco: backport immediate notification processing on Linux and FreeBSD")
Github: closes OpenVPN/openvpn#1020
Change-Id: I9b1f4fd06c8a02d3f51b6a3bdea2f92191669660
Signed-off-by: Ralf Lici <ralf@...2726...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1636
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to release/2.6.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1636
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 8ce7026..1df56cf 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -857,6 +857,23 @@
 static int
 ovpn_handle_del_peer(dco_context_t *dco, struct nlattr *attrs[])
 {
+    /* we must know which interface this message is referring to in order to
+     * avoid mixing messages for other instances
+     */
+    if (!attrs[OVPN_ATTR_IFINDEX])
+    {
+        msg(D_DCO, "ovpn-dco: Received message without ifindex");
+        return NL_STOP;
+    }
+
+    uint32_t ifindex = nla_get_u32(attrs[OVPN_ATTR_IFINDEX]);
+    if (ifindex != dco->ifindex)
+    {
+        msg(D_DCO_DEBUG, "ovpn-dco: ignoring message for foreign ifindex %d",
+            ifindex);
+        return NL_SKIP;
+    }
+
     if (!attrs[OVPN_ATTR_DEL_PEER])
     {
         msg(D_DCO, "ovpn-dco: no attributes in OVPN_DEL_PEER message");
@@ -930,23 +947,6 @@
         return NL_STOP;
     }
 
-    /* we must know which interface this message is referring to in order to
-     * avoid mixing messages for other instances
-     */
-    if (!attrs[OVPN_ATTR_IFINDEX])
-    {
-        msg(D_DCO, "ovpn-dco: Received message without ifindex");
-        return NL_STOP;
-    }
-
-    uint32_t ifindex = nla_get_u32(attrs[OVPN_ATTR_IFINDEX]);
-    if (ifindex != dco->ifindex)
-    {
-        msg(D_DCO_DEBUG, "ovpn-dco: ignoring message for foreign ifindex %d",
-            ifindex);
-        return NL_SKIP;
-    }
-
     /* based on the message type, we parse the subobject contained in the
      * message, that stores the type-specific attributes.
      *

