From: Torge Szczepanek <openvpn-devel@...239...>
Subject: Re: [Openvpn-devel] IP adress assignment to tun devices using server mode
References: <twig.1087235354.15668@...41...>
In-Reply-To: <twig.1087235354.15668@...41...>
MIME-Version: 1.0
Message-Id: <200406142132.40238@...240...>
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
Date: Mon Jun 14 12:32:13 2004
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net
Cc: openvpn-users@lists.sourceforge.net

On Monday 14 June 2004 19:49, you wrote:
> This is done for the benefit of OSes (such as Windows) which don't support
> true point-to-point tun interfaces.

Ok. You said enough. :-)

> any OS can transparently connect to an OpenVPN server which is also running
> on any OS, and the /30 subnet standardization was necessary to accomplish
> that.

I see.

> For one, you don't need to use --ifconfig-pool, you could use DHCP for
> example.  Or you could use --dev tap.

I'll try this out.

> This maximum can be trivially increased, though I don't think most users
> will be connecting 65536 clients to a single OpenVPN server instance :)

I asked since I put much work into getting pptp to work with more than 100 or 
255 authenticated users. But pptp is using a different model, where a ppp 
device is created for every logged in user. There you get quite some 
difficulties running with more than 100 users (or devices) and then later on 
with more than 255 users.

> Some people might claim that using /30 subnets wastes IPv4 addresses,
> though I don't think this argument holds much water because these addresses
> are mostly (but not always) taken from private address blocks such as
> 10.x.x.x where millions of free addresses are always available.

I am using PPTP (and maybe later on openvpn) for authentication of users in a 
lan for internet access. I assign official IPs to all these users. Therefore 
I really have to limit official IP usage to 1 adress per authenticated user. 
Otherwise RIPE would kill me. :-)

Thanks for your answer!

Torge

