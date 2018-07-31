Date: Tue, 31 Jul 2018 22:19:37 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180731201937.GL55859@...1296...>
References: <1494859203-21904-1-git-send-email-selva.nair@...277...>
 <1511228605-23207-1-git-send-email-selva.nair@...277...>
 <50c2b9c5-4558-1999-83e7-456c1f9bbb5c@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="jvmCgFKx2lledmPK"
Content-Disposition: inline
In-Reply-To: <50c2b9c5-4558-1999-83e7-456c1f9bbb5c@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] Correct the declaration of handle in
 'struct openvpn_plugin_args_open_return'
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: selva.nair@...277..., openvpn-devel@lists.sourceforge.net

--jvmCgFKx2lledmPK
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Aug 01, 2018 at 01:21:35AM +0800, Antonio Quartulli wrote:
> On 21/11/17 09:43, selva.nair@...277... wrote:
> > From: Selva Nair <selva.nair@...277...>
> >=20
> > - This is an opaque pointer so the change should not affect
> >   existing plugins. But it makes the code consistent and clears up
> >   the documentation as the handle pointer is treated as of type
> >   "openvpn_plugin_handle_t" in the rest of the code.
> >=20
> > Signed-off-by: Selva Nair <selva.nair@...277...>
>=20
> Will make some noise during application (git pw patch apply 87), such as:
> "Falling back to patching base and 3-way merge..."
>=20
> But it won't generate any conflict.
>=20
> Acked-by: Antonio Quartulli <a@...2181...>

Oh, we had the patch on the list already.  Thanks for finding it & ACK.

I'll apply tomorrow or thursday, on the road right now.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--jvmCgFKx2lledmPK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbYMRZAAoJEB2Cnv7KVigSwU8L/0olTc7QsLpkBtrejdkINW4u
2A6/QGfMyviBZprhjL3dny3FMJhnScVTsSi2jFBGk42qVckG9I8jKBR2Va12bmKR
PaLpvjvPGJHqFu+LOmWA+S74R7hktvMClCT9YmMCounK0zjfbud2G2iYCEolwuYi
XiLnCA4Iq4JPOpmn+/Aogzc1izMThGXzAgc1lJYu6yEStGmljfB9S1SLaqFYB1SF
E6osEcRDTqonWPYK9PG/ACXRUxvYlcCGK7phtR2KhTrArd0Eu/m+2gyZB1eYMVG3
4x3O4uRk3LUwV8tge+oHOiAUOR/e4Z+IdP7rbMtPJRdei3vWNRAI1XcRWYQjCcI3
qnpr9qkB137nUIXLsU2D7uTfp+McPkH29cZdgupmFuCzz3SDCCAurcD9L1o1Pwim
c/ZTupfpfJAjp9IImbuNSjcxYiHofrzLvY0YNiRuzWtd60iMISlUlJmE1H9tHm9g
poid5Ehn5wGlwvnXDLhsMPUFKQs4cUGNwZ8z+tSOhw==
=uwaS
-----END PGP SIGNATURE-----

--jvmCgFKx2lledmPK--

