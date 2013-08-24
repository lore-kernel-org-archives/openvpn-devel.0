Date: Sat, 24 Aug 2013 10:35:02 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20130824083502.GZ16543@...1296...>
References: <CANfRfr0zuKi5mf0vAFXPvnRtrsyyFx3EtpGpbzNJsCLBnqZxLA@...278...>
	<kv65m0$qbs$1@...1062...>
	<CANfRfr02EyQbPJ52pq4-B02hrKdAShn_cbWOE1NYKbosYrd7Qw@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PE0DJtTPNVbxyIcY"
Content-Disposition: inline
In-Reply-To: <CANfRfr02EyQbPJ52pq4-B02hrKdAShn_cbWOE1NYKbosYrd7Qw@...278...>
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
To: Jesse Glick <jglick@...1836...>
Cc: openvpn-devel@lists.sourceforge.net

--PE0DJtTPNVbxyIcY
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Aug 22, 2013 at 07:49:42PM -0400, Jesse Glick wrote:
> On Thu, Aug 22, 2013 at 7:08 PM, Josh Cepek <josh.cepek@...1085...> wrote:
> >> akin to how HTTP reverse proxies commonly delegate to a physical server
> >> according to the HTTP 1.1 Host header???so that many hostnames can map
> >> to the same IP of the reverse proxy.
> >
> > There was some issue figuring out what this all means. Do you have an
> > example use-case where this is helpful?
>=20
> To expand on my explanation as quoted above:

Thanks for the explanation.

I'm not convinced it makes sense to merge this right now.

Why?  HTTP/1.1 with Host: headers is extremely widespread, because there
are zillions of "lightweight" web servers that can easily share one
physical machine + IP address, because they hardly cause any load etc.

OTOH, I do not really see people sharing multiple OpenVPN services behind
one single "reverse proxy" - and if you really need that (multiple OpenVPN
services on a single IP address), you could run multiple OpenVPN services=20
on different UDP ports already today (either on the same box, or using=20
some sort of UDP forwarder).

With web browsers, using different ports is a pain.  OTOH, with OpenVPN
you usually specify the port anyway, it's just part of the .ovpn you
ship to your clients.


As you say yourself that there is no such service currently, as the server
side proxy has not been written yet, balancing "cool feature" vs. "amount
of special cases in the code we have to maintain" makes me tend to "let's
postpone this until some real-world experience shows it's really useful".

(OTOH, a patch that is based on Arne's dual-stack work and ensures that
SOCKS5 works nicely over IPv4 and IPv6, talking to IPv4 or IPv6 servers
via the proxy, that would be more immediately relevant...  and with IPv6,
you can run your OpenVPN server farm with "one IP address per OpenVPN
service" again, so this whole discussion becomes moot anyway :-) )

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--PE0DJtTPNVbxyIcY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUhhwNqkuBuNlUUl1AQL3BQP8CRs2S2hNrcOupTjnNvyxR+wz09eWFu4U
vPoP8fSnmrP1QAKr1TqmN3FjSaGPoWrbVjCUG71fdLVpZVXA6FZljdM/6WPeUwg7
Inp297zKYe79lwKYK9mdNS4ajZByKTlrpyBbCzFiuXkS+OhcosfEMfVApYwDKxMN
z7Csy/ckTPU=
=gsUB
-----END PGP SIGNATURE-----

--PE0DJtTPNVbxyIcY--

