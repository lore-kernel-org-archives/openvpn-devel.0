Date: Mon, 20 Feb 2017 13:18:52 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20170220121852.GW93896@...1296...>
References: <1483905658-25267-1-git-send-email-selva.nair@...277...>
	<1484428589-7882-1-git-send-email-selva.nair@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bGD25dtqTBkDy1zG"
Content-Disposition: inline
In-Reply-To: <1484428589-7882-1-git-send-email-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH v2] Fix user's group membership check in
 interactive service to work with domains
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: selva.nair@...277...
Cc: openvpn-devel@lists.sourceforge.net

--bGD25dtqTBkDy1zG
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

HI,

On Sat, Jan 14, 2017 at 04:16:29PM -0500, selva.nair@...277... wrote:
> From: Selva Nair <selva.nair@...277...>
>=20
> Currently the username unqualified by the domain is used to validate
> a user which fails for domain users. Instead authorize the user
>=20
> (i) if the built-in admin group or ovpn_admin group is in the process tok=
en
> (ii) else if the user's SID is in the built-in admin or ovpn_admin groups
>=20
> The second check is needed to recognize dynamic updates to group membersh=
ip
> on the local machine that will not be reflected in the token.
>=20
> These checks do not require connection to a domain controller and will
> work even when user is logged in with cached credentials.
>=20
> Resolves Trac: #810
>=20
> v2: include the token check as described above

Took me way too long...  the code change looks reasonable ("does what it
says on the tin, and safely so").=20=20

One questions occured to me, though...

MS documentation for GetTokenInformation() suggests that group membership=20
tests should be done with "CheckTokenMembership()", which sounds more=20
convenient than "extract them all and walk the list" - so maybe this=20
is done to avoid domain controller contact?

OTOH, the example given somewhere else does the same thing with
EqualSid(), so MS doesn't know what to recommend either, it seems...
https://msdn.microsoft.com/de-de/library/windows/desktop/aa379554(v=3Dvs.85=
).aspx


A few more tests, then merge...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--bGD25dtqTBkDy1zG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYqt6sAAoJEB2Cnv7KVigSpGcL/1hcZzvHr17vP+NFPjkvEcHC
0nbZgSkz4WueFZsRAix8lUBLG8BfFW5/1KWst7Fjkz5j0FJAYmTRhOWgFitKgl+D
PBx51gpJs6Qi19iER3Sd+zPGWRm6oPtHTCJTSHtOwGhYEbp1wZoLreIZY5KW/sEh
OUmKID+ov3lh/KhgS/pst6NTNwio6Qh9japkzEDU+HrUqOBTAdATrr3wKfOjItjP
d5mWPNQrnOAtHUs6MnoV1yu6i3HJsUxjBuiyTG7/OTE4PuG8UeP7fBaEaZGLKazi
4lwFKTcU0W9Ovb7/aGNf8NTWBKnyVNtcYTBL4DGhIQSfpng+FUql7vOh8RdpcJJt
JvPnbREH3GKt58slJrt0kautTsh4DF56IgBXlN6Szndx6jY/b2hqhL9BYD5G4NPd
0ngpxO1T4YPttWfjFckLg1+u7wKsMUVGyq/csyBGA36YHfWcuXs95aSGWgoG6T3/
mzjfM6AuYvmOuii7Zwrj7TzMTxpmHffyir/vqCYLRg==
=gDpm
-----END PGP SIGNATURE-----

--bGD25dtqTBkDy1zG--

