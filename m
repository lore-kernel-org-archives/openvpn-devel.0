Date: Mon, 20 Jun 2016 20:40:17 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160620184017.GU79504@...1296...>
References: <1444553332-16205-1-git-send-email-dejong@...1435...>
	<1444557137-19267-1-git-send-email-dejong@...1435...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="65ImJOski3p8EhYV"
Content-Disposition: inline
In-Reply-To: <1444557137-19267-1-git-send-email-dejong@...1435...>
Subject: Re: [Openvpn-devel] [PATCH v2] Allow inlining of --auth-user-pass
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Adriaan de Jong <dejong@...1435...>
Cc: openvpn-devel@...350...

--65ImJOski3p8EhYV
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Oct 11, 2015 at 11:52:17AM +0200, Adriaan de Jong wrote:
> This patch allows inlining of the --auth-user-pass directive, so it is now
> possible to do
>=20
> <auth-user-pass>
> myusername
> mypassword
> </auth-user-pass>
[..]

I still think that this is a useful patch, but it might need a=20
rewrite, given that get_user_pass_cr() learned inline file handling
in James' change

commit c9a35a20812aafdacc3682a0379f52126bd567ae
Author: James Yonan <james@...515...>
Date:   Thu Mar 3 01:19:05 2016 -0700

    Added directive to specify HTTP proxy credentials in config.
=20=20=20=20
    The inline directive http-proxy-user-pass can be used to
    specify proxy credentials in config, e.g.:

(which adds INLINE_TAG handling to the general user/pass auth mechanism)

> +  if (options->auth_user_pass_file_inline)
> +    {
> +      int n_inlined =3D 0;
> +      const char *pos =3D options->auth_user_pass_file_inline;
> +      const char *prev =3D pos;
> +
> +      if ( strlen(pos) =3D=3D 0 )
> +        msg (M_USAGE, "Invalid format for inlined --auth-user-pass");
> +
> +      while( (pos =3D strchr(pos, '\n')) !=3D NULL )
> +        {
> +          n_inlined++;
> +
> +          if (n_inlined > 2)
> +            msg (M_USAGE, "Too many lines in inlined --auth-user-pass");

... so this explicit handling is no longer needed, and should go to
the general function (if possible).

It also looks like a lot of code, compared to James' patch which does
mostly the same thing for http-proxy-user-pass user/password...  (but=20
maybe this is just because the generic auth-user-pass stuff is called
from many more places).

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--65ImJOski3p8EhYV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV2g4kKkuBuNlUUl1AQKebgP+NO6rfV25ZJny2QQTOUaZmDltuUcbgT5w
qgccFUtm58WlTgNK8JEgxLBAcdePRR9Et20R/93OZxcc0I1Bf7ZE3AsHqgDz2Gmt
jgKCvDKpZ7GT9x5OvjuGPON+sWJR2dlW5BQmkRGE3xlBKolYeybuoYaFtSl1r8f7
QYuNp2K2AJY=
=nob9
-----END PGP SIGNATURE-----

--65ImJOski3p8EhYV--

