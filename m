Message-ID: <3FA23C83.7020200@...129...>
From: Farkas Levente <lfarkas@...129...>
MIME-Version: 1.0
References: <3FA22924.8010404@...129...>
In-Reply-To: <3FA22924.8010404@...129...>
Subject: [Openvpn-devel] option suggestion (was Re: routing on windows)
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Fri Oct 31 02:43:02 2003
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net

Mathias Sundman wrote:
> Hi!
>=20
>  > we use our linux vpn gateway and some win2000 road warrior clients with
>  > openvpn. I would like to route all internet traffic trough our firewall
>  > from the windows clients.
>=20
>  I=B4ve been thinking about doing this too, but never accually tried it.
>=20
>  What you basicly need to do is:
>=20
>  1. Don=B4t set a default gateway on your ethernet adapter.

you have to set otherwise the vpn connection can't estabilished.

>  2. Add a route to your openvpn server with a /32 mask pointing to the
>     gateway on your ethernet.
>=20
>     In your exampel this would be done with the following command on
>     Win2K where w.x.y.z is the IP of your remote openvpn server,
>     and a.b.c.254 is your local gateway.
>=20
>     ROUTE ADD w.x.y.z MASK 255.255.255.255 a.b.c.254
>=20
>  3. Setup OpenVPN as usual but also add a default gateway route to
>     the TAP interface.
>=20
>=20
>  The reason why I havn=B4t tried this is because I don=B4t know how to so=
lve
>  the problem that the ROUTE command will be diffrent for each network you
>  hook your laptop into. So if you don=B4t want to manually do this every
>  time, you would need to write a little app that looks at the IP and
>  default gateway that has been assigned by DHCP, switch to static IP and
>  add the correct route.
>=20
>  Anyone that has a better solution to this?

you see exactly the problem!
on linux I can do (eg. in the up script):
----------------------------------
route add -host <remote-server-ip> dev ppp0
route del default dev ppp0
route add default dev tun0
----------------------------------
and we got it, but unfotunately on windows you can't route by interface=20
(or to be more precise on windos the interface is defined by it's ip=20
address even if you can specify the interface).
so I'd like to suggest a new option for openvpn to be portable (like in=20
the case of --route):
--route-internal
   which do exactly as the above on all platform.
since openvpn know whcih ip address has the under the tun/tap interface.
or may it would be more better if the up script has one more (6th)=20
paramter and the underlying interface's ip address:
-----------------------------------
cmd tun_dev tun_mtu link_mtu ifconfig_local_ip ifconfig_remote_ip=20
underlying_ip [ init | restart ]
cmd tap_dev tap_mtu link_mtu ifconfig_local_ip ifconfig_netmask=20
underlying_ip [ init | restart ]
-----------------------------------
and in this case on linux we cn write an up script as:
----------------------------------
route add -host $5 dev ppp0
route del default dev ppp0
route add default dev tun0
----------------------------------
while on windows
----------------------------------
route add $5 gw $6
route delete 0.0.0.0 mask 0.0.0.0 $5
route add 0.0.0.0 mask 0.0.0.0 $4
----------------------------------
does it possible? or any better solution?

--=20
   Levente                               "Si vis pacem para bellum!"



