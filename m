Date: Sat, 16 Jul 2016 22:22:07 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160716202207.GT78279@...1296...>
References: <20160716181726.GQ78279@...1296...>
	<1468696381.29435.18578.36594@...2154...>
MIME-Version: 1.0
In-Reply-To: <1468696381.29435.18578.36594@...2154...>
Subject: Re: [Openvpn-devel] net6_gateway feature request
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: streampp <streampp@...2153...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On Sat, Jul 16, 2016 at 10:13:01PM +0300, streampp wrote:
> Hello Gert, thanks for quick answer.
> 
> > On Sat, Jul 16, 2016 at 08:45:03PM +0300, streampp wrote:
> > > I'm connecting to my remote OpenVPN server via IPv4. On openvpn-server.conf I have something like:
> > > 
> > > push "route 10.0.0.0 255.0.0.0 net_gateway"
> > > push "route 172.16.0.0 255.240.0.0 net_gateway"
> > > push "route 192.168.0.0 255.255.0.0 net_gateway"
> > > 
> > > with works perfect and my IPv4 gateway replaces "net_gateway" parameter, so with IPv4 everything is fine.
> > 
> > "why"?
> 
> Didn't understand the question. :(

Why are you doing this?

Just because OpenVPN *can* do this for IPv4 doesn't mean it's a sensible
thing to do - and in all my use cases I've never needed to do this, so
it's not implemented for IPv6.

[..]
> Ok, here we go.
> Private network is just an example. Real case is: I have two openvpn's. One for work and one my personal. My personal OpenVPN to hosters VPS always ON, so all my internet traffic i encrypted.
> But when I enable OpenVPN from my work, it becomes OpenVPN over OpenVPN (work vpn over my personal one). I just want to avoid OpenVPN over OpenVPN :)

OK, that makes more sense - in both OpenVPN configs, you want to ensure
that the *other* VPN server is routed via net_gateway(6).  Indeed, 
convincing :-)

Unfortunately, not totally easy to do.  While git master openvpn actually
knows how to find the current default gateway (more precisely: the gateway
used to reach the current VPN server's address, which might not be the
default gateway if there is a more specific route in place) the whole
IPv6 routing logic doesn't deal with symbolic names yet.  Lots of pieces
to extend (and test)...

gert
-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

