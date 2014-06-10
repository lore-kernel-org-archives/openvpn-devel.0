From: Gert Doering <gert@...1296...>
Date: Tue, 10 Jun 2014 16:04:31 +0200
Message-Id: <1402409073-54067216-3-git-send-email-gert@...1296...>
In-Reply-To: <1402409073-54067216-2-git-send-email-gert@...1296...>
References: <1402409073-54067216-1-git-send-email-gert@...1296...>
	<1402409073-54067216-2-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH 2/4] Add tap driver initialization and
	ifconfig for AIX.
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
Cc: Gert Doering <gd@...1505...>

From: Gert Doering <gd@...1505...>

AIX is special... ifconfig only works if it can add the data to
the ODM right away, so setup a local enviromnment set that has
"ODMDIR=/etc/objrepos" in it (hard-coded, nobody changes that).

Only --dev tap or --dev tapNN are supported right now.  AIX has no
tun driver (so tun mode would need to dynamically add/remove ethernet
headers to/from AIX).

Signed-off-by: Gert Doering <gd@...1505...>
---
 src/openvpn/tun.c |  170 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 170 insertions(+), 0 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 482f640..25d5473 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1194,6 +1194,43 @@ do_ifconfig (struct tuntap *tt,
 	  openvpn_execve_check (&argv, es, S_FATAL, "FreeBSD ifconfig inet6 failed");
 	}
 
+#elif defined(TARGET_AIX)
+      {
+	/* AIX ifconfig will complain if it can't find ODM path in env */
+	struct env_set *aix_es = env_set_create (NULL);
+	env_set_add( aix_es, "ODMDIR=/etc/objrepos" );
+
+	if (tun)
+	  msg(M_FATAL, "no tun support on AIX (canthappen)");
+
+	/* example: ifconfig tap0 172.30.1.1 netmask 255.255.254.0 up */
+	argv_printf (&argv,
+		     "%s %s %s netmask %s mtu %d up",
+			    IFCONFIG_PATH,
+			    actual,
+			    ifconfig_local,
+			    ifconfig_remote_netmask,
+			    tun_mtu
+			    );
+
+	argv_msg (M_INFO, &argv);
+	openvpn_execve_check (&argv, aix_es, S_FATAL, "AIX ifconfig failed");
+	tt->did_ifconfig = true;
+
+	if ( do_ipv6 )
+	  {
+	    argv_printf (&argv,
+				"%s %s inet6 %s/%d",
+				IFCONFIG_PATH,
+				actual,
+				ifconfig_ipv6_local,
+				tt->netbits_ipv6
+				);
+	    argv_msg (M_INFO, &argv);
+	    openvpn_execve_check (&argv, aix_es, S_FATAL, "AIX ifconfig inet6 failed");
+	  }
+	env_set_destroy (aix_es);
+      }
 #elif defined (WIN32)
       {
 	/*
@@ -2825,6 +2862,139 @@ read_tun (struct tuntap* tt, uint8_t *buf, int len)
     return read (tt->fd, buf, len);
 }
 
+#elif defined(TARGET_AIX)
+
+void
+open_tun (const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt)
+{
+  char tunname[256];
+  char dynamic_name[20];
+  const char *p;
+  struct argv argv;
+
+  if (tt->type == DEV_TYPE_NULL)
+    {
+      open_null (tt);
+      return;
+    }
+
+  if ( tt->type == DEV_TYPE_TUN)
+    {
+      msg(M_FATAL, "no support for 'tun' devices on AIX" );
+    }
+
+  if ( strncmp( dev, "tap", 3 ) != 0 || dev_node )
+    {
+      msg(M_FATAL, "'--dev %s' and/or '--dev-node' not supported on AIX, use '--dev tap0', 'tap1', etc.", dev );
+    }
+
+  if ( strcmp( dev, "tap" ) == 0 )		/* find first free tap dev */
+    {						/* (= no /dev/tapN node) */
+      int i;
+      for (i=0; i<99; i++ )
+	{
+	  openvpn_snprintf (tunname, sizeof (tunname), "/dev/tap%d", i);
+	  if ( access( tunname, F_OK ) < 0 && errno == ENOENT )
+	    { break; }
+	}
+      if ( i >= 99 )
+	msg( M_FATAL, "cannot find unused tap device" );
+
+      openvpn_snprintf( dynamic_name, sizeof(dynamic_name), "tap%d", i );
+      dev = dynamic_name;
+    }
+  else						/* name given, sanity check */
+    {
+      /* ensure that dev name is "tap+<digits>" *only* */
+      p = &dev[3];
+      while( isdigit(*p) ) p++;
+      if ( *p != '\0' )
+	msg( M_FATAL, "TAP device name must be '--dev tapNNNN'" );
+
+      openvpn_snprintf (tunname, sizeof (tunname), "/dev/%s", dev);
+    }
+
+  /* pre-existing device? 
+   */
+  if ( access( tunname, F_OK ) < 0 && errno == ENOENT )
+    {
+
+      /* tunnel device must be created with 'ifconfig tapN create'
+       */
+      struct env_set *es = env_set_create (NULL);
+      argv_init (&argv);
+      argv_printf (&argv, "%s %s create", IFCONFIG_PATH, dev);
+      argv_msg (M_INFO, &argv);
+      env_set_add( es, "ODMDIR=/etc/objrepos" );
+      openvpn_execve_check (&argv, es, S_FATAL, "AIX 'create tun interface' failed");
+      env_set_destroy (es);
+    }
+  else
+    {
+      /* we didn't make it, we're not going to break it */
+      tt->persistent_if = TRUE;
+    }
+
+  if ((tt->fd = open (tunname, O_RDWR)) < 0)
+    {
+      msg (M_ERR, "Cannot open TAP device '%s'", tunname);
+    }
+
+  set_nonblock (tt->fd);
+  set_cloexec (tt->fd); /* don't pass fd to scripts */
+  msg (M_INFO, "TUN/TAP device %s opened", tunname);
+
+  /* tt->actual_name is passed to up and down scripts and used as the ifconfig dev name */
+  tt->actual_name = string_alloc(dev, NULL);
+}
+
+/* tap devices need to be manually destroyed on AIX
+ */
+void
+close_tun (struct tuntap* tt)
+{
+  struct gc_arena gc = gc_new ();
+  struct argv argv;
+  struct env_set *es = env_set_create (NULL);
+
+  if (!tt) return;
+
+  /* persistent devices need IP address unconfig, others need destroyal
+   */
+  argv_init (&argv);
+
+  if (tt->persistent_if)
+    {
+      argv_printf (&argv, "%s %s 0.0.0.0 down",
+                          IFCONFIG_PATH, tt->actual_name);
+    }
+  else
+    {
+      argv_printf (&argv, "%s %s destroy",
+                          IFCONFIG_PATH, tt->actual_name);
+    }
+
+  close_tun_generic (tt);
+  argv_msg (M_INFO, &argv);
+  env_set_add( es, "ODMDIR=/etc/objrepos" );
+  openvpn_execve_check (&argv, es, 0, "AIX 'destroy tap interface' failed (non-critical)");
+
+  free(tt);
+  env_set_destroy (es);
+}
+
+int
+write_tun (struct tuntap* tt, uint8_t *buf, int len)
+{
+    return write (tt->fd, buf, len);
+}
+
+int
+read_tun (struct tuntap* tt, uint8_t *buf, int len)
+{
+    return read (tt->fd, buf, len);
+}
+
 #elif defined(WIN32)
 
 int
-- 
1.6.4


