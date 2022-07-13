Date: Wed, 13 Jul 2022 12:53:05 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <Ys6kEeGapGS5xxDj@...1296...>
References: <20220706142907.3962-1-a@...2181...>
 <20220711081019.29511-1-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="CBwkrPk2Lh1dNaXG"
Content-Disposition: inline
In-Reply-To: <20220711081019.29511-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v2 pre-05/25] networking: add
 net_iface_type API
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

--CBwkrPk2Lh1dNaXG
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

close, but NAK, due to...

On Mon, Jul 11, 2022 at 10:10:19AM +0200, Antonio Quartulli wrote:
> This new API can be used to retrieve the type of a specific interface.
> It's mostly platform dependant, but right now expected values are
> "ovpn-dco", "tun" or "tap".
>=20
> Other values are possible too, but they are not of interest to us.
>=20
> This commit also extends the networking unit-test by using the newly
> introduced API in conjunction with iface_new and iface_del.
>=20
> The t_next.sh script has been slightly adapted to allow running these
> tests in standalone (as they don't require any iproute2 counterpart).

Typo: t_net.sh (but this is not the crucial bit).

> +int
> +net_iface_type(openvpn_net_ctx_t *ctx, const char *iface,
> +               char type[IFACE_TYPE_LEN_MAX])
> +{
> +    struct sitnl_link_req req =3D { };
> +    int ifindex =3D if_nametoindex(iface);
> +
> +    if (!ifindex)
> +    {
> +        return errno;
> +    }

I think this violates the "errors are returned as negative errno" function=
=20
contract (and this is a code change, I won't "fix this on the fly").

> +for i in $(seq $(($LAST_AUTO_TEST + 1)) ${LAST_TEST}); do

Does $(( $A + 1 )) work in POSIX shells?

t_net.sh currenty requires bash, but I wonder if this is really needed,
and a POSIX /bin/sh would do the job.


Also, while at it - maybe add a unit test for "this interface does not exis=
t"
(as we need that functionality for the "--dev tun3" test)?

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--CBwkrPk2Lh1dNaXG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJizqQRAAoJEB2Cnv7KVigScpcL/1wAqxt0YXKu2Tjkzc1xbvnw
It9HlPvyHLgslerB4dNqMrr/pf02b4TDOx2xsZLU30bF7L8GEN3CYZ07OyMV8bPg
IuaXg+6ys9g0+QjpM9k9htX4ZKLTCGIUO3CcDxftWBOe0ifQk1h511yY5+gQfZv3
3FSn1RwjEyqoH/kzq0RLtKqFet/lGm5ZjtIVDtFMKT/T1RCZspjMHeUa2red9AAH
NrKh2ibMmk4OKBa7zA2gYmzmaBQBThVhEnNEvNKCt8neFpGUBC78vpN0OMGYQwm6
WwT7anQYxSASqFabBsGF3kTsdZzIzQ5PjAsbmumz0SU91VftgCyqn6ZRJnAh8g/N
/b0V8sGVYB0fdjdvppC6i6O5z8KH8Kf92zzVyXGZPYjVFULStuFJMY6HJv4YPy3l
wlk5n9HnGwiz73XhNUCwDyGFLa9t7ZB48ORwjUXumYBnA/qiUdH/zH83TuBjTU6t
9OgkLhEkKAX9JOdx/84bhTyOqJYVws16AAhgEsXP/g==
=PDmf
-----END PGP SIGNATURE-----

--CBwkrPk2Lh1dNaXG--

