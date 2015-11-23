From: Steffan Karger <steffan@...1856...>
Date: Mon, 23 Nov 2015 19:56:09 +0100
Message-Id: <1448304969-2277-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Fix memory leak in add_option() by
	simplifying get_ipv6_addr
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

If get_ipv6_addr() would fail *after* allocating memory for ipv6_local,
add_option() would fail to free that memory.

The fix here is to remove the allocation from get_ipv6_addr(), and create
a separate function for the strip-and-allocate, such that failures are
easier to handle.

Memory leak found by coverity (in 2011!).

Signed-off-by: Steffan Karger <steffan@...1856...>
---

Note: I wrote this patch for release/2.3, and although it won't apply to
master directly, it does cherry-pick from release/2.3 to master just fine.

 src/openvpn/options.c | 59 +++++++++++++++++++++++++++++++--------------------
 src/openvpn/options.h |  3 +--
 src/openvpn/route.c   |  2 +-
 3 files changed, 38 insertions(+), 26 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 59e47c6..132d779 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -961,13 +961,11 @@ get_ip_addr (const char *ip_string, int msglevel, bool *error)
  * "/nn" is optional, default to /64 if missing
  *
  * return true if parsing succeeded, modify *network and *netbits
- * return address part without "/nn" in *printable_ipv6 (if != NULL)
  */
 bool
 get_ipv6_addr( const char * prefix_str, struct in6_addr *network,
-	       unsigned int * netbits, char ** printable_ipv6, int msglevel )
+	       unsigned int * netbits, int msglevel)
 {
-    int rc;
     char * sep, * endp;
     int bits;
     struct in6_addr t_network;
@@ -994,21 +992,14 @@ get_ipv6_addr( const char * prefix_str, struct in6_addr *network,
 
     if ( sep != NULL ) *sep = '\0';
 
-    rc = inet_pton( AF_INET6, prefix_str, &t_network );
-
-    if ( rc == 1 && printable_ipv6 != NULL )
-      {
-	*printable_ipv6 = string_alloc( prefix_str, NULL );
-      }
-
-    if ( sep != NULL ) *sep = '/';
-
-    if ( rc != 1 )
+    if ( inet_pton( AF_INET6, prefix_str, &t_network ) != 1 )
       {
 	msg (msglevel, "IPv6 prefix '%s': invalid IPv6 address", prefix_str);
 	return false;
       }
 
+    if ( sep != NULL ) *sep = '/';
+
     if ( netbits != NULL )
       {
 	*netbits = bits;
@@ -1020,12 +1011,35 @@ get_ipv6_addr( const char * prefix_str, struct in6_addr *network,
     return true;		/* parsing OK, values set */
 }
 
+/**
+ * Returns newly allocated string containing address part without "/nn".
+ *
+ * If gc != NULL, the allocated memory is registered in the supplied gc.
+ */
+static char *
+get_ipv6_addr_no_netbits (const char *addr, struct gc_arena *gc)
+{
+  const char *end = strchr (addr, '/');
+  char *ret = NULL;
+  if (NULL == end)
+    {
+      ret = string_alloc (addr, gc);
+    }
+  else
+    {
+      size_t len = end - addr;
+      ret = gc_malloc (len + 1, true, gc);
+      memcpy (ret, addr, len);
+    }
+  return ret;
+}
+
 static bool ipv6_addr_safe_hexplusbits( const char * ipv6_prefix_spec )
 {
     struct in6_addr t_addr;
     unsigned int t_bits;
 
-    return get_ipv6_addr( ipv6_prefix_spec, &t_addr, &t_bits, NULL, M_WARN );
+    return get_ipv6_addr( ipv6_prefix_spec, &t_addr, &t_bits, M_WARN );
 }
 
 static char *
@@ -1267,7 +1281,7 @@ option_iroute_ipv6 (struct options *o,
 
   ALLOC_OBJ_GC (ir, struct iroute_ipv6, &o->gc);
 
-  if ( !get_ipv6_addr (prefix_str, &ir->network, &ir->netbits, NULL, msglevel ))
+  if ( !get_ipv6_addr (prefix_str, &ir->network, &ir->netbits, msglevel ))
     {
       msg (msglevel, "in --iroute-ipv6 %s: Bad IPv6 prefix specification",
 	   prefix_str);
@@ -4467,10 +4481,9 @@ add_option (struct options *options,
   else if (streq (p[0], "ifconfig-ipv6") && p[1] && p[2] )
     {
       unsigned int netbits;
-      char * ipv6_local;
 
       VERIFY_PERMISSION (OPT_P_UP);
-      if ( get_ipv6_addr( p[1], NULL, &netbits, &ipv6_local, msglevel ) &&
+      if ( get_ipv6_addr( p[1], NULL, &netbits, msglevel ) &&
            ipv6_addr_safe( p[2] ) )
         {
 	  if ( netbits < 64 || netbits > 124 )
@@ -4483,7 +4496,7 @@ add_option (struct options *options,
             /* explicitly ignoring this is a const char */
             free ((char *) options->ifconfig_ipv6_local);
 
-	  options->ifconfig_ipv6_local = ipv6_local;
+	  options->ifconfig_ipv6_local = get_ipv6_addr_no_netbits (p[1], &options->gc);
 	  options->ifconfig_ipv6_netbits = netbits;
 	  options->ifconfig_ipv6_remote = p[2];
         }
@@ -5558,7 +5571,7 @@ add_option (struct options *options,
       unsigned int netbits = 0;
 
       VERIFY_PERMISSION (OPT_P_GENERAL);
-      if ( ! get_ipv6_addr (p[1], &network, &netbits, NULL, lev) )
+      if ( ! get_ipv6_addr (p[1], &network, &netbits, lev) )
 	{
 	  msg (msglevel, "error parsing --server-ipv6 parameter");
 	  goto err;
@@ -5669,7 +5682,7 @@ add_option (struct options *options,
       unsigned int netbits = 0;
 
       VERIFY_PERMISSION (OPT_P_GENERAL);
-      if ( ! get_ipv6_addr (p[1], &network, &netbits, NULL, lev ) )
+      if ( ! get_ipv6_addr (p[1], &network, &netbits, lev ) )
 	{
 	  msg (msglevel, "error parsing --ifconfig-ipv6-pool parameters");
 	  goto err;
@@ -5930,7 +5943,7 @@ add_option (struct options *options,
 
       VERIFY_PERMISSION (OPT_P_INSTANCE);
 
-      if ( ! get_ipv6_addr( p[1], &local, &netbits, NULL, msglevel ) )
+      if ( ! get_ipv6_addr( p[1], &local, &netbits, msglevel ) )
 	{
 	  msg (msglevel, "cannot parse --ifconfig-ipv6-push addresses");
 	  goto err;
@@ -5938,7 +5951,7 @@ add_option (struct options *options,
 
       if ( p[2] )
 	{
-	  if ( !get_ipv6_addr( p[2], &remote, NULL, NULL, msglevel ) )
+	  if ( !get_ipv6_addr( p[2], &remote, NULL, msglevel ) )
 	    {
 	      msg( msglevel, "cannot parse --ifconfig-ipv6-push addresses");
 	      goto err;
@@ -5948,7 +5961,7 @@ add_option (struct options *options,
 	{
 	  if ( ! options->ifconfig_ipv6_local ||
 	       ! get_ipv6_addr( options->ifconfig_ipv6_local, &remote, 
-				NULL, NULL, msglevel ) )
+				NULL, msglevel ) )
 	    {
 	      msg( msglevel, "second argument to --ifconfig-ipv6-push missing and no global --ifconfig-ipv6 address set");
 	      goto err;
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index af9a47f..40cf71e 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -777,8 +777,7 @@ void options_string_import (struct options *options,
 			    struct env_set *es);
 
 bool get_ipv6_addr( const char * prefix_str, struct in6_addr *network,
-		    unsigned int * netbits, char ** printable_ipv6, 
-		    int msglevel );
+		    unsigned int * netbits, int msglevel );
 
 /*
  * inline functions
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index a3d4b71..1775a9c 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -390,7 +390,7 @@ init_route_ipv6 (struct route_ipv6 *r6,
 {
   r6->defined = false;
 
-  if ( !get_ipv6_addr( r6o->prefix, &r6->network, &r6->netbits, NULL, M_WARN ))
+  if ( !get_ipv6_addr( r6o->prefix, &r6->network, &r6->netbits, M_WARN ))
     goto fail;
 
   /* gateway */
-- 
2.5.0


