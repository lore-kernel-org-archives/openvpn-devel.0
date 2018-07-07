References: <BN6PR04MB088248FC428ABCF529D3CFD5DD460@...2438...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <06da91cb-ef1e-69db-e131-5d27fcfeee5f@...1227...>
Date: Sat, 7 Jul 2018 15:33:54 +0200
MIME-Version: 1.0
In-Reply-To: <BN6PR04MB088248FC428ABCF529D3CFD5DD460@...2438...>
Content-Language: de-DE
Subject: Re: [Openvpn-devel] OpenVPN Connect App on IOS // Support for
 IPv6-only networks with DNS64/NAT64
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
To: Kristian McColm <kristianmccolm@...160...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 07.07.18 um 03:27 schrieb Kristian McColm:
> Hello List,
> 
> As you may be aware, the Internet is running/has run out of IPv4 address space. To that end, I am a part of a team at a national mobile network operator who are working on deploying IPv6-only mode to our Android and iPhone handsets, and deprecating the use of IPv4 on our netowrk. Since we have begun migrations to IPv6-only mode, we have received a few complaints from users of the OpenVPN Connect app on IOS stating that their VPN tunnels are establishing but they are unable to pass and data inside the tunnel.
> 
> We have been able to reproduce the issue using an OpenVPN server 2.4.6 on Fedora Linux 26 and an iPhone running IOS 11.3.1 and version 1.2.0 build 0 (iOS 64-bit). The VPN server is IPv4 only and using UDP transport. The IOS device is on an IPv6-only network that provides DNS64/NAT64 for 6to4 translation. The Android device is running Android 6.0.1 and OpenVPN Connect version 3.0.5 (1816). Using the same client profile (.ovpn file) on both the Android and and IOS clients, and the same cell network settings and VPN server, we observe that the VPN tunnel is established OK on both devices, but only the Android is able to pass data traffic inside the VPN tunnel.
> 
> Is anyone aware of whether the developers of this application have any experience testing the IOS version of the app on IOS devices on IPv6-only networks, and moreover are the developers aware of and ensuring the app is compliant with Apple standards for IPv6-only networks as documented here: https://developer.apple.com/support/ipv6?
> 
> As per our understanding, Apple are actively pursuing apps which are not compliant with these standards, since IOS does not provide 464XLAT at the current time and compliance with Apple's standard is the only way to ensure compatibility with IPv6-only networks such as ours.
> 
> If anyone who has any feedback or would like me to test anything or provide any further assistance I would be glad to assist.

From my experience with Android and NAT64:

- T-mobile US had (or still has?) an issue with MTU on UDP connections
on NAT64. Behaviour looks similar to what you are experiencing. Try if
using TCP or UDP makes a difference.


- Too often profiles have literal IPv4 addresses in them instead of
IPv6. Google patched its XLAT464 to even allow VPN tunnel to work over
XLAT464 (urgh)

- For split tunnel configuration, setting a IPv4 DNS that is unreachable
might also cause troubles.

- Reconecting involving NAT64/DNS64 networks often breaks because the
whole "what DNS does the VPN app use" is a total mess and often end up
with the wrong address (unmapped, still mapped when switching to WiFi).

Arne

