From: Teodor Milkov <tm@...2385...>
Message-ID: <e70826e2-7ad7-e64b-76b5-14588ef98b04@...2385...>
Date: Mon, 12 Mar 2018 12:37:00 +0200
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="------------5888DF5A7DF4C9E789827DFB"
Content-Language: en-US
Subject: [Openvpn-devel] multihome broken in the presence of asymmetric
 routing
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------5888DF5A7DF4C9E789827DFB
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

Hello,

I have the following multihomed setup:


            BGP1                        BGP2
             ^                           ^
             |                           |
+-----------+-----------+    +----------+-----------+
| IP1.1   IP1.2   IP1.3 |    | IP2.1  IP2.2   IP3.1 |
|                       |    |                      |
|                       |    |                      |
|          RTR1         |    |         RTR2         |
|                       |    |                      |
|                       |    |                      |
|          vIP          |    |         vIP          |
+-----------+-----------+    +----------+-----------+
             |                           |
             |                           |
             |                           |
             |            VRRP           |
             +---------------------------+


I.e. two routers with BGP to multiple ISPs. VRRP running at inner side 
keeping one virtual IP (vIP) up at the master router.

Someday I hope I'll be able to use the vIP only for openvpn server bind 
IP ("local" config option). Untill then, for legacy reasons, I have to 
use the "multihome" config option, so that clients could connect to each 
of the 7 IPs (IP1.1, IP1.2, IP1.3, IP2.1, IP2.2, IP2.3, vIP).

Unfortunately, Linux would not respond to /some/ clients over UDP. It 
seems like this is due to the way "multihome" forces the output 
interface using IP_PKTINFO when we have asymetric path to/from vpn clients.

To provide single-socket UDP multihoming, openvpn uses the IP_PKTINFO 
data from recvmsg() and passes it as-is to sendmsg(). Apparently 
ipi_ifindex behaves in an interesting way under Linux. man 7 ip states:

     If  IP_PKTINFO  is  passed  to  sendmsg(2)  and ipi_spec_dst  is  not
     zero, then it is used as the local source address for the routing table
     lookup and for setting up IP source route options.  When ipi_ifindex is
     not zero, the primary local address of the interface  specified  by
     the  index overwrites ipi_spec_dst for the routing table lookup.


In my tests it's like /ipi_ifindex/ will override any routing table 
decision. But then if there is no routing table entry for the 
destination via
that interface, the destination will be assumed to be on-link and will 
not be routed via a gateway. No error is returned to
userspace, but if the destination does not respond to an ARP request on 
that link, the packet will be silently dropped. That's what I see with 
tcpdump on the openvpn server: arp requests for the dst address of the 
openvpn client. For example if a.b.c.100 is an openvpn client and 
x.y.z.1 is the virtual IP on the openvpn server to which the client 
tries to connect:

11:52:40.695830 ARP, Request who-has a.b.c.100 tell x.y.z.1, length 28

I got it working by patching socket.c in the following manner:

--- openvpn-2.4.0/src/openvpn/socket.c  2016-12-26 13:51:00.000000000 +0200
+++ openvpn-2.4.0/src/openvpn/socket.c  2018-03-09 15:37:10.015832657 +0200
@@ -3379,7 +3379,7 @@
              {
                  struct in_pktinfo *pkti;
                  pkti = (struct in_pktinfo *) CMSG_DATA(cmsg);
-                pkti->ipi_ifindex = to->pi.in4.ipi_ifindex;
+                pkti->ipi_ifindex = 0;
                  pkti->ipi_spec_dst = to->pi.in4.ipi_spec_dst;
                  pkti->ipi_addr.s_addr = 0;
              }


I guess this should be confirmed by someone else too, and I haven't 
looked into IPv6 side at all, but the above patch works for me ™.

Best regards,
Teodor Milkov

--------------5888DF5A7DF4C9E789827DFB
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    Hello,<br>
    <br>
    I have the following multihomed setup:<br>
    <br>
    <br>
    <tt>           BGP1                        BGP2</tt><tt><br>
    </tt><tt>            ^                           ^</tt><tt><br>
    </tt><tt>            |                           |</tt><tt><br>
    </tt><tt>+-----------+-----------+    +----------+-----------+</tt><tt><br>
    </tt><tt>| IP1.1   IP1.2   IP1.3 |    | IP2.1  IP2.2   IP3.1 |</tt><tt><br>
    </tt><tt>|                       |    |                      |</tt><tt><br>
    </tt><tt>|                       |    |                      |</tt><tt><br>
    </tt><tt>|          RTR1         |    |         RTR2         |</tt><tt><br>
    </tt><tt>|                       |    |                      |</tt><tt><br>
    </tt><tt>|                       |    |                      |</tt><tt><br>
    </tt><tt>|          vIP          |    |         vIP          |</tt><tt><br>
    </tt><tt>+-----------+-----------+    +----------+-----------+</tt><tt><br>
    </tt><tt>            |                           |</tt><tt><br>
    </tt><tt>            |                           |</tt><tt><br>
    </tt><tt>            |                           |</tt><tt><br>
    </tt><tt>            |            VRRP           |</tt><tt><br>
    </tt><tt>            +---------------------------+</tt><br>
    <br>
    <br>
    I.e. two routers with BGP to multiple ISPs. VRRP running at inner
    side keeping one virtual IP (vIP) up at the master router.<br>
    <br>
    Someday I hope I'll be able to use the vIP only for openvpn server
    bind IP ("local" config option). Untill then, for legacy reasons, I
    have to use the "multihome" config option, so that clients could
    connect to each of the 7 IPs (IP1.1, IP1.2, IP1.3, IP2.1, IP2.2,
    IP2.3, vIP).<br>
    <br>
    Unfortunately, Linux would not respond to <i>some</i> clients over
    UDP. It seems like this is due to the way "multihome" forces the
    output interface using
    IP_PKTINFO when we have asymetric path to/from vpn clients.<br>
    <br>
    To provide single-socket UDP multihoming, openvpn uses the
    IP_PKTINFO data from recvmsg() and passes it as-is to sendmsg().
    Apparently ipi_ifindex behaves in an interesting way under Linux.
    man 7 ip states:
    <pre class="bz_comment_text">
    If  IP_PKTINFO  is  passed  to  sendmsg(2)  and ipi_spec_dst  is  not
    zero, then it is used as the local source address for the routing table
    lookup and for setting up IP source route options.  When ipi_ifindex is
    not zero, the primary local address of the interface  specified  by
    the  index overwrites ipi_spec_dst for the routing table lookup.


</pre>
    In my tests it's like <i>ipi_ifindex</i> will override any routing
    table decision. But then if there is no routing table entry for the
    destination via<br>
    that interface, the destination will be assumed to be on-link and
    will not be routed via a gateway. No error is returned to<br>
    userspace, but if the destination does not respond to an ARP request
    on that link, the packet will be silently dropped. That's what I see
    with tcpdump on the openvpn server: arp requests for the dst address
    of the openvpn client. For example if a.b.c.100 is an openvpn client
    and x.y.z.1 is the virtual IP on the openvpn server to which the
    client tries to connect:<br>
    <br>
    <tt>11:52:40.695830 ARP, Request who-has a.b.c.100 tell x.y.z.1,
      length 28</tt><br>
    <br>
    I got it working by patching socket.c in the following manner:<br>
    <br>
    <tt>--- openvpn-2.4.0/src/openvpn/socket.c  2016-12-26
      13:51:00.000000000 +0200</tt><tt><br>
    </tt><tt>+++ openvpn-2.4.0/src/openvpn/socket.c  2018-03-09
      15:37:10.015832657 +0200</tt><tt><br>
    </tt><tt>@@ -3379,7 +3379,7 @@</tt><tt><br>
    </tt><tt>             {</tt><tt><br>
    </tt><tt>                 struct in_pktinfo *pkti;</tt><tt><br>
    </tt><tt>                 pkti = (struct in_pktinfo *)
      CMSG_DATA(cmsg);</tt><tt><br>
    </tt><tt>-                pkti-&gt;ipi_ifindex =
      to-&gt;pi.in4.ipi_ifindex;</tt><tt><br>
    </tt><tt>+                pkti-&gt;ipi_ifindex = 0;</tt><tt><br>
    </tt><tt>                 pkti-&gt;ipi_spec_dst =
      to-&gt;pi.in4.ipi_spec_dst;</tt><tt><br>
    </tt><tt>                 pkti-&gt;ipi_addr.s_addr = 0;</tt><tt><br>
    </tt><tt>             }</tt><tt><br>
    </tt><br>
    <br>
    I guess this should be confirmed by someone else too, and I haven't
    looked into IPv6 side at all, but the above patch works for me ™.<br>
    <br>
    Best regards,<br>
    Teodor Milkov<br>
  </body>
</html>

--------------5888DF5A7DF4C9E789827DFB--

