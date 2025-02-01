From: Gert Doering <gert@...1296...>
Date: Sat,  1 Feb 2025 13:11:02 +0100
Message-ID: <20250201121102.27395-1-gert@...1296...>
In-Reply-To: <gerrit.1736759998000.I1cac0f036504c87205a3c97589a94a662cf79b99@...2715...>
References: <gerrit.1736759998000.I1cac0f036504c87205a3c97589a94a662cf79b99@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v7] multi.c: add iroutes after dco peer is
 added
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

This doesn't matter for Linux and FreeBSD but matters
for dco-win, where iroute subnet is mapped to a peer
context, which means that peer has to be created before
iroute is added.

Change-Id: I1cac0f036504c87205a3c97589a94a662cf79b99
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/856
This mail reflects revision 7 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index ab49726..025871c 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -2442,6 +2442,35 @@
             ifconfig_constraint_network, ifconfig_constraint_netmask);
     }
 
+    /* set our client's VPN endpoint for status reporting purposes */
+    mi->reporting_addr = mi->context.c2.push_ifconfig_local;
+    mi->reporting_addr_ipv6 = mi->context.c2.push_ifconfig_ipv6_local;
+
+    /* set context-level authentication flag */
+    mi->context.c2.tls_multi->multi_state = CAS_CONNECT_DONE;
+
+    /* Since dco-win maintains iroute routing table (subnet -> peer),
+     * peer must be added before iroutes. For other platforms it doesn't matter. */
+
+    /* authentication complete, calculate dynamic client specific options */
+    if (!multi_client_set_protocol_options(&mi->context))
+    {
+        mi->context.c2.tls_multi->multi_state = CAS_FAILED;
+    }
+    /* only continue if setting protocol options worked */
+    else if (!multi_client_setup_dco_initial(m, mi, &gc))
+    {
+        mi->context.c2.tls_multi->multi_state = CAS_FAILED;
+    }
+    /* Generate data channel keys only if setting protocol options
+     * and DCO initial setup has not failed */
+    else if (!multi_client_generate_tls_keys(&mi->context))
+    {
+        mi->context.c2.tls_multi->multi_state = CAS_FAILED;
+    }
+
+    /* dco peer has been added, it is now safe for Windows to add iroutes */
+
     /*
      * For routed tunnels, set up internal route to endpoint
      * plus add all iroute routes.
@@ -2489,30 +2518,6 @@
             multi_instance_string(mi, false, &gc));
     }
 
-    /* set our client's VPN endpoint for status reporting purposes */
-    mi->reporting_addr = mi->context.c2.push_ifconfig_local;
-    mi->reporting_addr_ipv6 = mi->context.c2.push_ifconfig_ipv6_local;
-
-    /* set context-level authentication flag */
-    mi->context.c2.tls_multi->multi_state = CAS_CONNECT_DONE;
-
-    /* authentication complete, calculate dynamic client specific options */
-    if (!multi_client_set_protocol_options(&mi->context))
-    {
-        mi->context.c2.tls_multi->multi_state = CAS_FAILED;
-    }
-    /* only continue if setting protocol options worked */
-    else if (!multi_client_setup_dco_initial(m, mi, &gc))
-    {
-        mi->context.c2.tls_multi->multi_state = CAS_FAILED;
-    }
-    /* Generate data channel keys only if setting protocol options
-     * and DCO initial setup has not failed */
-    else if (!multi_client_generate_tls_keys(&mi->context))
-    {
-        mi->context.c2.tls_multi->multi_state = CAS_FAILED;
-    }
-
     /* send push reply if ready */
     if (mi->context.c2.push_request_received)
     {

