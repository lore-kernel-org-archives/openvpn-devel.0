From: Gert Doering <gert@...1296...>
Date: Wed,  1 May 2024 14:42:54 +0200
Message-ID: <20240501124254.29114-1-gert@...1296...>
In-Reply-To: <gerrit.1713372754000.Iefd209c0856ef395ab74055496130de00b86ead0@...2715...>
References: <gerrit.1713372754000.Iefd209c0856ef395ab74055496130de00b86ead0@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Use topology default of "subnet" only
 for server mode
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

From: Frank Lichtenheld <frank@...2641...>

The setting of --topology changes the syntax of --ifconfig.
So changing the default of --topology breaks all existing
configs that use --ifconfig but not --topology.

For P2P setups that is probably a signification percentage.
For server setups the percentage is hopefully lower since
--ifconfig is implicitly set by --server. Also more people
might have set their topology explicitly since it makes a
much bigger difference. Clients will usually get the
topology and the IP config pushed by the server.

So we decided to not switch the default for everyone to
not affect P2P setups. What we care about is to change
the default for --mode server, so we only do that now. For
people using --server this should be transparent except
for a pool reset.

Change-Id: Iefd209c0856ef395ab74055496130de00b86ead0
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/554
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/Changes.rst b/Changes.rst
index b2278ab..fa0fb22 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -23,11 +23,12 @@
 ``persist-key`` option has been enabled by default.
     All the keys will be kept in memory across restart.
 
-Default for ``--topology`` changed to ``subnet``
-    Previous releases used ``net30`` as default. This only affects
-    configs with ``--dev tun`` and only IPv4. Note that this
-    changes the semantics of ``--ifconfig``, so if you have manual
-    settings for that in your config but not set ``--topology``
+Default for ``--topology`` changed to ``subnet`` for ``--mode server``
+    Previous releases always used ``net30`` as default. This only affects
+    configs with ``--mode server`` or ``--server`` (the latter implies the
+    former), and ``--dev tun``, and only if IPv4 is enabled.
+    Note that this changes the semantics of ``--ifconfig``, so if you have
+    manual settings for that in your config but not set ``--topology``
     your config might fail to parse with the new version. Just adding
     ``--topology net30`` to the config should fix the problem.
     By default ``--topology`` is pushed from server to client.
diff --git a/src/openvpn/helper.c b/src/openvpn/helper.c
index 1bab84c..5681718 100644
--- a/src/openvpn/helper.c
+++ b/src/openvpn/helper.c
@@ -137,6 +137,32 @@
 }
 
 
+/**
+ * Set --topology default depending on --mode
+ */
+void
+helper_setdefault_topology(struct options *o)
+{
+    if (o->topology != TOP_UNDEF)
+    {
+        return;
+    }
+    int dev = dev_type_enum(o->dev, o->dev_type);
+    if (dev != DEV_TYPE_TUN)
+    {
+        return;
+    }
+    if (o->mode == MODE_SERVER)
+    {
+        o->topology = TOP_SUBNET;
+    }
+    else
+    {
+        o->topology = TOP_NET30;
+    }
+}
+
+
 /*
  * Process server, server-bridge, and client helper
  * directives after the parameters themselves have been
@@ -151,7 +177,6 @@
      * Get tun/tap/null device type
      */
     const int dev = dev_type_enum(o->dev, o->dev_type);
-    const int topology = o->topology;
 
     /*
      *
@@ -177,11 +202,11 @@
 
         if (o->server_flags & SF_NOPOOL)
         {
-            msg( M_USAGE, "--server-ipv6 is incompatible with 'nopool' option" );
+            msg(M_USAGE, "--server-ipv6 is incompatible with 'nopool' option");
         }
         if (o->ifconfig_ipv6_pool_defined)
         {
-            msg( M_USAGE, "--server-ipv6 already defines an ifconfig-ipv6-pool, so you can't also specify --ifconfig-pool explicitly");
+            msg(M_USAGE, "--server-ipv6 already defines an ifconfig-ipv6-pool, so you can't also specify --ifconfig-pool explicitly");
         }
 
         o->mode = MODE_SERVER;
@@ -207,7 +232,7 @@
                                                   o->server_netbits_ipv6 < 112 ? 0x1000 : 2);
         o->ifconfig_ipv6_pool_netbits = o->server_netbits_ipv6;
 
-        push_option( o, "tun-ipv6", M_USAGE );
+        push_option(o, "tun-ipv6", M_USAGE);
     }
 
     /*
@@ -305,8 +330,10 @@
 
             o->mode = MODE_SERVER;
             o->tls_server = true;
+            /* Need to know topology now */
+            helper_setdefault_topology(o);
 
-            if (topology == TOP_NET30 || topology == TOP_P2P)
+            if (o->topology == TOP_NET30 || o->topology == TOP_P2P)
             {
                 o->ifconfig_local = print_in_addr_t(o->server_network + 1, 0, &o->gc);
                 o->ifconfig_remote_netmask = print_in_addr_t(o->server_network + 2, 0, &o->gc);
@@ -324,12 +351,12 @@
                 {
                     push_option(o, print_opt_route(o->server_network, o->server_netmask, &o->gc), M_USAGE);
                 }
-                else if (topology == TOP_NET30)
+                else if (o->topology == TOP_NET30)
                 {
                     push_option(o, print_opt_route(o->server_network + 1, 0, &o->gc), M_USAGE);
                 }
             }
-            else if (topology == TOP_SUBNET)
+            else if (o->topology == TOP_SUBNET)
             {
                 o->ifconfig_local = print_in_addr_t(o->server_network + 1, 0, &o->gc);
                 o->ifconfig_remote_netmask = print_in_addr_t(o->server_netmask, 0, &o->gc);
@@ -354,9 +381,9 @@
                 ASSERT(0);
             }
 
-            push_option(o, print_opt_topology(topology, &o->gc), M_USAGE);
+            push_option(o, print_opt_topology(o->topology, &o->gc), M_USAGE);
 
-            if (topology == TOP_NET30 && !(o->server_flags & SF_NOPOOL))
+            if (o->topology == TOP_NET30 && !(o->server_flags & SF_NOPOOL))
             {
                 msg(M_WARN, "WARNING: --topology net30 support for server "
                     "configs with IPv4 pools will be removed in a future "
@@ -394,7 +421,7 @@
         }
 
         /* set push-ifconfig-constraint directive */
-        if ((dev == DEV_TYPE_TAP || topology == TOP_SUBNET))
+        if ((dev == DEV_TYPE_TAP || o->topology == TOP_SUBNET))
         {
             o->push_ifconfig_constraint_defined = true;
             o->push_ifconfig_constraint_network = o->server_network;
diff --git a/src/openvpn/helper.h b/src/openvpn/helper.h
index d0fd17d..6b42e13 100644
--- a/src/openvpn/helper.h
+++ b/src/openvpn/helper.h
@@ -30,6 +30,8 @@
 
 #include "options.h"
 
+void helper_setdefault_topology(struct options *o);
+
 void helper_keepalive(struct options *o);
 
 void helper_client_server(struct options *o);
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index e2bfe0e..07387cd 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -796,7 +796,7 @@
         o->gc_owned = true;
     }
     o->mode = MODE_POINT_TO_POINT;
-    o->topology = TOP_SUBNET;
+    o->topology = TOP_UNDEF;
     o->ce.proto = PROTO_UDP;
     o->ce.af = AF_UNSPEC;
     o->ce.bind_ipv6_only = false;
@@ -3478,6 +3478,7 @@
     }
 }
 
+
 /**
  * Checks for availibility of Chacha20-Poly1305 and sets
  * the ncp_cipher to either AES-256-GCM:AES-128-GCM or
@@ -3680,6 +3681,8 @@
      * sequences of options.
      */
     helper_client_server(o);
+    /* must be called after helpers that might set --mode */
+    helper_setdefault_topology(o);
     helper_keepalive(o);
     helper_tcp_nodelay(o);
 

