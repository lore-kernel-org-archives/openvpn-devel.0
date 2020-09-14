Date: Mon, 14 Sep 2020 11:06:12 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200914090612.GO75094@...1296...>
References: <20200911115916.16117-1-gert@...1296...>
 <e53ed74d-d1c0-c76a-3622-da00e00cfb8b@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="FJ2D5YQYG6NL2pc1"
Content-Disposition: inline
In-Reply-To: <e53ed74d-d1c0-c76a-3622-da00e00cfb8b@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] If IPv6 pool specification sets pool
 start to ::0 address, increment.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--FJ2D5YQYG6NL2pc1
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Sep 14, 2020 at 10:56:59AM +0200, Antonio Quartulli wrote:
> >          pool->ipv6.base =3D ipv6_base;
> > +
> > +        /* if a pool starts at ::0, that first IPv6 address is not usa=
ble
> > +         * first clients (subnet anycast address).  Start with 1, then.
> > +         * NOTE: this will also fire for something like
> > +         *    ifconfig-ipv6-pool 2001:db8:0:1:1234::0/64
> > +         * as we only look at the rightmost 32 bits.  So be it...
> > +         */
> > +        if (base =3D=3D 0)
>=20
> why not memcmp'ing ipv6.base with in6addr_any (defined in netinet/in.h)?
> This way you get rid of the first NOTE (unless this header is linux
> specific..).

because ipv6.base is not "all zero"...  it's "the IPv6 address that
the pool starts on", host + network part...

If you have pools like this:

  --ifconfig-ipv6-pool 2001:db8:0:1:1234::0/64
  --ifconfig-ipv6-pool 2001:db8:0:1:1234::0/112

what would "comparing with in6addr_any" achieve?  "ipv6.base" is=20
2001:db8:0:1:1234::0 in both cases.


Now, "base" is "an integer that contains the lower 32 bit of the host
part" - which is 0, for both these cases.

To fix this "totally perfect" we'd need to move "base" to 64 bit integer,
and then figure out how to do that portably across supported 32 bit
platforms (including MSVC) (or work with 2x 32 bit 'base_low', 'base_hi',
or do "full 128 bit on 16 uint8_t" stuff...).

Yes, this can be done, but I was way too lazy and went for a less intrusive=
=20
fix instead...

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--FJ2D5YQYG6NL2pc1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfXzKEAAoJEB2Cnv7KVigSe8kMAI/ZJ8M89obFnKnp8b3QnSiN
gPrKeLF0FZhFiUJmdY11kXMJm+hK46lLOeVGvgv4xrQU6ildsIzfZt6Zl8SWONHU
mMM5sa26xU/x7LxY3KiegTBEUNYvuj2JuEu9na81Ri2XkkZBSIP0T8LhqPNcEcfA
zzS59QAAxevHPB7J0WDjj+Rreb0QbBSr83Hb6gKlj0KOK3ayjdXE1saL1KkehNZ4
JlWglCf1aoo4G+wJ5o7KsSfAzl1Q6iQbSPcbTWYW3xBGUZ8RcgDYyYfehJlsOPvK
UJTwLUtH/KXWcDOhA1q4712l6wsA/Fxp8zTzNxY/lNHl/5qAGr/bLMtcn0wsAayA
r6Xl9uU1ZR0GQvC7tygE1fsRv3x2Whh8oIJwbXykfh/bWpC/t6TynIyXmSM64lRf
XBv8vfWaWkdAti7RsCqLh/uyIQ4ONJtEYtaFT8HyyhtiYKIFX8crEOLDCCde6Hiv
3Xl1YvXo6NzJ86ywP73Tr5hMDjMhfhBRCwTHlNESUQ==
=QVV6
-----END PGP SIGNATURE-----

--FJ2D5YQYG6NL2pc1--

