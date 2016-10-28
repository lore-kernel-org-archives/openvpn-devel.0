From: Heiko Hund <heiko.hund@...1489...>
Date: Fri, 28 Oct 2016 18:42:38 +0200
Message-ID: <1477672963-5724-3-git-send-email-heiko.hund@...1489...>
In-Reply-To: <1477672963-5724-1-git-send-email-heiko.hund@...1489...>
References: <1477672963-5724-1-git-send-email-heiko.hund@...1489...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/7] Remove unused and unecessary argv
	interfaces
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

Signed-off-by: Heiko Hund <heiko.hund@...1489...>
---
 src/openvpn/argv.c            | 53 +++++++++++++++++++------------------------
 src/openvpn/argv.h            |  6 -----
 src/openvpn/console_systemd.c |  3 +--
 src/openvpn/route.c           | 12 ++++------
 src/openvpn/tun.c             | 42 +++++++++++-----------------------
 5 files changed, 41 insertions(+), 75 deletions(-)

diff --git a/src/openvpn/argv.c b/src/openvpn/argv.c
index 60534ac..89c9b14 100644
--- a/src/openvpn/argv.c
+++ b/src/openvpn/argv.c
@@ -39,7 +39,7 @@
 #include "argv.h"
 #include "options.h"
 
-void
+static void
 argv_init (struct argv *a)
 {
   a->capacity = 0;
@@ -157,12 +157,6 @@ argv_extract_cmd_name (const char *path)
   return ret;
 }
 
-const char *
-argv_system_str (const struct argv *a)
-{
-  return a->system_str;
-}
-
 static struct argv
 argv_clone (const struct argv *a, const size_t headroom)
 {
@@ -199,7 +193,7 @@ argv_insert_head (const struct argv *a, const char *head)
   return r;
 }
 
-char *
+static char *
 argv_term (const char **f)
 {
   const char *p = *f;
@@ -272,33 +266,13 @@ argv_msg_prefix (const int msglev, const struct argv *a, const char *prefix)
   gc_free (&gc);
 }
 
-void
-argv_printf (struct argv *a, const char *format, ...)
-{
-  va_list arglist;
-  va_start (arglist, format);
-  argv_printf_arglist (a, format, 0, arglist);
-  va_end (arglist);
- }
-
-void
-argv_printf_cat (struct argv *a, const char *format, ...)
-{
-  va_list arglist;
-  va_start (arglist, format);
-  argv_printf_arglist (a, format, APA_CAT, arglist);
-  va_end (arglist);
-}
-
-void
-argv_printf_arglist (struct argv *a, const char *format, const unsigned int flags, va_list arglist)
+static void
+argv_printf_arglist (struct argv *a, const char *format, va_list arglist)
 {
   struct gc_arena gc = gc_new ();
   char *term;
   const char *f = format;
 
-  if (!(flags & APA_CAT))
-    argv_reset (a);
   argv_extend (a, 1); /* ensure trailing NULL */
 
   while ((term = argv_term (&f)) != NULL)
@@ -410,3 +384,22 @@ argv_printf_arglist (struct argv *a, const char *format, const unsigned int flag
   gc_free (&gc);
 }
 
+void
+argv_printf (struct argv *a, const char *format, ...)
+{
+  va_list arglist;
+  argv_reset (a);
+  va_start (arglist, format);
+  argv_printf_arglist (a, format, arglist);
+  va_end (arglist);
+ }
+
+void
+argv_printf_cat (struct argv *a, const char *format, ...)
+{
+  va_list arglist;
+  va_start (arglist, format);
+  argv_printf_arglist (a, format, arglist);
+  va_end (arglist);
+}
+
diff --git a/src/openvpn/argv.h b/src/openvpn/argv.h
index df658a0..5f8e21c 100644
--- a/src/openvpn/argv.h
+++ b/src/openvpn/argv.h
@@ -40,18 +40,12 @@ struct argv {
   char *system_str;
 };
 
-void argv_init (struct argv *a);
 struct argv argv_new (void);
 void argv_reset (struct argv *a);
-char *argv_term (const char **f);
 const char *argv_str (const struct argv *a, struct gc_arena *gc, const unsigned int flags);
 struct argv argv_insert_head (const struct argv *a, const char *head);
 void argv_msg (const int msglev, const struct argv *a);
 void argv_msg_prefix (const int msglev, const struct argv *a, const char *prefix);
-const char *argv_system_str (const struct argv *a);
-
-#define APA_CAT (1<<0) /* concatentate onto existing struct argv list */
-void argv_printf_arglist (struct argv *a, const char *format, const unsigned int flags, va_list arglist);
 
 void argv_printf (struct argv *a, const char *format, ...)
 #ifdef __GNUC__
diff --git a/src/openvpn/console_systemd.c b/src/openvpn/console_systemd.c
index 9cd7575..8a953c9 100644
--- a/src/openvpn/console_systemd.c
+++ b/src/openvpn/console_systemd.c
@@ -60,9 +60,8 @@ get_console_input_systemd (const char *prompt, const bool echo, char *input, con
 {
     int std_out;
     bool ret = false;
-    struct argv argv;
+    struct argv argv = argv_new ();
 
-    argv_init (&argv);
     argv_printf (&argv, SYSTEMD_ASK_PASSWORD_PATH);
 #ifdef SYSTEMD_NEWER_THAN_216
     /* the --echo support arrived in upstream systemd 217 */
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 96d4e11..98bb228 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1395,7 +1395,7 @@ add_route (struct route_ipv4 *r,
 	   const struct env_set *es)
 {
   struct gc_arena gc;
-  struct argv argv;
+  struct argv argv = argv_new ();
   const char *network;
   const char *netmask;
   const char *gateway;
@@ -1406,7 +1406,6 @@ add_route (struct route_ipv4 *r,
     return;
 
   gc_init (&gc);
-  argv_init (&argv);
 
   network = print_in_addr_t (r->network, 0, &gc);
   netmask = print_in_addr_t (r->netmask, 0, &gc);
@@ -1671,7 +1670,7 @@ void
 add_route_ipv6 (struct route_ipv6 *r6, const struct tuntap *tt, unsigned int flags, const struct env_set *es)
 {
   struct gc_arena gc;
-  struct argv argv;
+  struct argv argv = argv_new ();
 
   const char *network;
   const char *gateway;
@@ -1693,7 +1692,6 @@ add_route_ipv6 (struct route_ipv6 *r6, const struct tuntap *tt, unsigned int fla
 #endif
 
   gc_init (&gc);
-  argv_init (&argv);
 
   route_ipv6_clear_host_bits (r6);
 
@@ -1933,7 +1931,7 @@ delete_route (struct route_ipv4 *r,
 	      const struct env_set *es)
 {
   struct gc_arena gc;
-  struct argv argv;
+  struct argv argv = argv_new ();
   const char *network;
   const char *netmask;
   const char *gateway;
@@ -1943,7 +1941,6 @@ delete_route (struct route_ipv4 *r,
     return;
 
   gc_init (&gc);
-  argv_init (&argv);
 
   network = print_in_addr_t (r->network, 0, &gc);
   netmask = print_in_addr_t (r->netmask, 0, &gc);
@@ -2108,7 +2105,7 @@ void
 delete_route_ipv6 (const struct route_ipv6 *r6, const struct tuntap *tt, unsigned int flags, const struct env_set *es)
 {
   struct gc_arena gc;
-  struct argv argv;
+  struct argv argv = argv_new ();
   const char *network;
   const char *gateway;
   const char *device = tt->actual_name;
@@ -2126,7 +2123,6 @@ delete_route_ipv6 (const struct route_ipv6 *r6, const struct tuntap *tt, unsigne
 #endif
 
   gc_init (&gc);
-  argv_init (&argv);
 
   network = print_in6_addr( r6->network, 0, &gc);
   gateway = print_in6_addr( r6->gateway, 0, &gc);
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index af685de..12c6976 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -752,9 +752,7 @@ do_ifconfig (struct tuntap *tt,
       const char *ifconfig_ipv6_local = NULL;
       const char *ifconfig_ipv6_remote = NULL;
       bool do_ipv6 = false;
-      struct argv argv;
-
-      argv_init (&argv);
+      struct argv argv = argv_new ();
 
       msg( M_DEBUG, "do_ifconfig, tt->did_ifconfig_ipv6_setup=%d",
 	            tt->did_ifconfig_ipv6_setup );
@@ -1844,9 +1842,8 @@ close_tun (struct tuntap *tt)
     {
 	if (tt->type != DEV_TYPE_NULL && tt->did_ifconfig)
 	  {
-	    struct argv argv;
+	    struct argv argv = argv_new ();
 	    struct gc_arena gc = gc_new ();
-	    argv_init (&argv);
 
 #ifdef ENABLE_IPROUTE
 	    if (is_tun_p2p (tt))
@@ -2129,8 +2126,7 @@ solaris_close_tun (struct tuntap *tt)
       /* IPv6 interfaces need to be 'manually' de-configured */
       if ( tt->did_ifconfig_ipv6_setup )
 	{
-	  struct argv argv;
-	  argv_init (&argv);
+	  struct argv argv = argv_new ();
 	  argv_printf( &argv, "%s %s inet6 unplumb",
 		       IFCONFIG_PATH, tt->actual_name );
 	  argv_msg (M_INFO, &argv);
@@ -2193,8 +2189,7 @@ static void
 solaris_error_close (struct tuntap *tt, const struct env_set *es, 
                      const char *actual, bool unplumb_inet6 )
 {
-  struct argv argv;
-  argv_init (&argv);
+  struct argv argv = argv_new ();
 
   if (unplumb_inet6)
     {
@@ -2286,12 +2281,11 @@ close_tun (struct tuntap* tt)
   else if (tt)
     {
       struct gc_arena gc = gc_new ();
-      struct argv argv;
+      struct argv argv = argv_new ();
 
       /* setup command, close tun dev (clears tt->actual_name!), run command
        */
 
-      argv_init (&argv);
       argv_printf (&argv, "%s %s destroy",
                           IFCONFIG_PATH, tt->actual_name);
 
@@ -2372,12 +2366,11 @@ close_tun (struct tuntap *tt)
   else if (tt)
     {
       struct gc_arena gc = gc_new ();
-      struct argv argv;
+      struct argv argv = argv_new ();
 
       /* setup command, close tun dev (clears tt->actual_name!), run command
        */
 
-      argv_init (&argv);
       argv_printf (&argv, "%s %s destroy",
                           IFCONFIG_PATH, tt->actual_name);
 
@@ -2492,12 +2485,11 @@ close_tun (struct tuntap *tt)
     }
   else if (tt)				/* close and destroy */
     {
-      struct argv argv;
+      struct argv argv = argv_new ();
 
       /* setup command, close tun dev (clears tt->actual_name!), run command
        */
 
-      argv_init (&argv);
       argv_printf (&argv, "%s %s destroy",
                           IFCONFIG_PATH, tt->actual_name);
 
@@ -2828,8 +2820,7 @@ close_tun (struct tuntap* tt)
   if (tt)
     {
       struct gc_arena gc = gc_new ();
-      struct argv argv;
-      argv_init (&argv);
+      struct argv argv = argv_new ();
 
       if (tt->did_ifconfig_ipv6_setup )
 	{
@@ -2879,7 +2870,6 @@ open_tun (const char *dev, const char *dev_type, const char *dev_node, struct tu
   char tunname[256];
   char dynamic_name[20];
   const char *p;
-  struct argv argv;
 
   if (tt->type == DEV_TYPE_NULL)
     {
@@ -2930,8 +2920,8 @@ open_tun (const char *dev, const char *dev_type, const char *dev_node, struct tu
 
       /* tunnel device must be created with 'ifconfig tapN create'
        */
+      struct argv argv = argv_new ();
       struct env_set *es = env_set_create (NULL);
-      argv_init (&argv);
       argv_printf (&argv, "%s %s create", IFCONFIG_PATH, dev);
       argv_msg (M_INFO, &argv);
       env_set_add( es, "ODMDIR=/etc/objrepos" );
@@ -2963,15 +2953,13 @@ void
 close_tun (struct tuntap* tt)
 {
   struct gc_arena gc = gc_new ();
-  struct argv argv;
+  struct argv argv = argv_new ();
   struct env_set *es = env_set_create (NULL);
 
   if (!tt) return;
 
   /* persistent devices need IP address unconfig, others need destroyal
    */
-  argv_init (&argv);
-
   if (tt->persistent_if)
     {
       argv_printf (&argv, "%s %s 0.0.0.0 down",
@@ -4495,15 +4483,13 @@ netsh_command (const struct argv *a, int n, int msglevel)
 void
 ipconfig_register_dns (const struct env_set *es)
 {
-  struct argv argv;
+  struct argv argv = argv_new ();
   bool status;
   const char err[] = "ERROR: Windows ipconfig command failed";
 
   msg (D_TUNTAP_INFO, "Start net commands...");
   netcmd_semaphore_lock ();
 
-  argv_init (&argv);
-
   argv_printf (&argv, "%s%sc stop dnscache",
 	       get_win_sys_path(),
 	       WIN_NET_PATH_SUFFIX);
@@ -4771,8 +4757,7 @@ static void
 netsh_enable_dhcp (const struct tuntap_options *to,
 		   const char *actual_name)
 {
-  struct argv argv;
-  argv_init (&argv);
+  struct argv argv = argv_new ();
 
   /* example: netsh interface ip set address my-tap dhcp */
   argv_printf (&argv,
@@ -5538,8 +5523,7 @@ close_tun (struct tuntap *tt)
           else
             {
               const char *ifconfig_ipv6_local;
-              struct argv argv;
-              argv_init (&argv);
+              struct argv argv = argv_new ();
 
               /* remove route pointing to interface */
               delete_route_connected_v6_net(tt, NULL);
-- 
2.7.4


