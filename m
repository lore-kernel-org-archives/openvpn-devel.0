From: Gert Doering <gert@...1296...>
Date: Fri, 11 Sep 2015 17:33:41 +0200
Message-Id: <1441985627-14822-5-git-send-email-gert@...1296...>
In-Reply-To: <1441985627-14822-1-git-send-email-gert@...1296...>
References: <1441985627-14822-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH 04/10] Create basic infrastructure for IPv6
	default gateway handling / redirection.
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

- introduce get_default_gateway_ipv6() and add stub functions with the
  implementation plan to the 4 major code blocks here (Windows,
  Linux/Android, *BSD and Solaris, "others")

- add &rgi6 to print_default_gateway(), and teach it to print v4, v6
  or both, depending on the calling environment

- unlike IPv4 (today), get_default_gateway_ipv6() is passed the actual
  target IPv6 address of the server we're looking for, so we can handle
  more complicated routing setups ("default to eth0, vpn server to ppp0")
  correctly

- consequently, --get-default-gateway has an optional parameter now, the
  IPv6 address to look up (for debugging)
---
 src/openvpn/init.c    |  4 ++-
 src/openvpn/options.c |  9 ++++--
 src/openvpn/route.c   | 76 +++++++++++++++++++++++++++++++++++++++++++++++++--
 src/openvpn/route.h   |  6 +++-
 4 files changed, 88 insertions(+), 7 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index fe00918..4c17905 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -639,8 +639,10 @@ init_static (void)
 #ifdef TEST_GET_DEFAULT_GATEWAY
   {
     struct route_gateway_info rgi;
+    struct route_ipv6_gateway_info rgi6;
     get_default_gateway(&rgi);
-    print_default_gateway(M_INFO, &rgi);
+    get_default_gateway_ipv6(&rgi6, NULL);
+    print_default_gateway(M_INFO, &rgi, &rgi6);
     return false;
   }
 #endif
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index caf1394..93ea415 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -4156,12 +4156,17 @@ add_option (struct options *options,
       read_config_file (options, p[1], level, file, line, msglevel, permission_mask, option_types_found, es);
     }
 #if defined(ENABLE_DEBUG) && !defined(ENABLE_SMALL)
-  else if (streq (p[0], "show-gateway") && !p[1])
+  else if (streq (p[0], "show-gateway") && !p[2])
     {
       struct route_gateway_info rgi;
+      struct route_ipv6_gateway_info rgi6;
+      struct in6_addr remote = IN6ADDR_ANY_INIT;
       VERIFY_PERMISSION (OPT_P_GENERAL);
+      if (p[1])
+	  get_ipv6_addr (p[1], &remote, NULL, NULL, M_WARN);
       get_default_gateway(&rgi);
-      print_default_gateway(M_INFO, &rgi);
+      get_default_gateway_ipv6(&rgi6, &remote);
+      print_default_gateway(M_INFO, &rgi, &rgi6);
       openvpn_exit (OPENVPN_EXIT_STATUS_GOOD); /* exit point */
     }
 #endif
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 6b2af3c..fd8209d 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -578,7 +578,7 @@ init_route_list (struct route_list *rl,
     {
       setenv_route_addr (es, "net_gateway", rl->rgi.gateway.addr, -1);
 #if defined(ENABLE_DEBUG) && !defined(ENABLE_SMALL)
-      print_default_gateway (D_ROUTE, &rl->rgi);
+      print_default_gateway (D_ROUTE, &rl->rgi, NULL);
 #endif
     }
   else
@@ -1084,10 +1084,12 @@ print_route_options (const struct route_option_list *rol,
 }
 
 void
-print_default_gateway(const int msglevel, const struct route_gateway_info *rgi)
+print_default_gateway(const int msglevel,
+	              const struct route_gateway_info *rgi,
+	              const struct route_ipv6_gateway_info *rgi6)
 {
   struct gc_arena gc = gc_new ();
-  if (rgi->flags & RGI_ADDR_DEFINED)
+  if (rgi && (rgi->flags & RGI_ADDR_DEFINED))
     {
       struct buffer out = alloc_buf_gc (256, &gc);
       buf_printf (&out, "ROUTE_GATEWAY");
@@ -1108,6 +1110,28 @@ print_default_gateway(const int msglevel, const struct route_gateway_info *rgi)
 	buf_printf (&out, " HWADDR=%s", format_hex_ex (rgi->hwaddr, 6, 0, 1, ":", &gc));
       msg (msglevel, "%s", BSTR (&out));
     }
+
+  if (rgi6 && (rgi6->flags & RGI_ADDR_DEFINED))
+    {
+      struct buffer out = alloc_buf_gc (256, &gc);
+      buf_printf (&out, "ROUTE6_GATEWAY");
+      if (rgi6->flags & RGI_ON_LINK)
+	buf_printf (&out, " ON_LINK");
+      else
+	buf_printf (&out, " %s", print_in6_addr (rgi6->gateway.addr_ipv6, 0, &gc));
+      if (rgi6->flags & RGI_NETMASK_DEFINED)
+	buf_printf (&out, "/%d", rgi6->gateway.netbits_ipv6);
+#ifdef WIN32
+      if (rgi6->flags & RGI_IFACE_DEFINED)
+	buf_printf (&out, " I=%u", (unsigned int)rgi6->adapter_index);
+#else
+      if (rgi6->flags & RGI_IFACE_DEFINED)
+	buf_printf (&out, " IFACE=%s", rgi6->iface);
+#endif
+      if (rgi6->flags & RGI_HWADDR_DEFINED)
+	buf_printf (&out, " HWADDR=%s", format_hex_ex (rgi6->hwaddr, 6, 0, 1, ":", &gc));
+      msg (msglevel, "%s", BSTR (&out));
+    }
   gc_free (&gc);
 }
 
@@ -2308,6 +2332,17 @@ windows_route_find_if_index (const struct route_ipv4 *r, const struct tuntap *tt
   return ret;
 }
 
+/* IPv6 implementation using GetIpForwardTable2() and dynamic linking (TBD)
+ * https://msdn.microsoft.com/en-us/library/windows/desktop/aa814416(v=vs.85).aspx
+ */
+void
+get_default_gateway_ipv6(struct route_ipv6_gateway_info *rgi6,
+			 struct in6_addr *dest)
+{
+    msg(D_ROUTE, "no support for get_default_gateway_ipv6() on this system (windows)");
+    CLEAR(*rgi6);
+}
+
 bool
 add_route_ipapi (const struct route_ipv4 *r, const struct tuntap *tt, DWORD adapter_index)
 {
@@ -2624,6 +2659,24 @@ get_default_gateway (struct route_gateway_info *rgi)
   gc_free (&gc);
 }
 
+/* IPv6 implementation using netlink (TBD)
+ */
+void
+get_default_gateway_ipv6(struct route_ipv6_gateway_info *rgi6,
+			 struct in6_addr *dest)
+{
+    msg(D_ROUTE, "no support for get_default_gateway_ipv6() on this system (Linux and Android)");
+    CLEAR(*rgi6);
+    struct in6_addr g = IN6ADDR_LOOPBACK_INIT;
+
+    rgi6->flags = RGI_ADDR_DEFINED | RGI_IFACE_DEFINED | RGI_HWADDR_DEFINED | 
+    		RGI_NETMASK_DEFINED;
+    rgi6->gateway.addr_ipv6 = g;
+    rgi6->gateway.netbits_ipv6 = 64;
+    memcpy( rgi6->hwaddr, "\1\2\3\4\5\6", 6 );
+    strcpy( rgi6->iface, "eth1" );
+}
+
 #elif defined(TARGET_DARWIN) || defined(TARGET_SOLARIS) || \
 	defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY) || \
 	defined(TARGET_OPENBSD) || defined(TARGET_NETBSD)
@@ -2866,6 +2919,16 @@ get_default_gateway (struct route_gateway_info *rgi)
   gc_free (&gc);
 }
 
+/* BSD implementation using routing socket (as does IPv4) (TBD)
+ */
+void
+get_default_gateway_ipv6(struct route_ipv6_gateway_info *rgi6,
+			 struct in6_addr *dest)
+{
+    msg(D_ROUTE, "no support for get_default_gateway_ipv6() on this system (BSD and OSX)");
+    CLEAR(*rgi6);
+}
+
 #undef max
 
 #else
@@ -2899,6 +2962,13 @@ get_default_gateway (struct route_gateway_info *rgi)
 {
   CLEAR(*rgi);
 }
+void
+get_default_gateway_ipv6(struct route_ipv6_gateway_info *rgi6,
+			 struct in6_addr *dest)
+{
+    msg(D_ROUTE, "no support for get_default_gateway_ipv6() on this system");
+    CLEAR(*rgi6);
+}
 
 #endif
 
diff --git a/src/openvpn/route.h b/src/openvpn/route.h
index 5ab5f98..95cf99f 100644
--- a/src/openvpn/route.h
+++ b/src/openvpn/route.h
@@ -300,7 +300,11 @@ void setenv_routes_ipv6 (struct env_set *es, const struct route_ipv6_list *rl6);
 bool is_special_addr (const char *addr_str);
 
 void get_default_gateway (struct route_gateway_info *rgi);
-void print_default_gateway(const int msglevel, const struct route_gateway_info *rgi);
+void get_default_gateway_ipv6 (struct route_ipv6_gateway_info *rgi,
+				struct in6_addr *dest);
+void print_default_gateway(const int msglevel,
+                           const struct route_gateway_info *rgi,
+                           const struct route_ipv6_gateway_info *rgi6);
 
 /*
  * Test if addr is reachable via a local interface (return ILA_LOCAL),
-- 
2.3.6


