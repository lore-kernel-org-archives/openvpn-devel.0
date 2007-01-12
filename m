Date: Fri, 12 Jan 2007 15:13:42 +0900
From: UMEZAWA Takeshi <umezawa@...528...>
Message-Id: <20070112145726.B845.UMEZAWA@...528...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fails to add route to OpenVPN server's
	tunnel address on Windows Vista
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On Windows Vista, OpenVPN client fails to add route to OpenVPN server's
tunnel address. After some try and error, I've found that this problem
can be avoided by setting route metric much larger.


Example of this problem:

openvpn.conf on server (NetBSD):

    dev tun0
    server 169.254.0.0 255.255.0.0
    proto tcp-server
    lport 443
    dh /etc/dhparam.pem
    ca /etc/ca-cert.pem
    cert /etc/server-cert.pem
    key /etc/server-key.pem

While OpenVPN server is running, 169.254.0.1 is set to tun0.

openvpn.ovpn on client (Windows):

    client
    proto tcp-client
    nobind
    dev tun
    remote <address-of-server>
    rport 443
    ca "C:\\mycert\\ca-cert.pem"
    cert "C:\\mycert\\client-cert.pem"
    key "C:\\mycert\\client-key.pem"

If OpenVPN client is running on Windows XP Professional, route to
169.254.0.1 is added correctly like following routing table:

C:\Documents and Settings\umezawa>route print
(snip)
===========================================================================
Active Routes:
Network Destination        Netmask          Gateway       Interface  Metric
          0.0.0.0          0.0.0.0    192.168.186.1  192.168.186.192      10
        127.0.0.0        255.0.0.0        127.0.0.1       127.0.0.1       1
      169.254.0.1  255.255.255.255      169.254.0.5     169.254.0.6       1
      169.254.0.4  255.255.255.252      169.254.0.6     169.254.0.6       30
      169.254.0.6  255.255.255.255        127.0.0.1       127.0.0.1       30
  169.254.255.255  255.255.255.255      169.254.0.6     169.254.0.6       30
(snip)

However, on Windows Vista Ultimate Edition, OpenVPN client fails to add
the route as following output:

Fri Jan 12 15:02:29 2007 OpenVPN 2.0.9 Win32-MinGW [SSL] [LZO] built on Oct  1 2006
Fri Jan 12 15:02:29 2007 WARNING: No server certificate verification method has been enabled.  See http://openvpn.net/howto.html#mitm for more info.
Fri Jan 12 15:02:29 2007 Attempting to establish TCP connection with <address-of-server>:443
Fri Jan 12 15:02:29 2007 TCP connection established with <address-of-server>:443
Fri Jan 12 15:02:29 2007 TCPv4_CLIENT link local: [undef]
Fri Jan 12 15:02:29 2007 TCPv4_CLIENT link remote: <address-of-server>:443
Fri Jan 12 15:02:29 2007 [otm-idgw-server] Peer Connection Initiated with <address-of-server>:443
Fri Jan 12 15:02:31 2007 TAP-WIN32 device [Local Area Connection 2] opened: \\.\Global\{A5A61131-3E01-48F4-9ED6-23FD6F14649F}.tap
Fri Jan 12 15:02:31 2007 Notified TAP-Win32 driver to set a DHCP IP/netmask of 169.254.0.6/255.255.255.252 on interface {A5A61131-3E01-48F4-9ED6-23FD6F14649F} [DHCP-serv: 169.254.0.5, lease-time: 31536000]
Fri Jan 12 15:02:31 2007 Successful ARP Flush on interface [14] {A5A61131-3E01-48F4-9ED6-23FD6F14649F}
Fri Jan 12 15:02:31 2007 ROUTE: route addition failed using CreateIpForwardEntry: One or more arguments are not correct.   [if_index=14]
Fri Jan 12 15:02:31 2007 Initialization Sequence Completed
Fri Jan 12 15:03:31 2007 SIGTERM[hard,] received, process exiting

and routing table is like:

C:\Users\VistaUser>route print -4
(snip)
IPv4 Route Table
===========================================================================
Active Routes:
Network Destination        Netmask          Gateway       Interface  Metric
          0.0.0.0          0.0.0.0    192.168.186.1  192.168.186.248     10
        127.0.0.0        255.0.0.0         On-link         127.0.0.1    306
        127.0.0.1  255.255.255.255         On-link         127.0.0.1    306
  127.255.255.255  255.255.255.255         On-link         127.0.0.1    306
      169.254.0.4  255.255.255.252         On-link       169.254.0.6    286
      169.254.0.6  255.255.255.255         On-link       169.254.0.6    286
      169.254.0.7  255.255.255.255         On-link       169.254.0.6    286
(snip)

Route to 169.254.0.1 does not exist.


Example patch for OpenVPN 2.0.9:

[umezawa@...999... ~]$ diff -ur orig/openvpn-2.0.9 patched/openvpn-2.0.9
diff -u -ur orig/openvpn-2.0.9/route.c patched/openvpn-2.0.9/route.c
--- orig/openvpn-2.0.9/route.c	Wed Apr  5 15:13:55 2006
+++ patched/openvpn-2.0.9/route.c	Mon Dec 18 18:43:47 2006
@@ -1128,7 +1128,7 @@
       fr.dwForwardProto = 3; /* PROTO_IP_NETMGMT */
       fr.dwForwardAge = 0;
       fr.dwForwardNextHopAS = 0;
-      fr.dwForwardMetric1 = r->metric_defined ? r->metric : 1;
+      fr.dwForwardMetric1 = r->metric_defined ? r->metric : 100;
       fr.dwForwardMetric2 = ~0;
       fr.dwForwardMetric3 = ~0;
       fr.dwForwardMetric4 = ~0;

I have tested metric value 1, 2, and 100. 1 and 2 causes the problem on
my environment and 100 does not. I cannot understand why this patch
avoid the problem...

--------------------------------------------------------------------
UMEZAWA Takeshi (FAMILY Given) <umezawa@...528...>
Internet Initiative Japan Inc.
PGP fingerprint = E9B1 4E6F 5E5F 6487 B93D  3FC6 1ACF C167 9D68 3E90


