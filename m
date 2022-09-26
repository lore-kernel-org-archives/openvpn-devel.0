Date: Mon, 26 Sep 2022 09:04:36 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YzFPBO/6XApn2Jkd@...1296...>
References: <20220818084825.187755-1-a@...2181...>
 <20220918220618.31112-1-a@...2181...>
 <YyntXHQMcmih8aLE@...1296...>
 <32aae0d4-d225-a5c1-3ee2-2b03b184d324@...2181...>
 <CAKuzo_gyYS=_cfV9QYi+UbpZbRuKdpJJjuCq3jFdhmNna2=2rg@...278...>
 <1edc266d-09e7-40b6-5b73-6998a3548d45@...2181...>
 <YzFJCxQ1pDGuMG+g@...1296...>
 <937cf6e4-375e-549a-99f3-a54d93d87b77@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="0dDL99eHW3O1AXu2"
Content-Disposition: inline
In-Reply-To: <937cf6e4-375e-549a-99f3-a54d93d87b77@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v4] push-peer-info: rearrange function
 generating peer info
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: Gert Doering <gert@...1296...>, Selva Nair <selva.nair@...277...>, openvpn-devel@lists.sourceforge.net

--0dDL99eHW3O1AXu2
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Sep 26, 2022 at 08:46:50AM +0200, Antonio Quartulli wrote:
> On 26/09/2022 08:39, Gert Doering wrote:
> > It might seem elegant, to do this with a fall-through switch/case, but
> > it turns out to be not very elegant due to the restrictions on local
> > variables.   Also, if someone ends up setting push-peer-info to 4,
> > they will get "nothing at all" now, instead of "everything".
>=20
> This is set programmatically, not by the user. So right now you can't=20
> set a value higher than 3.

Good point.

> > To keep to your idea of doing this in blocks "3", "2+3", "1+2+3" one
> > could do
> >=20
> >     int detail =3D session->opt->push_peer_info_detail;
> >     if (detail >=3D 3)
> >     {
> >         ...
> >     }
> >     if (detail > 2)
> >     {
> >         ...
> >     }
> >     if (detail > 1)
> >     {
> >         ...
> >     }
> >=20
> > so it has less twisted conditions.
>=20
> Since >3 is not possible, this is exactly the same as a switch/case,=20
> (just reimplemented with ifs).

True, but less ugly.  I know you really like the switch/case thing, but I
find it much less compelling for a flow with "everything is a fall-through".

> I am not sure why this switch/case is different from the others?
> We also have {} in other case blocks for the very same reason.
>=20
> If we feel having the {} is ugly, we should agree on what to do=20
> globally, no? Not just change this hunk.

You are introducing something here, which is intended to make the result
more readable.  If that doesn't work, pointing to other ugly parts of=20
openvpn code is not a very strong argument...

I'm sure we all agree that for every possible C style sin, you could
find a place where someone clever did this in OpenVPN (I specially like
#ifdef right in the middle of a complex if/else expression) - but for
new code, this should not be the standard to look at.


Anyway, I'm not insisting on this, just stating my thoughts.

What we should - indeed - not do is have inconsistent constructs, with
"some case: having {}, some not" - so in that case, better bring the
local variables before the switch, so we can have all case: without
brackets?

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--0dDL99eHW3O1AXu2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjMU8EAAoJEB2Cnv7KVigSo0IL/3eKayRVXZ/LqU1s5HB9PyNT
BxsmYYoG80sP9q3tn8NbXye325kJEWifWt70g0hV9Isly5NWaw7731DYZdiBmPPS
nr91+mrNs8oknhmL6NcUvE/QV6ouLIuzLywrfd+sl1l3RfDIpFEoKFsccrBxJeMo
1t/qxyTr1+hiHCrH9b23vm46dTGCnI/AR+xHZl3IMaNi71xkFogJzhoIlzT/qwLh
MJxqN/XEPf9L0tOVVKDy/dCEMk4fFwdv/euneZn+OTC4wQejTiYXGDzesnPVAA6Y
t2UGpMZFCFSxCWed23PQ9cYAu7b7yQuIPmdcUwF4ouT/s80VAe/4cKJCEEp9BsVU
0bgDpywFn15pWLgTiMlmFRfNtCrFPajLh/I9fYdAHdumgbnWj1Jo0eNn+Px4rct9
knz6O+EDK+v+rajn9S7ynQNjJvqx3lfgHxNx0OLCwBoGqPSI3TtUt7wg9ABUNH+D
4RSIb95ciXaXHxsEO7wcQxM/GX7nd1mnyTdMWYzzBg==
=bIS+
-----END PGP SIGNATURE-----

--0dDL99eHW3O1AXu2--

