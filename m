From: "bennyben admin" <bennyben@...538...>
Message-ID: <20060202160705.GK12748@...538...>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
Subject: [Openvpn-devel] openvpn-2.1_beta8 ifconfig problems with subnet topology on FreeBSD [solved]
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
Date: Thu Feb  2 08:08:06 2006
To: openvpn-devel@lists.sourceforge.net

--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline

Hello,

After testing this version on my FreeBSD, I got the error message :

Fri Jan 27 12:11:13 2006 us=835111 OPTIONS IMPORT: timers and/or timeouts modified
Fri Jan 27 12:11:13 2006 us=835260 OPTIONS IMPORT: --ifconfig/up options modified
Fri Jan 27 12:11:13 2006 us=835373 OPTIONS IMPORT: route options modified
Fri Jan 27 12:11:13 2006 us=835483 OPTIONS IMPORT: route-related options modified
Fri Jan 27 12:11:13 2006 us=835593 OPTIONS IMPORT: --ip-win32 and/or --dhcp-option options modified
Fri Jan 27 12:11:13 2006 us=836087 gw xx.xx.xx.xx
Fri Jan 27 12:11:13 2006 us=836302 ROUTE DEBUG: default_gateway=xx.xx.xx.xx
Fri Jan 27 12:11:13 2006 us=838416 TUN/TAP device /dev/tun0 opened
Fri Jan 27 12:11:13 2006 us=838634 /sbin/ifconfig tun0 172.18.48.15 netmask 255.255.240.0 mtu 1500 up
Fri Jan 27 12:11:13 2006 us=838932 SYSTEM[2] '/sbin/ifconfig tun0 172.18.48.15 netmask 255.255.240.0 mtu 1500 up'
ifconfig: ioctl (SIOCAIFADDR): Destination address required
Fri Jan 27 12:11:13 2006 us=861902 SYSTEM return=256
Fri Jan 27 12:11:13 2006 us=862216 FreeBSD ifconfig failed: shell command exited with error status: 1
Fri Jan 27 12:11:13 2006 us=862353 Exiting

It seems that it's a problem already solved for MacOS X.
I also patched the tun.c file, and now, it works well.

Attached, the patch.
Enjoy, and add it to the repository if you like.
TODO: test openvpn under other BSD and Unices.

Thanks,
Benoit Bourdin

--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="openvpn-2.1_beta8-freebsd.diff"

diff -uNr openvpn-2.1_beta8/tun.c openvpn-2.1_beta8-freebsd/tun.c
--- openvpn-2.1_beta8/tun.c	Thu Dec 22 18:48:35 2005
+++ openvpn-2.1_beta8-freebsd/tun.c	Thu Feb  2 16:05:29 2006
@@ -795,18 +795,41 @@
 			  ifconfig_remote_netmask,
 			  tun_mtu
 			  );
-      else
-	openvpn_snprintf (command_line, sizeof (command_line),
+      else {
+	if (tt->topology == TOP_SUBNET)
+            openvpn_snprintf (command_line, sizeof (command_line),
+                              IFCONFIG_PATH " %s %s %s netmask %s mtu %d up",
+                              actual,
+                              ifconfig_local,
+                              ifconfig_local,
+                              ifconfig_remote_netmask,
+                              tun_mtu
+                              );
+	else
+  	    openvpn_snprintf (command_line, sizeof (command_line),
 			  IFCONFIG_PATH " %s %s netmask %s mtu %d up",
 			  actual,
 			  ifconfig_local,
 			  ifconfig_remote_netmask,
 			  tun_mtu
 			  );
+      }
 	
       msg (M_INFO, "%s", command_line);
       system_check (command_line, es, S_FATAL, "FreeBSD ifconfig failed");
       tt->did_ifconfig = true;
+
+	/* Add a network route for the local tun interface */
+      if (!tun && tt->topology == TOP_SUBNET)
+        {               
+          struct route r;
+          CLEAR (r);      
+          r.defined = true;       
+          r.network = tt->local & tt->remote_netmask;
+          r.netmask = tt->remote_netmask;
+          r.gateway = tt->local;  
+          add_route (&r, tt, 0, es);
+        }
 
 #elif defined (WIN32)
       {

--nFreZHaLTZJo0R7j--

