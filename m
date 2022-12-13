Date: Tue, 13 Dec 2022 05:46:09 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y5gDkXBhDyqB+YZf@...1296...>
References: <20221205164103.9190-1-kprovost@...2661...>
 <20221205164103.9190-2-kprovost@...2661...>
 <b6c21ae8-536a-2c6f-07e6-d998102c646e@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="0EKV8cL6OhSRfR7r"
Content-Disposition: inline
In-Reply-To: <b6c21ae8-536a-2c6f-07e6-d998102c646e@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 1/4] Read DCO traffic stats from the
 kernel
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: Kristof Provost <kprovost@...2661...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0EKV8cL6OhSRfR7r
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Dec 12, 2022 at 09:53:36PM +0100, Antonio Quartulli wrote:
> On 05/12/2022 17:41, Kristof Provost via Openvpn-devel wrote:
> [cut]
> > +int
> > +dco_get_peer_stats(dco_context_t *dco, struct multi_context *m)
> > +{
> > +
> > +    struct ifdrv drv;
> > +    uint8_t buf[4096];
> > +    nvlist_t *nvl;
> > +    const nvlist_t *const *nvpeers;
> > +    size_t npeers;
> > +    int ret;
> > +
> > +    if (!dco || !dco->open)
> > +    {
> > +        return 0;
> > +    }
> > +
> > +    CLEAR(drv);
> > +    snprintf(drv.ifd_name, IFNAMSIZ, "%s", dco->ifname);
> > +    drv.ifd_cmd =3D OVPN_GET_PEER_STATS;
>=20
> What speaks against having a simple GET_PEER here which returns the full=
=20
> peer object with all possible attributes?
>=20
> This way, if we want to retrieve another attribute in the future, this=20
> attribute will already be delivered by the same API, without the need to=
=20
> implement a new command each time.

One counter-argument would be "the statistics are polled more often than
'all information about a peer object', so it should be less costly"
(also, when do we ever poll 'all attributes'?  Since OpenVPN *sets*
these, we should know, except for the counters...)

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--0EKV8cL6OhSRfR7r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjmAORAAoJEB2Cnv7KVigSYZ8L/32btqXS+Pt1rAIN2tYFTF7t
cOTRyLcGFhHzOtF9tWf2Fcao50blk9V7DDRjQS2P2/efVNRrbW1xgpAY2iUBGmPP
l2JtRqkHpqAYgNsXbaqfmzAssh6JEi2cPzraq3KsZt8Mnw1z4hyRWFpedAjhI7sB
t//mToqCwQJhd1QFdkLgo1zlLJbxJ10CCHqLX0GbBhFon2NjoClbcXxG5U+tiRP7
OClqPgWbh24A6OQzQQ+l+ZarJOkl2fpRKvF48/raKN1Umf3yYvV3Josng68n1V8+
kUAF3kkv7CQQipdVJKgF4R84rqQKEC7QynaZYgOWA8FzCIcRdnVmUEMpealLKAlf
hh+9z2IwCu7R3i1FLgGdMMhGJyt9EvrlQuoVrOjYqZbBXld693RCCnVZTYeGb6/W
4v0LExlwt+iQa5KeHaPWvguFwZUDjzf3xuzs1VmHgJoWlRauXCNUuWbpFtoUoDGQ
/J3hVIHJvMJtFe9BfjpPxkB+3RwTQZV/9/TasSZ0Kw==
=8XIh
-----END PGP SIGNATURE-----

--0EKV8cL6OhSRfR7r--

