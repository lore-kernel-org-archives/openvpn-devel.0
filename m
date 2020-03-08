Date: Sun, 8 Mar 2020 20:58:39 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20200308195839.GW1431@...1296...>
References: <20200205184922.883-1-simon@...2293...>
 <202003081955.028Jtb7k065172@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="hRt258QUzs6ToQn5"
Content-Disposition: inline
In-Reply-To: <202003081955.028Jtb7k065172@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: wintun: check for
 conflicting options
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

--hRt258QUzs6ToQn5
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Mar 08, 2020 at 08:55:37PM +0100, Gert Doering wrote:
> Your patch has been applied to the master branch.
>=20
> Indeed, check makes sense :-) - compile tested on Ubuntu 16 / MinGW.
>=20
> commit 05ce4563fbea51a2653a6aa1ee51154ae6b7c6a0

*sigh*

I forgot to pull & rebase before applying Simon's and Lev's 4 patches,
and at push time, git told me...

So the commits for those 4 patches are all wrong.


Here are the commit IDs after rebasing, which I am going to push now:

commit 53e7d8dba4f3d0a0c54641ad5e94acf060e352da (HEAD -> master)
Author: Simon Rozman <simon@...2293...>
Date:   Wed Feb 5 19:49:22 2020 +0100

    wintun: check for conflicting options

commit baef44fc8769bbd99f4d699ce9f63180c29a5455
Author: Simon Rozman <simon@...2293...>
Date:   Wed Feb 5 18:59:44 2020 +0100

    tun.c: uncrustify

commit 4c71a647c460e276b81476a409143b97f01a03cc
Author: Simon Rozman <simon@...2293...>
Date:   Wed Feb 5 18:55:56 2020 +0100

    tun.c: refactor driver detection and make it case-insensitive
=20=20=20=20
commit b111aa8006ae39f5ca9cf251d158d5850806f536
Author: Lev Stipakov <lev@...515...>
Date:   Sat Feb 29 14:35:15 2020 +0200

    interactive.c: remove unused function
=20=20=20=20

Apologies.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--hRt258QUzs6ToQn5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJeZU5uAAoJEB2Cnv7KVigSdqsL/3ywgv29AzaNp+JvXqNdomSV
PHWvXcgCB0ngoc7SnH9TFJMo7fNeYrHz2L+Obv1I1F5uLd3/FKqyZOdIAU4NmVtR
nh17h1ZxV9IADz7vlv9CtQtvC41T0bLQOoxCiE6bt44UenF29yJjrLGeS+//hCWZ
SzqNTjyuoGsNuto9mexdKUO0yHj/ZKzgphIW9xnoixpbjjbpOTWOt2uNstTmpnp2
lXOQWfEoIBwXnSVXBOdaEXaR/1VPuCeqtfGvMZo7kEnvEl2Sr/c84WBSGS1HbUeI
bHE9AzJG+fnuzxa8iHPYC0x5Xb6GqAu9nZaJyczU7bcs4VhaE99EwmDk/JUXB+6g
fx+6amlD+bXc+kvPr/IaYGYQdAt1ejgOA/YVv7IHcp95OLHaQCOMgx7lJqqrac1W
d8grQIffXydl2MO5QZNtEWU6d63hf9jbQJORTzuU7TxN+ZMNvMQGYqJyHwAyyK+2
qHPu75QSeQ+pPcRVxuKnB9AMbBXxOEl12SisYXGxTA==
=KrFQ
-----END PGP SIGNATURE-----

--hRt258QUzs6ToQn5--

