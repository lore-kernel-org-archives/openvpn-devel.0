Subject: Re: [Openvpn-devel] IP adress assignment to tun devices using server mode
From: "James Yonan" <jim@...41...>
Message-ID: <twig.1087235354.15668@...41...>
In-Reply-To: <200406102012.41488.openvpn-devel@...239...>
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
Date: Mon Jun 14 10:50:06 2004
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Torge Szczepanek <openvpn-devel@...239...>, openvpn-devel@lists.sourceforge.net
Cc: openvpn-users@lists.sourceforge.net

Torge Szczepanek <openvpn-devel@...239...> said:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hi!
> 
> I am currently trying out OpenVPN 2.0 beta 4 using server mode.
> 
> My config on the server looks like this:
> 
> dev tun
> mode server
> ifconfig 192.168.100.1 192.168.100.2
> ifconfig-pool 192.168.100.4 192.168.100.254
> push "route 192.168.100.1 255.255.255.255"
> route 192.168.100.0 255.255.255.0
> [...]
> 
> Everything works fine as expected. (Which is really great. I appreciate the 
> good work done here)
> 
> I am wondering why there is a subnet of size /30 assigned to the client. I 
> would expect a Point-to-Point device to receive only one ip adress and not 
> a /30 subnet.

This is done for the benefit of OSes (such as Windows) which don't support
true point-to-point tun interfaces.

The Windows TAP-Win32 driver supports tun interface emulation only.  What that
means is that the driver can talk to tun interfaces on other OSes, but from
the perspective of Windows, it sees the tun interface as a virtual ethernet
interface having a subnet mask of 255.255.255.254, containing the two
point-to-point interfaces, a network address, and a broadcast address.

One of the goals of --mode server in OpenVPN 2.0 is that clients running any
OS can transparently connect to an OpenVPN server which is also running on any
OS, and the /30 subnet standardization was necessary to accomplish that.

> tun0      Protokoll:Punkt-zu-Punkt Verbindung
>           inet Adresse:192.168.100.6  P-z-P:192.168.100.5  
> Maske:255.255.255.255
>
> The netmask is also not which one would expect for a /30 network.

The server side tun netmask will be 255.255.255.255 except on Windows where it
will be 255.255.255.252

> I have some servers running with lots of ppp devices. I am assigning also 
> adresses out of a pool. The two addresses do not lie within the same subnet.
> 
> ppp138    Link encap:Point-to-Point Protocol
>           inet addr:192.168.1.31  P-t-P:10.3.14.223  Mask:255.255.255.255
> 
> Is there any good reason for this /30 assignment?

> Is there a config option to change this behaviour (I didn't find one)?

For one, you don't need to use --ifconfig-pool, you could use DHCP for
example.  Or you could use --dev tap.

You could also change the code by passing IFCONFIG_POOL_INDIV instead of
IFCONFIG_POOL_30NET to ifconfig_pool_init in multi.c -- but at that point
you'll be on your own.  Windows compatibility will certainly break as well as
possibly other things.

> How many IPs can be assigned within a pool? 
> 
> I found:
> 
> #define IFCONFIG_POOL_MAX 65536
> 
> in pool.h
> 
> Has anyone tested this beyond a class-C network?

This maximum can be trivially increased, though I don't think most users will
be connecting 65536 clients to a single OpenVPN server instance :)

Some people might claim that using /30 subnets wastes IPv4 addresses, though I
don't think this argument holds much water because these addresses are mostly
(but not always) taken from private address blocks such as 10.x.x.x where
millions of free addresses are always available.

James


