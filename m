Date: Tue, 3 May 2022 12:09:22 +0200 (CEST)
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <1543037189.38645.1651572562179@...2642...>
In-Reply-To: <20220422142953.3805364-15-arne@...1227...>
References: <20220422134038.3801239-1-arne@...1227...>
 <20220422142953.3805364-1-arne@...1227...>
 <20220422142953.3805364-15-arne@...1227...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 24/28] Extract
 read_incoming_tls_plaintext into its own function
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

NACK, compile error.

> Arne Schwabe <arne@...1227...> hat am 22.04.2022 16:29 geschrieben:
>=20
>=20=20
> This makes the tls_process_state function a bit easier to read allows

missing "and" after read?

> extending the read_incoming_tls_plaintext function later without
> making tls_process_state even longer.
> ---
>  src/openvpn/ssl.c | 38 +++++++++++++++++++++++---------------
>  1 file changed, 23 insertions(+), 15 deletions(-)
>=20
> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> index e3101c7fa..01717559c 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
> @@ -2612,6 +2612,28 @@ control_packet_needs_wkc(const struct key_state *k=
s)
>             && (ks->send_reliable->packet_id =3D=3D 1);
>  }
>=20=20
> +static bool
> +read_incoming_tls_plaintext(struct buffer *buf, struct key_state *ks, in=
terval_t *wakeup)
> +{
> +    ASSERT(buf_init(buf, 0));
> +    int status =3D key_state_read_plaintext(&ks->ks_ssl, buf, TLS_CHANNE=
L_BUF_SIZE);
> +    update_time();
> +    if (status =3D=3D -1)
> +    {
> +        msg(D_TLS_ERRORS, "TLS Error: TLS object -> incoming plaintext r=
ead error");
> +        return false;
> +    }
> +    if (status =3D=3D 1)
> +    {
> +        *state_change =3D true;

ssl.c: In function =E2=80=98read_incoming_tls_plaintext=E2=80=99:
ssl.c:2628:10: error: =E2=80=98state_change=E2=80=99 undeclared (first use =
in this function); did you mean =E2=80=98state_name=E2=80=99?
 2628 |         *state_change =3D true;
      |          ^~~~~~~~~~~~
      |          state_name

> +        dmsg(D_TLS_DEBUG, "TLS -> Incoming Plaintext");
> +
> +        /* More data may be available, wake up again asap to check. */
> +        *wakeup =3D 0;
> +    }
> +    return true;
> +}
> +
>=20=20
>  static bool
>  tls_process_state(struct tls_multi *multi,

Regards,
--
Frank Lichtenheld

