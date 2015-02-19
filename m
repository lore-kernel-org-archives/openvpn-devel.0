MIME-Version: 1.0
Date: Thu, 19 Feb 2015 13:52:51 -0700
Message-ID: <CAAA5faExMKUpmHNtVjXvvkpWb95-FFpfZ2FKEsUfppJU2Jk8tA@...278...>
From: Reinoud Koornstra <reinoudkoornstra@...277...>
Subject: [Openvpn-devel] statistics file format not respected in
	point-to-point?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi Everyone,

I have a side to side (point to point) configuration. Meaning no
client or server involved.
It comes up fine.
I did set this as well in the  config file:

status /tmp/openvpn_hello_status.log 5
status-version 3

When i look at the file:

OpenVPN STATISTICS
Updated,Thu Feb 19 13:41:29 2015
TUN/TAP read bytes,0
TUN/TAP write bytes,0
TCP/UDP read bytes,1480
TCP/UDP write bytes,1647
Auth read bytes,1480
END

This looks like format 1 when looking at the client-server statistics file case.
Is this correct or is the actually format 3?
The statistics file for server is more like I expected:

TITLE   OpenVPN 2.3.4 i486-gnu-linux-gnu [SSL (OpenSSL)] [EPOLL] [MH]
[IPv6] built on Feb 19 2015
TIME    Thu Feb 19 13:25:08 2015        1424377508
HEADER  CLIENT_LIST     Common Name     Real Address    Virtual
Address Bytes Received  Bytes Sent      Connected Since Connected
Since_(time_t)        Username
CLIENT_LIST     blabla   172.21.2.127:1194       192.168.0.6     5701
  5769    Thu Feb 19 13:19:07 2015        1424377147      UNDEF
HEADER  ROUTING_TABLE   Virtual Address Common Name     Real Address
 Last Ref        Last Ref (time_t)
ROUTING_TABLE   192.168.0.6     blabla   172.21.2.127:1194       Thu
Feb 19 13:19:08 2015        1424377148
GLOBAL_STATS    Max bcast/mcast queue length    0
END

