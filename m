Message-ID: <43C00B0B.1040904@...529...>
From: Emmanuel Kasper <kdev@...529...>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040708090207080508010007"
Subject: [Openvpn-devel] Ethernet Bridging support for NetBSD
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
Date: Sat Jan  7 09:56:49 2006
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------040708090207080508010007
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello
By looking at tun.c, I saw it was possible to enable quite easily 
Ethernet Bridging for NetBSD. ( only tunneling was enabled up to now in 
the source code )

After applying the patch, you have to create the device before starting 
the vpn with 'ifconfig tap0 create'.
I tested this with a NetBSD client connected to a Linux server in 
bridging mode and it just works.

Attached is the patch to tun.c for openvpn 2.0.5

Manu



--------------040708090207080508010007
Content-Type: text/plain;
 name="patch.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch.diff"

--- tun.c.orig	2006-01-07 17:56:51.000000000 +0000
+++ tun.c	2006-01-07 18:08:22.000000000 +0000
@@ -690,7 +690,19 @@ do_ifconfig (struct tuntap *tt,
 			  tun_mtu
 			  );
       else
-	no_tap_ifconfig ();
+      /*
+       * NetBSD has distinct tun and tap devices
+       * so we don't need the "link0" extra parameter to specify we want to do 
+       * tunneling at the ethernet level
+       */
+		openvpn_snprintf (command_line, sizeof (command_line),
+			  IFCONFIG_PATH " %s %s netmask %s mtu %d broadcast %s",
+			  actual,
+			  ifconfig_local,
+			  ifconfig_remote_netmask,
+			  tun_mtu,
+			  ifconfig_broadcast
+			  );
       msg (M_INFO, "%s", command_line);
       system_check (command_line, es, S_FATAL, "NetBSD ifconfig failed");
       tt->did_ifconfig = true;

--------------040708090207080508010007--

