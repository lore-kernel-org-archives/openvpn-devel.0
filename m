Date: Sun, 26 Feb 2023 17:15:57 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y/uFvdsaFiEk+xgt@...1296...>
References: <20230130172936.3444840-1-arne@...1227...>
 <20230130172936.3444840-2-arne@...1227...>
 <Y/suKJIyDKICDxXu@...1296...>
 <21963270-a013-9cdd-fc21-569e366c6e19@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ZN4zre6DmlKneuw8"
Content-Disposition: inline
In-Reply-To: <21963270-a013-9cdd-fc21-569e366c6e19@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 2/5] Fix unaligned access in
 macOS/Solaris hwaddr
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--ZN4zre6DmlKneuw8
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Feb 26, 2023 at 03:10:07PM +0100, Arne Schwabe wrote:
> > struct ifaddr {
> >          struct  sockaddr *ifa_addr;     /* address of interface */
> >          struct  sockaddr *ifa_dstaddr;  /* other end of p-to-p link */
> >          struct  sockaddr *ifa_netmask;  /* used to determine subnet */
> >
> > ... so the first memcpy() isn't actually copying the MAC address around,
> > just a bunch of pointers, and then we dereference the first of them
> > for the second memcpy(), using the dereferencing macro for a
> > "sockaddr_dl" structure.
>=20
> The problem is that LLVM ASAN does not like access to an unaligned=20
> struct. Even if it just accessing a member to deference it. So you are=20
> right that it is just copying a bunch of pointers, to not triggers the=20
> warning, we have to do this nonsense. The compiler will even optimise=20
> this then away again on platforms that have no problem with unaligned=20
> accesses.

With ifr being a structure now, it is aligned just fine - I'm not objecting
to that part, just to the intermediate "sdl" thing, and the double
memcpy(), and 10 lines of comments.

> > FreeBSD also has
> >
> > #define IF_LLADDR(ifp)                                                 =
 \
> >      LLADDR((struct sockaddr_dl *)((ifp)->if_addr->ifa_addr))
> >
> > which sounds like "feed in an *ifr, out comes a pointer for the
> > memcpy() to rgi->addr".
>=20
> Yes but you will still get warning about casting a smaller struct to a=20
> larger struct and that being a bad idea.

This is not casting a struct, just casting a pointer.  Does it still
warn?

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--ZN4zre6DmlKneuw8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJj+4W9AAoJEB2Cnv7KVigSBzUL/RiNb6FD/NiaIEaKRKK+Yl2m
9qwcdnB6AB9SeC9qzz7pkBaWo+FD2sFFI0DBskqONUymAAxifcsbwEHXkjz+442Z
GBxjKVDt/2pvpDnqOkr5y35qgrzKT/h2fstYXOG8hH320ji+rQuVTszxld88zLIw
URDNBeknXzERqKViTspPFYdpKCXTyRPkYyog2yL2cdNNrYJG/unoLOTyl0F8V2z6
olDuQB9Ksxh46a8wwM2UOtOo6TGLmEsCLDj6p0BPN3+G3G480bhNQaTlRlnDKdWt
KWYBspN0JIigRS6MLqtrvBOOQjmxKtuitj/B6Pt1iLSTuY4tmh+zrGatuqmNAmzm
4UOQfLjsJyet2BSU0TRBqKiIz8d6fEunEj7o6PDBTO0hAzW95zFfLbKykY9hIiqM
+WNCToETWNt6sN9fyhXRtWbU1at3ridgLXu0JhVBFEfAeqdPYML2hk294326CEM0
fnno2OzQm4sLx1cc9hUR0M4uqvzwVnhkOypqIwySLQ==
=9NCY
-----END PGP SIGNATURE-----

--ZN4zre6DmlKneuw8--

