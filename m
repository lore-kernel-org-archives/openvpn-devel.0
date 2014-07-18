Date: Fri, 18 Jul 2014 20:30:06 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140718183006.GZ1118@...1296...>
References: <1404735142-31420-1-git-send-email-arne@...1227...>
	<1404735142-31420-3-git-send-email-arne@...1227...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="beyCpKA84xV/nXfr"
Content-Disposition: inline
In-Reply-To: <1404735142-31420-3-git-send-email-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 3/4] Fix compiling without
	ENABLE_MANAGEMENT
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

--beyCpKA84xV/nXfr
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

while this patch looks reasonable, and I was just to ACK and merge it,
it confuses me just so slightly - if I look into my copy of push.c,=20
"git blame" tells me that these two lines in there already, and have=20
been so "since ever":

^6fbf66f push.c             (James Yonan      2005-09-26 05:28:27 +0000  71=
) #ifdef ENABLE_MANAGEMENT
^6fbf66f push.c             (James Yonan      2005-09-26 05:28:27 +0000  72=
)       if (management)
5733ef66 push.c             (James Yonan      2009-09-29 23:10:14 +0000  73=
)    {
...
8c7c6be4 push.c             (James Yonan      2010-03-12 03:05:34 +0000  78=
)      management_auth_failure (management, UP_TYPE_AUTH, reason);
3cf9dd88 push.c             (James Yonan      2010-10-24 09:12:47 +0000  79=
)    } else
^6fbf66f push.c             (James Yonan      2005-09-26 05:28:27 +0000  80=
) #endif

... could you double check your tree, please? ;-)

gert


On Mon, Jul 07, 2014 at 02:12:21PM +0200, Arne Schwabe wrote:
> ---
>  src/openvpn/push.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/src/openvpn/push.c b/src/openvpn/push.c
> index ea788b0..24d12c7 100644
> --- a/src/openvpn/push.c
> +++ b/src/openvpn/push.c
> @@ -68,6 +68,7 @@ receive_auth_failed (struct context *c, const struct bu=
ffer *buffer)
>  	  ASSERT (0);
>  	}
>        c->sig->signal_text =3D "auth-failure";
> +#ifdef ENABLE_MANAGEMENT
>        if (management)
>  	{
>  	  const char *reason =3D NULL;
> @@ -76,6 +77,7 @@ receive_auth_failed (struct context *c, const struct bu=
ffer *buffer)
>  	    reason =3D BSTR (&buf);
>  	  management_auth_failure (management, UP_TYPE_AUTH, reason);
>  	} else
> +#endif
>  	{
>  #ifdef ENABLE_CLIENT_CR
>  	  struct buffer buf =3D *buffer;
> --=20
> 1.8.5.2 (Apple Git-48)
>=20
>=20
> -------------------------------------------------------------------------=
-----
> Open source business process management suite built on Java and Eclipse
> Turn processes into business applications with Bonita BPM Community Editi=
on
> Quickly connect people, data, and systems into organized workflows
> Winner of BOSSIE, CODIE, OW2 and Gartner awards
> http://p.sf.net/sfu/Bonitasoft
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

--beyCpKA84xV/nXfr
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBU8lnrakuBuNlUUl1AQLReAP9G9XYCNQWrAxZRyfjTc2VkOeB0+tWy8Pi
QJNCd7HD6lAGBbh2H9+lfwUK+7Py9O7FkTJBqqymCGYvqkJBlmOPYEHVm59TM7CT
GQuWSRCZwfBFCZjMCI3N7YBiznDlxIEwmAD6UHGO2/9rbyCrFLS1DThXFr+2XSa2
PVWmcR/vo7A=
=Bdpg
-----END PGP SIGNATURE-----

--beyCpKA84xV/nXfr--

