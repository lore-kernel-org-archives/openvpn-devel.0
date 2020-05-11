References: <20200508212356.18522-1-a@...2181...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <bbdf076c-0a93-07e5-afca-acd0021c0cf6@...2080...>
Date: Mon, 11 May 2020 14:21:10 +0200
MIME-Version: 1.0
In-Reply-To: <20200508212356.18522-1-a@...2181...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="YkMbWwij09RtGeASPTfw01UoBZhSYdflG"
Subject: Re: [Openvpn-devel] [PATCH] get rid of TAG_FILE_INLINE constant
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YkMbWwij09RtGeASPTfw01UoBZhSYdflG
Content-Type: multipart/mixed; boundary="ece3ng3aH9kiREQJQi4Pqu0Z39zivGh0x";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net
Message-ID: <bbdf076c-0a93-07e5-afca-acd0021c0cf6@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] get rid of TAG_FILE_INLINE constant
References: <20200508212356.18522-1-a@...2181...>
In-Reply-To: <20200508212356.18522-1-a@...2181...>

--ece3ng3aH9kiREQJQi4Pqu0Z39zivGh0x
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 08/05/2020 23:23, Antonio Quartulli wrote:
> Now that the whole inline logic has been converted to using bool flags,
> the TAG_FILE_INLINE constant is not useful anymore.
>=20
> Get rid of the constant as it's now unused and to prevent any future
> developer from mistakenly use it again.
>=20
> Signed-off-by: Antonio Quartulli <a@...2181...>
> ---
>=20
> to be applied after all other fixes, as they remove the few last usages
> of this constant.
>=20
>=20
>  src/openvpn/common.h | 6 ------
>  src/openvpn/crypto.c | 2 +-
>  2 files changed, 1 insertion(+), 7 deletions(-)
>=20
> diff --git a/src/openvpn/common.h b/src/openvpn/common.h
> index 4e6f4809..623b3e0d 100644
> --- a/src/openvpn/common.h
> +++ b/src/openvpn/common.h
> @@ -88,12 +88,6 @@ typedef unsigned long ptr_type;
>   */
>  #define PUSH_REQUEST_INTERVAL 5
>=20=20
> -/*
> - * A sort of pseudo-filename for data provided inline within
> - * the configuration file.
> - */
> -#define INLINE_FILE_TAG "[[INLINE]]"
> -
>  /*
>   * Script security warning
>   */
> diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
> index 672aa14a..f1a52d8c 100644
> --- a/src/openvpn/crypto.c
> +++ b/src/openvpn/crypto.c
> @@ -1189,7 +1189,7 @@ print_key_filename(const char *str, bool is_inline)
>  {
>      if (is_inline)
>      {
> -        return INLINE_FILE_TAG;
> +        return "[[INLINE]]";
>      }
>=20=20
>      return np(str);
>=20

So with Antonio's explaination in message-id
<6a62b6d2-7870-124f-5b5f-be657ffeb34a@...2181...> and applying message-id
<20200510140017.16837-1-a@...2181...> ([PATCH] tls-crypt-v2: fix testing of
inline key, which I just gave an ACK) before this patch, it is all good.


Acked-by: David Sommerseth <davids@...515...>

--=20
kind regards,

David Sommerseth
OpenVPN Inc



--ece3ng3aH9kiREQJQi4Pqu0Z39zivGh0x--

--YkMbWwij09RtGeASPTfw01UoBZhSYdflG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJeuUM2AAoJEIbPlEyWcf3yrmUP/1aC2M/Jc2ugGivS5Bnfv1Uz
Bw1Ltg3nXbbXncb6SpYN5lpBMLig9dY4YDV/cTuOtQl3qj+Fjt/BNXVsi6qLbqfm
XsFVEJ6JpxbUlb5nMfTV3FKQIZlHhl9HLwOABHPtRkljsZxNE9BILsDJ7/cu9KoR
QBvYU4UVjwY8MCP/t8McFvodUNYst8SETjLefciu2IVLPj4ANM9ZklK4MpKMbhLN
Kw3vVlhYABUWnZU9d4S2+xZRt4qcAwLvJZhEQYrLNGRcllq59E4q4q1oTiMjKCr1
KCIFQA0BPnLczJu7ewZOs8a9olv8fuvMjtxWjOQ1MXEkdBusisdSGwYj3jvN0/kv
oaA2pNUjCRtcvCbI/C/3q+RGcwUX5MKt0Z/9/pT1ZO9R8zhg9qLop/Gg3FEgc/cj
nzgwyDoK5784WniMgwHYquhEjMGtPzhIDzzD8bE09ccmgol0VXYOPaKkiSwmU2cq
7QwDbF2Vbu3FBpxYEA8sK/Ky4R8YBSqZTDUHuhSbpafrmqku6PFnAb4R8iKkxXua
wm9glwfdAczpZwSCW2HBq3An95rKwPsJ+4XhqaoSmi8nCIbjM+GSXJzC/+hmEG+0
JPxJgvNksDR6HzWLSY/SzRD7EeqgAFxjv/RGZPZUrl7Si7MOmY36smIWfMCwPONf
pF/r6shmTRAypHVJXzuI
=roa2
-----END PGP SIGNATURE-----

--YkMbWwij09RtGeASPTfw01UoBZhSYdflG--

