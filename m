Date: Tue, 27 Jan 2009 16:48:06 +0100
From: Matthias Andree <ma+ovpnd@...31...>
Message-ID: <20090127154806.GA38604@...33...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="GRPZ8SYKNexpdSJ7"
Content-Disposition: inline
Subject: [Openvpn-devel] [PATCH] Fix non-C89 comments
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--GRPZ8SYKNexpdSJ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

openvpn uses non-C89 //-style comments in two places. Patch to convert
these to /* ... */ style comments attached.

Best

-- 
Matthias Andree

--GRPZ8SYKNexpdSJ7
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="fix-openvpn-comments.patch"

Index: proto.h
===================================================================
--- proto.h	(Revision 3896)
+++ proto.h	(Arbeitskopie)
@@ -66,15 +66,15 @@
 
 struct openvpn_arp {
 # define ARP_MAC_ADDR_TYPE 0x0001
-  uint16_t mac_addr_type;       // 0x0001
+  uint16_t mac_addr_type;       /* 0x0001 */
 
-  uint16_t proto_addr_type;     // 0x0800
-  uint8_t  mac_addr_size;       // 0x06
-  uint8_t  proto_addr_size;     // 0x04
+  uint16_t proto_addr_type;     /* 0x0800 */
+  uint8_t  mac_addr_size;       /* 0x06 */
+  uint8_t  proto_addr_size;     /* 0x04 */
 
 # define ARP_REQUEST 0x0001
 # define ARP_REPLY   0x0002
-  uint16_t arp_command;         // 0x0001 for ARP request, 0x0002 for ARP reply
+  uint16_t arp_command;         /* 0x0001 for ARP request, 0x0002 for ARP reply */
 
   uint8_t   mac_src[OPENVPN_ETH_ALEN];
   in_addr_t ip_src;
Index: route.c
===================================================================
--- route.c	(Revision 3896)
+++ route.c	(Arbeitskopie)
@@ -1694,7 +1694,7 @@
 
       if (netmask)
 	{
-	  *netmask = 0xFFFFFF00; // FIXME -- get the real netmask of the adapter containing the default gateway
+	  *netmask = 0xFFFFFF00; /* FIXME -- get the real netmask of the adapter containing the default gateway */
 	}
 
       gc_free (&gc);

--GRPZ8SYKNexpdSJ7--

