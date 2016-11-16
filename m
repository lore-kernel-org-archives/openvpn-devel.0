Date: Wed, 16 Nov 2016 17:26:21 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161116162621.GH28918@...1296...>
References: <1478870201-17943-1-git-send-email-davids@...515...>
	<1479165185-11730-1-git-send-email-davids@...515...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nR4f+zr2kNneuKs8"
Content-Disposition: inline
In-Reply-To: <1479165185-11730-1-git-send-email-davids@...515...>
Subject: Re: [Openvpn-devel] [PATCH v2] tun: Fix compiler warnings
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net

--nR4f+zr2kNneuKs8
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Nov 15, 2016 at 12:13:05AM +0100, David Sommerseth wrote:
> Fixes two compiler warnings idetified by using CFLAGS=3D-O2

Spelling...

> 1) ifconfig_ipv6_remote is only used on Solaris, move the
>    declaration and assignment of this variable into the
>    TARGET_SOLARIS block.
>=20
> 2) Linux have it's own open_tun() function and does not
>    depend on open_tun_generic() at all.  So do not exclude
>    open_tun_generic() if TARGET_LINUX is defined.

Should that be an "So do not include... " or "So exclude..."?

> @@ -915,7 +913,6 @@ do_ifconfig (struct tuntap *tt,
>        management_android_control (management, "IFCONFIG", buf_bptr(&out)=
);
>=20=20
>  #elif defined(TARGET_SOLARIS)
> -

Whitespace change - intentional?

> @@ -977,6 +974,9 @@ do_ifconfig (struct tuntap *tt,
>=20=20
>  	  if ( tt->type =3D=3D DEV_TYPE_TUN )
>  	   {
> +	      const char *ifconfig_ipv6_remote =3D NULL;
> +
> +	      ifconfig_ipv6_remote =3D print_in6_addr (tt->remote_ipv6, 0, &gc);

Why have an extra initialization with NULL here, if all you want is
"assing print_in6_addr"?  Single line should be good (unless too long).

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--nR4f+zr2kNneuKs8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBWCyIrakuBuNlUUl1AQKmQAQAndPPsGcW2UsDPNLjpo/1MbI9LYj1lO/w
Ece287pCGPJEZZ49QNv5ybcpK1Tbd0wpsdeoYvAV7bzh/rkxGSaDaSTOrvn1VBA3
+qixWF9AxDVcZ27tgsUBs9CTpvKhPLZnxMZLwFZEHFoZbRjV+ZNy6RM45ljU3DAC
HiFpJdujIVo=
=wGkv
-----END PGP SIGNATURE-----

--nR4f+zr2kNneuKs8--

