Date: Thu, 8 Mar 2018 17:05:41 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20180308160541.GR69387@...1296...>
References: <1512734870-17133-8-git-send-email-steffan.karger@...1435...>
 <201803081602.w28G2wft090849@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="iuErhZXXTDqxrbLV"
Content-Disposition: inline
In-Reply-To: <201803081602.w28G2wft090849@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Move env helper functions
 into their own module/file
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

--iuErhZXXTDqxrbLV
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

*this* mail should have never gone out, it was the first draft yesterday
after which I noticed that it failed cmocka testing...  so, please ignore
it.

git head is

commit 68b97b25e4c479156d697bf3df90a4b68fbbbcea (HEAD -> master, stable/mas=
ter, gitlab/master, github/master, delta2/master)
Author: Steffan Karger <steffan.karger@...1435...>
Date:   Fri Dec 8 13:07:47 2017 +0100

    Move env helper functions into their own module/file


On Thu, Mar 08, 2018 at 05:02:58PM +0100, Gert Doering wrote:
> Acked-by: Gert Doering <gert@...1296...>
>=20
> Does what it says on the lid: code is moved 1:1 with no code changes,=20
> and only #include lines are adjusted elsewhere (which is actually painful
> to review in this case, as the "moved out" stuff was scattered along
> misc.c and parts ended in env_set.h, so "plain diff" between old-misc.c=20
> and new-env_set.c didn't help much).
>=20
> One small catch: this collided with 06ad53e067d9a8b and setenv_long_long()
> being changed from "%lld" to PRIi64 - so I changed the patch accordingly
> so that it still only moves lines from misc.c to env_set.c
>=20
> Your patch has been applied to the master branch.
>=20
> commit 0afe0ca5620d5ab7cec3380d40048dce2286f048
> Author: Steffan Karger
> Date:   Fri Dec 8 13:07:47 2017 +0100
>=20
>      Move env helper functions into their own module/file
>=20
>      Signed-off-by: Antonio Quartulli <antonio@...515...>
>      Signed-off-by: Steffan Karger <steffan.karger@...1435...>
>      Acked-by: Gert Doering <gert@...1296...>
>      Message-Id: <1512734870-17133-8-git-send-email-steffan.karger@...2384...=
5...>
>      URL: https://www.mail-archive.com/openvpn-devel@...475...=
t/msg16066.html
>      Signed-off-by: Gert Doering <gert@...1296...>
>=20
>=20
> --
> kind regards,
>=20
> Gert Doering
>=20
>=20
> -------------------------------------------------------------------------=
-----
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20

--=20
now what should I write here...

Gert Doering - Munich, Germany                             gert@...1296...

--iuErhZXXTDqxrbLV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJaoV9VAAoJEB2Cnv7KVigSMq4L/iigB0crI/Jw8U9DVOijofIn
XnffoasVi1ZBy990bHDyxqtvQxlNUtI3N/tC4cZFqynzgfboijhYmveCTbKYEHsk
QugTLfFSgLAJ4DFXJxAH4ViDvfMWtymWZwaOXbI/sqjfOEgEsWH5zzBpSlGkLpmQ
xbTlcKNKQuKEu8Wm29wDlWy6oivrkOFp3LaBcnQkRb9iwMONveEJ9ax/Y1+sGw5P
cX2IPI86tmhn8SgRLmcikiD7476oAjzSEU75LkjxM7EWFtL7MY/CT3+jRyD4avGi
m0pLL3Srs4c48Njt86SCgPr7LTriu+5nM4N2Z4NaPur9f9Ds3mFJn+YgZkw1gSrp
C7n3Xh9SS4+YizMDv1e91okQBdAbxqqy5LjX2TC3DBaER/+IePL9+I7ocAN39YGh
SeKUo+Ve8SlygkHKl8oUI+PsCTST+cU6lPwepe8H2Ir1KP+sRJsuSqdjwGYoTeBt
ptqpndD869D/fXIn8Kw4O1gqzh/IW8IGcr1oUakGXg==
=EgC/
-----END PGP SIGNATURE-----

--iuErhZXXTDqxrbLV--

