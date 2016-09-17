Date: Sat, 17 Sep 2016 15:59:48 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160917135948.GV78279@...1296...>
References: <1474119208-18687-1-git-send-email-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XVaA3GwKhF+BPVDd"
Content-Disposition: inline
In-Reply-To: <1474119208-18687-1-git-send-email-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Enable TCP non-linear packet ID
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

--XVaA3GwKhF+BPVDd
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Sep 17, 2016 at 03:33:28PM +0200, Arne Schwabe wrote:
> --- a/src/openvpn/forward.c
> +++ b/src/openvpn/forward.c
> @@ -391,7 +391,7 @@ check_fragment_dowork (struct context *c)
>    struct link_socket_info *lsi =3D get_link_socket_info (c);
>=20=20
>    /* OS MTU Hint? */
> -  if (lsi->mtu_changed && c->c2.ipv4_tun)
> +  if (lsi->mtu_changed)
>      {
>        frame_adjust_path_mtu (&c->c2.frame_fragment, c->c2.link_socket->m=
tu,
>  			     c->options.ce.proto);

I *think* this is part of the other patch...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--XVaA3GwKhF+BPVDd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBV91MU6kuBuNlUUl1AQJXTgQAhY6Fv3sCIlTjzYIjN5hdp7he7EMAFO0Z
9m1/T4mNOC7KbyudrBhnQmfV2OelxFPacNJZtQKzXD2t90E3d5/BVp9I5Kr1wnk1
fVPfugi7A8vcwDB5zdB9VOU6OWqE/Eu7emXHLuRX0IqMDF6h/RCesORFtLmuwE0t
ay/oD3xcnKY=
=gUq1
-----END PGP SIGNATURE-----

--XVaA3GwKhF+BPVDd--

