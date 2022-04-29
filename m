Date: Fri, 29 Apr 2022 14:02:07 +0200 (CEST)
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <941730844.685738.1651233727848@...2642...>
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

The "offset" part of the review :)

> Arne Schwabe <arne@...1227...> hat am 28.04.2022 00:34 geschrieben:
[...]
> diff --git a/src/openvpn/ssl_pkt.c b/src/openvpn/ssl_pkt.c
> index a93027505..56baa2895 100644
> --- a/src/openvpn/ssl_pkt.c
> +++ b/src/openvpn/ssl_pkt.c
[...]
> @@ -430,3 +440,91 @@ tls_reset_standalone(struct tls_auth_standalone *tas,
>      return buf;
>  }
>  
> +
> +hmac_ctx_t *
> +session_id_hmac_init(void)
> +{
> +    /* We assume that SHA256 is always available */
> +    ASSERT(md_valid("SHA256"));
> +    hmac_ctx_t *hmac_ctx = hmac_ctx_new();
> +
> +    uint8_t key[SHA256_DIGEST_LENGTH];
> +    ASSERT(rand_bytes(key, sizeof(key)));
> +
> +    hmac_ctx_init(hmac_ctx, key, "SHA256");
> +    return hmac_ctx;
> +}
> +
> +struct session_id
> +calculate_session_id_hmac(struct session_id client_sid,
> +                          const struct openvpn_sockaddr *from,
> +                          hmac_ctx_t *hmac,
> +                          int handwindow, int offset)
> +{
> +    union {
> +        uint8_t hmac_result[SHA256_DIGEST_LENGTH];
> +        struct session_id sid;
> +    } result;
> +
> +    /* Get the valid time quantisation for our hmac,
> +     * we divide time by handwindow/2 and allow the current
> +     * and the previous timestamp */

This comment is misleading. There is no logic here for "current" and
"previous" here. The caller makes this decision via offset.
So maybe "[...] we divide time by handwindow/2. offset can be
used to allow previous timestamps."

> +    uint32_t session_id_time = now/((handwindow+1)/2) + offset;
> +
> +    hmac_ctx_reset(hmac);
> +    /* We do not care about endian here since it does not need to be
> +     * portable */
> +    hmac_ctx_update(hmac, (const uint8_t *) &session_id_time,
> +                    sizeof(session_id_time));
> +
> +    /* add client IP and port */
> +    switch (af_addr_size(from->addr.sa.sa_family))
> +    {
> +        case AF_INET:
> +            hmac_ctx_update(hmac, (const uint8_t *) &from->addr.in4, sizeof(struct sockaddr_in));
> +            break;
> +
> +        case AF_INET6:
> +            hmac_ctx_update(hmac, (const uint8_t *) &from->addr.in6, sizeof(struct sockaddr_in6));
> +            break;
> +    }
> +
> +    /* add session id of client */
> +    hmac_ctx_update(hmac, client_sid.id, SID_SIZE);
> +
> +    hmac_ctx_final(hmac, result.hmac_result);
> +
> +    return result.sid;
> +}
> +
> +bool
> +check_session_id_hmac(struct tls_pre_decrypt_state *state,
> +                      const struct openvpn_sockaddr *from,
> +                      hmac_ctx_t *hmac,
> +                      int handwindow)
> +{
> +    if (!from)
> +    {
> +        return false;
> +    }
> +
> +    struct buffer buf = state->newbuf;
> +    struct reliable_ack ack;
> +
> +    if (!reliable_ack_parse(&buf, &ack, &state->server_session_id))
> +    {
> +        return false;
> +    }
> +

Here we could put a comment like "allow adjacent timestamps".

> +    for (int i = -1; i<=1; i++)

Why not call this variable "offset"?

> +    {
> +        struct session_id expected_id =
> +            calculate_session_id_hmac(state->peer_session_id, from, hmac, handwindow, i);
> +
> +        if (memcmp_constant_time(&expected_id, &state->server_session_id, SID_SIZE))
> +        {
> +            return true;
> +        }
> +    }
> +    return false;
> +}
> diff --git a/src/openvpn/ssl_pkt.h b/src/openvpn/ssl_pkt.h
> index dd9361407..75cdc1c58 100644
> --- a/src/openvpn/ssl_pkt.h
> +++ b/src/openvpn/ssl_pkt.h
[...]
> @@ -141,6 +146,48 @@ tls_pre_decrypt_lite(const struct tls_auth_standalone *tas,
>                       const struct link_socket_actual *from,
>                       const struct buffer *buf);
>  
> +/* Creates an SHA256 HMAC context with a random key that is used for the
> + * session id.
> + *
> + * We do not support loading this from a config file since continuing session
> + * between restarts of OpenVPN has never been supported and that includes
> + * early session setup
> + */
> +hmac_ctx_t *session_id_hmac_init(void);
> +
> +/**
> + * Calculates the a HMAC based server session id based on a client session id
> + * and socket addr.
> + *
> + * @param client_sid    session id of the client
> + * @param from          link_socket from the client
> + * @param hmac          the hmac context to use for the calculation
> + * @param handwindow    the quantisation of the current time
> + * @param offset        offset to 'now' to use
> + * @return              the expected server session id
> + */
> +struct session_id
> +calculate_session_id_hmac(struct session_id client_sid,
> +                          const struct openvpn_sockaddr *from,
> +                          hmac_ctx_t *hmac,
> +                          int handwindow, int offset);
> +
> +/**
> + * Checks if a control packet has a correct HMAC server session id
> + *
> + * @param client_sid    session id of the client
> + * @param from          link_socket from the client
> + * @param hmac          the hmac context to use for the calculation
> + * @param handwindow    the quantisation of the current time
> + * @param offset        offset to 'now' to use

This function has no parameter "offset".

> + * @return              the expected server session id
> + */
> +bool
> +check_session_id_hmac(struct tls_pre_decrypt_state *state,
> +                      const struct openvpn_sockaddr *from,
> +                      hmac_ctx_t *hmac,
> +                      int handwindow);
> +
>  /*
>   * Write a control channel authentication record.
>   */
> diff --git a/tests/unit_tests/openvpn/test_pkt.c b/tests/unit_tests/openvpn/test_pkt.c
> index 77338cd3a..c4e23521d 100644
> --- a/tests/unit_tests/openvpn/test_pkt.c
> +++ b/tests/unit_tests/openvpn/test_pkt.c
[...]
> @@ -325,8 +347,170 @@ test_tls_decrypt_lite_none(void **ut_state)
[...]
> +static void
> +test_verify_hmac_none(void **ut_state)
> +{
> +    hmac_ctx_t *hmac = session_id_hmac_init();
> +
> +    struct link_socket_actual from = { 0 };
> +    struct tls_auth_standalone tas = { 0 };
> +    struct tls_pre_decrypt_state state = { 0 };
> +
> +    struct buffer buf = alloc_buf(1024);
> +    enum first_packet_verdict verdict;
> +
> +    tas.tls_wrap.mode = TLS_WRAP_NONE;
> +
> +    buf_reset_len(&buf);
> +    buf_write(&buf, client_ack_none_random_id, sizeof(client_ack_none_random_id));
> +    verdict = tls_pre_decrypt_lite(&tas, &state, &from, &buf);
> +    assert_int_equal(verdict, VERDICT_VALID_ACK_V1);
> +
> +    check_session_id_hmac(&state, &from.dest, hmac, 30);

Shouldn't this have some associated assert?

> +
>      free_tls_pre_decrypt_state(&state);
>      free_buf(&buf);
> +    hmac_ctx_cleanup(hmac);
> +    hmac_ctx_free(hmac);
> +}
> +
> +static hmac_ctx_t *
> +init_static_hmac(void)
> +{
> +    ASSERT(md_valid("SHA256"));
> +    hmac_ctx_t *hmac_ctx = hmac_ctx_new();
> +
> +    uint8_t key[SHA256_DIGEST_LENGTH] = {1, 2, 3};
> +
> +    hmac_ctx_init(hmac_ctx, key, "SHA256");
> +    return hmac_ctx;
> +}
> +
> +static void
> +test_calc_session_id_hmac_static(void **ut_state)
> +{
> +    hmac_ctx_t *hmac = init_static_hmac();
> +
> +    struct openvpn_sockaddr addr = {0 };
> +
> +    /* we do not use htons functions here since the hmac calculate function
> +     * also does not care about the endianness of the data but just assumes
> +     * the endianness doesn't change between calls */
> +    addr.addr.in4.sin_family = AF_INET;
> +    addr.addr.in4.sin_addr.s_addr = 0xff000ff;
> +    addr.addr.in4.sin_port = 1194;
> +
> +
> +    struct session_id client_id = { {0, 1, 2, 3, 4, 5, 6, 7}};
> +
> +    now = 1005;

I would suggest creating a variable or define here for the "100" handwindow. I think
that would improve readability and since it must be synced it also makes the code more
implicitely correct.

> +    struct session_id server_id = calculate_session_id_hmac(client_id, &addr, hmac, 100, 0);
> +
> +    struct session_id expected_server_id = { {0xba,  0x83, 0xa9, 0x00, 0x72, 0xbd,0x93, 0xba }};
> +    assert_memory_equal(expected_server_id.id, server_id.id, SID_SIZE);
> +
> +    struct session_id server_id_m1 = calculate_session_id_hmac(client_id, &addr, hmac, 100, -1);
> +    struct session_id server_id_p1 = calculate_session_id_hmac(client_id, &addr, hmac, 100, 1);
> +    struct session_id server_id_p2 = calculate_session_id_hmac(client_id, &addr, hmac, 100, 2);
> +
> +    assert_memory_not_equal(expected_server_id.id, server_id_m1.id, SID_SIZE);
> +    assert_memory_not_equal(expected_server_id.id, server_id_p1.id, SID_SIZE);
> +
> +    /* moving now should also move the calculated ids */

"moving now by more than half of handwindow should also move the calculated ids by offset 1"

> +    now = 1062;
> +
> +    struct session_id server_id2_m2 = calculate_session_id_hmac(client_id, &addr, hmac, 100, -2);
> +    struct session_id server_id2_m1 = calculate_session_id_hmac(client_id, &addr, hmac, 100, -1);
> +    struct session_id server_id2 = calculate_session_id_hmac(client_id, &addr, hmac, 100, 0);
> +    struct session_id server_id2_p1 = calculate_session_id_hmac(client_id, &addr, hmac, 100, 1);
> +
> +    assert_memory_equal(server_id2_m2.id, server_id_m1.id, SID_SIZE);
> +    assert_memory_equal(server_id2_m1.id, expected_server_id.id, SID_SIZE);
> +    assert_memory_equal(server_id2.id, server_id_p1.id, SID_SIZE);
> +    assert_memory_equal(server_id2_p1.id, server_id_p2.id, SID_SIZE);
> +
> +    hmac_ctx_cleanup(hmac);
> +    hmac_ctx_free(hmac);
>  }
>  
>  static void
[...]

Regards,
--
Frank Lichtenheld

