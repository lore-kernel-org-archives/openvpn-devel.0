Date: Mon, 16 Mar 2020 09:04:50 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20200316080450.GA50857@...1296...>
References: <20200314052906.28095-1-lstipakov@...277...>
 <202003152116.02FLGSo4037377@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
In-Reply-To: <202003152116.02FLGSo4037377@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Fix building with
 --enable-async-push in FreeBSD
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--wac7ysb48OaltWcw
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

and yet another mail for this patch - Lev asked for this to be merged
to release/2.4 as well, which I've done.  Context is unchanged, so
it merges nicely.  Tested on FreeBSD 11.3, works.

commit 8484f37a62ce4f1b8efe7644c6ddb28819c4f8ae (HEAD -> release/2.4)

gert

On Sun, Mar 15, 2020 at 10:16:28PM +0100, Gert Doering wrote:
> Acked-by: Gert Doering <gert@...1296...>
>=20
> Your patch has been applied to the master branch.=20=20
>=20
> Tested on FreeBSD 11.3 with libinotify installed and 12.0 without (fails
> if called with "--enable-async-patch", works nicely otherwise).  From
> "staring at patch" I assume no changes for other platforms, so I did not
> test there.
>=20
> Re-sending with a new commit ID - I noticed, after sending out the mail,
> that the "Trac: ###" got lost from v4.  So I re-added, and this is the
> right commit ID now.
>=20
> commit e1eb630df1b3ef5df88afd51003fbec40e5d6d67
> Author: Lev Stipakov
> Date:   Sat Mar 14 07:29:06 2020 +0200
>=20
>      Fix building with --enable-async-push in FreeBSD
>=20
>      Signed-off-by: Lev Stipakov <lstipakov@...277...>
>      Acked-by: Gert Doering <gert@...1296...>
>      Message-Id: <20200314052906.28095-1-lstipakov@...277...>
>      URL: https://www.mail-archive.com/search?l=3Dmid&q=3D20200314052906.=
28095-1-lstipakov@...277...
>      Signed-off-by: Gert Doering <gert@...1296...>
>=20
>=20
> --
> kind regards,
>=20
> Gert Doering
>=20
>=20
>=20
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--wac7ysb48OaltWcw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJebzMhAAoJEB2Cnv7KVigSDQQL/3CjCcSq0Q4i8AnOYbODeHCt
L+Ow/Ntk47bENJqOt2uNkn/jutsNqB9bE3m+LctPTbvv65fDQopFgnNYMhqUcoaF
YzCEj1mDvb8Df6ykg07Ln98EFtffG0KYvKQOLWZMZpXMe3rTo2xdqgShSDT29QZf
bAYIMHFZtXLQEBPwXgUMTyb97/fgYLCWyq2/88SrZVh272schsjBTvK6LPBvJvBG
Xguk6zlIl1ZHQnaUi9ioGLsmw1B0urOZKE92KgkCygyyqqO6S1Sk8+Nvx0D6bFBA
ScaGwGHe5BY5i7YKxN4jxnOEh9yc7l6jP5m6ncMUjA8TPtBGMwbA5tYjCiKa5D7u
Ne5dW+Um1IOr7kvEmSF6PERIPhXPVqwK0yzS/3kG541KNYo5vUY0xuJaUV26vhJD
iSSYkI3BBB0DUIf+tXZIid377xibDlfWa5m8Ah0aYW7oHXcgsCLAE2mCDeuasfTT
nf8KrF5S/mOxYiQUxwCfI0xo/tyfxxgR9PCOI4Xy7A==
=mvbQ
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--

