MIME-Version: 1.0
In-Reply-To: <20130824083502.GZ16543@...1296...>
References: <CANfRfr0zuKi5mf0vAFXPvnRtrsyyFx3EtpGpbzNJsCLBnqZxLA@...278...>
	<kv65m0$qbs$1@...1062...>
	<CANfRfr02EyQbPJ52pq4-B02hrKdAShn_cbWOE1NYKbosYrd7Qw@...278...>
	<20130824083502.GZ16543@...1296...>
Date: Mon, 26 Aug 2013 08:49:57 -0400
Message-ID: <CANfRfr3XdncNZO=8nyg6avFJge9JujvkOOEVQLOj3x1dvYd=yA@...278...>
From: Jesse Glick <jglick@...1836...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] When using UDP over SOCKS5,
 send the actual remote hostname (FQDN) to the proxy server in the
 first packet.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

On Sat, Aug 24, 2013 at 4:35 AM, Gert Doering <gert@...1296...> wrote:
> I do not really see people sharing multiple OpenVPN services behind
> one single "reverse proxy"

That was my intent but obviously there will not be such a service if
the client cannot support it.

> with OpenVPN
> you usually specify the port anyway, it's just part of the .ovpn you
> ship to your clients.

Of course; the point is that a service provider would rather not
allocate a dedicated port or IP for every account when there are
potentially thousands of them. You want a permanent *.ovpn that
identifies that account by name.

Oh well, I guess I give up on this possibility and will look for other
workarounds. Thanks for review.

