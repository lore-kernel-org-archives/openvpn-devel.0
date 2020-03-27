References: <20191109151306.18597-1-arne@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <fe900dd6-ea47-af72-d055-f741d0214f1f@...2080...>
Date: Fri, 27 Mar 2020 16:31:25 +0100
MIME-Version: 1.0
In-Reply-To: <20191109151306.18597-1-arne@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="gcwFXpznsbMxvXEUWMwUm1FIYvE3eypM9"
Subject: Re: [Openvpn-devel] [PATCH v2 1/5] Implement parsing and sending
 INFO and INFO_PRE control messages
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gcwFXpznsbMxvXEUWMwUm1FIYvE3eypM9
Content-Type: multipart/mixed; boundary="1xLyC3bFeDKY4HXQhggnBY9aH2YhqY1VB";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net
Message-ID: <fe900dd6-ea47-af72-d055-f741d0214f1f@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v2 1/5] Implement parsing and sending INFO
 and INFO_PRE control messages
References: <20191109151306.18597-1-arne@...1227...>
In-Reply-To: <20191109151306.18597-1-arne@...1227...>

--1xLyC3bFeDKY4HXQhggnBY9aH2YhqY1VB
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 09/11/2019 16:13, Arne Schwabe wrote:
> OpenVPN 3 implements these messages to send information during the
> authentication to the UI, implement these message also in OpenVPN 2.x
>=20
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  src/openvpn/forward.c |  8 ++++++++
>  src/openvpn/push.c    | 33 +++++++++++++++++++++++++++++++++
>  src/openvpn/push.h    |  3 +++
>  3 files changed, 44 insertions(+)
>=20
> diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
> index 8451706b..0f735384 100644
> --- a/src/openvpn/forward.c
> +++ b/src/openvpn/forward.c
> @@ -395,6 +395,14 @@ check_incoming_control_channel_dowork(struct context=
 *c)
>              {
>                  server_pushed_signal(c, &buf, false, 4);
>              }
> +            else if (buf_string_match_head_str(&buf, "INFO_PRE"))
> +            {
> +                server_pushed_info(c, &buf, 8);
> +            }
> +            else if (buf_string_match_head_str(&buf, "INFO"))
> +            {
> +                server_pushed_info(c, &buf, 4);
> +            }
>              else
>              {
>                  msg(D_PUSH_ERRORS, "WARNING: Received unknown control me=
ssage: %s", BSTR(&buf));
> diff --git a/src/openvpn/push.c b/src/openvpn/push.c
> index 368b6920..ee1cb980 100644
> --- a/src/openvpn/push.c
> +++ b/src/openvpn/push.c
> @@ -178,6 +178,39 @@ server_pushed_signal(struct context *c, const struct=
 buffer *buffer, const bool
>      }
>  }
>=20=20
> +void
> +server_pushed_info(struct context *c, const struct buffer *buffer,
> +                   const int adv)
> +{
> +    const char *m =3D "";
> +    struct buffer buf =3D *buffer;
> +
> +    if (buf_advance(&buf, adv) && buf_read_u8(&buf) =3D=3D ',' && BLEN(&=
buf))
> +    {
> +        m =3D BSTR(&buf);
> +    }
> +
> +#ifdef ENABLE_MANAGEMENT
> +    struct gc_arena gc;
> +    if (management)
> +    {
> +        gc =3D gc_new();
> +
> +        /*
> +         * We use >INFOMSG here instead of plain >INFO since INFO is use=
d to
> +         * for management greeting and we don't want to confuse the clie=
nt
> +         */
> +        struct buffer out =3D alloc_buf_gc(256, &gc);
> +        buf_printf(&out, ">%s:%s", "INFOMSG", m);
> +        management_notify_generic(management, BSTR(&out));
> +
> +        gc_free(&gc);
> +    }
> +    #endif

The indent of this #endif is wrong.  Wouldn't harm with an "/*
ENABLE_MANAGEMENT */" comment as well.  This could be fixed at merge time.

Otherwise, this looks good.

Acked-By: David Sommerseth <davids@...515...>


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--1xLyC3bFeDKY4HXQhggnBY9aH2YhqY1VB--

--gcwFXpznsbMxvXEUWMwUm1FIYvE3eypM9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJefhxNAAoJEIbPlEyWcf3y2EsQAJoKQSi3bzewt3B+B/ZYXZ4R
BZTDuev6v9kbVpoe6M/F6QT6KfUsg0EeBlZHtwZ4EE540xZvFnf4h4tTutDMN+RB
969sLdujl5ak0VgKLcO5EHAZwi6/cbacd9bv/C7TLbXrNprzGO9ykWx3xBVxM4UJ
6av+dylVZvp1oX44tMYFJlIA2bCT/z3POM8N/tyz+yqrmcIxRThpMeI9L5PQb0nl
gRiqtkqw4JjE06OfUzm3OQt0SZA1OF9vrHha1WXlSRILUo4V14LETM11eHc93JaM
9+CLsIH4OpuP6xE2tESHVAwWtAgmVznxwSc9ceX8GrsKJnUDALbI1BMwa4yUmibz
8RDv1jKyjnSj/EBKQ+B3fJ6bNClMT9NJC8j9mBJyYwZWNPMNeZDfak/TX5659p4p
nsjcjiFsFe3AUoe2hvpJ8u4zmhJQGsmrSe7jTSfEiiB1APo0h4AymAWHO5jz/v/3
LqN1bS9dux06upJJ9Sgkelac8LBH+JoN4jS0o0mkD/nyWdiL5n3EhMqn6q9/O19L
egFVylnDuo6JvY+77G4Cun3e7kwyyGpRgmkA8Gfv0EhbwTrggsH14WrMUvLjKI9c
hHqTTr15Z5AT99JRb6oRBOifzew2rap2DT2HXKNnoN8kMIB7P6gUZhgP6uvp2k/1
XrovO/aF3hamOKSLDPaS
=v1wq
-----END PGP SIGNATURE-----

--gcwFXpznsbMxvXEUWMwUm1FIYvE3eypM9--

