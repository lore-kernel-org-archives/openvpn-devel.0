Message-ID: <00d001c37376$dae287c0$6e166d8c@...94...>
From: "Tom Bin" <openvpn@...93...>
References: <twig.1062740798.74062@...41...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Re: [Openvpn-users] New feature proposal:  --route option
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
Date: Thu Sep  4 23:29:09 2003
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

It's really a good idea.
I think the syntax is good enough...,
maybe you can take the metric(route cost) into consideration.

I would like to suggest the route is added once the vpn is up
and deleted when the vpn is down.

Moreover, is it possible to have multiple routes added ?



> I would like to implement a --route option that will be a proxy for the
route
> command, similar to the way that the --ifconfig option is a proxy for the
> ifconfig command.
>
> The goal would be to present a kind of least-common-denominator route
> functionality which is basic enough to be portable across OpenVPN's
platform
> space.
>
> I'm thinking of a syntax such as
>
>   --route network netmask gateway
>
> I'm looking for a syntax that will cover basic routing -- for more
advanced
> usage, one can always write a script.
>
> The overall goal is to simplify configuration by getting the common
operations
> out of --up scripts and into the OpenVPN config file where they will be
> portable and easier to support.
>
> Comments?
>
> James


