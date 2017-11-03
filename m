Date: Fri, 3 Nov 2017 19:27:53 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20171103182753.GQ958@...1296...>
References: <1508751613-23728-1-git-send-email-steffan.karger@...1435...>
 <20171103182433.GP958@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Q4RbCnAmn9VrkE5p"
Content-Disposition: inline
In-Reply-To: <20171103182433.GP958@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] make struct key * argument of
 init_key_ctx const
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

--Q4RbCnAmn9VrkE5p
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Nov 03, 2017 at 07:24:33PM +0100, Gert Doering wrote:
> On Mon, Oct 23, 2017 at 11:40:13AM +0200, Steffan Karger wrote:
> > This can be const, and should thus be const.  (Also, resolves a compiler
> > warning.)
[..]
> I think the patch is good, but it *so* does not apply for me...
>=20
> Applying: make struct key * argument of init_key_ctx const
> error: patch failed: src/openvpn/crypto.c:826
> error: src/openvpn/crypto.c: patch does not apply
> error: patch failed: src/openvpn/crypto.h:321
> error: src/openvpn/crypto.h: patch does not apply

Looked at the first two occurences, and the confusion is explained - this
change is already in "master" but not in 2.4

master/crypto.h

void init_key_ctx(struct key_ctx *ctx, const struct key *key,
                  const struct key_type *kt, int enc,
                  const char *prefix);

2.4/crypto.h

void init_key_ctx(struct key_ctx *ctx, struct key *key,
                  const struct key_type *kt, int enc,
                  const char *prefix);

I'm too lazy to trace which patch changed master, and did not get=20
cherrypicked to 2.4 - but this is reasonable to apply to 2.4 (-only),
so I will :-) - ACK.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--Q4RbCnAmn9VrkE5p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZ/LUoAAoJEB2Cnv7KVigS0HIMALI9JqYOHRUthzg9p51pUrmU
+sbGCsWzjZzH3N4D++KMkRHu3tUhS4z8FnIgXzh2VExSEkLRdMWzwPlr7ODYsoWK
3Xr6X8scD0828j5UTz+55ak/6+YHpZbQzoYKsEFvrh1QAXQUX+71e3iisuJnTVik
BJikOEt+xWFDP+fOXna0fyiJKepJNC62eTzOmYxQ2C4oErzvgEfOEVadDHnqwhXQ
iYEyz85P3erDp5FDSZSHxHAGB9ot1aSRa2T/PDjPavNtR2eSFb+6+OGL3YP6Mgnm
vAcb/TTbFioJbTrTgNcNXOZKfgTVWgHbaIwTrcj16HcIOjCNvdudx/dk7m9+GJeI
T6jtLb0aF0/7xOyr562HzAPpZTW0C9onbsbEV4qgqqmT9gDz8lGDVPS4oDpFddsi
+lRi7ZhaEsNzB6FivYAnA0JWhluyEn/O34Hqtn39N79FJVlZ07cY8Iv3G8RZbT5g
NlJ/9TUiVfCxXDQ6j1pRkH5YaOAyD4GRgfZxVSCjeg==
=g/LH
-----END PGP SIGNATURE-----

--Q4RbCnAmn9VrkE5p--

