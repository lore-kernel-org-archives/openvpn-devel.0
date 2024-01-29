MIME-Version: 1.0
From: Tony He <huangya90@...277...>
Date: Mon, 29 Jan 2024 12:25:21 +0800
Message-ID: <CAAUX2SWqB=3zUqqxcXBEN-p6mq2ea8i-gjy-AX3aBXJzrE-QMA@...278...>
Subject: [Openvpn-devel] [ovpn-dco] Can ovpn-dco use all cpu cores?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Antonio Quartulli <antonio@...515...>
Cc: Antonio Quartulli <a@...2181...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi Antonio,

I'm using ovpn-dco which is backported to v4.14 based on your latest
code. My topology is:

LAN PC -- openwrt router running openvpn server -- WAN PC running openvpn c=
lient
Router is with two mips64 cores.

I use the iperf3 to test speed between LAN PC and WAN PC.
The result is sometime the performance is good(~280Mbps=EF=BC=89 while
sometimes is bad(~140Mbps).
 When the performance is bad, one of two CPUs is 100% idle. When the
performance is good, two CPUs are busy. However=EF=BC=8C I don't see the is=
sue
when ipsec is tested in the same test env. Two cores are always used
for ipsec. So , can ovpn-dco use all cpu cores to get max performance?
Thank you!

Tony

