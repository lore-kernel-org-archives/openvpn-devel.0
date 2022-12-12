Date: Mon, 12 Dec 2022 14:30:48 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y5ctCJ1r0oHFG2Qw@...1296...>
References: <20221205164103.9190-1-kprovost@...2661...>
 <20221205164103.9190-2-kprovost@...2661...>
 <CAGyAFMW_pYqUKXttVQFzeRD-PAapHznauqbgfnettcwerkNyhQ@...278...>
 <bfa5c96e-3478-5150-0066-ee05643be9f8@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="NnEA6GYd18yCKPTL"
Content-Disposition: inline
In-Reply-To: <bfa5c96e-3478-5150-0066-ee05643be9f8@...1227...>
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
To: Arne Schwabe <arne@...1227...>
Cc: Lev Stipakov <lstipakov@...277...>, Kristof Provost <kprovost@...2661...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--NnEA6GYd18yCKPTL
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Dec 12, 2022 at 01:50:51PM +0100, Arne Schwabe wrote:
> > I am not too much into FreeBSD parts, but
> >=20
> >> +    hash_iterator_init(m->hash, &hi);
> >> +
> >> +    while ((he =3D hash_iterator_next(&hi)))
> >> +    {
> >> +        struct multi_instance *mi =3D (struct multi_instance *) he->v=
alue;
> >> +
> >> +        if (mi->context.c2.tls_multi->peer_id !=3D peerid)
> >> +            continue;
> >=20
> > Shouldn't we use m->instances[peerid] instead of iterating over m->hash?
>=20
> Yes and a check that kernel does not give something > max_peer

I agree, doing the iterator here for every single active peer when we
already have the array.  But then, of course, p2p peer-id will be=20
"something random", not constrained by max-clients.

Anyway, we have a procedural problem here - kp@ is on vacation for a
few weeks now, so we won't see a v2 of this patch any time soon.

Do you think the patch is ready to be merged, "as is", with not-so-good
efficiency?  One of you could then send a followup patch changing this
to use the array accessor.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--NnEA6GYd18yCKPTL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjly0IAAoJEB2Cnv7KVigSqIoL/18mGLoYtDCgE0kCvhPe7KZI
LHhTg3bc4dpUBCjXxoqf0mSrjhGu4cAQqswRuRLFNIptMaSZ5DUEhm7+2Ks0yHn0
QcV1rlkeRCNjq2V32eds0im6Ae/2BCFdBZudDjuwJQx+R9AoanwPI62IHDvcXsN2
2mFay59mTkaxOEDD9zCgeaH1NOW5r2RlFU9qkBN6uNxAvkeHN/ZRtW5IcUHVhhzL
Ch+x7fe6IFjDPZ1DZTjKPUNMC0U5RyoOhoaVzoVxS3AMjzXP4D6m4sRDwctVlsa5
XNyZBfkJdCHgCvEW1zHv2i9IKDBeVV7kmqC1mrET/gh5cti0P5TaqHSm+GnVE6hi
2L+Oo7MvoovqylgfEVzBu3sGPaWTGWM4L7p1RjKh5bHZ7ZXXDfac93eMfP3w8Zzz
4MR8AcZa0LUqonzWcQmvbmD37SH4RfDUhVqbp6abYOLuidRGSHdnKwwZ/irEJCwG
nrku7uoWlX4YwripdFDIC6azzzYKt1dK7plNYCr+XA==
=dZb1
-----END PGP SIGNATURE-----

--NnEA6GYd18yCKPTL--

