From: "Andrew Goodney" <S3070337@...173...>
MIME-Version: 1.0
Message-ID: <1078123995.c7b89ba0S3070337@...173...>
Subject: [Openvpn-devel] winXP strangeness -long
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
Date: Sun Feb 29 22:58:05 2004
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

I may have a worst case senario, and hopefully someone has an idea as to wh=
at might be wrong. Sorry for the length...

Thanks in advance...

Set up is as follows:

(winXP-home, wireless with Novell VPN Client) -> http-proxy -> linux server

I've tried both 1.5.0 and the latest 1.6beta with both tun and tap. Also bo=
th manual and automatic IP config.

I can get the VPN connection established over the proxy. However the WinXP =
interface never seems to recieve any packets. Using tcpdump on the linux en=
d and windump on the XP end I never see a packet recieved on XP.

Pinging XP -> linux you see both the echo request and echo reply in tcpdump=
 on linux. Windump sees only the echo request.

Pinging linux -> XP tcpdump on linux sees the echo request. windump sees no=
thing.

Arp seems to work, as I can see arp requests and replys and the arp table o=
n each machine seems to be correct.

Strangely, the packet counter on the WinXP "Local Area Connection 2" dialog=
 increases as the ICPM pings come in, but they do not make it to windump. T=
he openvpn console windows on both linux and XP show the rW etc. as the pac=
kets are written/recieved.

Using nmap on the linux machine: with tcpdump you can see the packets go ou=
t on linux, they are not seen on windump. UDP as well as TCP.

command line on linux: --dev tap --mssfix --tun-mtu 1500 --tun-mtu-extra 32=
 --verb 5 --proto tcp-server

XP command line is complementary.

I've also tried smaller mtu values (with the appropriate change on the XP t=
ap adapter)


