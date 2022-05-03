Date: Tue, 3 May 2022 11:12:27 +0200 (CEST)
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <1812801850.32102.1651569147848@...2642...>
In-Reply-To: <20220502154310.836947-1-arne@...1227...>
References: <20220422142953.3805364-9-arne@...1227...>
 <20220502154310.836947-1-arne@...1227...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH v3] Implement stateless,
 HMAC basedsesssion id three way handshake
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Acked-By: Frank Lichtenheld <frank@...2641...>

Used this patch to make myself familiar with the OpenVPN RFC documentation
enough to say that this change overall makes sense to me. No further
issues found in the code. Just some more text/whitespace issues, see below.

Compile/UT tested only from my side.

Small issues:

You have ignored my comment about the commit's summary line:
Summary line: "HMAC-based session-id three-way-handshake" maybe? Just to help one parse the word pile ;)

> Arne Schwabe <arne@...1227...> hat am 02.05.2022 17:43 geschrieben:
[...]
> diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
> index e5cc36b45..ead61e827 100644
> --- a/src/openvpn/mudp.c
> +++ b/src/openvpn/mudp.c
> @@ -40,24 +40,81 @@
[...]
> +    else if (verdict == VERDICT_VALID_CONTROL_V1 || verdict == VERDICT_VALID_ACK_V1)
> +    {
> +        /* ACK_V1 contains the peer id (our id) while CONTROL_V1 can but does not
> +         * need to contain the peer id */
> +        struct gc_arena gc = gc_new();
> +
> +        bool ret = check_session_id_hmac(state, from, hmac, handwindow);
> +
> +        const char *peer = print_link_socket_actual(&m->top.c2.from, &gc);
> +        if (!ret)
> +        {
> +
> +            msg(D_MULTI_MEDIUM, "Packet with invalid or missing SID from %s", peer);
> +
> +        }
> +        else
> +        {
> +            msg(D_MULTI_DEBUG, "Valid packet with HMAC challenge from peer (%s), "
> +                               "accepting new connection.", peer);

uncrustify is not happy with this one:
--- "a/src/openvpn/mudp.c"      2022-05-03 10:51:05.039037300 +0200
+++ "b/src/openvpn/mudp.c"      2022-05-03 10:51:05.215071400 +0200
@@ -106,7 +106,7 @@
         else
         {
             msg(D_MULTI_DEBUG, "Valid packet with HMAC challenge from peer (%s), "
-                               "accepting new connection.", peer);
+                "accepting new connection.", peer);
         }
         gc_free(&gc);

> @@ -114,10 +171,18 @@ multi_get_create_instance_udp(struct multi_context *m, bool *floated)
>                  mi = (struct multi_instance *) he->value;
>              }
>          }
> +
> +        /* we not have no existing multi instance for this connection */

Remove "not"

>          if (!mi)
>          {
> -            if (do_pre_decrypt_check(m))
> +            struct tls_pre_decrypt_state state = {0};
> +
> +            if (do_pre_decrypt_check(m, &state, real))
>              {
> +                /* This is an unknown session but with valid tls-auth/tls-crypt (or no auth at all),
> +                 * if this is the initial packet of a session, we just send a reply with a HMAC session id and do not
> +                 * generate a session slot */
> +
>                  if (frequency_limit_event_allowed(m->new_connection_limiter))
>                  {
>                      mi = multi_create_instance(m, &real);
> @@ -127,6 +192,14 @@ multi_get_create_instance_udp(struct multi_context *m, bool *floated)
>                          mi->did_real_hash = true;
>                          multi_assign_peer_id(m, mi);
>                      }
> +                    /* If we have a session ids already, ensure that the state is using the same */

"id", not "ids"

> +                    if (session_id_defined(&state.server_session_id)
> +                        && session_id_defined((&state.peer_session_id)))
> +                    {
> +                        mi->context.c2.tls_multi->n_sessions++;
> +                        struct tls_session *session = &mi->context.c2.tls_multi->session[TM_ACTIVE];
> +                        session_skip_to_pre_start(session, &state, &m->top.c2.from);
> +                    }
>                  }
>                  else
>                  {
[...]
> diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
> index e925a16ea..0ba86d3e6 100644
> --- a/src/openvpn/ssl.h
> +++ b/src/openvpn/ssl.h
> @@ -556,4 +556,12 @@ tls_session_generate_data_channel_keys(struct tls_session *session);
>  void
>  load_xkey_provider(void);
>  
> +/* Special method to skip the three way handshake RESET stages. This is
> + * used by the HMAC code when seeing a packet that matches the previous
> + * HMAC based stateless server state */
> +bool
> +session_skip_to_pre_start(struct tls_session *session,
> +                          struct tls_pre_decrypt_state *state,
> +                          struct link_socket_actual *from);
> +
>  #endif /* ifndef OPENVPN_SSL_H */
> diff --git a/src/openvpn/ssl_pkt.c b/src/openvpn/ssl_pkt.c
> index 7d9172703..9c8154b12 100644
> --- a/src/openvpn/ssl_pkt.c
> +++ b/src/openvpn/ssl_pkt.c
[...]
> +    /* check adjacent timestamps too */
> +    for (int offset = -2; offset <= 1; offset++)
> +    {
> +        struct session_id expected_id =
> +            calculate_session_id_hmac(state->peer_session_id, from, hmac, handwindow, offset);
> +
> +        if (memcmp_constant_time(&expected_id, &state->server_session_id, SID_SIZE))
> +        {
> +            return true;
> +        }
> +    }
> +    return false;
> +}
> +

new blank line at EOF.

> diff --git a/src/openvpn/ssl_pkt.h b/src/openvpn/ssl_pkt.h
> index 769dc1f44..ae92f6b33 100644
> --- a/src/openvpn/ssl_pkt.h
> +++ b/src/openvpn/ssl_pkt.h
[...]
> @@ -141,6 +146,47 @@ tls_pre_decrypt_lite(const struct tls_auth_standalone *tas,
>                       const struct link_socket_actual *from,
>                       const struct buffer *buf);
>  
> +/* Creates an SHA256 HMAC context with a random key that is used for the
> + * session id.
> + *
> + * We do not support loading this from a config file since continuing session
> + * between restarts of OpenVPN has never been supported and that includes
> + * early session setup

Nitpick: missing full stop.

+
+/**
+ * Calculates the a HMAC based server session id based on a client session id

either "the" or "a" but not both.

+ * and socket addr.
+ *

Regards,
--
Frank Lichtenheld

