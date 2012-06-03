Date: Sun, 3 Jun 2012 12:19:44 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120603101944.GM400@...1296...>
References: <1338649101-12636-1-git-send-email-alon.barlev@...277...>
	<1338651015-15724-1-git-send-email-alon.barlev@...277...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TKYYegg/GYAC5JIZ"
Content-Disposition: inline
In-Reply-To: <1338651015-15724-1-git-send-email-alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] build: update INSTALL to recent changes
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--TKYYegg/GYAC5JIZ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Jun 02, 2012 at 06:30:15PM +0300, Alon Bar-Lev wrote:
> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
> ---
>  INSTALL |  144 +++++++++++++++++++++++++++++++++++++--------------------=
------

Thanks for covering this missing piece.

One thing that caught my eye while reading this:

> @@ -75,13 +74,16 @@ OPTIONAL (for developers only):
>=20=20
>  CHECK OUT SOURCE FROM SUBVERSION REPOSITORY:
>=20=20
> +  git clone https://github.com/OpenVPN/openvpn=20
> +

You have updated all the commands to "git", but all the head lines still
talk about "SUBVERSION".  Maybe change that to "SOURCE CODE REPOSITORY"
or so?

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--TKYYegg/GYAC5JIZ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBT8s6QKkuBuNlUUl1AQJDGwP/XwXGrYwaG+W3NUID/I16QAP0wp6WA3pW
z5hZPLUiTM5E97gZtbnBppYz4OQAUJqv9OY/LDl0nvyAg6m1KUlWiik2MYkeVC5u
j0RJ2//bA6KLhghtq5ANBzK7dEf/vGQOm7gAO0qjVk7rFbS/OP7kjKGSRlHG/M2m
DD71X+lg3uA=
=y6/s
-----END PGP SIGNATURE-----

--TKYYegg/GYAC5JIZ--

