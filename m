Date: Sun, 19 Jan 2020 15:53:27 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20200119145327.GF1431@...1296...>
References: <20200116141900.1524-1-simon@...2293...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="rPgHZmYkQ+bUEpVC"
Content-Disposition: inline
In-Reply-To: <20200116141900.1524-1-simon@...2293...>
Subject: Re: [Openvpn-devel] [PATCH] wintun: refactor code to use enum
 driver type
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Rozman <simon@...2293...>
Cc: openvpn-devel@lists.sourceforge.net

--rPgHZmYkQ+bUEpVC
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Jan 16, 2020 at 03:19:00PM +0100, Simon Rozman wrote:
>  {
> @@ -3676,14 +3692,16 @@ get_tap_reg(struct gc_arena *gc)
>=20=20
>                  if (status =3D=3D ERROR_SUCCESS && data_type =3D=3D REG_=
SZ)
>                  {
> -                    if (!strcmp(component_id, TAP_WIN_COMPONENT_ID) ||
> -                        !strcmp(component_id, "root\\" TAP_WIN_COMPONENT=
_ID) ||
> -                        !strcmp(component_id, WINTUN_COMPONENT_ID))
> +                    enum windows_driver_type windows_driver =3D WINDOWS_=
DRIVER_UNSPECIFIED;
> +
> +                    if ((windows_driver =3D WINDOWS_DRIVER_TAP_WINDOWS6,=
 !strcmp(component_id, TAP_WIN_COMPONENT_ID))
> +                        || (windows_driver =3D WINDOWS_DRIVER_TAP_WINDOW=
S6, !strcmp(component_id, "root\\" TAP_WIN_COMPONENT_ID))
> +                        || (windows_driver =3D WINDOWS_DRIVER_WINTUN, !s=
trcmp(component_id, WINTUN_COMPONENT_ID)))
>                      {

I could propably figure out what this if() statement with three intentional
assignments in it does, but I'm fairly sure I do not *want* to spend the
time, and I think nobody else should.

Lev has ACKed the patch, and it's WIN32 only - but I would very much
prefer are more readable variant of this.  Like

	if ( strcmp(component_id, TAP_WIN_COMPONENT_ID) =3D=3D 0 ||
	     strcmp(component_id, "root\\" TAP_WIN_COMPONENT_ID) )
	{
	    windows_driver =3D WINDOWS_DRIVER_TAP_WINDOWS6;
	}
	else if ( strcmp(component_id, WINTUN_COMPONENT_ID) =3D=3D 0 )
	{
	    windows_driver =3D WINDOWS_DRIVER_WINTUN:
	}

	if ( windows_driver !=3D WINDOWS_DRIVER_UNSPECIFIED )
	{
	    ... pre-existing code in the if() clause


not many more lines, but way easier to read than on-the-fly assignments
in if(), and also easier to read than the old code.


Pretty please :)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--rPgHZmYkQ+bUEpVC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJeJG1nAAoJEB2Cnv7KVigSNEoL/3nNwLxUVoXtUWuKTgTIkzcO
Dn+JlQoKKvGK0wZecevO3LTKu51jsYluvVs/sZ3W2wUxXf7eUzgk+uZnKm584Ae7
Zti/PmgAHmEjUOs/mhAVRn6pBXzFFPjeZ2J0hDupOALOm6O9Bpk1LRcJsoIt8Zjj
W28RbG8YYYYKX0WClR6XExfhSOtdMfLLtMT5HWaTfwXhRNx6VnEWYkGlYA0z4eIO
dycBwxrkOK70rseWNk7R87W/DOTeABVJi7qq3LPrJYfYGKDplGUDRkgTT6/LR5rU
XSGTMKDAie5tUbz6YUsQhyGAfKzZkmxf5vvtq+pmqha33zPFfPeFpklCgCZQA0GL
R+owwDi8qrMsU+MoLi1JnjDZ39j/vDEFQWmitNV6ashWZ1v9MlbUi2sC9S8mSbVr
KD8XD67FCMglJpw3z5e7troo5inlKIusO2LmqpDsDYt9ayWNfKsfS8sYoQQuDL8e
HxOWBnVIqCjayfzK7T/OpoItV19+spr9LAFLns6aMg==
=eVYX
-----END PGP SIGNATURE-----

--rPgHZmYkQ+bUEpVC--

