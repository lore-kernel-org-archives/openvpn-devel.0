Date: Sun, 13 Apr 2014 13:52:57 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140413115257.GO16637@...1296...>
References: <1397389435-20170-1-git-send-email-gert@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SX99NFWHfbJ3fJTR"
Content-Disposition: inline
In-Reply-To: <1397389435-20170-1-git-send-email-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Fix SOCKSv5 method selection
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net
Cc: Yawning Angel <yawning@...1897...>

--SX99NFWHfbJ3fJTR
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

this came in as github pull req #14, and fixes the socks problem that
people are complaining about in about every list, except here and in
trac...  - there *is* also trac#377.

The patch "as is" breaks windows compilation as...

> +  if (p->authfile[0])
> +      method_sel[2] =3D 0x02; /* METHODS =3D [2 (plain login)] */
> +  const ssize_t size =3D send (sd, method_sel, sizeof (method_sel), MSG_=
NOSIGNAL);

... doing the variable declaration of "size" after some other code has
been executed is not permitted by MSVC.  I'll amend that when committing.

To me, the patch is good, even though it might break user-visible behaviour
(users specifying proxy auth credentials to a proxy that is not using
them, this will now result in an error) - the reasoning behind it is valid.

More opinions are welcome, though...?

gert



On Sun, Apr 13, 2014 at 01:43:55PM +0200, Gert Doering wrote:
> From: Yawning Angel <yawning@...1897...>
>=20
> So, RFC 1928 doesn't say anything about the METHODS field in the Method
> Selection message being ordered in terms of preference or anything, and
> the server is free to pick any of the METHODS offered by the client.
>=20
> Always sending a Method Selection message with NO AUTHENTICATION REQUIRED
> and USERNAME/PASSWORD set is broken on two fronts:
>=20
>  * If the OpenVPN client can't handle the server picking USERNAME/PASSWORD
>    due to the credentials being missing, it shouldn't offer it to the ser=
ver.
>=20
>  * If the OpenVPN client has credentials, then it should always attempt to
>    authenticate.  This is a security product.  "You can misconfigure it a=
nd
>    it will work" is not acceptable.  Setting a username/password when the
>    SOCKS server doesn't require/support that as an option is the user not
>    configuring it correctly, and should be treated as such.
>=20
> Also verify that the SOCKS server returned the auth that was requested.
> ---
>  src/openvpn/socks.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>=20
> diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c
> index 1551da8..5cd27ac 100644
> --- a/src/openvpn/socks.c
> +++ b/src/openvpn/socks.c
> @@ -190,9 +190,12 @@ socks_handshake (struct socks_proxy_info *p,
>    int len =3D 0;
>    const int timeout_sec =3D 5;
>=20=20
> -  /* VER =3D 5, NMETHODS =3D 2, METHODS =3D [0 (no auth), 2 (plain login=
)] */
> -  const ssize_t size =3D send (sd, "\x05\x02\x00\x02", 4, MSG_NOSIGNAL);
> -  if (size !=3D 4)
> +  /* VER =3D 5, NMETHODS =3D 1, METHODS =3D [0 (no auth)] */
> +  char method_sel[3] =3D { 0x05, 0x01, 0x00 };
> +  if (p->authfile[0])
> +      method_sel[2] =3D 0x02; /* METHODS =3D [2 (plain login)] */
> +  const ssize_t size =3D send (sd, method_sel, sizeof (method_sel), MSG_=
NOSIGNAL);
> +  if (size !=3D sizeof (method_sel))
>      {
>        msg (D_LINK_ERRORS | M_ERRNO, "socks_handshake: TCP port write fai=
led on send()");
>        return false;
> @@ -252,6 +255,13 @@ socks_handshake (struct socks_proxy_info *p,
>        return false;
>      }
>=20=20
> +  /* validate that the auth method returned is the one sent */
> +  if (buf[1] !=3D method_sel[2])
> +    {
> +      msg (D_LINK_ERRORS, "socks_handshake: Socks proxy returned unexpec=
ted auth");
> +      return false;
> +    }
> +
>    /* select the appropriate authentication method */
>    switch (buf[1])
>      {
> --=20
> 1.8.3.2
>=20
>=20
> -------------------------------------------------------------------------=
-----
> Put Bad Developers to Shame
> Dominate Development with Jenkins Continuous Integration
> Continuously Automate Build, Test & Deployment=20
> Start a new project now. Try Jenkins in the cloud.
> http://p.sf.net/sfu/13600_Cloudbees
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--SX99NFWHfbJ3fJTR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBU0p6makuBuNlUUl1AQJAogQAkoQofIMUkDedT0XKH167fV0P+yuBbMZY
KmjcBVuIWVPUmHjmjAnp39iG4p6FvdoIkIuhwa0v5wFfJhsnHRauftI2mJckFXwp
0DU8DI0zy0p8L7LJEXE8hgQG2bWMjx3wfOwGSbbdmza8DZvw/6qPJLKmOsCEKjeT
4pjgenetc3w=
=QOou
-----END PGP SIGNATURE-----

--SX99NFWHfbJ3fJTR--

