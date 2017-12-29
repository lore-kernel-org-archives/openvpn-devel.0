References: <1512724338-22197-1-git-send-email-steffan@...1856...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <03ea2fd3-c3eb-ae11-7208-9f33565f24d9@...2181...>
Date: Fri, 29 Dec 2017 17:39:54 +0800
MIME-Version: 1.0
In-Reply-To: <1512724338-22197-1-git-send-email-steffan@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="zd626rQZpYTPTEYIGGWCmaBwdjjExAcUW"
Subject: Re: [Openvpn-devel] [PATCH] Fix memory leak in buffer unit tests
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zd626rQZpYTPTEYIGGWCmaBwdjjExAcUW
Content-Type: multipart/mixed; boundary="0WV3VcOaYL9lhS3thoZayeYaHb8a5zZGN";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net
Message-ID: <03ea2fd3-c3eb-ae11-7208-9f33565f24d9@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] Fix memory leak in buffer unit tests
References: <1512724338-22197-1-git-send-email-steffan@...1856...>
In-Reply-To: <1512724338-22197-1-git-send-email-steffan@...1856...>

--0WV3VcOaYL9lhS3thoZayeYaHb8a5zZGN
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 08/12/17 17:12, Steffan Karger wrote:
> buffer_list_push_data does not take ownership of the memory, so just feed
> it stack data to plug the leak.
>=20
> Signed-off-by: Steffan Karger <steffan@...1856...>

as reported by Steffan, buffer_list_push_data() takes the content of the
buffer passed as argument and copies it in a new buffer. Thus the
ownership of that argument still belongs to the caller which is
responsible for releasing it.

Using stack data just fixes the issue.

Acked-by: Antonio Quartulli <a@...2181...>

Aside from this patch, I just noted that buffer_list_push_data() suffers
from the same problem as buffer_list_aggregate_separator().
The caller could pass size=3D0 as argument, thus leading to a 0-byte
malloc. This should probably be fixed with an additional patch.

Cheers,

> ---
>  tests/unit_tests/openvpn/test_buffer.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/tests/unit_tests/openvpn/test_buffer.c b/tests/unit_tests/op=
envpn/test_buffer.c
> index ba5aa67..c2b7f30 100644
> --- a/tests/unit_tests/openvpn/test_buffer.c
> +++ b/tests/unit_tests/openvpn/test_buffer.c
> @@ -77,10 +77,9 @@ static int test_buffer_list_setup(void **state)
>      buffer_list_push(ctx->zero_length_strings, "");
>=20=20
>      ctx->empty_buffers =3D buffer_list_new(2);
> -    uint8_t *data1 =3D malloc(1);
> -    uint8_t *data2 =3D malloc(1);
> -    buffer_list_push_data(ctx->empty_buffers, data1, 0);
> -    buffer_list_push_data(ctx->empty_buffers, data2, 0);
> +    uint8_t data =3D 0;
> +    buffer_list_push_data(ctx->empty_buffers, &data, 0);
> +    buffer_list_push_data(ctx->empty_buffers, &data, 0);
>=20=20
>      *state =3D ctx;
>      return 0;
>=20

--=20
Antonio Quartulli


--0WV3VcOaYL9lhS3thoZayeYaHb8a5zZGN--

--zd626rQZpYTPTEYIGGWCmaBwdjjExAcUW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlpGDWsACgkQB6U8WA7y
zXSDmA//fBrSzMMTAiVvLQu8XVLk9rWFtwPmud8xyBALimPgAmdthG9hy3RWpeRA
ZOQhmNr12S/R2SiIaCNlroWMRHL6MDGaedumUl3FDnq3KSKAAN1IEOA6qj4KoR94
rEiJI8AAYNKmI4qSUst1VRY1TNIfZqoSFj8ip/RxiURy4FKw1WXrabTNtctrr0wf
hV3HQ/3XUAyaEZLKAYMCy8uptJEK16sofq/MzZOOxCpxeS+FR6e25OSnT7soHvQu
a4GDcKedntKTG5UWLDE5hZE8XpdZA1liVnoS1+U6y0qW1HaWYCz6AajJtgtVANLs
ncC0ozrcZOQ0+0qWz4JokYjEKlMcaTpN8DFg5lXpvkzKyuv+Dtc63iwM7mM0kwMD
lWVV+coa3sLDdjYe+5orlzSQB+atwTU3Z7GGyz7uaT0zg4L279VcKaZ2KMOWaTe6
jSo3YIYqRdSi6gMXJ1WMnXIgdfyZwsYW90qmei256jGkEAZub2RjjuPJ7jEbDOUe
kSHgXI6cMU5Ecp7F8A/HnjG2gCbYL8YZCwMpF+TVbEhnxSe4FvuGEl7g1sub79x8
CSQKJAF9uDTlpCph9eb3DRIIIUYIPbZ/qvClChs6CNTRc8BpNC5gtQJ0p7T9/VQb
AufAetTQP/ydMO9q5VUAR7vwnNsqs0fNWdhI+jjGmXx4kJQ3aw0=
=WOwb
-----END PGP SIGNATURE-----

--zd626rQZpYTPTEYIGGWCmaBwdjjExAcUW--

