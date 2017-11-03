Date: Fri, 3 Nov 2017 19:24:33 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20171103182433.GP958@...1296...>
References: <1508751613-23728-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="kY0AMSsGPnDJoAXR"
Content-Disposition: inline
In-Reply-To: <1508751613-23728-1-git-send-email-steffan.karger@...1435...>
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

--kY0AMSsGPnDJoAXR
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Oct 23, 2017 at 11:40:13AM +0200, Steffan Karger wrote:
> This can be const, and should thus be const.  (Also, resolves a compiler
> warning.)
>=20
> Signed-off-by: Steffan Karger <steffan.karger@...1435...>
> ---
>  src/openvpn/crypto.c         | 2 +-
>  src/openvpn/crypto.h         | 2 +-
>  src/openvpn/crypto_backend.h | 2 +-
>  src/openvpn/crypto_mbedtls.c | 2 +-
>  src/openvpn/crypto_openssl.c | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)

I think the patch is good, but it *so* does not apply for me...

Applying: make struct key * argument of init_key_ctx const
error: patch failed: src/openvpn/crypto.c:826
error: src/openvpn/crypto.c: patch does not apply
error: patch failed: src/openvpn/crypto.h:321
error: src/openvpn/crypto.h: patch does not apply
error: patch failed: src/openvpn/crypto_backend.h:334
error: src/openvpn/crypto_backend.h: patch does not apply
error: patch failed: src/openvpn/crypto_mbedtls.c:563
error: src/openvpn/crypto_mbedtls.c: patch does not apply
error: patch failed: src/openvpn/crypto_openssl.c:677
error: src/openvpn/crypto_openssl.c: patch does not apply
Patch failed at 0001 make struct key * argument of init_key_ctx const

what tree is this based on...?

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--kY0AMSsGPnDJoAXR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZ/LRUAAoJEB2Cnv7KVigSHVgMAKnPOqMtSAs6ySTMXtvjy2X6
jwDlJZOqkHqbo1nUnz3wurWIp6JuIUJCux892P4YnHlU1QbHwFSm8hkryeT85aX1
pLu9tyUstF1P63HqTm4Tt1qKTQiETzeE1Tvg8jgLUtUd1LXSP92YCvGcuGLjIGXB
X5kBn2sjJ76LJpJ1p4DJKcR6DPKCHVKj6NAxEHPYf32GgMrrVu23c2b/cPsLmY/w
rTv80/y+OHozC474OZCmN18HgJ76AUXTKRcsww7CDppClmnZuNQsR1/26OCLp+QZ
Z4ZkNitj0xpJJyskgpV6eAayszJyAqWWAMepkTU7W7c6y4zkOtH1HHCqACyw832T
8qCNn81tSGZfRy9HdBoNmpN8oEYzqqsR+BJrkSQStAtY29Bni3dpaHIAjhMRH4P5
H1Cx+HwF7DnG3ekT/q2X66XivKO32ENZgOw7kXJtfZO57fXK5k4c4bwZsRhRfu93
92sOakwiK3OE7AsQoOoeMndU0+Ts7DmDBwneOlCpRA==
=LhPJ
-----END PGP SIGNATURE-----

--kY0AMSsGPnDJoAXR--

