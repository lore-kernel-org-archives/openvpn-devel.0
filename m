From: Arne Schwabe <arne@...1227...>
Date: Wed, 12 Oct 2016 11:13:11 +0200
Message-Id: <1476263591-12401-1-git-send-email-arne@...1227...>
In-Reply-To: <20160916161354.GM78279@...1296...>
References: <20160916161354.GM78279@...1296...>
Subject: [Openvpn-devel] [PATCH v4] Remove tun-ipv6 Option. Instead assume
	that IPv6 is always supported.
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

This option was useful when Ipv6 tun support was non standard and was an internal/user specified flag that tracked the Ipv6 capability of the tun device.

All supported OS support IPv6. Also tun-ipv6 is pushable by the remote so not putting tun-ipv6 does not forbid ipv6 addresses.

This commit also clean up a bit of the ipv6 related tun.c. Changes for most platforms are minimal.

For linux a bit more cleanup is done:
- Remove compatibility defines that were added 2008
- Always use IFF_NO_PI for the linux tun and not only for IPv4 only tun setups (Android also always IFF_NO_PI works fine with Ipv6).

This commit also remove a non ipv6 fallback for tap driver from OpenVPN 2.2-beta or earlier and only warns.

Patch V2: Integrate Gert's comments
Patch V3: Remove tun_ipv4 option. It only used for MTU discovery and there it was wrong since it should on the transport protocol if at all
Patch V4: Completely remove support for NetBSD <= 4.0 and remove NETBSD_MULTI_AF defines
---
 Changes.rst           |   3 ++
 src/openvpn/forward.c |   2 +-
 src/openvpn/helper.c  |   2 -
 src/openvpn/init.c    |   6 ---
 src/openvpn/multi.c   |   8 ++-
 src/openvpn/openvpn.h |   5 --
 src/openvpn/options.c |  11 +---
 src/openvpn/options.h |   1 -
 src/openvpn/route.c   |  13 ++---
 src/openvpn/tun.c     | 139 +++++++-------------------------------------------
 src/openvpn/tun.h     |   2 -
 11 files changed, 30 insertions(+), 162 deletions(-)

diff --git a/Changes.rst b/Changes.rst
index 9fcba75..2956003 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -135,6 +135,9 @@ User-visible Changes
   ciphers configured in the config file.  Use --ncp-disable if you don't want
   that.
 
+- ALl tun devices on all platforms are considered always IPv6 capable. The --tun-ipv6
+  option is ignored (behaves like it is always on).
+
 
 Maintainer-visible changes
 --------------------------
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 6c11439..b3077ed 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -391,7 +391,7 @@ check_fragment_dowork (struct context *c)
   struct link_socket_info *lsi = get_link_socket_info (c);
 
   /* OS MTU Hint? */
-  if (lsi->mtu_changed && c->c2.ipv4_tun)
+  if (lsi->mtu_changed)
     {
       frame_adjust_path_mtu (&c->c2.frame_fragment, c->c2.link_socket->mtu,
 			     c->options.ce.proto);
diff --git a/src/openvpn/helper.c b/src/openvpn/helper.c
index 62f88ec..229523d 100644
--- a/src/openvpn/helper.c
+++ b/src/openvpn/helper.c
@@ -200,8 +200,6 @@ helper_client_server (struct options *o)
 		add_in6_addr( o->server_network_ipv6, 0x1000 );
 	o->ifconfig_ipv6_pool_netbits = o->server_netbits_ipv6;
 
-	o->tun_ipv6 = true;
-
 	push_option( o, "tun-ipv6", M_USAGE );
      }
 
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index cc8e945..73f8c6d 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1400,9 +1400,6 @@ do_init_tun (struct context *c)
 			   !c->options.ifconfig_nowarn,
 			   c->c2.es);
 
-  /* flag tunnel for IPv6 config if --tun-ipv6 is set */
-  c->c1.tuntap->ipv6 = c->options.tun_ipv6;
-
   init_tun_post (c->c1.tuntap,
 		 &c->c2.frame,
 		 &c->options.tuntap_options);
@@ -1420,9 +1417,6 @@ do_open_tun (struct context *c)
   struct gc_arena gc = gc_new ();
   bool ret = false;
 
-  c->c2.ipv4_tun = (!c->options.tun_ipv6
-		    && is_dev_type (c->options.dev, c->options.dev_type, "tun"));
-
 #ifndef TARGET_ANDROID
   if (!c->c1.tuntap)
     {
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 3bc6ee9..93a554d 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1378,8 +1378,7 @@ multi_select_virtual_addr (struct multi_context *m, struct multi_instance *mi)
        * (see below) so issue a warning if that happens - don't break the
        * session, though, as we don't even know if this client WANTS IPv6
        */
-      if ( mi->context.c1.tuntap->ipv6 &&
-	   mi->context.options.ifconfig_ipv6_pool_defined &&
+      if ( mi->context.options.ifconfig_ipv6_pool_defined &&
 	   ! mi->context.options.push_ifconfig_ipv6_defined )
 	{
 	  msg( M_INFO, "MULTI_sva: WARNING: if --ifconfig-push is used for IPv4, automatic IPv6 assignment from --ifconfig-ipv6-pool does not work.  Use --ifconfig-ipv6-push for IPv6 then." );
@@ -1452,8 +1451,7 @@ multi_select_virtual_addr (struct multi_context *m, struct multi_instance *mi)
    * way round ("dynamic IPv4, static IPv6") or "both static" makes sense
    * -> and so it's implemented right now
    */
-  if ( mi->context.c1.tuntap->ipv6 &&
-       mi->context.options.push_ifconfig_ipv6_defined )
+  if ( mi->context.options.push_ifconfig_ipv6_defined )
     {
       mi->context.c2.push_ifconfig_ipv6_local = 
 	    mi->context.options.push_ifconfig_ipv6_local;
@@ -1511,7 +1509,7 @@ multi_set_virtual_addr_env (struct multi_context *m, struct multi_instance *mi)
   setenv_del (mi->context.c2.es, "ifconfig_pool_remote_ip6");
   setenv_del (mi->context.c2.es, "ifconfig_pool_ip6_netbits");
 
-  if (mi->context.c1.tuntap->ipv6 && mi->context.c2.push_ifconfig_ipv6_defined)
+  if (mi->context.c2.push_ifconfig_ipv6_defined)
     {
       setenv_in6_addr (mi->context.c2.es,
                        "ifconfig_pool_remote",
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index 65a183a..5cda7b4 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -390,11 +390,6 @@ struct context_2
   struct buffer to_tun;
   struct buffer to_link;
 
-  /*
-   * IPv4 TUN device?
-   */
-  bool ipv4_tun;
-
   /* should we print R|W|r|w to console on packet transfers? */
   bool log_rw;
 
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index d97dc8f..ee8d351 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1500,7 +1500,6 @@ show_settings (const struct options *o)
   SHOW_STR (dev_node);
   SHOW_STR (lladdr);
   SHOW_INT (topology);
-  SHOW_BOOL (tun_ipv6);
   SHOW_STR (ifconfig_local);
   SHOW_STR (ifconfig_remote_netmask);
   SHOW_BOOL (ifconfig_noexec);
@@ -2103,10 +2102,6 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
                   options->connection_list->array[0]->remote)
           msg (M_USAGE, "<connection> cannot be used with --mode server");
 
-#if 0
-      if (options->tun_ipv6)
-	msg (M_USAGE, "--tun-ipv6 cannot be used with --mode server");
-#endif
       if (options->shaper)
 	msg (M_USAGE, "--shaper cannot be used with --mode server");
       if (options->inetd)
@@ -2130,9 +2125,6 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
 	msg (M_USAGE, "--ifconfig-pool-persist must be used with --ifconfig-pool");
       if (options->ifconfig_ipv6_pool_defined && !options->ifconfig_ipv6_local )
 	msg (M_USAGE, "--ifconfig-ipv6-pool needs --ifconfig-ipv6");
-      if (options->ifconfig_ipv6_local && !options->tun_ipv6 )
-	msg (M_INFO, "Warning: --ifconfig-ipv6 without --tun-ipv6 will not do IPv6");
-
       if (options->auth_user_pass_file)
 	msg (M_USAGE, "--auth-user-pass cannot be used with --mode server (it should be used on the client side only)");
       if (options->ccd_exclusive && !options->client_config_dir)
@@ -3076,7 +3068,7 @@ options_string (const struct options *o,
   /* send tun_ipv6 only in peer2peer mode - in client/server mode, it
    * is usually pushed by the server, triggering a non-helpful warning
    */
-  if (o->tun_ipv6 && o->mode == MODE_POINT_TO_POINT && !PULL_DEFINED(o))
+  if (o->ifconfig_ipv6_local && o->mode == MODE_POINT_TO_POINT && !PULL_DEFINED(o))
     buf_printf (&out, ",tun-ipv6");
 
   /*
@@ -4577,7 +4569,6 @@ add_option (struct options *options,
   else if (streq (p[0], "tun-ipv6") && !p[1])
     {
       VERIFY_PERMISSION (OPT_P_UP);
-      options->tun_ipv6 = true;
     }
 #ifdef ENABLE_IPROUTE
   else if (streq (p[0], "iproute") && p[1] && !p[2])
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 9b7b57c..b7453a0 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -251,7 +251,6 @@ struct options
   int ping_send_timeout;        /* Send a TCP/UDP ping to remote every n seconds */
   int ping_rec_timeout;         /* Expect a TCP/UDP ping from remote at least once every n seconds */
   bool ping_timer_remote;       /* Run ping timer only if we have a remote address */
-  bool tun_ipv6;                /* Build tun dev that supports IPv6 */
 
 # define PING_UNDEF   0
 # define PING_EXIT    1
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index aace2af..8a3bbba 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1729,10 +1729,10 @@ add_route_ipv6 (struct route_ipv6 *r6, const struct tuntap *tt, unsigned int fla
     }
 #endif
 
-  if ( !tt->ipv6 )
+  if (!tt->did_ifconfig_ipv6_setup)
     {
-      msg( M_INFO, "add_route_ipv6(): not adding %s/%d, no IPv6 on if %s",
-		    network, r6->netbits, device );
+      msg( M_INFO, "add_route_ipv6(): not adding %s/%d, no IPv6 ifconfig on if %s",
+		    network, r6->netbits, device);
       return;
     }
 
@@ -2159,13 +2159,6 @@ delete_route_ipv6 (const struct route_ipv6 *r6, const struct tuntap *tt, unsigne
     }
 #endif
 
-  if ( !tt->ipv6 )
-    {
-      msg( M_INFO, "delete_route_ipv6(): not deleting %s/%d, no IPv6 on if %s",
-		    network, r6->netbits, device );
-      return;
-    }
-
   msg( M_INFO, "delete_route_ipv6(%s/%d)", network, r6->netbits );
 
   /* if we used a gateway on "add route", we also need to specify it on
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index b7a29f7..226ff7d 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -741,8 +741,8 @@ do_ifconfig (struct tuntap *tt,
 
       argv_init (&argv);
 
-      msg( M_INFO, "do_ifconfig, tt->ipv6=%d, tt->did_ifconfig_ipv6_setup=%d",
-	           tt->ipv6, tt->did_ifconfig_ipv6_setup );
+      msg( M_INFO, "do_ifconfig, tt->did_ifconfig_ipv6_setup=%d",
+	            tt->did_ifconfig_ipv6_setup );
 
       /*
        * We only handle TUN/TAP devices here, not --dev null devices.
@@ -755,7 +755,7 @@ do_ifconfig (struct tuntap *tt,
       ifconfig_local = print_in_addr_t (tt->local, 0, &gc);
       ifconfig_remote_netmask = print_in_addr_t (tt->remote_netmask, 0, &gc);
 
-      if ( tt->ipv6 && tt->did_ifconfig_ipv6_setup )
+      if (tt->did_ifconfig_ipv6_setup )
         {
 	  ifconfig_ipv6_local = print_in6_addr (tt->local_ipv6, 0, &gc);
 	  ifconfig_ipv6_remote = print_in6_addr (tt->remote_ipv6, 0, &gc);
@@ -1077,13 +1077,6 @@ do_ifconfig (struct tuntap *tt,
 
 #elif defined(TARGET_NETBSD)
 
-/* whether or not NetBSD can do IPv6 can be seen by the availability of
- * the TUNSIFHEAD ioctl() - see next TARGET_NETBSD block for more details
- */
-#ifdef TUNSIFHEAD
-# define NETBSD_MULTI_AF
-#endif
-
       if (tun)
 	argv_printf (&argv,
 			  "%s %s %s %s mtu %d netmask 255.255.255.255 up",
@@ -1126,7 +1119,6 @@ do_ifconfig (struct tuntap *tt,
 
       if ( do_ipv6 )
 	{
-#ifdef NETBSD_MULTI_AF
 	  argv_printf (&argv,
 			  "%s %s inet6 %s/%d",
 			  IFCONFIG_PATH,
@@ -1139,10 +1131,6 @@ do_ifconfig (struct tuntap *tt,
 
 	  /* and, hooray, we explicitely need to add a route... */
 	  add_route_connected_v6_net(tt, es);
-#else
-	  msg( M_INFO, "no IPv6 support for tun interfaces on NetBSD before 4.0 (if your system is newer, recompile openvpn)" );
-	  tt->ipv6 = false;
-#endif
 	}
       tt->did_ifconfig = true;
 
@@ -1425,7 +1413,6 @@ clear_tuntap (struct tuntap *tuntap)
 #ifdef TARGET_SOLARIS
   tuntap->ip_fd = -1;
 #endif
-  tuntap->ipv6 = false;
 }
 
 static void
@@ -1478,7 +1465,7 @@ write_tun_header (struct tuntap* tt, uint8_t *buf, int len)
 
         iph = (struct ip *) buf;
 
-        if (tt->ipv6 && iph->ip_v == 6)
+        if (iph->ip_v == 6)
             type = htonl (AF_INET6);
         else
             type = htonl (AF_INET);
@@ -1526,7 +1513,7 @@ open_tun_generic (const char *dev, const char *dev_type, const char *dev_node,
   bool dynamic_opened = false;
 
 
-  if ( tt->ipv6 && ! ipv6_explicitly_supported )
+  if (  ! ipv6_explicitly_supported )
     msg (M_WARN, "NOTE: explicit support for IPv6 tun devices is not provided for this OS");
 
   if (tt->type == DEV_TYPE_NULL)
@@ -1710,7 +1697,6 @@ read_tun (struct tuntap* tt, uint8_t *buf, int len)
 }
 
 #elif defined(TARGET_LINUX)
-#ifdef HAVE_LINUX_IF_TUN_H	/* New driver support */
 
 #ifndef HAVE_LINUX_SOCKIOS_H
 #error header file linux/sockios.h required
@@ -1751,8 +1737,7 @@ open_tun (const char *dev, const char *dev_type, const char *dev_node, struct tu
        * Process --tun-ipv6
        */
       CLEAR (ifr);
-      if (!tt->ipv6)
-	ifr.ifr_flags = IFF_NO_PI;
+      ifr.ifr_flags = IFF_NO_PI;
 
 #if defined(IFF_ONE_QUEUE) && defined(SIOCSIFTXQLEN)
       ifr.ifr_flags |= IFF_ONE_QUEUE;
@@ -1833,32 +1818,10 @@ open_tun (const char *dev, const char *dev_type, const char *dev_node, struct tu
   ASSERT (0);
 }
 
-#endif
-
-#else
-
-void
-open_tun (const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt)
-{
-  open_tun_generic (dev, dev_type, dev_node, false, true, tt);
-}
-
-#endif /* HAVE_LINUX_IF_TUN_H */
+#endif /* !PENDANTIC */
 
 #ifdef ENABLE_FEATURE_TUN_PERSIST
 
-/*
- * This can be removed in future
- * when all systems will use newer
- * linux-headers
- */
-#ifndef TUNSETOWNER
-#define TUNSETOWNER	_IOW('T', 204, int)
-#endif
-#ifndef TUNSETGROUP
-#define TUNSETGROUP	_IOW('T', 206, int)
-#endif
-
 void
 tuncfg (const char *dev, const char *dev_type, const char *dev_node, int persist_mode, const char *username, const char *groupname, const struct tuntap_options *options)
 {
@@ -1940,7 +1903,7 @@ close_tun (struct tuntap *tt)
 	    argv_msg (M_INFO, &argv);
 	    openvpn_execve_check (&argv, NULL, 0, "Linux ip addr del failed");
 
-            if (tt->ipv6 && tt->did_ifconfig_ipv6_setup)
+            if (tt->did_ifconfig_ipv6_setup)
               {
                 const char * ifconfig_ipv6_local = print_in6_addr (tt->local_ipv6, 0, &gc);
 
@@ -1977,53 +1940,13 @@ close_tun (struct tuntap *tt)
 int
 write_tun (struct tuntap* tt, uint8_t *buf, int len)
 {
-  if (tt->ipv6)
-    {
-      struct tun_pi pi;
-      struct iphdr *iph;
-      struct iovec vect[2];
-      int ret;
-
-      iph = (struct iphdr *)buf;
-
-      pi.flags = 0;
-
-      if(iph->version == 6)
-	pi.proto = htons(OPENVPN_ETH_P_IPV6);
-      else
-	pi.proto = htons(OPENVPN_ETH_P_IPV4);
-
-      vect[0].iov_len = sizeof(pi);
-      vect[0].iov_base = &pi;
-      vect[1].iov_len = len;
-      vect[1].iov_base = buf;
-
-      ret = writev(tt->fd, vect, 2);
-      return(ret - sizeof(pi));
-    }
-  else
-    return write (tt->fd, buf, len);
+  return write (tt->fd, buf, len);
 }
 
 int
 read_tun (struct tuntap* tt, uint8_t *buf, int len)
 {
-  if (tt->ipv6)
-    {
-      struct iovec vect[2];
-      struct tun_pi pi;
-      int ret;
-
-      vect[0].iov_len = sizeof(pi);
-      vect[0].iov_base = &pi;
-      vect[1].iov_len = len;
-      vect[1].iov_base = buf;
-
-      ret = readv(tt->fd, vect, 2);
-      return(ret - sizeof(pi));
-    }
-  else
-    return read (tt->fd, buf, len);
+  return read (tt->fd, buf, len);
 }
 
 #elif defined(TARGET_SOLARIS)
@@ -2227,7 +2150,7 @@ solaris_close_tun (struct tuntap *tt)
   if (tt)
     {
       /* IPv6 interfaces need to be 'manually' de-configured */
-      if ( tt->ipv6 && tt->did_ifconfig_ipv6_setup )
+      if ( tt->did_ifconfig_ipv6_setup )
 	{
 	  struct argv argv;
 	  argv_init (&argv);
@@ -2435,11 +2358,7 @@ read_tun (struct tuntap *tt, uint8_t *buf, int len)
 void
 open_tun (const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt)
 {
-#ifdef NETBSD_MULTI_AF
     open_tun_generic (dev, dev_type, dev_node, true, true, tt);
-#else
-    open_tun_generic (dev, dev_type, dev_node, false, true, tt);
-#endif
 
     if (tt->fd >= 0)
       {
@@ -2448,7 +2367,6 @@ open_tun (const char *dev, const char *dev_type, const char *dev_node, struct tu
         i = 0;
         ioctl (tt->fd, TUNSLMODE, &i);   /* link layer mode off */
 
-#ifdef NETBSD_MULTI_AF
 	if ( tt->type == DEV_TYPE_TUN )
 	  {
 	    i = 1;
@@ -2457,7 +2375,6 @@ open_tun (const char *dev, const char *dev_type, const char *dev_node, struct tu
 		msg (M_WARN | M_ERRNO, "ioctl(TUNSIFHEAD): %s", strerror(errno));
 	      }
 	  }
-#endif
       }
 }
 
@@ -2496,8 +2413,6 @@ close_tun (struct tuntap *tt)
     }
 }
 
-#ifdef NETBSD_MULTI_AF
-
 static inline int
 netbsd_modify_read_write_return (int len)
 {
@@ -2518,7 +2433,7 @@ write_tun (struct tuntap* tt, uint8_t *buf, int len)
 
       iph = (struct openvpn_iphdr *) buf;
 
-      if (tt->ipv6 && OPENVPN_IPH_GET_VER(iph->version_len) == 6)
+      if (OPENVPN_IPH_GET_VER(iph->version_len) == 6)
         type = htonl (AF_INET6);
       else 
         type = htonl (AF_INET);
@@ -2553,21 +2468,6 @@ read_tun (struct tuntap* tt, uint8_t *buf, int len)
     return read (tt->fd, buf, len);
 }
 
-#else	/* not NETBSD_MULTI_AF -> older code, IPv4 only */
-
-int
-write_tun (struct tuntap* tt, uint8_t *buf, int len)
-{
-    return write (tt->fd, buf, len);
-}
-
-int
-read_tun (struct tuntap* tt, uint8_t *buf, int len)
-{
-    return read (tt->fd, buf, len);
-}
-#endif	/* NETBSD_MULTI_AF */
-
 #elif defined(TARGET_FREEBSD)
 
 static inline int
@@ -2644,7 +2544,7 @@ write_tun (struct tuntap* tt, uint8_t *buf, int len)
 
       iph = (struct ip *) buf;
 
-      if (tt->ipv6 && iph->ip_v == 6)
+      if (iph->ip_v == 6)
         type = htonl (AF_INET6);
       else 
         type = htonl (AF_INET);
@@ -2727,7 +2627,7 @@ write_tun (struct tuntap* tt, uint8_t *buf, int len)
 
       iph = (struct ip *) buf;
 
-      if (tt->ipv6 && iph->ip_v == 6)
+      if (iph->ip_v == 6)
         type = htonl (AF_INET6);
       else 
         type = htonl (AF_INET);
@@ -2954,7 +2854,7 @@ close_tun (struct tuntap* tt)
       struct argv argv;
       argv_init (&argv);
 
-      if ( tt->ipv6 && tt->did_ifconfig_ipv6_setup )
+      if (tt->did_ifconfig_ipv6_setup )
 	{
 	  const char * ifconfig_ipv6_local =
 				print_in6_addr (tt->local_ipv6, 0, &gc);
@@ -5182,7 +5082,7 @@ open_tun (const char *dev, const char *dev_type, const char *dev_node, struct tu
 
   /*netcmd_semaphore_lock ();*/
 
-  msg( M_INFO, "open_tun, tt->ipv6=%d", tt->ipv6 );
+  msg( M_INFO, "open_tun");
 
   if (tt->type == DEV_TYPE_NULL)
     {
@@ -5308,11 +5208,10 @@ open_tun (const char *dev, const char *dev_type, const char *dev_node, struct tu
     /* usage of numeric constants is ugly, but this is really tied to
      * *this* version of the driver
      */
-    if ( tt->ipv6 && tt->type == DEV_TYPE_TUN &&
+    if (tt->type == DEV_TYPE_TUN &&
          info[0] == 9 && info[1] < 8)
       {
-	msg( M_INFO, "WARNING:  Tap-Win32 driver version %d.%d does not support IPv6 in TUN mode.  IPv6 will be disabled.  Upgrade to Tap-Win32 9.8 (2.2-beta3 release or later) or use TAP mode to get IPv6", (int) info[0], (int) info[1] );
-	tt->ipv6 = false;
+	msg( M_INFO, "WARNING:  Tap-Win32 driver version %d.%d does not support IPv6 in TUN mode.  IPv6 will not work.  Upgrade to Tap-Win32 9.8 (2.2-beta3 release or later) or use TAP mode to get IPv6", (int) info[0], (int) info[1] );
       }
 
     /* tap driver 9.8 (2.2.0 and 2.2.1 release) is buggy
@@ -5653,7 +5552,7 @@ close_tun (struct tuntap *tt)
 
   if (tt)
     {
-      if ( tt->ipv6 && tt->did_ifconfig_ipv6_setup )
+      if ( tt->did_ifconfig_ipv6_setup )
         {
           if (tt->options.msg_channel)
             {
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 4e93a3f..88431fb 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -139,8 +139,6 @@ struct tuntap
   bool did_ifconfig_ipv6_setup;
   bool did_ifconfig;
 
-  bool ipv6;
-
   bool persistent_if;		/* if existed before, keep on program end */
 
   struct tuntap_options options; /* options set on command line */
-- 
2.8.4 (Apple Git-73)


