From: Jan Seeger <jan.seeger@...2574...>
Date: Wed, 30 Sep 2020 08:48:45 +0200
Message-Id: <20200930064845.28022-1-jan.seeger@...2574...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Added environment variable for IPv6 route
 metric.
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
 doc/man-sections/script-options.rst | 8 ++++----
 src/openvpn/route.c                 | 7 +++++++
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/doc/man-sections/script-options.rst b/doc/man-sections/script-options.rst
index a4df6732..03b3dd77 100644
--- a/doc/man-sections/script-options.rst
+++ b/doc/man-sections/script-options.rst
@@ -709,10 +709,10 @@ instances.
     A set of variables which define each IPv6 route to be added, and are
     set prior to **--up** script execution.
 
-    ``parm`` will be one of :code:`network` or :code:`gateway`
-    (:code:`netmask` is contained as :code:`/nnn` in the
-    ``route_ipv6_network_{n}``, unlike IPv4 where it is passed in a
-    separate environment variable).
+    ``parm`` will be one of :code:`network`, :code:`gateway` or
+    :code:`metric`. ``route_ipv6_network_{n}`` contains :code:`netmask`
+    as :code:`/nnn`, unlike IPv4 where it is passed in a separate environment
+    variable.
 
     ``n`` is the OpenVPN route number, starting from 1.
 
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index d75aa5f4..30cdabba 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1479,6 +1479,13 @@ setenv_route_ipv6(struct env_set *es, const struct route_ipv6 *r6, int i)
 
         buf_printf( &name2, "route_ipv6_gateway_%d", i );
         setenv_str( es, BSTR(&name2), print_in6_addr( r6->gateway, 0, &gc ));
+
+        if (r6->flags & RT_METRIC_DEFINED)
+        {
+            struct buffer name3 = alloc_buf_gc( 256, &gc );
+            buf_printf( &name3, "route_ipv6_metric_%d", i) ;
+            setenv_int( es, BSTR(&name3), r6->metric);
+        }
     }
     gc_free(&gc);
 }
-- 
2.26.2


