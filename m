From: Kristof Provost <kprovost@...2661...>
Date: Mon, 08 Aug 2022 16:35:22 +0200
Message-ID: <DC1DEB99-2EFF-4F0A-9A62-B6143286169B@...2661...>
In-Reply-To: <20220808143424.65924-2-kprovost@...2661...>
References: <20220808143424.65924-1-kprovost@...2661...>
 <20220808143424.65924-2-kprovost@...2661...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] Handle exceeding 'max-clients'
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
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Apologies,

This patch isn=E2=80=99t part of the series (and has in fact already landed=
), but got sent because of a stray patch file in my working tree.

Kristof

On 8 Aug 2022, at 16:34, Kristof Provost wrote:
> From: Kristof Provost <kp@...1376...>
>
> If 'max-clients' is set multi_create_instance() can return NULL (for any
> client that would take us over the client limit).
>
> If mi is NULL we don't add it to the hash map, but we do potentially
> dereference it to increment the session count.
> Do not attempt to do so if 'mi =3D=3D NULL'.
>
> Signed-off-by: Kristof Provost <kprovost@...2661...>
> ---
>  src/openvpn/mudp.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
> index 0810fada..0cbca1a9 100644
> --- a/src/openvpn/mudp.c
> +++ b/src/openvpn/mudp.c
> @@ -241,15 +241,16 @@ multi_get_create_instance_udp(struct multi_context =
*m, bool *floated)
>                          hash_add_fast(hash, bucket, &mi->real, hv, mi);
>                          mi->did_real_hash =3D true;
>                          multi_assign_peer_id(m, mi);
> -                    }
> -                    /* If we have a session id already, ensure that the
> -                     * state is using the same */
> -                    if (session_id_defined(&state.server_session_id)
> -                        && session_id_defined((&state.peer_session_id)))
> -                    {
> -                        mi->context.c2.tls_multi->n_sessions++;
> -                        struct tls_session *session =3D &mi->context.c2.=
tls_multi->session[TM_ACTIVE];
> -                        session_skip_to_pre_start(session, &state, &m->t=
op.c2.from);
> +
> +                        /* If we have a session id already, ensure that =
the
> +                         * state is using the same */
> +                        if (session_id_defined(&state.server_session_id)
> +                            && session_id_defined((&state.peer_session_i=
d)))
> +                        {
> +                            mi->context.c2.tls_multi->n_sessions++;
> +                            struct tls_session *session =3D &mi->context=
.c2.tls_multi->session[TM_ACTIVE];
> +                            session_skip_to_pre_start(session, &state, &=
m->top.c2.from);
> +                        }
>                      }
>                  }
>                  else
> --=20
> 2.37.0

