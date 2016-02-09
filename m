Date: Tue, 9 Feb 2016 18:01:30 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20160209170130.GU24952@...1296...>
References: <1454874438-5081-1-git-send-email-steffan@...1856...>
	<1454874438-5081-10-git-send-email-steffan@...1856...>
	<56B8BC53.40805@...1227...>
	<56BA02BF.5090208@...2080...>
	<CAA1AbxLu+P5-Vn3kPYFgrVZFHpY1WtD3+0TkFZzDTdOkLJgB-Q@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="t0K3MTE2gCquMEb7"
Content-Disposition: inline
In-Reply-To: <CAA1AbxLu+P5-Vn3kPYFgrVZFHpY1WtD3+0TkFZzDTdOkLJgB-Q@...278...>
Subject: Re: [Openvpn-devel] [PATCH 09/10] Add cipher name translation for
 OpenSSL.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--t0K3MTE2gCquMEb7
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Feb 09, 2016 at 05:46:21PM +0100, Steffan Karger wrote:
> gcc 5.2.1:
> $ clang -o no-yoda no-yoda.c
> no-yoda.c:5:9: warning: using the result of an assignment as a condition =
without
>       parentheses [-Wparentheses]
>   if (a =3D NULL) {
>       ~~^~~~~~

I noticed this as well, and find it really useful (without needing -Wall).

> So, I do not have any strong preference.

In that case, my preference always is "match existing coding style"
(which would mean "it depends on the module" - the ssl_*.c / crypto*.c code=
=20
tends to "if ( NULL =3D=3D ...)" while most of the rest uses "if ( ... =3D=
=3D NULL )"
- so much for "existing coding style"...)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--t0K3MTE2gCquMEb7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVrobaakuBuNlUUl1AQIEzQP+JuKqZNqfX2VDfnV7lh/GC2Sp3qKDALfx
akmvkhsc6Wo0byFo2qNlVprqb4UM32A+QZw5iBt591nSpHHo47w/bXgPL2zegFjy
6gsMnrQ5FySbTidgeXqUaPhvwIc3CXT0FFqVcIcy5FkAETr0kRoj0I/E8zyd9iMG
+ANxGxnCGw8=
=Kz13
-----END PGP SIGNATURE-----

--t0K3MTE2gCquMEb7--

