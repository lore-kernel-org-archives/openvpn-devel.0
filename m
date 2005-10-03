Message-ID: <434189C7.5090304@...361...>
From: Rolf Fokkens <r.fokkens@...361...>
MIME-Version: 1.0
References: <43404D99.8080309@...361...>
In-Reply-To: <43404D99.8080309@...361...>
Content-Type: multipart/mixed;
 boundary="------------080202050109010603020909"
Subject: [Openvpn-devel] Patch: TAP usage made non ARP dependent
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
Date: Mon Oct  3 12:44:58 2005
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------080202050109010603020909
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Using OpenVPN to build a WAN, I noticed a disturbing thing: After
failing over to secondary OpenVPN server it takes a long time until a
ping to a client side IP works again. I think I know what's happening:

An OpenVPN server learns client-side MAC addresses based on the source
MAC addresses of received packets, just like an ethernet switch. When an
ethernet packet has to be sent to a client, the OpenVPN server selects
the client based on previously learnt MAC addresses. When a packet has
an unknown destination MAC address it's dropped - this is very unlike a
switch which broadcasts a packet to all interfaces. There's only one
exception for OpenVPN: when the destination MAC address is a broadcast /
multicast address the packet is sent to all clients.

The above makes clear why ICMP (or other IP) packets normaly arrive.
It's because they're preceeded by an ARP request..... which is a
broadcast. The ARP request is delivered to all clients, including the
right one. The ARP reply that's sent back to the server contains a
source MAC address which is learnt by the server, after which the ICMP
packets are delivered properly.

The attached patch makes OpenVPN do the switch-like thing: broadcast a
packet with an unknow destination to all clients instead of dropping it.

It helps me a lot, so it may help others as well.

Cheers,

Rolf


--------------080202050109010603020909
Content-Type: text/x-patch;
 name="openvpn-2.0.2-fks2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="openvpn-2.0.2-fks2.patch"

--- openvpn-2.0.2/multi.c.orig	2005-10-02 14:58:58.000000000 +0200
+++ openvpn-2.0.2/multi.c	2005-10-02 15:04:20.000000000 +0200
@@ -1756,9 +1756,17 @@
 	    }
 	  else
 	    {
-	      multi_set_pending (m, multi_get_instance_by_virtual_addr (m, &dest, dev_type == DEV_TYPE_TUN));
+              struct multi_instance *mi;
 
-	      if (m->pending)
+	      mi = multi_get_instance_by_virtual_addr (m, &dest, dev_type == DEV_TYPE_TUN);
+	      multi_set_pending (m, mi);
+
+	      if (!mi)
+                {
+	          /* No known instance? Do like a switch: broadcast */
+	          if (dev_type == DEV_TYPE_TAP) multi_bcast (m, &m->top.c2.buf, NULL);
+                }
+              else
 		{
 		  /* get instance context */
 		  c = &m->pending->context;


--------------080202050109010603020909--

