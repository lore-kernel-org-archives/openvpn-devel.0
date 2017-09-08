References: <20170907022827.10658-1-davids@...515...>
 <20170907172004.22534-1-davids@...515...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <a9189aa3-f5a0-8204-6656-956325a06aa4@...2181...>
Date: Fri, 8 Sep 2017 09:42:02 +0800
MIME-Version: 1.0
In-Reply-To: <20170907172004.22534-1-davids@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ODKolUcGW6f39w6je5LUF7h1je4Pk5Ajo"
Subject: Re: [Openvpn-devel] [PATCH v2] lz4: Move towards a newer LZ4 API
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...515...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ODKolUcGW6f39w6je5LUF7h1je4Pk5Ajo
Content-Type: multipart/mixed; boundary="pcFx0LwVMWhnoUi7xmM428w1Sqwrh9qHC";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: David Sommerseth <davids@...515...>, openvpn-devel@lists.sourceforge.net
Message-ID: <a9189aa3-f5a0-8204-6656-956325a06aa4@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v2] lz4: Move towards a newer LZ4 API
References: <20170907022827.10658-1-davids@...515...>
 <20170907172004.22534-1-davids@...515...>
In-Reply-To: <20170907172004.22534-1-davids@...515...>

--pcFx0LwVMWhnoUi7xmM428w1Sqwrh9qHC
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 08/09/17 01:20, David Sommerseth wrote:

[CUT]

> diff --git a/src/openvpn/comp-lz4.c b/src/openvpn/comp-lz4.c
> index e056caa8..bdb3247d 100644
> --- a/src/openvpn/comp-lz4.c
> +++ b/src/openvpn/comp-lz4.c
> @@ -43,6 +43,7 @@
>=20=20
>  #include "memdbg.h"
>=20=20
> +
>  static void
>  lz4_compress_init(struct compress_context *compctx)
>  {
> @@ -86,7 +87,7 @@ do_lz4_compress(struct buffer *buf,
>              return false;
>          }
>=20=20
> -        zlen =3D LZ4_compress_limitedOutput((const char *)BPTR(buf), (ch=
ar *)BPTR(work), BLEN(buf), zlen_max );
> +        zlen =3D LZ4_compress_default((const char *)BPTR(buf), (char *)B=
PTR(work), BLEN(buf), zlen_max );

while at it, could you remove the annoying space between the last
argument and the closing parenthesis? (you or the committer)

Cheers,

>=20=20
>          if (zlen <=3D 0)
>          {
>=20

--=20
Antonio Quartulli


--pcFx0LwVMWhnoUi7xmM428w1Sqwrh9qHC--

--ODKolUcGW6f39w6je5LUF7h1je4Pk5Ajo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEbd2mMhAXbmSCipS40+HICM1soFAFAlmx9WoACgkQ0+HICM1s
oFCL1w//eTSqukn9r61efKFQSMC5G6zoiVz9fq6zBTwHDvJovLkV5yW0+i8HG8gv
5t1MlT2Yn+dNrtq8384pDTgcksjHve7RkBQSYmtQnu5du/+2sAgIfYyKQK3dJQc+
issEmH+/QLFb3AE/wq1HW1JFQtzWH0n58K6rzyWFOLiQXAHA0fqOnHHwJrivFvh7
KSjzfN5p6u9O+ZP5n6xpXFUrj/8zUrh1rlqXJhfqg1k9MH/Iv7P6S9PJ9gOG9/vn
0nBfyS3jp8bg28OtfUaHw6a5bmkKiw0TCO4zLNEHutjvl51HkMNWAtw1VLS3K5Qx
acNulQeQ2mUAY6I/xC30S2gPh49gZHTRdwcudlATXAaLBbKE9Q8uzIPD51BHmS/9
muneMWxi2F0fbrFvnnKOFFEdavy9U3LeyvyKacmys29C8xp+IZcp2E3O5/VU7IPr
bR3+qXV9L+sPPZjWYtV92+X/aGEonntH1GSKUPDIjgP1wqDlS0sWv6fnDVczFwzK
CeIlRFjdjEleGSbl238JNwcA0ksFTxby76tIESWtr0woaH9+frQN/AMZn/vPZ4rL
5mtYrtHHyFyC3ksBDQ1NM8olKipAYpDq/HcHcAd1bF8YF/4zzFpoliIi7xEVfj71
sNHvugWSHgoHMCu1H047ty6aS0Onp/H7paSjrXeo1R+GR8uJ6D0=
=kK36
-----END PGP SIGNATURE-----

--ODKolUcGW6f39w6je5LUF7h1je4Pk5Ajo--

