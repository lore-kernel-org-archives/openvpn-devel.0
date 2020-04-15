Date: Wed, 15 Apr 2020 21:12:26 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200415191226.GN1431@...1296...>
References: <1581519967-16950-1-git-send-email-selva.nair@...277...>
 <202002131954.01DJsIrb090643@...2054...>
 <20200415175828.GK1431@...1296...>
 <CAKuzo_gXcXxbKuQ-7GK54H6GBvOYCd0xrF2g0ry9=DZ5MUtsQA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="BcdBrJ7VxrpNMUFN"
Content-Disposition: inline
In-Reply-To: <CAKuzo_gXcXxbKuQ-7GK54H6GBvOYCd0xrF2g0ry9=DZ5MUtsQA@...278...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Skip expired certificates
 in Windows certificate store
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--BcdBrJ7VxrpNMUFN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Apr 15, 2020 at 02:22:15PM -0400, Selva Nair wrote:
> > is this one and aa6affe6df811db11577847366a569def0a3e314 also material
> > for release/2.4?  So "feature" or "bug" category?
>=20
> Yes it would be good to get this one and aa6affe into 2.4. This one
> will cherry-pick with a minor conflict in cryptoapicert.c, easily
> resolved. aa6affe should cherry-pick with no issues.

That conflict was trivial indeed.  I fixed an occurrance of "else {"
while at it (whitespace only).

Test built on Ubuntu/MinGW, not actually tested the resulting binary.

Cursory review of the code also does not reveal anything unexpected.


commit 5f8a9df1eea33c2d6fc267e5e3683449954c986b (HEAD -> release/2.4)
Author: Selva Nair <selva.nair@...277...>
Date:   Wed Feb 12 10:06:07 2020 -0500

    Allow unicode search string in --cryptoapicert option
    (cherry picked from commit aa6affe6df811db11577847366a569def0a3e314)

commit 4658b3b6f6008eea1819ea26a46fd46df87b1030
Author: Selva Nair <selva.nair@...277...>
Date:   Wed Feb 12 10:06:06 2020 -0500

    Skip expired certificates in Windows certificate store
    (cherry picked from commit 7b63984d51a2582ba2d406e46a7debb11df7f478)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--BcdBrJ7VxrpNMUFN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJel1yZAAoJEB2Cnv7KVigSdPwL/0HRunsJ5/DW2Da367rjNZBO
FCpGf5zjiWlmCw0Q6J5YYl/5P80UwFupd5QPFydur3fa+klBbHk9MEiDPEioOIUP
AME6o8FZnQqbo6NvaxYYbTxcVDDwpvcNxBPpq5M8gkm/G2XCibepbmJrMpnKnDUg
v/gGJSXPjivcXgSN+K+EqLA+Pqmbvrc+nbhmEsLUXS/qCjetz2bbOKjpJ1J3i2SV
L+rGLfWB4GSliLTTcWQLo/kGWuPi/dhxMtGbe8Gn/9RyYmeDmS6bhWurZPnuO9AU
r5I37sLcm3oKMC72ap9p4ophcTwcrc5HhFkMVtO6Xzj0qyEWoZWNDkd15A7FOcYc
zEC8McmezauD6Vo0NJn+v5Tloo+TD2vWGwqNSaUuadVfVih0+5LyFICo/rwXRQw5
A/7XJX0uxz5GtMbhn1KFWFKXpqMqL0TMdKG6XkOXSZT4kt4+YFJJXsf3eUv9mOtZ
pwpoBZpXyxeqEFK6sUTiXPP9C9Fx1N52ti7wOHnPtQ==
=FsWX
-----END PGP SIGNATURE-----

--BcdBrJ7VxrpNMUFN--

