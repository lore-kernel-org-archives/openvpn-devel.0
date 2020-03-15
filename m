Date: Sun, 15 Mar 2020 10:23:31 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20200315092331.GF1431@...1296...>
References: <20200314123531.GD1431@...1296...>
 <20200314005957.20411-1-lstipakov@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="P0uLJ1D0dtZMuM2h"
Content-Disposition: inline
In-Reply-To: <20200314005957.20411-1-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH v3] Fix building with
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

--P0uLJ1D0dtZMuM2h
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Mar 14, 2020 at 02:59:57AM +0200, Lev Stipakov wrote:
> This option can be used in FreedBSD with devel/libinotify
> installed.
>=20
> Detect presence of libinotify with pkgconf and use its word
> to compile and link.
>=20
> Signed-off-by: Lev Stipakov <lstipakov@...277...>
> ---
>=20
>  v3: use _CFLAGS from pkgconf to get include dir
>=20
>  v2: use _LIBS from pkgcong instead of hardcoded -linotify

We're getting close :-) - but something is still funny.  In the output,
I now have...

checking for OPTIONAL_INOTIFY... yes
../openvpn/configure: ,: not found
checking for CMOCKA... yes


... which is caused by these lines in configure:

------- snip ----------
                                        $as_echo "#define HAVE_SYS_INOTIFY_=
H 1" >>confdefs.h
,

$as_echo "#define ENABLE_ASYNC_PUSH 1" >>confdefs.h
------- snip ----------

so yes, there's a single line with a "," on it...  autoconf 2.69_3


It compiles and links fine, with inotify, but I think we should do a v4
and get rid of the Comma.

thanks,

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--P0uLJ1D0dtZMuM2h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJebfQSAAoJEB2Cnv7KVigSgcYL/3LjSTn6bGU7Osfsh/2aCDot
UkCVTc8sHrIU3mN6fiLBUiMs91/8m36aOUCFiA4UMq7qX9Gf2WOw7AyKtZH+B7oM
QOLMMrJegCEnxsgSD8/gMJKQsOPH/lki00dXNk7qwHDorMkeNWdk5oCSs2MVzw5s
zCT071Pd99Xf862Dgj7amwjd9vd9Ezny+pOdLpWTv9SqjMG5kpQ+MyCUmDpH4dli
gqAEwoyblu/qLPBZu3bTidVSsyWhcWlsvdU3Qk7MhShOXb+4FRzNbCPvBRQRhp71
IwMo9BYzU+v4CynT5vjf+lFde4w/fgKrh2EwUVeiH8cpRWPCgK08nHm1jWSDHhwl
whgTHwss51K5EPS1pBsjEQ2rxRQpeAHAL3/AxjE9aAqRqj7H3qoEveb+7Jq7it/0
pEKzipettuvlRpGxrI4yyeRqy4L9t48Q7AZoenQ1TnZeQVGina56PgA+aCIV15rp
3etnNpsTgAftGVxNP/X5sMUlv1jmX/fOQxXv5Wy70w==
=uS9n
-----END PGP SIGNATURE-----

--P0uLJ1D0dtZMuM2h--

