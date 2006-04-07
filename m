From: Roy Marples <uberlord@...594...>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_zAsNEL0lE5Uupgx"
Message-Id: <200604072040.35488.uberlord@...594...>
Subject: [Openvpn-devel] [PATCH] Allow link layer address to be set
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Fri Apr  7 12:41:08 2006
To: OpenVPN devel <openvpn-devel@lists.sourceforge.net>

--Boundary-00=_zAsNEL0lE5Uupgx
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi List!

It's advantageous to set the local link layer address to be a specific one for 
things like radvd (ip6 route advertiser) to work smoothly. Also, it allows 
the server to push specific link layer addresses to clients.

Attached are patches for 2.0 and 2.1_beta12 that allows this for OS's that 
support it (Linux, FreeBSD, OpenBSD, Darwin and Solaris, but only Linux has 
been tested).

Thanks

-- 
Roy Marples <uberlord@...594...>
Gentoo Linux Developer

--Boundary-00=_zAsNEL0lE5Uupgx
Content-Type: text/x-diff;
  charset="utf-8";
  name="openvpn-2.0.6-lladdr.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="openvpn-2.0.6-lladdr.patch"

--- openvpn-2.0.6/init.c	2006-04-06 10:49:00.044150686 +0100
+++ openvpn-2.0.6/init.c	2006-04-07 12:20:50.110560634 +0100
@@ -38,6 +38,7 @@
 #include "otime.h"
 #include "pool.h"
 #include "gremlin.h"
+#include "lladdr.h"
 
 #include "memdbg.h"
 
@@ -348,6 +349,8 @@ do_persist_tuntap (const struct options 
 	     "options --mktun or --rmtun should only be used together with --dev");
       tuncfg (options->dev, options->dev_type, options->dev_node,
 	      options->tun_ipv6, options->persist_mode);
+      if (options->persist_mode && options->lladdr)
+        set_lladdr(options->dev, options->lladdr, NULL);
       return true;
     }
 #endif
@@ -746,6 +749,10 @@ do_open_tun (struct context *c)
       open_tun (c->options.dev, c->options.dev_type, c->options.dev_node,
 		c->options.tun_ipv6, c->c1.tuntap);
 
+      /* set the hardware address */
+      if (c->options.lladdr)
+	  set_lladdr(c->c1.tuntap->actual_name, c->options.lladdr, c->c2.es);
+
       /* do ifconfig */
       if (!c->options.ifconfig_noexec
 	  && ifconfig_order () == IFCONFIG_AFTER_TUN_OPEN)
--- openvpn-2.0.6/lladdr.c	1970-01-01 01:00:00.000000000 +0100
+++ openvpn-2.0.6/lladdr.c	2006-04-07 12:30:22.153046049 +0100
@@ -0,0 +1,58 @@
+/*
+ * Support routine for configuring link layer address 
+ */
+
+#ifdef WIN32
+#include "config-win32.h"
+#else
+#include "config.h"
+#endif
+
+#include "syshead.h"
+#include "error.h"
+#include "misc.h"
+
+int set_lladdr(const char *ifname, const char *lladdr,
+		const struct env_set *es)
+{
+  char cmd[256];
+
+  if (!ifname || !lladdr)
+    return -1;
+  
+#if defined(TARGET_LINUX)
+#ifdef CONFIG_FEATURE_IPROUTE
+  openvpn_snprintf (cmd, sizeof (cmd),
+		    IPROUTE_PATH " link set addr %s dev %s",
+		    lladdr, ifname);
+#else
+  openvpn_snprintf (cmd, sizeof (cmd),
+		    IFCONFIG_PATH " %s hw ether %s",
+		    ifname, lladdr);
+#endif
+#elif defined(TARGET_SOLARIS)
+  openvpn_snprintf (cmd, sizeof (cmd),
+		    IFCONFIG_PATH " %s ether %s",
+		    ifname, lladdr);
+#elif defined(TARGET_OPENBSD)
+  openvpn_snprintf (cmd, sizeof (cmd),
+		    IFCONFIG_PATH " %s lladdr %s",
+		    ifname, lladdr);
+#elif defined(TARGET_DARWIN)
+  openvpn_snprintf (cmd, sizeof (cmd),
+		    IFCONFIG_PATH " %s lladdr %s",
+		    ifname, lladdr);
+#elif defined(TARGET_FREEBSD)
+  openvpn_snprintf (cmd, sizeof (cmd),
+		    IFCONFIG_PATH " %s ether %s",
+		    ifname, lladdr);
+#else
+      msg (M_WARN, "Sorry, but I don't know how to do configure link layer addresses on this operating system.");
+      return;
+#endif
+
+  int r = system_check (cmd, es, M_WARN, "ERROR: Unable to set link layer address.");
+  if (r)
+    msg (M_INFO, "TUN/TAP link layer address set to %s", lladdr);
+  return r;
+}
--- openvpn-2.0.6/lladdr.h	1970-01-01 01:00:00.000000000 +0100
+++ openvpn-2.0.6/lladdr.h	2006-04-07 12:28:47.728391663 +0100
@@ -0,0 +1,8 @@
+/*
+ * Support routine for configuring link layer address 
+ */
+
+#include "misc.h"
+
+int set_lladdr(const char *ifname, const char *lladdr,
+		const struct env_set *es);
--- openvpn-2.0.6/Makefile.am	2005-11-02 18:56:04.000000000 +0000
+++ openvpn-2.0.6/Makefile.am	2006-04-07 12:21:16.992812269 +0100
@@ -50,6 +50,7 @@ openvpn_SOURCES = \
 	fragment.c fragment.h \
 	gremlin.c gremlin.h \
 	helper.c helper.h \
+	lladdr.c lladdr.h \
 	init.c init.h \
 	integer.h \
         interval.c interval.h \
--- openvpn-2.0.6/openvpn.8	2006-04-06 10:49:00.092155548 +0100
+++ openvpn-2.0.6/openvpn.8	2006-04-07 12:21:08.124067866 +0100
@@ -70,6 +70,7 @@ openvpn \- secure IP tunnel daemon.
 [\ \fB\-\-dev\fR\ \fItunX\ |\ tapX\fR\ ]
 [\ \fB\-\-dev\-type\fR\ \fIdevice\-type\fR\ ]
 [\ \fB\-\-dev\-node\fR\ \fInode\fR\ ]
+[\ \fB\-\-lladdr\fR\ \fIaddress\fR\ ]
 .in -4
 .ti +4
 .hy
@@ -799,6 +800,10 @@ to enumerate all available TAP-Win32
 adapters and will show both the network
 connections control panel name and the GUID for
 each TAP-Win32 adapter.
+.TP
+.B --lladdr address
+Specify the link layer address, more commonly known as the MAC address.
+Only applied to TAP devices.
 .\"*********************************************************
 .TP
 .B --ifconfig l rn
--- openvpn-2.0.6/options.c	2006-04-07 12:03:52.524353266 +0100
+++ openvpn-2.0.6/options.c	2006-04-07 12:10:41.496280070 +0100
@@ -130,6 +130,7 @@ static const char usage_message[] =
   "--dev-node node : Explicitly set the device node rather than using\n"
   "                  /dev/net/tun, /dev/tun, /dev/tap, etc.\n"
   "--tun-ipv6      : Build tun link capable of forwarding IPv6 traffic.\n"
+  "--lladdr hw     : Set the link layer address of the tap device.\n"
   "--ifconfig l rn : TUN: configure device to use IP address l as a local\n"
   "                  endpoint and rn as a remote endpoint.  l & rn should be\n"
   "                  swapped on the other peer.  l & rn must be private\n"
@@ -960,6 +961,7 @@ show_settings (const struct options *o)
   SHOW_STR (dev);
   SHOW_STR (dev_type);
   SHOW_STR (dev_node);
+  SHOW_STR (lladdr);
   SHOW_BOOL (tun_ipv6);
   SHOW_STR (ifconfig_local);
   SHOW_STR (ifconfig_remote_netmask);
@@ -1252,6 +1254,10 @@ options_postprocess (struct options *opt
   if (options->inetd == INETD_NOWAIT && dev != DEV_TYPE_TAP)
     msg (M_USAGE, "--inetd nowait only makes sense in --dev tap mode");
 
+
+  if (options->lladdr && dev != DEV_TYPE_TAP)
+    msg (M_USAGE, "--lladdr can only be used in --dev tap mode");
+ 
   /*
    * In forking TCP server mode, you don't need to ifconfig
    * the tap device (the assumption is that it will be bridged).
@@ -2804,6 +2810,12 @@ add_option (struct options *options,
       VERIFY_PERMISSION (OPT_P_GENERAL);
       options->dev_node = p[1];
     }
+  else if (streq (p[0], "lladdr") && p[1])
+    {
+      i++;
+      VERIFY_PERMISSION (OPT_P_UP);
+      options->lladdr = p[1];
+    }
   else if (streq (p[0], "tun-ipv6"))
     {
       VERIFY_PERMISSION (OPT_P_UP);
--- openvpn-2.0.6/options.h	2006-04-06 10:49:00.124158789 +0100
+++ openvpn-2.0.6/options.h	2006-04-07 12:10:41.496280070 +0100
@@ -123,6 +123,7 @@ struct options
   const char *dev;
   const char *dev_type;
   const char *dev_node;
+  const char *lladdr;
   const char *ifconfig_local;
   const char *ifconfig_remote_netmask;
   bool ifconfig_noexec;

--Boundary-00=_zAsNEL0lE5Uupgx
Content-Type: text/x-diff;
  charset="utf-8";
  name="openvpn-2.1_beta12-lladdr.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="openvpn-2.1_beta12-lladdr.patch"

--- openvpn-2.1_beta12/init.c	2006-04-07 19:51:34.000000000 +0100
+++ openvpn-2.1_beta12/init.c	2006-04-07 19:52:13.000000000 +0100
@@ -40,6 +40,7 @@
 #include "gremlin.h"
 #include "pkcs11.h"
 #include "ps.h"
+#include "lladdr.h"
 
 #include "memdbg.h"
 
@@ -420,6 +421,8 @@
 	     "options --mktun or --rmtun should only be used together with --dev");
       tuncfg (options->dev, options->dev_type, options->dev_node,
 	      options->tun_ipv6, options->persist_mode);
+      if (options->persist_mode && options->lladdr)
+        set_lladdr(options->dev, options->lladdr, NULL);
       return true;
     }
 #endif
@@ -831,6 +834,10 @@
       open_tun (c->options.dev, c->options.dev_type, c->options.dev_node,
 		c->options.tun_ipv6, c->c1.tuntap);
 
+      /* set the hardware address */
+      if (c->options.lladdr)
+	  set_lladdr(c->c1.tuntap->actual_name, c->options.lladdr, c->c2.es);
+
       /* do ifconfig */
       if (!c->options.ifconfig_noexec
 	  && ifconfig_order () == IFCONFIG_AFTER_TUN_OPEN)
--- openvpn-2.1_beta12/lladdr.c	1970-01-01 01:00:00.000000000 +0100
+++ openvpn-2.1_beta12/lladdr.c	2006-04-07 19:52:13.000000000 +0100
@@ -0,0 +1,58 @@
+/*
+ * Support routine for configuring link layer address 
+ */
+
+#ifdef WIN32
+#include "config-win32.h"
+#else
+#include "config.h"
+#endif
+
+#include "syshead.h"
+#include "error.h"
+#include "misc.h"
+
+int set_lladdr(const char *ifname, const char *lladdr,
+		const struct env_set *es)
+{
+  char cmd[256];
+
+  if (!ifname || !lladdr)
+    return -1;
+  
+#if defined(TARGET_LINUX)
+#ifdef CONFIG_FEATURE_IPROUTE
+  openvpn_snprintf (cmd, sizeof (cmd),
+		    IPROUTE_PATH " link set addr %s dev %s",
+		    lladdr, ifname);
+#else
+  openvpn_snprintf (cmd, sizeof (cmd),
+		    IFCONFIG_PATH " %s hw ether %s",
+		    ifname, lladdr);
+#endif
+#elif defined(TARGET_SOLARIS)
+  openvpn_snprintf (cmd, sizeof (cmd),
+		    IFCONFIG_PATH " %s ether %s",
+		    ifname, lladdr);
+#elif defined(TARGET_OPENBSD)
+  openvpn_snprintf (cmd, sizeof (cmd),
+		    IFCONFIG_PATH " %s lladdr %s",
+		    ifname, lladdr);
+#elif defined(TARGET_DARWIN)
+  openvpn_snprintf (cmd, sizeof (cmd),
+		    IFCONFIG_PATH " %s lladdr %s",
+		    ifname, lladdr);
+#elif defined(TARGET_FREEBSD)
+  openvpn_snprintf (cmd, sizeof (cmd),
+		    IFCONFIG_PATH " %s ether %s",
+		    ifname, lladdr);
+#else
+      msg (M_WARN, "Sorry, but I don't know how to do configure link layer addresses on this operating system.");
+      return;
+#endif
+
+  int r = system_check (cmd, es, M_WARN, "ERROR: Unable to set link layer address.");
+  if (r)
+    msg (M_INFO, "TUN/TAP link layer address set to %s", lladdr);
+  return r;
+}
--- openvpn-2.1_beta12/lladdr.h	1970-01-01 01:00:00.000000000 +0100
+++ openvpn-2.1_beta12/lladdr.h	2006-04-07 19:52:13.000000000 +0100
@@ -0,0 +1,8 @@
+/*
+ * Support routine for configuring link layer address 
+ */
+
+#include "misc.h"
+
+int set_lladdr(const char *ifname, const char *lladdr,
+		const struct env_set *es);
--- openvpn-2.1_beta12/Makefile.am	2006-02-14 08:32:45.000000000 +0000
+++ openvpn-2.1_beta12/Makefile.am	2006-04-07 19:52:13.000000000 +0100
@@ -50,6 +50,7 @@
 	fragment.c fragment.h \
 	gremlin.c gremlin.h \
 	helper.c helper.h \
+	lladdr.c lladdr.h \
 	init.c init.h \
 	integer.h \
         interval.c interval.h \
--- openvpn-2.1_beta12/openvpn.8	2006-04-07 19:51:34.000000000 +0100
+++ openvpn-2.1_beta12/openvpn.8	2006-04-07 19:52:13.000000000 +0100
@@ -70,6 +70,7 @@
 [\ \fB\-\-dev\fR\ \fItunX\ |\ tapX\fR\ ]
 [\ \fB\-\-dev\-type\fR\ \fIdevice\-type\fR\ ]
 [\ \fB\-\-dev\-node\fR\ \fInode\fR\ ]
+[\ \fB\-\-lladdr\fR\ \fIaddress\fR\ ]
 .in -4
 .ti +4
 .hy
@@ -918,6 +919,10 @@
 adapters and will show both the network
 connections control panel name and the GUID for
 each TAP-Win32 adapter.
+.TP
+.B --lladdr address
+Specify the link layer address, more commonly known as the MAC address.
+Only applied to TAP devices.
 .\"*********************************************************
 .TP
 .B --ifconfig l rn
diff -uN openvpn-2.1_beta12/options.c openvpn-2.1_beta12/options.c
--- openvpn-2.1_beta12/options.c	2006-04-07 19:51:34.000000000 +0100
+++ openvpn-2.1_beta12/options.c	2006-04-07 19:53:25.000000000 +0100
@@ -147,6 +147,7 @@
   "                  does not begin with \"tun\" or \"tap\".\n"
   "--dev-node node : Explicitly set the device node rather than using\n"
   "                  /dev/net/tun, /dev/tun, /dev/tap, etc.\n"
+  "--lladdr hw     : Set the link layer address of the tap device.\n"
   "--topology t    : Set --dev tun topology: 'net30', 'p2p', or 'subnet'.\n"
   "--tun-ipv6      : Build tun link capable of forwarding IPv6 traffic.\n"
   "--ifconfig l rn : TUN: configure device to use IP address l as a local\n"
@@ -1070,6 +1071,7 @@
   SHOW_STR (dev);
   SHOW_STR (dev_type);
   SHOW_STR (dev_node);
+  SHOW_STR (lladdr);
   SHOW_INT (topology);
   SHOW_BOOL (tun_ipv6);
   SHOW_STR (ifconfig_local);
@@ -1403,6 +1405,10 @@
   if (options->inetd == INETD_NOWAIT && dev != DEV_TYPE_TAP)
     msg (M_USAGE, "--inetd nowait only makes sense in --dev tap mode");
 
+
+  if (options->lladdr && dev != DEV_TYPE_TAP)
+    msg (M_USAGE, "--lladdr can only be used in --dev tap mode");
+ 
   /*
    * In forking TCP server mode, you don't need to ifconfig
    * the tap device (the assumption is that it will be bridged).
@@ -3217,6 +3223,11 @@
       VERIFY_PERMISSION (OPT_P_GENERAL);
       options->dev_node = p[1];
     }
+  else if (streq (p[0], "lladdr") && p[1])
+    {
+      VERIFY_PERMISSION (OPT_P_UP);
+      options->lladdr = p[1];
+    }
   else if (streq (p[0], "topology") && p[1])
     {
       VERIFY_PERMISSION (OPT_P_UP);
--- openvpn-2.1_beta12/options.h	2006-04-07 19:51:34.000000000 +0100
+++ openvpn-2.1_beta12/options.h	2006-04-07 19:52:13.000000000 +0100
@@ -125,6 +125,7 @@
   const char *dev;
   const char *dev_type;
   const char *dev_node;
+  const char *lladdr;
   int topology; /* one of the TOP_x values from proto.h */
   const char *ifconfig_local;
   const char *ifconfig_remote_netmask;

--Boundary-00=_zAsNEL0lE5Uupgx--

