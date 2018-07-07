From: Kristian McColm <kristianmccolm@...160...>
Date: Sat, 7 Jul 2018 01:27:23 +0000
Message-ID: <BN6PR04MB088248FC428ABCF529D3CFD5DD460@...2438...>
Content-Language: en-US
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN Connect App on IOS // Support for IPv6-only
 networks with DNS64/NAT64
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hello List,

As you may be aware, the Internet is running/has run out of IPv4 address sp=
ace. To that end, I am a part of a team at a national mobile network operat=
or who are working on deploying IPv6-only mode to our Android and iPhone ha=
ndsets, and deprecating the use of IPv4 on our netowrk. Since we have begun=
 migrations to IPv6-only mode, we have received a few complaints from users=
 of the OpenVPN Connect app on IOS stating that their VPN tunnels are estab=
lishing but they are unable to pass and data inside the tunnel.

We have been able to reproduce the issue=A0using an OpenVPN server 2.4.6 on=
 Fedora Linux 26 and an iPhone running IOS 11.3.1 and version 1.2.0 build 0=
 (iOS 64-bit). The VPN server is IPv4 only and using UDP transport. The IOS=
 device is on an IPv6-only network that provides DNS64/NAT64 for 6to4 trans=
lation. The Android device is running Android 6.0.1 and OpenVPN Connect ver=
sion 3.0.5 (1816). Using the same client profile (.ovpn file) on both the A=
ndroid and and IOS clients, and the same cell network settings and VPN serv=
er, we observe that the VPN tunnel is established OK on both devices, but o=
nly the Android is able to pass data traffic inside the VPN tunnel.

Is anyone aware of whether the developers of this application have any expe=
rience testing the IOS version of the app on IOS devices on IPv6-only netwo=
rks, and moreover are the developers aware of and ensuring the app is compl=
iant with Apple standards for IPv6-only networks as documented here: https:=
//developer.apple.com/support/ipv6?

As per our understanding, Apple are actively pursuing apps which are not co=
mpliant with these standards, since IOS does not provide 464XLAT at the cur=
rent time and compliance with Apple's standard is the only way to ensure co=
mpatibility with IPv6-only networks such as ours.

If anyone who has any feedback or would like me to test anything or provide=
 any further assistance I would be glad to assist.

Regards
KM


