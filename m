Date: Wed, 18 May 2011 17:11:37 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20110518151136.GD8496@...1296...>
References: <1305729501-500-1-git-send-email-xavier@...1461...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EeeDLpRJNGbogvEL"
Content-Disposition: inline
In-Reply-To: <1305729501-500-1-git-send-email-xavier@...1461...>
Subject: Re: [Openvpn-devel] +++ route.c	2011-05-18 09:15:17.000000000 +0200
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Xavier Franquet <xavier@...1461...>
Cc: openvpn-devel@lists.sourceforge.net

--EeeDLpRJNGbogvEL
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, May 18, 2011 at 04:38:21PM +0200, Xavier Franquet wrote:
>    if (!r->defined)
>      return;
> @@ -1113,23 +1114,26 @@ add_route (struct route *r, const struct tuntap *=
tt, unsigned int flags, const s
>=20=20
>  #if defined(TARGET_LINUX)
>  #ifdef CONFIG_FEATURE_IPROUTE
> -  argv_printf (&argv, "%s route add %s/%d via %s",
> +  argv_printf (&argv, "%s route add %s/%d via %s dev %s",

A few words on why exactly this patch is needed, and what problems it
solves would be appreciated...

As it stands, I'd NAK it, because "the existing code works for me", and=20
your code just makes it more complicated.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--EeeDLpRJNGbogvEL
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTdPhqKkuBuNlUUl1AQLteAQAha1xvfNjbPz7rRl2+yOaPsPYoVaEARAx
MM3p989JOe6nqd3SCjlEhPZOysjofuEYwQq+nkK8NYA9KYDHhc8NftMJ4nxAaOnq
uvQ8AXxGuLJwt7/TrMBM58vYzzoajcFRrA5n+B8MGIMfkQHzyAmRcHcgfiBIiGGI
0WhwZviZsD4=
=GZM0
-----END PGP SIGNATURE-----

--EeeDLpRJNGbogvEL--

