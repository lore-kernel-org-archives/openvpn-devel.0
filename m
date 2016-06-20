Date: Mon, 20 Jun 2016 08:40:12 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160620064012.GQ79504@...1296...>
References: <20160619194538.GR2563@...2120...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WBsA/oQW3eTA3LlM"
Content-Disposition: inline
In-Reply-To: <20160619194538.GR2563@...2120...>
Subject: Re: [Openvpn-devel] Adding "protocol static" to Linux routes?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Samuel Thibault <samuel.thibault@...1817...>, openvpn-devel@lists.sourceforge.net

--WBsA/oQW3eTA3LlM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Jun 19, 2016 at 09:45:38PM +0200, Samuel Thibault wrote:
> Here we used two openvpn servers for resiliency, and we use the bird
> bgp daemon to make the two boxes exchange routes. Bird however does not
> pick up openvpn's routes because they are considered as "protocol boot"
> in Linux' "ip route" terms, i.e. they are assumed to be an automatic
> configuration, and not an administratively-configured route (see the
> protocol RTPROTO part of man ip-route for the details).
>=20
> So we need the attached change, which just adds "protocol static", to
> express that the routes created by openvpn are to override other
> dynamic routing.
>=20
> What do you think?

I'm wondering how you do the resiliency.  Traditionally, one would set up
the routes on client-connect/client-disconnect (or via --learn-address),
so it's under your control anyway - if you set up the routes from within
openvpn, both servers would announce all the routes all the time...

Besides, I'm a bit reluctant to change something like this, which might
break someone *else*'s setup, which relies on the route being what they
are today ("boot") - can't you teach bird to do "redistribute boot"?

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--WBsA/oQW3eTA3LlM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV2ePzKkuBuNlUUl1AQKKRQQAuaTaXMjLRPT7Isut5XtEubYNOVMzMYVq
ihfc6uW9zyPnQA56N26z7azHw9g8dcUXghVbaEXJjWCEBL9Pl9xE74I4+FPY37tu
5k6LVSHWdMdn7BY/tkrfG1ylNAWm9UF0wdlCEsvAbdhZTk28NWvjlky7qAVp7nGo
HQGZiL3mAPg=
=gJ2r
-----END PGP SIGNATURE-----

--WBsA/oQW3eTA3LlM--

