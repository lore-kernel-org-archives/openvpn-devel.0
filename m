Date: Wed, 6 Jun 2018 18:45:04 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180606164504.GF57262@...1296...>
References: <CAKuzo_i5wMwqSKjH-ohK8ujSApthxNrHsbFw2k5U9q_YKb_YqA@...278...>
 <9319a55d-c27e-aa07-749d-9c998271a5c4@...2181...>
 <CAKuzo_gfgG=6LxX-s0aPReZeaXDwEBM0zfrtWxZR9JzNvkraOA@...278...>
 <20180605185352.GR57262@...1296...>
 <CAKuzo_gaiCL1Y_zbHUBjaQwxtU2WYzg5Z4zv9tDUS-J4oeoLVg@...278...>
 <20180605195935.GU57262@...1296...>
 <CAKuzo_jP1F13rw2pdRx9zF0n-7+N29u3d4FE53tL9SrwxMwk9w@...278...>
 <9a878b99-12ef-47b4-fc85-a16ecc196363@...2181...>
 <CAKuzo_hU64ML71iL7Xdt5_k08QLXwDytXd1W2TVze=7SUhLLSQ@...278...>
 <46042b3b-ff87-903a-315e-dd6d577a8a39@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="dLXnlYbDJNCwF3YM"
Content-Disposition: inline
In-Reply-To: <46042b3b-ff87-903a-315e-dd6d577a8a39@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 1/5] tun: ensure interface can be
 configured with IPv6 only
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: Selva Nair <selva.nair@...277...>, Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--dLXnlYbDJNCwF3YM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Jun 07, 2018 at 12:02:44AM +0800, Antonio Quartulli wrote:
> > - Make sure v4 routes do not break a v6-only connection -- either
> > filter out and warn about v4 routes via the tun interface or just let
> > them fail with a warning but proceed with the rest of the tasks.
> > Setting v4 routes via other adapters should work
>=20
> Do you think it makes sense to install other v4 routes (i.e. routes
> using the LAN gateway as next-hop) even though we have no IPv4 on tun?
> It feels like they would be totally unrelated.
> Gert? what do you think?

For whatever reason I never understood we support this...  so while
it doesn't make much sense here, breaking it on purpose doesn't make=20
much sense either.

I'd go with "whatever is less intrusive to implement"

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--dLXnlYbDJNCwF3YM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbGA+PAAoJEB2Cnv7KVigSLAwL+QEGLkjIkrIGb/WWoFPaD96i
LqrSyQjcJf/Wq63aLfr1bRNtsG2cU5lnS6YTA4vOBUVVYdeC/Oz1ZJ2C/YH3i5AZ
99NVJ+N6mwrIl53SVOB9nQJmAiVgEvBrisfGZ3Y+jipW+Qn04pI2tRV1iqqc3tyZ
P5uS5BU3rsLzi22YyvycqCWlwszDNWJYj8R57sJWYe28eklFEAd8NzePrvMDmPLq
TGj18calM+bZUy3zIddlLv/VojfoYPsGQiE8osBQEYJO8zspTY4Jl0Ur4BeZpLIc
G9yRbaJnYEwYwh21hO6zg/zlggD39sXUQUhJxnRQu6yX/8dJ7gJ1ZJ1LE0+zBTnt
BtYYRCl73/RyGRmsT3N6tSu7BD8EJnqGwQVIcRuLdpQ0BT4by3m1stwsfsLd98Jq
zhQTbjRgbTpJYAlypgaBSSjtTxS7c2U4I0Bx5v5/YQdILzR0QI6dy5XvUkh3i9og
UtyePUu2m+auIXq+hoR59mu6o2Gbqw96j44l7Adltg==
=tT5x
-----END PGP SIGNATURE-----

--dLXnlYbDJNCwF3YM--

