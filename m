Subject: Re: [Openvpn-devel] option suggestion (was Re: routing on windows)
From: "James Yonan" <jim@...41...>
Message-ID: <twig.1067635476.84761@...41...>
In-Reply-To: <3FA23C83.7020200@...129...>
References: <3FA22924.8010404@...129...>, <3FA22924.8010404@...129...>
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
Date: Fri Oct 31 13:25:13 2003
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Farkas Levente <lfarkas@...129...>, openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net

Farkas Levente <lfarkas@...129...> said:

> Mathias Sundman wrote:
> > Hi!
> > 
> >  > we use our linux vpn gateway and some win2000 road warrior clients with
> >  > openvpn. I would like to route all internet traffic trough our firewall
> >  > from the windows clients.
> > 
> >  I´ve been thinking about doing this too, but never accually tried it.
> > 
> >  What you basicly need to do is:
> > 
> >  1. Don´t set a default gateway on your ethernet adapter.
> 
> you have to set otherwise the vpn connection can't estabilished.
> 
> >  2. Add a route to your openvpn server with a /32 mask pointing to the
> >     gateway on your ethernet.
> > 
> >     In your exampel this would be done with the following command on
> >     Win2K where w.x.y.z is the IP of your remote openvpn server,
> >     and a.b.c.254 is your local gateway.
> > 
> >     ROUTE ADD w.x.y.z MASK 255.255.255.255 a.b.c.254
> > 
> >  3. Setup OpenVPN as usual but also add a default gateway route to
> >     the TAP interface.
> > 
> > 
> >  The reason why I havn´t tried this is because I don´t know how to solve
> >  the problem that the ROUTE command will be diffrent for each network you
> >  hook your laptop into. So if you don´t want to manually do this every
> >  time, you would need to write a little app that looks at the IP and
> >  default gateway that has been assigned by DHCP, switch to static IP and
> >  add the correct route.
> > 
> >  Anyone that has a better solution to this?
> 
> you see exactly the problem!
> on linux I can do (eg. in the up script):
> ----------------------------------
> route add -host <remote-server-ip> dev ppp0
> route del default dev ppp0
> route add default dev tun0
> ----------------------------------
> and we got it, but unfotunately on windows you can't route by interface 
> (or to be more precise on windos the interface is defined by it's ip 
> address even if you can specify the interface).
> so I'd like to suggest a new option for openvpn to be portable (like in 
> the case of --route):
> --route-internal
>    which do exactly as the above on all platform.
> since openvpn know whcih ip address has the under the tun/tap interface.
> or may it would be more better if the up script has one more (6th) 
> paramter and the underlying interface's ip address:
> -----------------------------------
> cmd tun_dev tun_mtu link_mtu ifconfig_local_ip ifconfig_remote_ip 
> underlying_ip [ init | restart ]
> cmd tap_dev tap_mtu link_mtu ifconfig_local_ip ifconfig_netmask 
> underlying_ip [ init | restart ]
> -----------------------------------
> and in this case on linux we cn write an up script as:
> ----------------------------------
> route add -host $5 dev ppp0
> route del default dev ppp0
> route add default dev tun0
> ----------------------------------
> while on windows
> ----------------------------------
> route add $5 gw $6
> route delete 0.0.0.0 mask 0.0.0.0 $5
> route add 0.0.0.0 mask 0.0.0.0 $4
> ----------------------------------
> does it possible? or any better solution?

When you say "underlying_ip" I assume you mean the original default gateway
(before the up script (might have) changed it)?

I agree that it would be useful to provide an "original default gateway"
parameter to up scripts.

This would provide the support necessary to conveniently route all IP traffic
through the VPN tunnel.

Unfortunately, as is often the case with network configuration, there is no
standard API for doing this.

To make this work in OpenVPN, you would need to follow the model of tun.c and
route.c where there is a function such as get_default_gateway that has a bunch
of #ifdefs for each platform.

If you want this to work on Windows right now, I would suggest you run "route
print" in your up script and pipe the output to a program which parses out the
"default gateway" information and returns it to the script.

Then you can do the little routing dance where you route the VPN endpoint to
the original default gateway, then reset the default gateway to point to the
TAP adapter.

James


