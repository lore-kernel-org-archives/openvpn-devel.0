Date: Fri, 29 Apr 2022 12:28:24 +0200 (CEST)
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <2127738744.675772.1651228104970@...2642...>
In-Reply-To: <20220427223419.241904-2-arne@...1227...>
References: <20220422134038.3801239-1-arne@...1227...>
 <20220427223419.241904-1-arne@...1227...>
 <20220427223419.241904-2-arne@...1227...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH v2] Implement stateless,
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

Summary line: "HMAC-based session-id three-way-handshake" maybe? Just to help one parse the word pile ;)

> Arne Schwabe <arne@...1227...> hat am 28.04.2022 00:34 geschrieben:
> OpenVPN currently has a bit of a weakness in its early three way handshake
> 
> A single client reset packet (first packet of the handshake) will
>   - trigger creating session on the server side leading to poential

"creating a session", "potential"

>     ressource exhaustian

"exhaustion"

>   - make the server respond with 3 answers trying to get an ACK for its

Could we maybe slightly elaborate on that? What are those "3" answers?

>     answer making it a amplification

"an"

> 
> Instead of allocating a connection for each client on the initial packet
> OpenVPN will now send back a response that contains an HMAC based cookie
> that the client will need to respond to. This eliminates the amplification
> attack and resource exhaustion attacks. For tls-crypt-v2 client HMAC based
> handshake is not used yet.

I think this is not very helpful in understanding the change. In trying to
understand it, this is my personal explanation I came up with. Not sure
whether it is correct, but maybe it can be useful:

"Instead of allocating a connection for each client on the initial
HARD_RESET_CLIENT packet OpenVPN server will now create its own session id
for the HARD_RESET_SERVER packet as an HMAC of client data. This way it can
verify the session id on the second packet of
the client (ACK or CONTROL) and only create the connection then."

"This eliminates the amplification [...]" (unchanged)

> 
> Patch v2: rebase on master
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  doc/doxygen/doc_protocol_overview.h |   2 +
>  src/openvpn/init.c                  |   4 +
>  src/openvpn/mudp.c                  | 105 ++++++++++++--
>  src/openvpn/multi.h                 |   3 +
>  src/openvpn/openvpn.h               |   6 +
>  src/openvpn/ssl.c                   |  41 +++++-
>  src/openvpn/ssl.h                   |   8 ++
>  src/openvpn/ssl_pkt.c               | 102 +++++++++++++-
>  src/openvpn/ssl_pkt.h               |  55 +++++++-
>  tests/unit_tests/openvpn/test_pkt.c | 204 ++++++++++++++++++++++++++--
>  10 files changed, 503 insertions(+), 27 deletions(-)
> 
[...]
> diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
> index e5cc36b45..92a1673ee 100644
> --- a/src/openvpn/mudp.c
> +++ b/src/openvpn/mudp.c
> @@ -40,24 +40,81 @@
>  #include <sys/inotify.h>
>  #endif
>  
> +/* Return if this packet should create a new session */

missing "true" after "Return".

>  static bool
> -do_pre_decrypt_check(struct multi_context *m)
> +do_pre_decrypt_check(struct multi_context *m,
> +                     struct tls_pre_decrypt_state *state,
> +                     struct mroute_addr addr)
>  {
>      ASSERT(m->top.c2.tls_auth_standalone);
>  
>      enum first_packet_verdict verdict;
> -    struct tls_pre_decrypt_state state = {0};
>  
> -    verdict = tls_pre_decrypt_lite(m->top.c2.tls_auth_standalone, &state,
> -                                   &m->top.c2.from, &m->top.c2.buf);
> +    struct tls_auth_standalone *tas = m->top.c2.tls_auth_standalone;
>  
> -    free_tls_pre_decrypt_state(&state);
> +    verdict = tls_pre_decrypt_lite(tas, state, &m->top.c2.from, &m->top.c2.buf);
>  
> -    if (verdict == VERDICT_INVALID || verdict == VERDICT_VALID_CONTROL_V1)
> +    hmac_ctx_t *hmac = m->top.c2.session_id_hmac;
> +    struct openvpn_sockaddr *from = &m->top.c2.from.dest;
> +    int handwindow = m->top.options.handshake_window;
> +
> +
> +    if (verdict == VERDICT_VALID_RESET_V3)
> +    {
> +        /* For tls-crypt-v2 we need to keep the state of the first packet to
> +         * store the unwrapped key */
> +        return true;
> +    }
> +    else if (verdict == VERDICT_VALID_RESET_V2)
>      {
> +        /* Calculate the session ID HMAC for our reply and create reset packet */
> +        struct session_id sid = calculate_session_id_hmac(state->peer_session_id,
> +                                                          from, hmac, handwindow, 0);
> +        reset_packet_id_send(&tas->tls_wrap.opt.packet_id.send);
> +        tas->tls_wrap.opt.packet_id.rec.initialized = true;
> +        uint8_t header = 0 | (P_CONTROL_HARD_RESET_SERVER_V2 << P_OPCODE_SHIFT);
> +        struct buffer buf = tls_reset_standalone(tas, &sid,
> +                                                 &state->peer_session_id, header);
> +
> +
> +        struct context *c = &m->top;
> +
> +        buf_reset_len(&c->c2.buffers->aux_buf);
> +        buf_copy(&c->c2.buffers->aux_buf, &buf);
> +        m->hmac_reply = c->c2.buffers->aux_buf;
> +        m->hmac_reply_dest = &m->top.c2.from;
> +        msg(D_MULTI_DEBUG, "Reset packet from client, sending HMAC based reset challenge");
> +        /* We have a reply do not create a new session */
>          return false;
> +
> +    }
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

Not a review, but rather a question: What actually happens to the connection in this
code path?

> +
> +        }
> +        else
> +        {
> +            msg(D_MULTI_DEBUG, "Reset packet from client (%s), "
> +                "sending HMAC based reset challenge", peer);

Huh? This is not a reset packet? Also we're not sending a reset challenge, we just completed it?
Should this message say something different?

> +        }
> +        gc_free(&gc);
> +
> +        return ret;
>      }
> -    return true;
> +
> +    /* VERDICT_INVALID */
> +    return false;
>  }
>  
>  /*
[... rest of the code not reviewed, yet ...]

Regards,
--
Frank Lichtenheld

