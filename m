From: Stefan Monnier <monnier@...1268...>
Message-ID: <jwvmy3gia3y.fsf-monnier+inbox@...1269...>
References: <jwvvdie3l5z.fsf-monnier+gmane.network.openvpn.devel@...1269...>
	<4AE35940.9060604@...41...>
Date: Sat, 24 Oct 2009 20:46:23 -0400
In-Reply-To: <4AE35940.9060604@...41...> (James Yonan's message of "Sat, 24
	Oct 2009 13:45:04 -0600")
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] FQDN for routes should expand to all IPs
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
To: James Yonan <jim@...41...>
Cc: openvpn-devel@lists.sourceforge.net

> This is the right place to submit bug reports.

Thanks.

> Having said that, your bug report seems more like a feature request since
> routing commands/APIs generally do not support DNS A-record expansion
> as a standard feature.

I understand that it's halfway between feature request and bugreport.
The current code does explicitly allow FQDN in route commands and its
implementation just happens to choose one (randomly) one IP rather than
to select all of them.  This basically means that such route commands
only work reliably for FQDNs that have only one IP.  This is
a restriction that iseems to come just from the implementation rather
than from a design choice: the FQDN-to-IP mapping is done by reusing the
code used elsewhere, but that "elsewhere" is when we want to connect to
that FQDN, so in that case selecting all IPs is nonsenscal and we need
to choose one (tho we may want to cycle in case of connection failure).

So I do think it's a bug, but I understand that it can be considered as
a feature to extend route commands to support multiple-IP FQDNs.

In either case, I'd love to hear comments about my patch (and even more
so to have it be included, since I rely heavily on this feature).

> It's an interesting idea though, and one that makes sense, but I haven't
> seen any other requests for it.

I use it for example to let clients connect to portal.acm.org (which has
2 IPs) via the VPN so as to benefit from the site-wide
digital-library access we have.  Without this feature, either the
redirection works unreliably (half the times, the connection is done
via the VPN the other half it's done directly), or I'd have to redirect
all traffic (causing a significant load increase on the VPN server,
increase of bandwidth use, and general slowdown for the clients), or
hard-code the IPs and try and detect when they change.


        Stefan

