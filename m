From: "dave" <dev@...575...>
Date: Sat, 6 Jun 2009 06:58:53 -0500
Message-ID: <9006FFE98A674C4AB8A17E174E615119@...576...>
MIME-Version: 1.0
In-Reply-To: <4A2A50AE.30805@...1164...>
Subject: Re: [Openvpn-devel] How to route without splitting the network into
	a/30?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Emrah KAVUN' <eka@...1164...>
Cc: openvpn-devel@lists.sourceforge.net

> -----Original Message-----
> From: Emrah KAVUN [mailto:eka@...1164...] 
...
> I would like to route with OpenVPN with public IPs. My setup 
> works fine
> now, however every client get a dedicated /30 network segment 
> instead of
> the /28 allowed. This of course means that I waste too many 
> IPs as every
> client get its own gateway, and so on.
> I don't want to use Tap for this.
...

The option:
  topology subnet

I think is what you are wanting.  Check out the man page for details,
but the short story is that you get one IP per client, one for the
server, within the subnet defined in the 'server' directive.

-dave


