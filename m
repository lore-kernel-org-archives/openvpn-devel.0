Date: Tue, 19 Jun 2012 13:02:02 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120619110202.GW1059@...1296...>
References: <1340044749-10694-1-git-send-email-arne@...1227...>
	<1340044749-10694-3-git-send-email-arne@...1227...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p8BcnzLwh3ipgLRM"
Content-Disposition: inline
In-Reply-To: <1340044749-10694-3-git-send-email-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 2/6] Completely remove ancient IANA port
	warning.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--p8BcnzLwh3ipgLRM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jun 18, 2012 at 08:39:05PM +0200, Arne Schwabe wrote:
> @@ -2462,12 +2462,6 @@ do_option_warnings (struct context *c)
>  {
>    const struct options *o =3D &c->options;
>=20=20
> -#if 1 /* JYFIXME -- port warning */
> -  if (!o->ce.port_option_used && (o->ce.local_port =3D=3D OPENVPN_PORT &=
& o->ce.remote_port =3D=3D OPENVPN_PORT))
> -    msg (M_WARN, "IMPORTANT: OpenVPN's default port number is now %d, ba=
sed on an official port number assignment by IANA.  OpenVPN 2.0-beta16 and =
earlier used 5000 as the default port.",
> -	 OPENVPN_PORT);
> -#endif
> -

ACK.  As discussed previously.  This is a "legacy warning", and whoever=20
needs to see the warning should have upgraded from OpenVPN 1.x loooong ago.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--p8BcnzLwh3ipgLRM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBT+BcKqkuBuNlUUl1AQI/awP+MtvfIVWxjw2hYyygJbUGyWrPJFC9dJ16
T1hZcChIIqPTm/JppqLjVS2CBqAcQO2PTqTsI0nquzSm3+bUMfjRATePLTo3ztRs
NvrDcTIUNuRfO8Mb4spjGQYhbLFJZvlD8TjUb00h+fcz4lPNoeyc9eqvgFGDWY8L
4t5kv8/XGco=
=egSd
-----END PGP SIGNATURE-----

--p8BcnzLwh3ipgLRM--

