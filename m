From: Antonio Quartulli <a@...2181...>
References: <1498913642-32459-3-git-send-email-steffan.karger@...1435...>
 <1510236133-6926-1-git-send-email-steffan.karger@...1435...>
Message-ID: <d19475e8-d4b4-56ac-7899-53b3aec2d4f3@...2181...>
Date: Fri, 29 Dec 2017 06:51:11 +0800
MIME-Version: 1.0
In-Reply-To: <1510236133-6926-1-git-send-email-steffan.karger@...1435...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="rqBScKdis27vNNQ56RTBnAMJotumyO5SF"
Subject: Re: [Openvpn-devel] [PATCH 3/5 v2]
 buffer_list_aggregate_separator(): don't exceed max_len
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rqBScKdis27vNNQ56RTBnAMJotumyO5SF
Content-Type: multipart/mixed; boundary="WIfHoSbC1m2uZyXzO3HemmIa2roJ7aHoq";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Steffan Karger <steffan.karger@...1435...>,
 openvpn-devel@lists.sourceforge.net
Message-ID: <d19475e8-d4b4-56ac-7899-53b3aec2d4f3@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 3/5 v2] buffer_list_aggregate_separator():
 don't exceed max_len
References: <1498913642-32459-3-git-send-email-steffan.karger@...1435...>
 <1510236133-6926-1-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1510236133-6926-1-git-send-email-steffan.karger@...1435...>

--WIfHoSbC1m2uZyXzO3HemmIa2roJ7aHoq
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 09/11/17 22:02, Steffan Karger wrote:
> buffer_list_aggregate_separator() would merge buffer_list entries until it
> had exceeded the provided max_len, instead of stopping *before* exceeding
> the max value.
>=20
> Signed-off-by: Steffan Karger <steffan.karger@...1435...>
> ---
> v2: rebase on 1/5 v2 (other patches should still apply)
>=20
>  src/openvpn/buffer.c                   | 17 +++++++++++++----
>  src/openvpn/buffer.h                   |  2 +-
>  tests/unit_tests/openvpn/test_buffer.c | 11 +++++++----
>  3 files changed, 21 insertions(+), 9 deletions(-)
>=20
> diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
> index 583c5c7..f72d525 100644
> --- a/src/openvpn/buffer.c
> +++ b/src/openvpn/buffer.c
> @@ -1231,7 +1231,8 @@ buffer_list_peek(struct buffer_list *ol)
>  }
>=20=20
>  void
> -buffer_list_aggregate_separator(struct buffer_list *bl, const size_t max=
, const char *sep)
> +buffer_list_aggregate_separator(struct buffer_list *bl, const size_t max=
_len,
> +                                const char *sep)
>  {
>      int sep_len =3D strlen(sep);
>=20=20
> @@ -1240,10 +1241,18 @@ buffer_list_aggregate_separator(struct buffer_lis=
t *bl, const size_t max, const
>          struct buffer_entry *more =3D bl->head;
>          size_t size =3D 0;
>          int count =3D 0;
> -        for (count =3D 0; more && size <=3D max; ++count)
> +        for (count =3D 0; more; ++count)
>          {
> -            size +=3D BLEN(&more->buf) + sep_len;
> -            more =3D more->next;
> +            size_t extra_len =3D BLEN(&more->buf) + sep_len;
> +            if (size + extra_len <=3D max_len)
> +            {
> +                size +=3D extra_len;
> +                more =3D more->next;
> +            }
> +            else
> +            {
> +                break;
> +            }

The code looks correct as it simply changes the looping condition and
moves it inside the loop to stay below the 80chars.

However, my taste would suggest to change the inner if-else block as
follows:

if (condition)
{
    break;
}

rest;


simply to avoid non-needed indentation and follow the usual "this is
bad, we can't continue, thus go away" logic.

But again, this is just my taste. Other maintainers can decide what is
better.

>          }
>=20=20
>          if (count >=3D 2)
> diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
> index 1ed5631..499c75e 100644
> --- a/src/openvpn/buffer.h
> +++ b/src/openvpn/buffer.h
> @@ -1102,7 +1102,7 @@ void buffer_list_pop(struct buffer_list *ol);
>=20=20
>  void buffer_list_aggregate(struct buffer_list *bl, const size_t max);
>=20=20
> -void buffer_list_aggregate_separator(struct buffer_list *bl, const size_=
t max, const char *sep);
> +void buffer_list_aggregate_separator(struct buffer_list *bl, const size_=
t max_len, const char *sep);

why not going on a new line now that you are touching it? (I know it
exceeded 80 chars even before your change)

>=20=20
>  struct buffer_list *buffer_list_file(const char *fn, int max_line_len);
>=20=20
> diff --git a/tests/unit_tests/openvpn/test_buffer.c b/tests/unit_tests/op=
envpn/test_buffer.c
> index f5830a1..99e6530 100644
> --- a/tests/unit_tests/openvpn/test_buffer.c
> +++ b/tests/unit_tests/openvpn/test_buffer.c
> @@ -135,13 +135,16 @@ static void
>  test_buffer_list_aggregate_separator_two(void **state)
>  {
>      struct test_buffer_list_aggregate_ctx *ctx =3D *state;
> +    const char *expected =3D teststr1 testsep teststr2 testsep;
>=20=20
> -    /* Aggregate the first two elements */
> -    /* FIXME this exceeds the supplied max */
> -    buffer_list_aggregate_separator(ctx->one_two_three, 4, testsep);
> +    /* Aggregate the first two elements
> +     * (add 1 to max_len to test if "three" is not sneaked in too)
> +     */
> +    buffer_list_aggregate_separator(ctx->one_two_three, strlen(expected)=
+1,
> +                                    testsep);

Like in the previous patch, the '+' should be surrounded by spaces.

>      assert_int_equal(ctx->one_two_three->size, 2);
>      struct buffer *buf =3D buffer_list_peek(ctx->one_two_three);
> -    assert_buf_equals_str(buf, teststr1 testsep teststr2 testsep);
> +    assert_buf_equals_str(buf, expected);
>  }
>=20=20
>  static void
>=20

Another FIXME thrown away :-)

For the code correctness:

Acked-by: Antonio Quartulli <a@...2181...>


Cheers,

--=20
Antonio Quartulli



--WIfHoSbC1m2uZyXzO3HemmIa2roJ7aHoq--

--rqBScKdis27vNNQ56RTBnAMJotumyO5SF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlpFdV8ACgkQB6U8WA7y
zXQkLA/+MXL0G4PkZ/idyMUEWkX557aUW8y02BN1W/SpHjL+79Pee8efx6UnxQNR
jr1V2/AIHwC+ysYjesForOTXUvjPdebh5HiQvt9TMGFg/MHGfi0Vqba73UHF0LqS
KkqDxli9PGmECeDkz7TvUBKphHFiR6XMGbL2ML/zbzm8XU1WlTpKVTo1TMZwdx1/
jSLNgCYPvAwx1KB0knExYDpW0qPVe2IoNwiBq9ry+ghiQq7lcKLfeglb1kD4mdPS
NKF0vSHxbcHBS04aEKH2NLrfPN51x4iyxMhwIyHFIkvdifLkikA1etmmYZaONSSQ
Sx/peIltnRu0AZNfbF7zeoqL2Ao1JUhaqXAUdBYs3jYLSBgoSWlfVrOn0OP2NaIS
1Wm26MoWcMrug1eM7no4FK8iurcROaQ3/0LypfZVCUi+bJRGGEd88Rnd7fsUCCkT
SASTTieF5e4viKC2J5dg+f+NL6uoRSSBEWjEjhyMptZywIS5PJdcy8zX2KPJcddl
dTbWjPfPWRk0SM4Dhtp4xzGiWl5JH2p1gBCiUkRiUh/GZFEaEdf1beZgrla1OF24
Wq39ie4+DGJHSt8rSTG+6ZH5ajffw9/ewnWxQfGiec2H8xg1KGNMYkra4nVbIzEt
xvoaexwZD6tEeXFnQO37k7UHbxPPk/ceaoCAbnoReX9i6rKpQ1E=
=f49h
-----END PGP SIGNATURE-----

--rqBScKdis27vNNQ56RTBnAMJotumyO5SF--

