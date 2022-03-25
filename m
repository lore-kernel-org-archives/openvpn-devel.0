Date: Fri, 25 Mar 2022 19:57:55 +0100 (CET)
Message-Id: <202203251857.22PIvta2049622@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220224144245.878056-1-arne@...1227...>
References: <20220224144245.878056-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Implement fixed MSS value for
 mssfix and use it for non default MTUs
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

I have tested this on the server and client test rigs ("nothing broke").

Also, explicitly tested this using "--mssfix 500 fixed" and tcpdumped
on the tunnel interface - not caring about outside packet size, this time.

TUN mode:
  IPv4 MSS: 460
    Family: IP (2)
    Total Length: 500
    Transmission Control Protocol, Src Port: 22, Dst Port: 36351, Seq: 5005, Ack: 37, Len: 448
    TCP payload (448 bytes)

  IPv6 MSS: 440
    Family: IPv6 (28)
    Payload Length: 460
    Transmission Control Protocol, Src Port: 22, Dst Port: 27345, Seq: 8518, Ack: 3034, Len: 428
    [TCP Segment Len: 428]
    TCP payload (428 bytes)

  (tshark / tcpdump claim "504 bytes on the wire" in both cases, but
   I assume this is some FreeBSD/tun overhead artefact... maybe the
   "is this ipv4 or or ipv6?" extra header)

TAP mode:

  IPv4 MSS: 460
    514 bytes on wire (4112 bits), 514 bytes captured (4112 bits) on interface tap0, id 0
    ...
    TCP payload (448 bytes)

  IPv6 MSS: 440
    514 bytes on wire (4112 bits), 514 bytes captured (4112 bits) on interface tap0, id 0
    ...
    TCP payload (428 bytes)


So, in tun mode, this does what it says on the lid ("MSS is lowered so
the resulting IPv4/IPv6 packet is not exceeding this value").  For TAP,
there is overhead, which gets added.

Arguably this is *correct* behaviour - this goes hand in hand with
"--tun-mtu $small --mssfix (default)", and if you set a "--tun-mtu 500"
on a *TAP* interface, this is what you get: IP packets "up to 500",
plus ethernet header.  The system-set MSS value will be exactly the
same number that OpenVPN uses in this case (tested!), so -> perfect.


Your patch has been applied to the master branch.

commit 47671d6d6814eadb3dd5e742ebc40c6f21038224
Author: Arne Schwabe
Date:   Thu Feb 24 15:42:45 2022 +0100

     Implement fixed MSS value for mssfix and use it for non default MTUs

     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20220224144245.878056-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23886.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


