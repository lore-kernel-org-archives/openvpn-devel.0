Date: Sat, 18 Jul 2020 12:00:18 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200718100018.GD1431@...1296...>
References: <20200717134739.21168-1-arne@...1227...>
 <20200717134739.21168-6-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ZPvzLrGZeahB1mXl"
Content-Disposition: inline
In-Reply-To: <20200717134739.21168-6-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 6/9] Remove ENABLE_OCC #define
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--ZPvzLrGZeahB1mXl
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jul 17, 2020 at 03:47:36PM +0200, Arne Schwabe wrote:
> Commit 037669f3dd already made occ being unconditionally on. This commit
> only removes the #ifdefs
>=20
> Signed-off-by: Arne Schwabe <arne@...1227...>

This generally looks good, and does what it says on the tin, so

Acked-By: Gert Doering <gert@...1296...>

I have tried to apply it out of sequence, but that leads to compile-time
errors=20

  ld: ssl.o: in function `key_method_1_write':
         .../ssl.c:2239: undefined reference to `local_options_string'

... so the "remove key-method 1" patch must be applied first.

(This is not a show-stopper, just an explanation why I ACK this and
not merge it right away)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--ZPvzLrGZeahB1mXl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfEsgxAAoJEB2Cnv7KVigS278MAJvnQDchrWFCqYCcpM8TqoBS
vFiGI0kK4QvPNP7Xbmgo87uMbEJlaNZQj6syKem2mow5XjXGodnlTeMiiLQcxP3h
j7u6fZQdIVX6YKTqu2EI2YOsD3DMlqZ5TBhYmqR6qfbVv0ucbKyAmbNHcD5P5r+2
PpSLWwYj6TvxjPYGbQsJIuuTfYw0b2UXMpyumW5Cmw2UupFeUv7kKKRBxl+nSG91
u8dM2Ug1CxcZhdTd5hMt+HSXoPJFmwQVylsw4wP+jHrwdH2huVXNd6VorD/LXqXu
/irDHsTtCGzJb/RumBF35G3JjT1lkvGzH3urgZqbamT1UI1Qs/Hl17m6CpVU13gK
5tRsk/CEyclf/s3SKqiruDtDZc2brD0/KT4hWmfRuaunUJoxvi3PIlmkXQGIofCn
zuA/0YqyQSHf22+J0ahRv0Uqf5r9+Aop4PLqPYdhZzpGc4dmtQL24zAdwpn+5K7l
pxHraNW1VckUuk5um6UmPUEUERGlLTN+DdKsCOiJTg==
=le0e
-----END PGP SIGNATURE-----

--ZPvzLrGZeahB1mXl--

