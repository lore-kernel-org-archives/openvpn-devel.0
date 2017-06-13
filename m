Date: Tue, 13 Jun 2017 21:25:59 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170613192559.GX97029@...1296...>
References: <c97c0fd6-3d34-fb94-40e4-3ec8dc7af0c9@...277...>
	<f910a64e-235f-56ad-52b4-aff5dae46acf@...277...>
	<CAKuzo_hUiYVxZSEnB=8=ijO86_VbiZep2mR=1_FCi2pFJYLYmg@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1Ly9fPFUReNfSsPe"
Content-Disposition: inline
In-Reply-To: <CAKuzo_hUiYVxZSEnB=8=ijO86_VbiZep2mR=1_FCi2pFJYLYmg@...278...>
Subject: Re: [Openvpn-devel] W10 Client assigns old AND new IPv6 address to
 TAP with GUI+Service but not with cmd prompt
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: debbie10t <debbie10t@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--1Ly9fPFUReNfSsPe
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jun 13, 2017 at 03:19:59PM -0400, Selva Nair wrote:
> > 1. Administrator command prompt - execute openvp config-1.ovpn
> >    TAP is assigned 12fc:1918::10:36:101:110/112
> > 2. Terminate by closing [X] the command prompt
[..]
>=20
> I haven't tested this, but if both connections use the same adapter, this
> looks possible as you kill the first process without giving it a chance to
> remove the IP first. Addresses are added with store=3Dactive so would
> disappear on reboot as you saw.

Right.  If you a) run as admin, and b) force-kill openvpn (which "close
the command window" might do), yes, there is no way to clean up.

In that case, it's just plain PEBKAC :-)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--1Ly9fPFUReNfSsPe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZQDxHAAoJEB2Cnv7KVigSSBML/j4ZItclUSUVfDnTqecJHqI0
lVam7bvcoXYXXgpWk+CsU+oc4/Ef2WtvQpoUv11rriaEQIYdQuHEehjjmZ0QTK5b
Wg7F4tsl9Ai0WLwJUeOwBvABGB99qlTe71/ujhOLN0vufWHRquG5ciG+xBmrZYc/
uQ/fiYgCJUIyvc1XGKCAsbCv59vzBktZEikbKuW32WBI+8Ab91JwEEZ/l+n+21Cg
9E6GNhlnWc362vx17MkaWSb30SUYAU1FxSuvJMVsG6bg6LC8IePTC2y356VQItno
0WmY2sCHpZJrqq8PknHy3aYJ2uPgK5ECp63gnGUOeMHEQ4xhU9yDWyYjEY+7usQy
k+eC1Of6xpNa2ChK0NrpPz0KMaT1bDItN/nLSWKENn1cj8LCmDxeRrbl4WvzmL4L
JoUt0E6iNypcD/6NUZ+QftPpiu5HIRzZCnYMDxhscK7hkKvgpwpYSDXm2AoK/4LU
v6iZrxmX7iC0fN/nuYLMX56Cliot161qazyJZpSQMw==
=m1nw
-----END PGP SIGNATURE-----

--1Ly9fPFUReNfSsPe--

