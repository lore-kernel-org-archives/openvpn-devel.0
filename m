Date: Sat, 14 Nov 2015 20:23:39 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20151114192338.GZ24952@...1296...>
References: <1444553332-16205-1-git-send-email-dejong@...1435...>
	<1444557137-19267-1-git-send-email-dejong@...1435...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7cXxibKNEnJOqEg4"
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

--7cXxibKNEnJOqEg4
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Oct 11, 2015 at 11:52:17AM +0200, Adriaan de Jong wrote:
> This patch allows inlining of the --auth-user-pass directive, so it is now
> possible to do

Streams have somewhat crossed here, and I'm not sure if this patch=20
is conflict-free with commit

commit 6e9373c84639382c16d9eb8f1f78f60079bb89df
Author: Michal Ludvig <mludvig@...1388...>
Date:   Sun Oct 11 10:44:20 2015 +0200

    Support for username-only auth file.


"it *should*", but at least one change is causing a conflict:

> --- a/src/openvpn/misc.c
> +++ b/src/openvpn/misc.c
> @@ -1003,7 +1003,7 @@ get_user_pass_cr (struct user_pass *up,
>=20=20
>    if (!up->defined)
>      {
> -      const bool from_stdin =3D (!auth_file || !strcmp (auth_file, "stdi=
n"));
> +      const bool from_stdin =3D (!auth_file || streq (auth_file, "stdin"=
));
>=20=20
>        if (flags & GET_USER_PASS_PREVIOUS_CREDS_FAILED)
>  	msg (M_WARN, "Note: previous '%s' credentials failed", prefix);

This one does no longer apply, as this line is no longer there - OTOH,
it's basically just cleanup and no functional change, so the hunk could
be left off.


Since you've reviewed this already - could you give it a quick check=20
whether it still does the right thing with the misc.c hunk left off?
"I think it does", but would welcome a second opinion.

(No need to re-send the patch, I can just take out this part)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--7cXxibKNEnJOqEg4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVkeJ86kuBuNlUUl1AQKs+gP+KhYcX5+3/3/GpevhAPcMo8E92GLiYALW
hvE6h0Op1fyFA4d/zU2nLmNt+pCuh1MXBlo7Palzvbi/mGGKQxNnolGK+cwNxNMf
A4GDxE6YdNOP0YRGvb+ffI1Y+rVQq2+t8UDH7bFAVlWnxqpy/Te7pzDHVvaIwaZR
s+K4tAt0JF4=
=38d6
-----END PGP SIGNATURE-----

--7cXxibKNEnJOqEg4--

