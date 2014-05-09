From: Paul Stewart <pstew@...1913...>
Date: Fri, 9 May 2014 09:23:01 -0700
Message-Id: <20140509162908.375CFE0247@...1914...>
Subject: [Openvpn-devel] [PATCH] Export --redirect-gateway parameters
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Report the flags passed to the --redirect-gateway and
--redirect-private flags, so that systems that manage routing
tables have hints about how the routing table should be modified.

Signed-off-by: Paul Stewart <pstew@...1913...>
---
 doc/openvpn.8       | 10 ++++++++++
 src/openvpn/route.c | 30 ++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 34894e5..40ea46c 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -5924,6 +5924,16 @@ modifier is specified, and deleted from the environment
 after the script returns.
 .\"*********************************************************
 .TP
+.B redirect_gateway
+The comma-separated list of flags provided to the
+.B \-\-redirect-gateway
+option.
+.TP
+.B redirect_private
+The comma-separated list of flags provided to the
+.B \-\-redirect-private
+option.
+.TP
 .B proto
 The
 .B \-\-proto
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 12f5b62..8c29e16 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -548,6 +548,35 @@ add_block_local (struct route_list *rl)
     }
 }
 
+static void
+setenv_redirect_gateway (struct env_set *es, unsigned int flags) {
+  struct gc_arena gc = gc_new ();
+  if (flags & RG_ENABLE)
+    {
+      struct buffer val = alloc_buf_gc( 256, &gc );
+      char *name = "redirect_private";
+
+      if (flags & RG_REROUTE_GW)
+	name = "redirect_gateway";
+      if (flags & RG_LOCAL)
+	buf_printf( &val, "local,");
+      if (flags & RG_AUTO_LOCAL)
+	buf_printf( &val, "autolocal,");
+      if (flags & RG_DEF1)
+	buf_printf( &val, "def1,");
+      if (flags & RG_BYPASS_DHCP)
+	buf_printf( &val, "bypass-dhcp,");
+      if (flags & RG_BYPASS_DNS)
+	buf_printf( &val, "bypass-dns,");
+      if (flags & RG_BLOCK_LOCAL)
+	buf_printf( &val, "block-local,");
+      buf_rmtail(&val, ',');
+
+      setenv_str( es, name, BSTR(&val) );
+    }
+  gc_free (&gc);
+}
+
 bool
 init_route_list (struct route_list *rl,
 		 const struct route_option_list *opt,
@@ -620,6 +649,7 @@ init_route_list (struct route_list *rl,
     {
       add_block_local (rl);
       get_bypass_addresses (&rl->spec.bypass, rl->flags);
+      setenv_redirect_gateway(es, rl->flags);
 #ifdef ENABLE_DEBUG
       print_bypass_addresses (&rl->spec.bypass);
 #endif
-- 
1.9.1.423.g4596e3a


