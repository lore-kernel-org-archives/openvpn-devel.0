Message-ID: <400836F1.1000804@...157...>
From: Martin Hejl <martin@...157...>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080501070201030407070401"
Subject: [Openvpn-devel] patch for iproute
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
Date: Fri Jan 16 11:10:05 2004
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------080501070201030407070401
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi everybody,

I am part of the LEAF project - a small distro for embedded environments 
- at http://leaf.sourceforge.net (I'm actually only part of the "Bering 
uClibc" branch, to be precise).

Since LEAF does not provide ifconfig and route by default (just 
iproute2) I created a patch that allows using OpenVPN on LEAF boxes 
without the need for ifconfig and route.

I would be very happy to see this integrated into OpenVPN at some point 
(there's no hurry - we have a mostly automated build environment, so 
applying the patch is no big deal).

I've tested the patch using a LEAF box plus a regular Fedora box (both 
tun and tap devices) and everything seems to be working nicely.

If the patch doesn't make it onto the list (the LEAF lists trim all 
attachments), it can also be found at:
http://cvs.sourceforge.net/viewcvs.py/leaf/src/bering-uclibc/apps/openvpn/iproute.patch

Let me know if you have any questions.

Martin

--------------080501070201030407070401
Content-Type: text/plain;
 name="iproute.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="iproute.patch"

diff -N -u -r -b openvpn-1.6_beta1/misc.c openvpn-1.6_beta1.hejl/misc.c
--- openvpn-1.6_beta1/misc.c	Wed Jan 14 07:54:34 2004
+++ openvpn-1.6_beta1.new/misc.c	Thu Jan 15 11:33:07 2004
@@ -680,3 +680,29 @@
       ++cp;
     }
 }
+
+
+/*
+ * 'stolen' from busybox networking/ifupdown.c
+ */
+unsigned int count_bits(unsigned int a)
+{
+	unsigned int result;
+	result = (a & 0x55) + ((a >> 1) & 0x55);
+	result = (result & 0x33) + ((result >> 2) & 0x33);
+	return((result & 0x0F) + ((result >> 4) & 0x0F));
+}
+
+int count_netmask_bits(const char *dotted_quad)
+{
+	unsigned int result, a, b, c, d;
+	/* Found a netmask...  Check if it is dotted quad */
+	if (sscanf(dotted_quad, "%u.%u.%u.%u", &a, &b, &c, &d) != 4)
+		return -1;
+	result = count_bits(a);
+	result += count_bits(b);
+	result += count_bits(c);
+	result += count_bits(d);
+	return ((int)result);
+}
+
diff -N -u -r -b openvpn-1.6_beta1/misc.h openvpn-1.6_beta1.hejl/misc.h
--- openvpn-1.6_beta1/misc.h	Thu Nov  6 14:45:12 2003
+++ openvpn-1.6_beta1.hejl/misc.h	Thu Jan 15 09:38:32 2004
@@ -138,6 +139,10 @@
 void setenv_int (const char *name, int value);
 void setenv_del (const char *name);
 
+/* convert netmasks for iproute2 */
+int count_netmask_bits(const char *);
+unsigned int count_bits(unsigned int );
+
 /* make cp safe to be passed to system() or set as an environmental variable */
 void safe_string (char *cp);
 
@@ -171,3 +176,4 @@
 }
 
 #endif
+
diff -N -u -r -b openvpn-1.6_beta1/route.c openvpn-1.6_beta1.hejl/route.c
--- openvpn-1.6_beta1/route.c	Thu Nov  6 14:45:12 2003
+++ openvpn-1.6_beta1.hejl/route.c	Thu Jan 15 09:32:30 2004
@@ -525,6 +525,7 @@
     setenv_route (&rl->routes[i], i + 1);
 }
 
+
 static void
 add_route (struct route *r)
 {
@@ -545,14 +546,22 @@
   gateway = print_in_addr_t (r->gateway, false);
 
 #if defined(TARGET_LINUX)
+#ifdef CONFIG_FEATURE_IPROUTE
+  buf_printf (&buf, IPROUTE_PATH " route add %s/%d via %s",
+	      network,
+	      count_netmask_bits(netmask),
+	      gateway);
+  if (r->metric_defined)
+    buf_printf (&buf, " metric %d", r->metric);
 
+#else
   buf_printf (&buf, ROUTE_PATH " add -net %s netmask %s gw %s",
 	      network,
 	      netmask,
 	      gateway);
   if (r->metric_defined)
     buf_printf (&buf, " metric %d", r->metric);
-
+#endif  /*CONFIG_FEATURE_IPROUTE*/
   msg (D_ROUTE, "%s", BSTR (&buf));
   status = system_check (BSTR (&buf), "ERROR: Linux route add command failed", false);
 
@@ -650,11 +659,16 @@
   gateway = print_in_addr_t (r->gateway, false);
 
 #if defined(TARGET_LINUX)
+#ifdef CONFIG_FEATURE_IPROUTE
+  buf_printf (&buf, IPROUTE_PATH " route del %s/%d",
+	      network,
+	      count_netmask_bits(netmask));
+#else
 
   buf_printf (&buf, ROUTE_PATH " del -net %s netmask %s",
 	      network,
 	      netmask);
-
+#endif /*CONFIG_FEATURE_IPROUTE*/
   msg (D_ROUTE, "%s", BSTR (&buf));
   system_check (BSTR (&buf), "ERROR: Linux route delete command failed", false);
 
diff -N -u -r -b openvpn-1.6_beta1/tun.c openvpn-1.6_beta1.hejl/tun.c
--- openvpn-1.6_beta1/tun.c	Thu Nov  6 14:45:12 2003
+++ openvpn-1.6_beta1.hejl/tun.c	Thu Jan 15 09:52:58 2004
@@ -451,7 +451,46 @@
 	ifconfig_broadcast = print_in_addr_t (tt->broadcast, false);
 
 #if defined(TARGET_LINUX)
+#ifdef CONFIG_FEATURE_IPROUTE
+	/*
+	 * Set the MTU for the device
+	 */
+	openvpn_snprintf (command_line, sizeof (command_line),
+			  IPROUTE_PATH " link set dev %s up mtu %d",
+			  actual,
+			  tun_mtu
+			  );
+	  msg (M_INFO, "%s", command_line);
+	  system_check (command_line, "Linux ip link set failed", true);
 
+
+	if (tun) {
+
+		/*
+		 * Set the address for the device
+		 */
+		openvpn_snprintf (command_line, sizeof (command_line),
+				  IPROUTE_PATH " addr add dev %s local %s peer %s",
+				  actual,
+				  ifconfig_local,
+				  ifconfig_remote_netmask
+				  );
+		  msg (M_INFO, "%s", command_line);
+		  system_check (command_line, "Linux ip addr add failed", true);
+	} else {
+		openvpn_snprintf (command_line, sizeof (command_line),
+				  IPROUTE_PATH " addr add dev %s %s/%d broadcast %s",
+				  actual,
+				  ifconfig_local,
+				  count_netmask_bits(ifconfig_remote_netmask),
+				  ifconfig_broadcast
+				  );
+		  msg (M_INFO, "%s", command_line);
+		  system_check (command_line, "Linux ip addr add failed", true);
+
+	}
+	tt->did_ifconfig = true;
+#else
       if (tun)
 	openvpn_snprintf (command_line, sizeof (command_line),
 			  IFCONFIG_PATH " %s %s pointopoint %s mtu %d",
@@ -472,7 +511,7 @@
       msg (M_INFO, "%s", command_line);
       system_check (command_line, "Linux ifconfig failed", true);
       tt->did_ifconfig = true;
-
+#endif /*CONFIG_FEATURE_IPROUTE*/
 #elif defined(TARGET_SOLARIS)
 
       /* example: ifconfig tun2 10.2.0.2 10.2.0.1 mtu 1450 netmask 255.255.255.255 up */
--- openvpn-1.6_beta1/configure.ac	Wed Jan 14 21:30:21 2004
+++ openvpn-1.6_beta1.new/configure.ac	Thu Jan 15 11:33:43 2004
@@ -106,6 +106,14 @@
 )
 AC_DEFINE_UNQUOTED(IFCONFIG_PATH, "$IFCONFIG", [Path to ifconfig tool])
 
+AC_ARG_WITH(iproute-path,
+   [  --with-iproute-path=PATH    Path to iproute tool],
+   [IPROUTE="$withval"],
+   [AC_PATH_PROG([IPROUTE], [ip], [ip], [$PATH:/usr/local/sbin:/usr/sbin:/sbin])]
+)
+AC_DEFINE_UNQUOTED(IPROUTE_PATH, "$IPROUTE", [Path to iproute tool])
+
+
 AC_ARG_WITH(route-path,
    [  --with-route-path=PATH  Path to route tool],
    [ROUTE="$withval"],
@@ -118,6 +126,13 @@
    [LEAK="$withval"]
 )
 
+AC_ARG_ENABLE(iproute2,
+   [  --enable-iproute2       Enable support for iproute2],
+   AC_DEFINE(CONFIG_FEATURE_IPROUTE, 1, [enable iproute2 support])
+   
+)
+
+
 dnl Guess host type.
 AC_CANONICAL_HOST
 AC_CANONICAL_SYSTEM

--------------080501070201030407070401--


