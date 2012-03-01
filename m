Date: Thu, 1 Mar 2012 13:15:54 +0100
From: =?iso-8859-1?Q?Carsten_Kr=FCger?= <C.Krueger@...448...>
Message-ID: <38614505.20120301131554@...449...>
In-Reply-To: <4F4F6675.1090306@...1114...>
References: <4F4CE4FE.3010009@...515...> <3440230.bBsdCSzEj1@...1526...>
	<1375292789.20120229123817@...449...> <7855235.EvfmKnZP6h@...1526...>
	<CAP+U6t+ZUA3UpYfKms0Qr=-Cn1M-GP1EJtGybG0+j+O2xnfv7g@...278...>
	<1957833067.20120229194040@...449...>
	<4F4E7BEE.50700@...1114...>
	<1656594721.20120229203737@...449...>
	<4F4F6675.1090306@...1114...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN 2.3-alpha1 released
Reply-To: =?iso-8859-1?Q?Carsten_Kr=FCger?= <C.Krueger@...448...>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: David Sommerseth <openvpn.list@...1114...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hello David,

> a) Mounting and un-mounting networked filesystems after the tunnel is up.
> Here I even implemented the --route-pre-down script hook, to unmount the
> filesystem before the tunnel is taken down.  Here's the config extract:

This need root rights?

> This client has a web server behind it which is available on the public
> internet via the openvpn server which got the public IP address.  To make
> sure the incoming public traffic is returned via the VPN tunnel and not
> the default gateway on the openvpn client, simple ip rules like the ones
> below are used in the route-up.sh

>   /sbin/ip rule add from ${ifconfig_local} table 132
>   /sbin/ip route add default via 10.8.0.1 table 132

> And the route-down.sh takes care of deleting the rule.  This is to avoid
> errors and duplications if openvpn is restarted.  (And there are probably
> other ways to solve this as well, but this is one way)

Need root rights, too?

Maybe it's a good idea to have two type of scripts.
One that is controlled from the administrator and is executed with
admin/root privileges and the other that runs as the user.

> Plugins can be used on both server side and client side.  They can be
> used to extend the logging, or do other more advanced things which is
> easier and cleaner solved in a C program than using plenty of scripts.

In an enterprise setup I would think a plugin should be not modifable by the user (i.e. the
user should have no chance to load own modules).

greetings
Carsten


