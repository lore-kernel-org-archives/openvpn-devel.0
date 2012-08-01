Date: Wed, 1 Aug 2012 22:38:32 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120801203832.GK2535@...1296...>
References: <1343837470-3923-1-git-send-email-arne@...1227...>
	<1343837470-3923-4-git-send-email-arne@...1227...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GUPx2O/K0ibUojHx"
Content-Disposition: inline
In-Reply-To: <1343837470-3923-4-git-send-email-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 3/4] Merge almost identical
	create_socket_tcp and create_socket_tcp6
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

--GUPx2O/K0ibUojHx
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Aug 01, 2012 at 06:11:09PM +0200, Arne Schwabe wrote:
> @@ -1099,15 +1068,7 @@ socket_connect (socket_descriptor_t *sd,
>        if (*signal_received)
>  	goto done;
>=20=20
> -      switch(local->addr.sa.sa_family)
> -	{
> -	case PF_INET6:
> -	  *sd =3D create_socket_tcp6 ();
> -	  break;
> -	case PF_INET:
> -	  *sd =3D create_socket_tcp ();
> -	  break;
> -	}
> +	create_socket_tcp(local->addr.sa.sa_family);

I might be overlooking something, but shouldn't that be

+	*sd =3D create_socket_tcp(local->addr.sa.sa_family);

?

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--GUPx2O/K0ibUojHx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBUBmTyKkuBuNlUUl1AQLcZwQAkT71KrJNC3AxKCDTgo5B9/Nq1yGdBsfL
u2YD5sy4f2K3hNLV4dU+12erRpqvPr2CV7rwT4XEVDzj1QGB0MfYiOIQ21WvuCRX
eyckzOv7jjlXJAawI/yDUMQGlWYpUMLq3DhrvJMg3vw+fTG1YtUVM8YyEj8T1KdO
x6rSrl1ZVMM=
=pQmK
-----END PGP SIGNATURE-----

--GUPx2O/K0ibUojHx--

