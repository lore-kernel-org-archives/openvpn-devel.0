Date: Mon, 20 Jun 2016 09:29:36 +0200
From: Samuel Thibault <samuel.thibault@...1817...>
Message-ID: <20160620072936.GR22598@...2120...>
References: <20160619194538.GR2563@...2120...>
	<20160620064012.GQ79504@...1296...>
MIME-Version: 1.0
In-Reply-To: <20160620064012.GQ79504@...1296...>
Subject: Re: [Openvpn-devel] Adding "protocol static" to Linux routes?
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Hello,

Gert Doering, on Mon 20 Jun 2016 08:40:12 +0200, wrote:
> I'm wondering how you do the resiliency.  Traditionally, one would set up
> the routes on client-connect/client-disconnect (or via --learn-address),
> so it's under your control anyway

Ah, right, yes, we do that, and we announce those routes via bgp.

So what remains is the "converse": the routes set by openvpn with the
"route" configuration element. When a client manages to connect to the
server and thus get access to the network, it is useful to add the
routes with "protocol static" so that the access to the network is
announced through bgp to the network behind the client. Of course we
could drop the "route" configuration element, and add the route ourself
in a route-up script, but that's less clean.

> Besides, I'm a bit reluctant to change something like this, which might
> break someone *else*'s setup, which relies on the route being what they
> are today ("boot") - can't you teach bird to do "redistribute boot"?

You mean patching bird?  AIUI that would be counter-productive: the
boot/static separation was explicitly made to separate between routes
which shouldn't be announced and routes which should be announced...

Setting static could also be made an option, e.g.

--route network/IP [netmask] [gateway] [metric] [announce]

and putting "announce" would make openvpn set "protocol static" in the
route command.

Samuel

