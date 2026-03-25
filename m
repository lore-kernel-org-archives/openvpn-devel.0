From: Frank Lichtenheld <frank@...2641...>
Date: Wed, 25 Mar 2026 13:45:26 +0100
Message-ID: <20260325124526.124049-1-frank@...2641...>
In-Reply-To: <gerrit.1773145887000.Ia699b0dfa407ac377970bb130434298eaaec592b@...2715...>
References: <gerrit.1773145887000.Ia699b0dfa407ac377970bb130434298eaaec592b@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v7] Increase default size of internal hash
 maps to 4 * --max-clients
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
Cc: Arne Schwabe <arne@...1227...>, Antonio Quartulli <antonio@...2726...>

From: Arne Schwabe <arne@...1227...>

The default of 256 seems quite low as with (at least) 1024 possible
entries (the --max-clients default setting) we have a guaranteed
collisions. Using 4 times the number of possible entries for real
addresses should reduce collisions quite a bit while also leaving
some headroom for the virtual addresses hash where a client might
have more than one address.

A reason to keep the limit so low are the memory requirements. Each
bucket has the size of one linked-list pointer (4 byte or 32 bit and
8 byte for 64 bit). So 256 buckets use 1 or 2 kB while 4096 will use
16 kB or 32 kB.

When the current limit was set 20 years ago this might have been a
meaningful memory saving but today the collision probability is
more important.

Change-Id: Ia699b0dfa407ac377970bb130434298eaaec592b
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Antonio Quartulli <antonio@...2726...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1563
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1563
This mail reflects revision 7 of this Change.

Acked-by according to Gerrit (reflected above):
Antonio Quartulli <antonio@...2726...>

        
diff --git a/doc/man-sections/advanced-options.rst b/doc/man-sections/advanced-options.rst
index e1115e4..73ca44a 100644
--- a/doc/man-sections/advanced-options.rst
+++ b/doc/man-sections/advanced-options.rst
@@ -36,7 +36,8 @@
 
      hash-size r v
 
-  By default, both tables are sized at 256 buckets.
+  By default, both tables are sized at 4 times ``--max-clients`` buckets.
+  With the default of 1024 of ``--max-clients`` this gives 4096 buckets.
 
 --bcast-buffers n
   Allocate ``n`` buffers for broadcast datagrams (default :code:`256`).
diff --git a/doc/man-sections/server-options.rst b/doc/man-sections/server-options.rst
index 03ce651..eb8e273 100644
--- a/doc/man-sections/server-options.rst
+++ b/doc/man-sections/server-options.rst
@@ -414,7 +414,7 @@
      iroute-ipv6 ipv6addr/bits
 
 --max-clients n
-  Limit server to a maximum of ``n`` concurrent clients.
+  Limit server to a maximum of ``n`` concurrent clients. Defaults to 1024.
 
 --max-routes-per-client n
   Allow a maximum of ``n`` internal routes per client (default
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 1db781d..24f2407 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -849,8 +849,6 @@
 #endif
     o->vlan_accept = VLAN_ALL;
     o->vlan_pvid = 1;
-    o->real_hash_size = 256;
-    o->virtual_hash_size = 256;
     o->n_bcast_buf = 256;
     o->tcp_queue_limit = 64;
     o->max_clients = 1024;
@@ -3724,6 +3722,22 @@
     gc_free(&gc);
 }
 #endif /* if defined(_WIN32) || defined(TARGET_ANDROID) */
+/**
+ * Sets the internal hash maps sizes according to the max_clients
+ *
+ */
+static void
+helper_hashmap_sizes(struct options *o)
+{
+    if (!o->real_hash_size)
+    {
+        o->real_hash_size = 4 * o->max_clients;
+    }
+    if (!o->virtual_hash_size)
+    {
+        o->virtual_hash_size = 4 * o->max_clients;
+    }
+}
 
 static void
 options_postprocess_mutate(struct options *o, struct env_set *es)
@@ -3739,6 +3753,11 @@
     helper_keepalive(o);
     helper_tcp_nodelay(o);
 
+    if (o->mode == MODE_SERVER)
+    {
+        helper_hashmap_sizes(o);
+    }
+
     options_postprocess_setdefault_ncpciphers(o);
     options_set_backwards_compatible_options(o);
     options_process_mutate_prf(o);

