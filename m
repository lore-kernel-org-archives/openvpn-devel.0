Date: Sun, 7 Mar 2010 21:17:31 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20100307201731.GT25238@...1296...>
References: <7bb795fd1002211100l760645cfl1a3cfc07ebd91e4@...278...>
	<20100221193132.GO9556@...1296...>
	<20100221200311.11614.qmail@...1287...>
	<20100221201416.GQ9556@...1296...>
	<20100228222326.GU9556@...1296...>
Mime-Version: 1.0
In-Reply-To: <20100228222326.GU9556@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] IPv6 support for TUN/TAP driver on
	windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Hi,

On Sun, Feb 28, 2010 at 11:23:26PM +0100, Gert Doering wrote:
> to follow up on this...

Next round of "do things on windows" :-)

> [ TUN / TAP driver on windows ]
> 
> Now... is there someone who has worked on this before, and can help
> me a bit with it?  
> 
> Initial questions:
> 
>  - can it be cross-compiled?  If yes, how?  If no, what needs to be
>    done on Windows to compile it?  (I have *no* experience with Windows,
>    but I can follow instructions and read documentation).

It does not seem to be possible to cross-compile this.

For the archives:

Fairly detailed instructions how to compile on windows are contained in 
"domake-win" in the OpenVPN distribution - unfortunately, this is lacking
some of the important details, like "what to do if Microsoft is not willing
to ship WDK 6001* anymore, but you need to adjust to 7.1.0" or "don't
even try to build this from a drive that is not C:".

Anyway:

 - get MinGW and MSYS
 - get the Windows Driver Kit (WDK) from Microsoft
 - put everything on C:, not on different drive letters(!!)
 - follow the instructions in domake-win
 - adjust install-win32/settings.in if you use a different WDK version
 - adjust install-win32/maketap, "w2ktarget=..." for current WDK versions
 - build, pray, curse, fix scripts, ...

So far, I have been successful in building the tap driver, and ignored
all the rest.  I will give this another fight on a machine with enough
disk space on C: next week.


>  - what needs to be done to install the driver / replace the existing
>    driver?

If you have OpenVPN installed in the normal location, just copy the
driver sources (tap0901.sys, tap0901.cap, OemWin2k.inf) to
C:\...\openvpn\driver and run "deltapall.bat" and "addtap.bat" from
...\openvpn\bin.

Make sure OpenVPN isn't active while replacing the driver, because you
might end up using the driver that's still in memory.

>  - how does one debug Windows drivers?  Is there a printf() as in Linux
>    that goes to console / syslog?

I have not yet figured out that part.  I did my debugging with Wireshark
("see what packets move back and forth and stare at the packet details").


Attached below is the patch to the TUN/TAP driver that is required to
make OpenVPN work with IPv6 in TUN mode on windows.  The magic for IPv6
is modelled similar to the way ARP is handled for IPv4:

 - all routes are set up with a next-hop of fe80::8
 - if the tapdrvr notices a neighbor-discovery packet for fe80::8, it
   will grab the packet and synthesize a neighbor-advertisement response
 - windows is happy and sends the data packets to the tap driver :-)

(The patch is 175e17a5abd5969f6803a9cc9587b7959e1100ae in my git tree
- David, could you please git-pull to feat_ipv6_payload?)


What needs to happen next?

 - "someone who understands" needs to look at the diff, and ACK it
   (or tell me where i misunderstood things, and what to fix)

 - it whould be highly appreciated if Samuli could get OpenVPN Tech
   to provide Windows binaries for the "openvpn-testing" tree, so that
   we can get decent testing by the windows user base

 - if someone is willing to risk the stability of his system, you can
   test my binaries:

    http://www.greenie.net/ipv6/tap0901-ipv6-20100307.tar.gz
    http://www.greenie.net/ipv6/openvpn-win-ipv6-20100307.tgz

   (extract in ...\openvpn\driver and ...\openvpn\bin, respectively,
   then run deltapall.bat / addtap.bat)

   DO NOT DO THIS ON A PRODUCTION SYSTEM.  Really.  This has been tested 
   on two different Windows XP systems, and no adverse effects have been
   observed - but this is my first attemt at Windows driver programming, 
   and I would not trust that yet.

 
gert


diff --git a/install-win32/settings.in b/install-win32/settings.in
index 643ef99..202f782 100644
--- a/install-win32/settings.in
+++ b/install-win32/settings.in
@@ -42,8 +42,8 @@
 !define PRODUCT_TAP_DEVICE_DESCRIPTION  "TAP-Win32 Adapter V9"
 !define PRODUCT_TAP_PROVIDER            "TAP-Win32 Provider V9"
 !define PRODUCT_TAP_MAJOR_VER           9
-!define PRODUCT_TAP_MINOR_VER           6
-!define PRODUCT_TAP_RELDATE             "06/22/2009"
+!define PRODUCT_TAP_MINOR_VER           7
+!define PRODUCT_TAP_RELDATE             "07/03/2010"
 
 # TAP adapter icon -- visible=0x81 or hidden=0x89
 !define PRODUCT_TAP_CHARACTERISTICS     0x81
diff --git a/tap-win32/proto.h b/tap-win32/proto.h
index e059772..ffb9ac9 100755
--- a/tap-win32/proto.h
+++ b/tap-win32/proto.h
@@ -29,9 +29,11 @@
 #pragma pack(1)
 
 #define IP_HEADER_SIZE 20
+#define IPV6_HEADER_SIZE 40
 
 typedef unsigned char MACADDR [6];
 typedef unsigned long IPADDR;
+typedef unsigned char IPV6ADDR [16];
 
 //-----------------
 // Ethernet address
@@ -55,6 +57,7 @@ typedef struct
   MACADDR src;                /* source ether addr	*/
 
 # define ETH_P_IP   0x0800    /* IPv4 protocol */
+# define ETH_P_IPV6 0x86DD    /* IPv6 protocol */
 # define ETH_P_ARP  0x0806    /* ARP protocol */
   USHORT proto;               /* packet type ID field	*/
 } ETH_HEADER, *PETH_HEADER;
@@ -161,4 +164,61 @@ typedef struct {
 #define	TCPOPT_MAXSEG  2
 #define TCPOLEN_MAXSEG 4
 
+//------------
+// IPv6 Header
+//------------
+
+typedef struct {
+  UCHAR    version_prio;
+  UCHAR    flow_lbl[3];
+  USHORT   payload_len;
+# define IPPROTO_ICMPV6  0x3a  /* ICMP protocol v6 */
+  UCHAR    nexthdr;
+  UCHAR    hop_limit;
+  IPV6ADDR saddr;
+  IPV6ADDR daddr;
+} IPV6HDR;
+
+//--------------------------------------------
+// IPCMPv6 NS/NA Packets (RFC4443 and RFC4861)
+//--------------------------------------------
+
+// Neighbor Solictiation - RFC 4861, 4.3
+// (this is just the ICMPv6 part of the packet)
+typedef struct {
+  UCHAR    type;
+# define ICMPV6_TYPE_NS	135		// neighbour solicitation
+  UCHAR    code;
+# define ICMPV6_CODE_0	0		// no specific sub-code for NS/NA
+  USHORT   checksum;
+  ULONG    reserved;
+  IPV6ADDR target_addr;
+} ICMPV6_NS;
+
+// Neighbor Advertisement - RFC 4861, 4.4 + 4.6/4.6.1
+// (this is just the ICMPv6 payload)
+typedef struct {
+  UCHAR    type;
+# define ICMPV6_TYPE_NA	136		// neighbour advertisement
+  UCHAR    code;
+# define ICMPV6_CODE_0	0		// no specific sub-code for NS/NA
+  USHORT   checksum;
+  UCHAR    rso_bits;			// Router(0), Solicited(2), Ovrrd(4)
+  UCHAR	   reserved[3];
+  IPV6ADDR target_addr;
+// always include "Target Link-layer Address" option (RFC 4861 4.6.1)
+  UCHAR    opt_type;
+#define ICMPV6_OPTION_TLLA 2
+  UCHAR    opt_length;
+#define ICMPV6_LENGTH_TLLA 1		// multiplied by 8 -> 1 = 8 bytes
+  MACADDR  target_macaddr;
+} ICMPV6_NA;
+
+// this is the complete packet with Ethernet and IPv6 headers
+typedef struct {
+  ETH_HEADER eth;
+  IPV6HDR    ipv6;
+  ICMPV6_NA  icmpv6;
+} ICMPV6_NA_PKT;
+
 #pragma pack()
diff --git a/tap-win32/tapdrvr.c b/tap-win32/tapdrvr.c
index 2c6af48..79b4c67 100755
--- a/tap-win32/tapdrvr.c
+++ b/tap-win32/tapdrvr.c
@@ -1429,6 +1429,158 @@ NDIS_STATUS AdapterModify
   return l_Status;
 }
 
+// checksum code for ICMPv6 packet, taken from dhcp.c / udp_checksum
+// see RFC 4443, 2.3, and RFC 2460, 8.1
+USHORT
+icmpv6_checksum (const UCHAR *buf,
+	         const int len_icmpv6,
+	         const UCHAR *saddr6,
+	         const UCHAR *daddr6)
+{
+  USHORT word16;
+  ULONG sum = 0;
+  int i;
+
+  // make 16 bit words out of every two adjacent 8 bit words and
+  // calculate the sum of all 16 bit words
+  for (i = 0; i < len_icmpv6; i += 2){
+    word16 = ((buf[i] << 8) & 0xFF00) + ((i + 1 < len_icmpv6) ? (buf[i+1] & 0xFF) : 0);
+    sum += word16;
+  }
+
+  // add the IPv6 pseudo header which contains the IP source and destination addresses
+  for (i = 0; i < 16; i += 2){
+    word16 =((saddr6[i] << 8) & 0xFF00) + (saddr6[i+1] & 0xFF);
+    sum += word16;
+  }
+  for (i = 0; i < 16; i += 2){
+    word16 =((daddr6[i] << 8) & 0xFF00) + (daddr6[i+1] & 0xFF);
+    sum += word16;
+  }
+
+  // the next-header number and the length of the ICMPv6 packet
+  sum += (USHORT) IPPROTO_ICMPV6 + (USHORT) len_icmpv6;
+
+  // keep only the last 16 bits of the 32 bit calculated sum and add the carries
+  while (sum >> 16)
+    sum = (sum & 0xFFFF) + (sum >> 16);
+
+  // Take the one's complement of sum
+  return ((USHORT) ~sum);
+}
+
+// check IPv6 packet for "is this an IPv6 Neighbor Solicitation that
+// the tap driver needs to answer?"
+// see RFC 4861 4.3 for the different cases
+static IPV6ADDR IPV6_NS_TARGET_MCAST =
+	{ 0xff, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+          0x00, 0x00, 0x00, 0x01, 0xff, 0x00, 0x00, 0x08 };
+static IPV6ADDR IPV6_NS_TARGET_UNICAST =
+	{ 0xfe, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+          0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08 };
+
+BOOLEAN
+HandleIPv6NeighborDiscovery( TapAdapterPointer p_Adapter, UCHAR * m_Data )
+{
+    const ETH_HEADER * e = (ETH_HEADER *) m_Data;
+    const IPV6HDR *ipv6 = (IPV6HDR *) (m_Data + sizeof (ETH_HEADER));
+    const ICMPV6_NS * icmpv6_ns = (ICMPV6_NS *) (m_Data + sizeof (ETH_HEADER) + sizeof (IPV6HDR));
+    ICMPV6_NA_PKT *na;
+    USHORT icmpv6_len, icmpv6_csum;
+
+    // we don't really care about the destination MAC address here
+    // - it's either a multicast MAC, or the userland destination MAC
+    // but since the TAP driver is point-to-point, all packets are "for us"
+
+    // IPv6 target address must be ff02::1::ff00:8 (multicast for
+    // initial NS) or fe80::1 (unicast for recurrent NUD)
+    if ( memcmp( ipv6->daddr, IPV6_NS_TARGET_MCAST,
+		 sizeof(IPV6ADDR) ) != 0 &&
+         memcmp( ipv6->daddr, IPV6_NS_TARGET_UNICAST,
+		 sizeof(IPV6ADDR) ) != 0 )
+    {
+	return FALSE;				// wrong target address
+    }
+
+    // IPv6 Next-Header must be ICMPv6
+    if ( ipv6->nexthdr != IPPROTO_ICMPV6 )
+    {
+	return FALSE;				// wrong next-header
+    }
+
+    // ICMPv6 type+code must be 135/0 for NS
+    if ( icmpv6_ns->type != ICMPV6_TYPE_NS ||
+	 icmpv6_ns->code != ICMPV6_CODE_0 )
+    {
+	return FALSE;				// wrong ICMPv6 type
+    }
+
+    // ICMPv6 target address must be fe80::8 (magic)
+    if ( memcmp( icmpv6_ns->target_addr, IPV6_NS_TARGET_UNICAST,
+	         sizeof(IPV6ADDR) ) != 0 )
+    {
+	return FALSE;				// not for us
+    }
+
+    // packet identified, build magic response packet
+
+    na = (ICMPV6_NA_PKT *) MemAlloc (sizeof (ICMPV6_NA_PKT), TRUE);
+    if ( !na ) return FALSE;
+
+    //------------------------------------------------
+    // Initialize Neighbour Advertisement reply packet
+    //------------------------------------------------
+
+    // ethernet header
+    na->eth.proto = htons(ETH_P_IPV6);
+    COPY_MAC(na->eth.dest, p_Adapter->m_MAC);
+    COPY_MAC(na->eth.src, p_Adapter->m_TapToUser.dest);
+
+    // IPv6 header
+    na->ipv6.version_prio = ipv6->version_prio;
+    NdisMoveMemory( na->ipv6.flow_lbl, ipv6->flow_lbl,
+		    sizeof(na->ipv6.flow_lbl) );
+    icmpv6_len = sizeof(ICMPV6_NA_PKT) - sizeof(ETH_HEADER) - sizeof(IPV6HDR);
+    na->ipv6.payload_len = htons(icmpv6_len);
+    na->ipv6.nexthdr = IPPROTO_ICMPV6;
+    na->ipv6.hop_limit = 255;
+    NdisMoveMemory( na->ipv6.saddr, IPV6_NS_TARGET_UNICAST,
+		    sizeof(IPV6ADDR) );
+    NdisMoveMemory( na->ipv6.daddr, ipv6->saddr,
+		    sizeof(IPV6ADDR) );
+
+    // ICMPv6
+    na->icmpv6.type = ICMPV6_TYPE_NA;
+    na->icmpv6.code = ICMPV6_CODE_0;
+    na->icmpv6.checksum = 0;
+    na->icmpv6.rso_bits = 0x60;		// Solicited + Override
+    NdisZeroMemory( na->icmpv6.reserved, sizeof(na->icmpv6.reserved) );
+    NdisMoveMemory( na->icmpv6.target_addr, IPV6_NS_TARGET_UNICAST,
+		    sizeof(IPV6ADDR) );
+
+    // ICMPv6 option "Target Link Layer Address"
+    na->icmpv6.opt_type = ICMPV6_OPTION_TLLA;
+    na->icmpv6.opt_length = ICMPV6_LENGTH_TLLA;
+    COPY_MAC( na->icmpv6.target_macaddr, p_Adapter->m_TapToUser.dest );
+
+    // calculate and set checksum
+    icmpv6_csum = icmpv6_checksum ( (UCHAR*) &(na->icmpv6),
+				    icmpv6_len,
+				    na->ipv6.saddr,
+				    na->ipv6.daddr );
+    na->icmpv6.checksum = htons( icmpv6_csum );
+
+    DUMP_PACKET ("HandleIPv6NeighborDiscovery",
+		 (unsigned char *) na,
+		 sizeof (ICMPV6_NA_PKT));
+
+    InjectPacketDeferred (p_Adapter, (UCHAR *) na, sizeof (ICMPV6_NA_PKT));
+
+    MemFree (na, sizeof (ICMPV6_NA_PKT));
+
+    return TRUE;				// all fine
+}
+
 //====================================================================
 //                               Adapter Transmission
 //====================================================================
@@ -1565,7 +1717,10 @@ AdapterTransmit (IN NDIS_HANDLE p_AdapterContext,
 
     //===============================================
     // In Point-To-Point mode, check to see whether
-    // packet is ARP or IPv4 (if neither, then drop).
+    // packet is ARP (handled) or IPv4 (sent to app).
+    // IPv6 packets are inspected for neighbour discovery
+    // (to be handled locally), and the rest is forwarded
+    // all other protocols are dropped
     //===============================================
     if (l_Adapter->m_tun)
       {
@@ -1610,6 +1765,27 @@ AdapterTransmit (IN NDIS_HANDLE p_AdapterContext,
 
 	    // Packet looks like IPv4, queue it.
 	    l_PacketBuffer->m_SizeFlags |= TP_TUN;
+
+	  case ETH_P_IPV6:
+	    // make sure that packet is large
+	    // enough to be IPv6
+	    if (l_PacketLength
+		< ETHERNET_HEADER_SIZE + IPV6_HEADER_SIZE)
+	      goto no_queue;
+
+	    // broadcasts and multicasts are handled specially
+	    // (to be implemented)
+
+	    // neighbor discovery packets to fe80::8 are special
+	    // OpenVPN sets this next-hop to signal "handled by tapdrv"
+	    if ( HandleIPv6NeighborDiscovery( l_Adapter,
+					      l_PacketBuffer->m_Data ))
+	      {
+		goto no_queue;
+	      }
+
+	    // Packet looks like IPv6, queue it :-)
+	    l_PacketBuffer->m_SizeFlags |= TP_TUN;
 	  }
       }
 
@@ -1901,6 +2077,8 @@ TapDeviceHook (IN PDEVICE_OBJECT p_DeviceObject, IN PIRP p_IRP)
 		  COPY_MAC (l_Adapter->m_UserToTap.dest, l_Adapter->m_MAC);
 
 		  l_Adapter->m_TapToUser.proto = l_Adapter->m_UserToTap.proto = htons (ETH_P_IP);
+		  l_Adapter->m_UserToTap_IPv6 = l_Adapter->m_UserToTap;
+		  l_Adapter->m_UserToTap_IPv6.proto = htons(ETH_P_IPV6);
 
 		  l_Adapter->m_tun = TRUE;
 
@@ -1938,6 +2116,8 @@ TapDeviceHook (IN PDEVICE_OBJECT p_DeviceObject, IN PIRP p_IRP)
 		  COPY_MAC (l_Adapter->m_UserToTap.dest, l_Adapter->m_MAC);
 
 		  l_Adapter->m_TapToUser.proto = l_Adapter->m_UserToTap.proto = htons (ETH_P_IP);
+		  l_Adapter->m_UserToTap_IPv6 = l_Adapter->m_UserToTap;
+		  l_Adapter->m_UserToTap_IPv6.proto = htons(ETH_P_IPV6);
 
 		  l_Adapter->m_tun = TRUE;
 
@@ -2235,10 +2415,18 @@ TapDeviceHook (IN PDEVICE_OBJECT p_DeviceObject, IN PIRP p_IRP)
 	  {
 	    __try
 	      {
+		ETH_HEADER * p_UserToTap = &l_Adapter->m_UserToTap;
+
+		// for IPv6, need to use ethernet header with IPv6 proto
+		if ( IPH_GET_VER( ((IPHDR*) p_IRP->AssociatedIrp.SystemBuffer)->version_len) == 6 )
+		  {
+		    p_UserToTap = &l_Adapter->m_UserToTap_IPv6;
+		  }
+
 		p_IRP->IoStatus.Information = l_IrpSp->Parameters.Write.Length;
 
 		DUMP_PACKET2 ("IRP_MJ_WRITE P2P",
-			      &l_Adapter->m_UserToTap,
+			      p_UserToTap,
 			      (unsigned char *) p_IRP->AssociatedIrp.SystemBuffer,
 			      l_IrpSp->Parameters.Write.Length);
 
@@ -2257,8 +2445,8 @@ TapDeviceHook (IN PDEVICE_OBJECT p_DeviceObject, IN PIRP p_IRP)
 		NdisMEthIndicateReceive
 		  (l_Adapter->m_MiniportAdapterHandle,
 		   (NDIS_HANDLE) l_Adapter,
-		   (unsigned char *) &l_Adapter->m_UserToTap,
-		   sizeof (l_Adapter->m_UserToTap),
+		   (unsigned char *) p_UserToTap,
+		   sizeof (ETH_HEADER),
 		   (unsigned char *) p_IRP->AssociatedIrp.SystemBuffer,
 		   l_IrpSp->Parameters.Write.Length,
 		   l_IrpSp->Parameters.Write.Length);
@@ -2819,6 +3007,7 @@ VOID ResetTapAdapterState (TapAdapterPointer p_Adapter)
   p_Adapter->m_remoteNetmask = 0;
   NdisZeroMemory (&p_Adapter->m_TapToUser, sizeof (p_Adapter->m_TapToUser));
   NdisZeroMemory (&p_Adapter->m_UserToTap, sizeof (p_Adapter->m_UserToTap));
+  NdisZeroMemory (&p_Adapter->m_UserToTap_IPv6, sizeof (p_Adapter->m_UserToTap_IPv6));
 
   // DHCP Masq
   p_Adapter->m_dhcp_enabled = FALSE;
diff --git a/tap-win32/types.h b/tap-win32/types.h
index 48bdff7..312fe92 100755
--- a/tap-win32/types.h
+++ b/tap-win32/types.h
@@ -143,6 +143,7 @@ typedef struct _TapAdapter
   IPADDR m_remoteNetmask;
   ETH_HEADER m_TapToUser;
   ETH_HEADER m_UserToTap;
+  ETH_HEADER m_UserToTap_IPv6;		// same as UserToTap but proto=ipv6
   MACADDR m_MAC_Broadcast;
 
   // Used for DHCP server masquerade

-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

