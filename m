From: Kevin Cernekee <cernekee@...277...>
Date: Sat, 12 Apr 2014 22:16:56 -0700
Message-Id: <1397366216-657-4-git-send-email-cernekee@...277...>
In-Reply-To: <1397366216-657-1-git-send-email-cernekee@...277...>
References: <1397366216-657-1-git-send-email-cernekee@...277...>
Subject: [Openvpn-devel] [PATCH 3/3] Add "pipe to external program" device
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

Allow the tunneled traffic to be handled by an external program rather
than by a real tun/tap kernel device.  This allows non-root users to
connect to a VPN through a userland TCP/IP stack.

Signed-off-by: Kevin Cernekee <cernekee@...277...>
---
 doc/openvpn.8      |   29 +++++++++++++--
 src/openvpn/init.c |   12 +++++--
 src/openvpn/tun.c  |  100 ++++++++++++++++++++++++++++++++++++++++++++++++----
 src/openvpn/tun.h  |    2 ++
 4 files changed, 132 insertions(+), 11 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 3a58317..00efeb8 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -709,17 +709,42 @@ peers which will be initiating connections by using the
 option.
 .\"*********************************************************
 .TP
-.B \-\-dev tunX | tapX | null
+.B \-\-dev tunX | tapX | null | <program>
 TUN/TAP virtual network device (
 .B X
 can be omitted for a dynamic device.)
 
+.B tunX
+or
+.B tapX
+is the name of a network interface that openvpn will create.
+
+.B null
+is a special value used for testing only.  It will not pass traffic.
+
+.B <program>
+is the full path to an executable, such as
+.B |/usr/bin/ocproxy,
+which will pass traffic to and from openvpn over a socketpair.  This is an
+alternative to using a tun/tap interface to pass traffic to and from the
+OS kernel; unlike tun/tap it does not require any special privileges.  The
+path must start with a `|' (pipe) character.  This works with either
+.B \-\-dev-type tun
+or
+.B \-\-dev-type tap.
+If left unspecified, it will default to tun.
+
 See examples section below
 for an example on setting up a TUN device.
 
 You must use either tun devices on both ends of the connection
 or tap devices on both ends.  You cannot mix them, as they
-represent different underlying network layers.
+represent different underlying network layers.  Similarly, endpoints using
+device type
+.B null
+will only interoperate with other
+.B null
+endpoints.
 
 .B tun
 devices encapsulate IPv4 or IPv6 (OSI Layer 3) while
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 139c625..1158ad0 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1326,7 +1326,9 @@ do_route (const struct options *options,
 	  const struct plugin_list *plugins,
 	  struct env_set *es)
 {
-  if (!options->route_noexec && ( route_list || route_ipv6_list ) )
+  if (!options->route_noexec &&
+      !tt->is_pipe &&
+      ( route_list || route_ipv6_list ) )
     {
       add_routes (route_list, route_ipv6_list, tt, ROUTE_OPTION_FLAGS (options), es);
       setenv_int (es, "redirect_gateway", route_did_redirect_default_gateway(route_list));
@@ -1450,6 +1452,7 @@ do_open_tun (struct context *c)
       /* do ifconfig */
       c->c1.tuntap->mtu = TUN_MTU_SIZE (&c->c2.frame);
       if (!c->options.ifconfig_noexec
+	  && !c->c1.tuntap->is_pipe
 	  && ifconfig_order () == IFCONFIG_BEFORE_TUN_OPEN)
 	{
 	  /* guess actual tun/tap unit number that will be returned
@@ -1462,7 +1465,8 @@ do_open_tun (struct context *c)
 	}
 
       /* possibly add routes */
-      if (route_order() == ROUTE_BEFORE_TUN) {
+      if (route_order() == ROUTE_BEFORE_TUN
+	  && !c->c1.tuntap->is_pipe) {
         /* Ignore route_delay, would cause ROUTE_BEFORE_TUN to be ignored */
         do_route (&c->options, c->c1.route_list, c->c1.route_ipv6_list,
                   c->c1.tuntap, c->plugins, c->c2.es);
@@ -1476,11 +1480,13 @@ do_open_tun (struct context *c)
 		c->c1.tuntap);
 
       /* set the hardware address */
-      if (c->options.lladdr)
+      if (c->options.lladdr
+	  && !c->c1.tuntap->is_pipe)
 	  set_lladdr(c->c1.tuntap->actual_name, c->options.lladdr, c->c2.es);
 
       /* do ifconfig */
       if (!c->options.ifconfig_noexec
+	  && !c->c1.tuntap->is_pipe
 	  && ifconfig_order () == IFCONFIG_AFTER_TUN_OPEN)
 	{
 	  do_ifconfig (c->c1.tuntap, c->c1.tuntap->actual_name, c->c2.es);
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 31bb583..c832528 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -103,6 +103,8 @@ dev_type_enum (const char *dev, const char *dev_type)
     return DEV_TYPE_TAP;
   else if (is_dev_type (dev, dev_type, "null"))
     return DEV_TYPE_NULL;
+  else if (dev && *dev == '|')
+    return DEV_TYPE_TUN;
   else
     return DEV_TYPE_UNDEF;
 }
@@ -425,6 +427,9 @@ init_tun (const char *dev,       /* --dev option */
   tt->type = dev_type_enum (dev, dev_type);
   tt->topology = topology;
 
+  if (dev && *dev == '|')
+      tt->is_pipe = true;
+
   if (ifconfig_local_parm && ifconfig_remote_netmask_parm)
     {
       bool tun = false;
@@ -1290,6 +1295,67 @@ open_null (struct tuntap *tt)
   tt->actual_name = string_alloc ("null", NULL);
 }
 
+static void
+set_vpnc_vars (struct env_set *es, struct tuntap *tt)
+{
+  struct gc_arena gc = gc_new ();
+
+  setenv_str (es, "INTERNAL_IP4_ADDRESS", print_in_addr_t (tt->local, 0, &gc));
+  setenv_int (es, "INTERNAL_IP4_MTU", tt->mtu);
+
+  if (tt->ipv6 && tt->did_ifconfig_ipv6_setup)
+    {
+      const char *ifconfig_ipv6_local = print_in6_addr (tt->local_ipv6, 0, &gc);
+      struct buffer out6 = alloc_buf_gc (64, &gc);
+
+      buf_printf (&out6, "%s/%d", ifconfig_ipv6_local, tt->netbits_ipv6);
+      setenv_str (es, "INTERNAL_IP6_NETMASK", buf_bptr (&out6));
+    }
+
+  gc_free (&gc);
+}
+
+static void
+open_pipe (const char *dev, struct tuntap *tt)
+{
+  struct argv argv;
+  struct env_set *es;
+  int fds[2], pid;
+
+  if (socketpair (AF_UNIX, SOCK_DGRAM, 0, fds) == -1)
+    {
+      msg (M_FATAL | M_ERRNO, "ERROR: socketpair call failed");
+    }
+
+  tt->fd = fds[0];
+  tt->actual_name = string_alloc ("pipe", NULL);
+
+  set_nonblock (tt->fd);
+  set_cloexec (tt->fd);
+
+  es = env_set_create (NULL);
+  setenv_int (es, "VPNFD", fds[1]);
+  set_vpnc_vars (es, tt);
+
+  argv_init (&argv);
+  /* dev looks like: "|/path/to/program <args...>" */
+  argv_printf (&argv, "/bin/sh -c %s", &dev[1]);
+  pid = openvpn_execve (&argv, es, S_SCRIPT | S_NOWAIT | S_SETPGRP);
+  argv_reset (&argv);
+  env_set_destroy (es);
+  close (fds[1]);
+
+  /*
+   * This doesn't detect errors in the subprocess, but hopefully we'll notice
+   * if the other side of the socketpair gets closed.
+   */
+  if (pid <= 0)
+    {
+      msg (M_FATAL, "ERROR: unable to start subprocess");
+    }
+  tt->pipe_pid = (pid_t)pid;
+}
+
 
 #if defined (TARGET_OPENBSD) || (defined(TARGET_DARWIN) && HAVE_NET_IF_UTUN_H)
 
@@ -1385,7 +1451,11 @@ open_tun_generic (const char *dev, const char *dev_type, const char *dev_node,
   if ( tt->ipv6 && ! ipv6_explicitly_supported )
     msg (M_WARN, "NOTE: explicit support for IPv6 tun devices is not provided for this OS");
 
-  if (tt->type == DEV_TYPE_NULL)
+  if (tt->is_pipe)
+    {
+      open_pipe (dev, tt);
+    }
+  else if (tt->type == DEV_TYPE_NULL)
     {
       open_null (tt);
     }
@@ -1486,6 +1556,8 @@ close_tun_generic (struct tuntap *tt)
     close (tt->fd);
   if (tt->actual_name)
     free (tt->actual_name);
+  if (tt->pipe_pid)
+    kill (-tt->pipe_pid, SIGHUP);
   clear_tuntap (tt);
 }
 
@@ -1579,11 +1651,15 @@ open_tun (const char *dev, const char *dev_type, const char *dev_node, struct tu
 {
   struct ifreq ifr;
 
-  /*
-   * We handle --dev null specially, we do not open /dev/null for this.
-   */
-  if (tt->type == DEV_TYPE_NULL)
+  if (tt->is_pipe)
     {
+      open_pipe (dev, tt);
+    }
+  else if (tt->type == DEV_TYPE_NULL)
+    {
+      /*
+       * We handle --dev null specially, we do not open /dev/null for this.
+       */
       open_null (tt);
     }
   else
@@ -1880,6 +1956,12 @@ open_tun (const char *dev, const char *dev_type, const char *dev_node, struct tu
    */
   CLEAR(ifr);
 
+  if (tt->is_pipe)
+    {
+      open_pipe (dev, tt);
+      return;
+    }
+
   if (tt->type == DEV_TYPE_NULL)
     {
       open_null (tt);
@@ -4849,7 +4931,13 @@ open_tun (const char *dev, const char *dev_type, const char *dev_node, struct tu
 
   msg( M_INFO, "open_tun, tt->ipv6=%d", tt->ipv6 );
 
-  if (tt->type == DEV_TYPE_NULL)
+  if (tt->is_pipe)
+    {
+      open_pipe (dev, tt);
+      gc_free (&gc);
+      return;
+    }
+  else if (tt->type == DEV_TYPE_NULL)
     {
       open_null (tt);
       gc_free (&gc);
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 1b510d0..0c93a1d 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -131,6 +131,8 @@ struct tuntap
 # define TUNNEL_TOPOLOGY(tt) ((tt) ? ((tt)->topology) : TOP_UNDEF)
   int topology; /* one of the TOP_x values */
 
+  bool is_pipe;
+  pid_t pipe_pid;
   bool did_ifconfig_setup;
   bool did_ifconfig_ipv6_setup;
   bool did_ifconfig;
-- 
1.7.9.5


