Date: Sat, 30 Apr 2022 16:29:30 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <Ym1HymQZe4/2W3JP@...1296...>
References: <20220402070902.30282-5-a@...2181...>
 <20220411133528.27279-1-a@...2181...>
 <2078542256.353074.1649759630031@...2642...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="jL5xrrw92BMSJFPR"
Content-Disposition: inline
In-Reply-To: <2078542256.353074.1649759630031@...2642...>
Subject: Re: [Openvpn-devel] [PATCH v2 4/7] ovpn-dco: introduce linux
 data-channel offload support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Frank Lichtenheld <frank@...2641...>
Cc: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

--jL5xrrw92BMSJFPR
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

reading through Frank's review bits, I found something...

On Tue, Apr 12, 2022 at 12:33:50PM +0200, Frank Lichtenheld wrote:
> > +struct sockaddr *
> > +mapped_v4_to_v6(struct sockaddr *sock, struct gc_arena *gc)
> > +{
> > +    struct sockaddr_in6 *sock6 =3D ((struct sockaddr_in6 *)sock);
> > +    if (sock->sa_family =3D=3D AF_INET6
> > +        && memcmp(&sock6->sin6_addr, "\x00\x00\x00\x00\x00\x00\x00\x00=
\x00\x00\xff\xff", 12)=3D=3D0)
>=20
> magic constant?

Yes.  This should use IN6_IS_ADDR_V4MAPPED(), as we already do in
other places (=3D we know that macro is universally available and works
with our constructs).

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--jL5xrrw92BMSJFPR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJibUfKAAoJEB2Cnv7KVigS2XgMAI7irvbw46aoo7nDajl8yo5I
QN7Q+DIZo5/73EeMuVKea6RpPCvwb0erYBUrOecVbbRrJQPKhKaMLKS3hJKs/x5X
5jiWzCXGqTdpv4fV8SR4DCFh5f0W6renHD8MDAwHXNR/Qcai4Lr3uk+ELNjnWBv+
hDXb0vBLHomi9zpcyaCV55u20kBzgmZ9sw1BPdtyEYXJcyapb4zahc9AAhA07N4s
FrFwXR0GO3B5vlhUgLhxPny9cOVFizdccdhc1nxDZkQxPivGWighQkl98WyrRyJT
wEuAYLK8jmktirEEyArCMJposWRu3OT2d1sGuZ25D7mdZNA/q1TNFwgbvACRi/Aj
HrvHQe5YvfuxmDgLkSP1N3NEr6VHm8ztNLRmgbHAurciIexnCGZ17gQXlYsWYw6q
iB6C6zI0MFyJQnU+0yz9KA1Rfz6lN9I8Zwj7ykKS5N2psvbIvXWAvwRH6IBpwkdp
M6TJiUaMRuhFJqmuz5i9xTL2+nGMAdWDcYE4G1gqZA==
=rVWy
-----END PGP SIGNATURE-----

--jL5xrrw92BMSJFPR--

