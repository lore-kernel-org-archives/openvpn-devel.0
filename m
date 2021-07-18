References: <20210520151148.2565578-7-arne@...1227...>
 <20210713122550.3310818-1-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <0d3e330a-7a14-2597-4b6b-cbf6848ea436@...2181...>
Date: Sun, 18 Jul 2021 17:59:50 +0200
MIME-Version: 1.0
In-Reply-To: <20210713122550.3310818-1-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v5] Cleanup handling of initial auth
 token
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi,

On 13/07/2021 14:25, Arne Schwabe wrote:
> This changes that auth_token_initial is set when the token is
> initially generated instead when pushing the token. Even I do not know
> anymore why I did it in this way in the first place. Also use
> multi->auth_token_initial as source for the sesssion ID since it should
> now always be available. Also set auth_token_initial directly to
> up->password once we verified that we have gotten a valid token from
> a client. This cleans ups the logic in generating the environment and
> makes the code flow clearer.
> 
> Since the change makes auth_token_initial always available we need to add
> a check to only send a PUSH reply to update the token on renegotiations.
> The old code relied on multi->auth_token not being set in this case.
> 
> This commit also removes the workaround for old OpenVPN clients. These
> were only available as commercial OpenVPN Connect client and not in use
> anymore.
> 
> Furthermore, introduce a check if the session ID has changed during a session.
> Even though this is still a valid authentication changing to a different auth
> token mid session is highly irregular and should never occur naturally.
> 
> Patch V2: rebase.
> Patch V3: fix formatting, clarifying commit message, remove initial
>           token workaround for old v3.
> Patch v4: move sending the auth-token for renegotiations to a sane place
>           and trigger it when the TLS session reaches its fully authenticated
>           state.
> Patch v5: Move also setting auth_token_inital from up->password to a more
>           logical place, general cleanups, add session id mismatch check
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  doc/man-sections/server-options.rst        |  4 +-
>  src/openvpn/auth_token.c                   | 76 +++++++++++++++++-----
>  src/openvpn/auth_token.h                   |  9 +++
>  src/openvpn/push.c                         |  8 ---
>  src/openvpn/ssl.c                          |  7 +-
>  src/openvpn/ssl_common.h                   |  8 ++-
>  src/openvpn/ssl_verify.c                   | 31 +++------
>  tests/unit_tests/openvpn/test_auth_token.c | 49 +++++++++++---
>  8 files changed, 130 insertions(+), 62 deletions(-)
> 
> diff --git a/doc/man-sections/server-options.rst b/doc/man-sections/server-options.rst
> index 715473353..f1d2ec317 100644
> --- a/doc/man-sections/server-options.rst
> +++ b/doc/man-sections/server-options.rst
> @@ -35,7 +35,7 @@ fast hardware. SSL/TLS authentication must be used in this mode.
>    token is reached or after not being renewed for more than 2 \*
>    ``reneg-sec`` seconds. Clients will be sent renewed tokens on every TLS
>    renogiation to keep the client's token updated. This is done to

while here we could fix "renogiation" -> "renegotiation"

> -  invalidate a token if a client is disconnected for a sufficently long
> +  invalidate a token if a client is disconnected for a sufficiently long
>    time, while at the same time permitting much longer token lifetimes for
>    active clients.
>  
> @@ -46,7 +46,7 @@ fast hardware. SSL/TLS authentication must be used in this mode.
>    When the :code:`external-auth` keyword is present the normal
>    authentication method will always be called even if auth-token succeeds.
>    Normally other authentications method are skipped if auth-token
> -  verification suceeds or fails.
> +  verification succeeds or fails.
>  
>    This option postpones this decision to the external authentication
>    methods and checks the validity of the account and do other checks.
> diff --git a/src/openvpn/auth_token.c b/src/openvpn/auth_token.c
> index 0ea6d1832..6c1bec799 100644
> --- a/src/openvpn/auth_token.c
> +++ b/src/openvpn/auth_token.c
> @@ -109,11 +109,11 @@ add_session_token_env(struct tls_session *session, struct tls_multi *multi,
>          /*
>           * No session before, generate a new session token for the new session
>           */
> -        if (!multi->auth_token)
> +        if (!multi->auth_token_initial)
>          {
>              generate_auth_token(up, multi);
>          }
> -        session_id_source = multi->auth_token;
> +        session_id_source = multi->auth_token_initial;
>      }
>      /*
>       * In the auth-token the auth token is already base64 encoded
> @@ -184,7 +184,7 @@ generate_auth_token(const struct user_pass *up, struct tls_multi *multi)
>  
>      uint8_t sessid[AUTH_TOKEN_SESSION_ID_LEN];
>  
> -    if (multi->auth_token)
> +    if (multi->auth_token_initial)
>      {
>          /* Just enough space to fit 8 bytes+ 1 extra to decode a non padded
>           * base64 string (multiple of 3 bytes). 9 bytes => 12 bytes base64
> @@ -192,11 +192,14 @@ generate_auth_token(const struct user_pass *up, struct tls_multi *multi)
>           */
>          char old_tstamp_decode[9];
>  
> +        /* Make a copy of the string to not modify multi->auth_token_initial */
> +        char *initial_token_copy = string_alloc(multi->auth_token_initial, &gc);
> +
>          /*
>           * reuse the same session id and timestamp and null terminate it at
>           * for base64 decode it only decodes the session id part of it
>           */

This comment above does not make much sense to me, but since it has been
there since "ever", I'd suggest to fix it in a follow-up patch.
(This patch is not changing the logic that the comment is trying to explain)

On top of that, this function makes huge assumptions about the length of
the token and later it moves pointers across this buffer without
checking boundaries.
I am pretty sure that this code works well because the token has a
static and predictable length, but it might be good to make this
assumptions explicit by adding at least some comments.

Anyway, for a follow up patch too.

> -        char *old_sessid = multi->auth_token + strlen(SESSION_ID_PREFIX);
> +        char *old_sessid = initial_token_copy + strlen(SESSION_ID_PREFIX);
>          char *old_tsamp_initial = old_sessid + AUTH_TOKEN_SESSION_ID_LEN*8/6;
>  
>          old_tsamp_initial[12] = '\0';
> @@ -211,11 +214,7 @@ generate_auth_token(const struct user_pass *up, struct tls_multi *multi)
>          initial_timestamp = *tstamp_ptr;
>  
>          old_tsamp_initial[0] = '\0';
> -        ASSERT(openvpn_base64_decode(old_sessid, sessid, AUTH_TOKEN_SESSION_ID_LEN)==AUTH_TOKEN_SESSION_ID_LEN);
> -
> -
> -        /* free the auth-token, we will replace it with a new one */
> -        free(multi->auth_token);
> +        ASSERT(openvpn_base64_decode(old_sessid, sessid, AUTH_TOKEN_SESSION_ID_LEN) == AUTH_TOKEN_SESSION_ID_LEN);
>      }
>      else if (!rand_bytes(sessid, AUTH_TOKEN_SESSION_ID_LEN))
>      {
> @@ -272,11 +271,22 @@ generate_auth_token(const struct user_pass *up, struct tls_multi *multi)
>  
>      free(b64output);
>  
> +    /* free the auth-token if defined, we will replace it with a new one */
> +    free(multi->auth_token);
>      multi->auth_token = strdup((char *)BPTR(&session_token));
>  
>      dmsg(D_SHOW_KEYS, "Generated token for client: %s (%s)",
>           multi->auth_token, up->username);
>  
> +    if (!multi->auth_token_initial)
> +    {
> +        /*
> +         * Save the initial auth token to continue using the same session ID
> +         * and timestamp in updates
> +         */
> +        multi->auth_token_initial = strdup(multi->auth_token);
> +    }
> +
>      gc_free(&gc);
>  }
>  
> @@ -343,7 +353,7 @@ verify_auth_token(struct user_pass *up, struct tls_multi *multi,
>      }
>      else
>      {
> -        msg(M_WARN, "--auth-token-gen: HMAC on token from client failed (%s)",
> +        msg(M_WARN, "--auth-gen-token: HMAC on token from client failed (%s)",

totally unrelated to this patch :-) I let Gert decide if we can keep it
here or not.

>              up->username);
>          return 0;
>      }
> @@ -353,13 +363,7 @@ verify_auth_token(struct user_pass *up, struct tls_multi *multi,
>      bool in_renog_time = now >= timestamp
>                           && now < timestamp + 2 * session->opt->renegotiate_seconds;
>  
> -    /* We could still have a client that does not update
> -     * its auth-token, so also allow the initial auth-token */
> -    bool initialtoken = multi->auth_token_initial
> -                        && memcmp_constant_time(up->password, multi->auth_token_initial,
> -                                                strlen(multi->auth_token_initial)) == 0;
> -
> -    if (!in_renog_time && !initialtoken)
> +    if (!in_renog_time)

uhm, was this always supposed to be "in_reneg_time" ? maybe we can fix
it while at it..

>      {
>          ret |= AUTH_TOKEN_EXPIRED;
>      }
> @@ -383,7 +387,19 @@ verify_auth_token(struct user_pass *up, struct tls_multi *multi,
>      {
>          /* Tell client that the session token is expired */
>          auth_set_client_reason(multi, "SESSION: token expired");
> -        msg(M_INFO, "--auth-token-gen: auth-token from client expired");
> +        msg(M_INFO, "--auth-gen-token: auth-token from client expired");
> +    }
> +
> +    /* Check that we do have the same session ID in the token and the session
> +     * did not change, this also compares the prefix and session part of the

Regarding the sentence above, is it possible that we have the same
session ID and the sessions are not the same? From the comment it seems
it could be possible, but I am not sure this can be the case.

> +     * tokens, which should be identical if the session stayed the same */
> +    if (multi->auth_token_initial
> +        && memcmp_constant_time(multi->auth_token_initial, up->password,
> +                                strlen(SESSION_ID_PREFIX) + AUTH_TOKEN_SESSION_ID_LEN * 8 / 6))

Is this hunk actually fixing a problematic behaviour?
It seems before this patch we were missing this specific check? or
wasn't it needed?


Cosmetic note:
AUTH_TOKEN_SESSION_ID_LEN * 8 / 6 << this constant is used in several
places in the code.
Can we rather define another constant with a name that makes it clear
what it is? IIRC this "* 8 / 6" is used to compute the expected length
in base64, right?

> +    {
> +        msg(M_WARN, "--auth-gen-token: session id in token changed (. Rejecting "

The '.' is misplaced imho

> +                    "token.");

I Would just not put any '.' between parenthesis.

> +        ret = 0;
>      }
>      return ret;
>  }
> @@ -408,3 +424,27 @@ wipe_auth_token(struct tls_multi *multi)
>          multi->auth_token_initial = NULL;
>      }
>  }
> +
> +void
> +resend_auth_token_renegotiation(struct tls_multi *multi, struct tls_session *session)
> +{
> +    /*
> +     * Auth token already sent to client, update auth-token on client.
> +     * The initial auth-token is sent as part of the push message, for this
> +     * update we need to schedule an extra push message.
> +     *
> +     * Otherwise the auth-token get pushed out as part of the "normal"
> +     * push-reply
> +     */
> +    bool is_renegotiation = session->key[KS_PRIMARY].key_id != 0;
> +
> +    if (multi->auth_token_initial && is_renegotiation)
> +    {
> +        /*
> +         * We do not explicitly reschedule the sending of the
> +         * control message here. This might delay this reply
> +         * a few seconds until but this message is not time critical

until .. ? is something missing? or "until" was supposed to be removed?

> +         */
> +        send_push_reply_auth_token(multi);
> +    }
> +}
> \ No newline at end of file
> diff --git a/src/openvpn/auth_token.h b/src/openvpn/auth_token.h
> index 73a00ddd7..e9c33dc37 100644
> --- a/src/openvpn/auth_token.h
> +++ b/src/openvpn/auth_token.h
> @@ -129,4 +129,13 @@ is_auth_token(const char *password)
>      return (memcmp_constant_time(SESSION_ID_PREFIX, password,
>                                   strlen(SESSION_ID_PREFIX)) == 0);
>  }
> +/**
> + * Checks if a client has should be send a new auth token to update its

send -> sent

> + * current auth-token
> + * @param multi     Pointer the multi object of the TLS session
> + * @param session   Pointer to the TLS session itself
> + */
> +void
> +resend_auth_token_renegotiation(struct tls_multi *multi, struct tls_session *session);
> +
>  #endif /* AUTH_TOKEN_H */
> diff --git a/src/openvpn/push.c b/src/openvpn/push.c
> index f4957f147..53cb7ca6f 100644
> --- a/src/openvpn/push.c
> +++ b/src/openvpn/push.c
> @@ -527,14 +527,6 @@ prepare_auth_token_push_reply(struct tls_multi *tls_multi, struct gc_arena *gc,
>          push_option_fmt(gc, push_list, M_USAGE,
>                          "auth-token %s",
>                          tls_multi->auth_token);
> -        if (!tls_multi->auth_token_initial)
> -        {
> -            /*
> -             * Save the initial auth token for clients that ignore
> -             * the updates to the token
> -             */
> -            tls_multi->auth_token_initial = strdup(tls_multi->auth_token);
> -        }
>      }
>  }
>  
> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> index 592b2b893..504efab72 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
> @@ -3115,13 +3115,18 @@ tls_multi_process(struct tls_multi *multi,
>  
>              if (ks->state == S_ACTIVE && ks->authenticated == KS_AUTH_TRUE)
>              {
> -                /* This will ks->state from S_ACTIVE to S_GENERATED_KEYS */
> +                /* Session is now fully authenticated.
> +                 * tls_session_generate_data_channel_keys will ks->state
> +                 * from S_ACTIVE to S_GENERATED_KEYS */
>                  if (!tls_session_generate_data_channel_keys(session))
>                  {
>                      msg(D_TLS_ERRORS, "TLS Error: generate_key_expansion failed");
>                      ks->authenticated = KS_AUTH_FALSE;
>                      ks->state = S_ERROR;
>                  }
> +
> +                /* Update auth token on the client if needed */
> +                resend_auth_token_renegotiation(multi, session);
>              }
>          }
>      }
> diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
> index 43d6276be..5c261115c 100644
> --- a/src/openvpn/ssl_common.h
> +++ b/src/openvpn/ssl_common.h
> @@ -96,7 +96,9 @@
>                                   *   handshake window, deferred auth, client
>                                   *   connect and can still
>                                   *   be pending. */
> -#define S_GENERATED_KEYS  7     /**< The data channel keys have been generated */
> +#define S_GENERATED_KEYS  7     /**< The data channel keys have been generated.
> +                                  *  The TLS session is fully authenticated
> +                                  *  when reaching this state. */
>  /* Note that earlier versions also had a S_OP_NORMAL state that was
>   * virtually identical with S_ACTIVE and the code still assumes everything
>   * >= S_ACTIVE to be fully operational */
> @@ -597,8 +599,8 @@ struct tls_multi
>                            *   user/pass authentications in this session.
>                            */
>      char *auth_token_initial;
> -    /**< The first auth-token we sent to a client, for clients that do
> -     * not update their auth-token (older OpenVPN3 core versions)
> +    /**< The first auth-token we sent to a client. We use this to remember
> +     * the session ID and initial timestamp when generating new auth-token.
>       */
>  #define  AUTH_TOKEN_HMAC_OK              (1<<0)
>      /**< Auth-token sent from client has valid hmac */
> diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
> index bbb1878a3..e8cd87088 100644
> --- a/src/openvpn/ssl_verify.c
> +++ b/src/openvpn/ssl_verify.c
> @@ -1512,6 +1512,15 @@ verify_user_pass(struct user_pass *up, struct tls_multi *multi,
>      if (session->opt->auth_token_generate && is_auth_token(up->password))
>      {
>          ks->auth_token_state_flags = verify_auth_token(up, multi, session);
> +
> +        /* If this is the first time we see an auth-token in this session, save
> +         * it as initial auth token so to continue using the same session ID
> +         * and timestamp in updates */
> +        if (!multi->auth_token_initial)
> +        {
> +            multi->auth_token_initial = strdup(up->password);
> +        }
> +

We have the very same code in generate_auth_token(), why do we need it
here too? I had thought that the auth-token-initial is saved only upon
first token generation.

What use case are we covering here in verify_user_pass()?

>          if (session->opt->auth_token_call_auth)
>          {
>              /*
> @@ -1631,27 +1640,7 @@ verify_user_pass(struct user_pass *up, struct tls_multi *multi,
>               */
>              generate_auth_token(up, multi);
>          }
> -        /*
> -         * Auth token already sent to client, update auth-token on client.
> -         * The initial auth-token is sent as part of the push message, for this
> -         * update we need to schedule an extra push message.
> -         *
> -         * Otherwise the auth-token get pushed out as part of the "normal"
> -         * push-reply
> -         */
> -        if (multi->auth_token_initial)
> -        {
> -            /*
> -             * We do not explicitly schedule the sending of the
> -             * control message here but control message are only
> -             * postponed when the control channel  is not yet fully
> -             * established and furthermore since this is called in
> -             * the middle of authentication, there are other messages
> -             * (new data channel keys) that are sent anyway and will
> -             * trigger schedueling

typ0: scheduling

> -             */
> -            send_push_reply_auth_token(multi);
> -        }
> +
>          msg(D_HANDSHAKE, "TLS: Username/Password authentication %s for username '%s' %s",
>              (ks->authenticated == KS_AUTH_DEFERRED) ? "deferred" : "succeeded",
>              up->username,
> diff --git a/tests/unit_tests/openvpn/test_auth_token.c b/tests/unit_tests/openvpn/test_auth_token.c
> index 4030052e0..476f64b89 100644
> --- a/tests/unit_tests/openvpn/test_auth_token.c
> +++ b/tests/unit_tests/openvpn/test_auth_token.c
> @@ -174,7 +174,10 @@ auth_token_test_timeout(void **state)
>  
>      now = 100000;
>      generate_auth_token(&ctx->up, &ctx->multi);
> +
>      strcpy(ctx->up.password, ctx->multi.auth_token);
> +    free(ctx->multi.auth_token_initial);
> +    ctx->multi.auth_token_initial = NULL;
>  
>      /* No time has passed */
>      assert_int_equal(verify_auth_token(&ctx->up, &ctx->multi, ctx->session),
> @@ -195,11 +198,6 @@ auth_token_test_timeout(void **state)
>      assert_int_equal(verify_auth_token(&ctx->up, &ctx->multi, ctx->session),
>                       AUTH_TOKEN_HMAC_OK|AUTH_TOKEN_EXPIRED);
>  
> -    /* Check if the mode for a client that never updates its token works */
> -    ctx->multi.auth_token_initial = strdup(ctx->up.password);
> -    assert_int_equal(verify_auth_token(&ctx->up, &ctx->multi, ctx->session),
> -                     AUTH_TOKEN_HMAC_OK);
> -
>      /* But not when we reached our timeout */
>      now = 100000 + ctx->session->opt->auth_token_lifetime + 1;
>      assert_int_equal(verify_auth_token(&ctx->up, &ctx->multi, ctx->session),
> @@ -244,10 +242,10 @@ auth_token_test_known_keys(void **state)
>  
>      now = 0;
>      /* Preload the session id so the same session id is used here */
> -    ctx->multi.auth_token = strdup(now0key0);
> +    ctx->multi.auth_token_initial = strdup(now0key0);
>  
>      /* Zero the hmac part to ensure we have a newly generated token */
> -    zerohmac(ctx->multi.auth_token);
> +    zerohmac(ctx->multi.auth_token_initial);
>  
>      generate_auth_token(&ctx->up, &ctx->multi);
>  
> @@ -268,6 +266,38 @@ setenv_str(struct env_set *es, const char *name, const char *value)
>      }
>  }
>  
> +void
> +auth_token_test_session_mismatch(void **state)
> +{
> +    struct test_context *ctx = (struct test_context *) *state;
> +
> +    /* Generate first auth token and check it is correct */
> +    generate_auth_token(&ctx->up, &ctx->multi);
> +    strcpy(ctx->up.password, ctx->multi.auth_token);
> +    assert_int_equal(verify_auth_token(&ctx->up, &ctx->multi, ctx->session),
> +                     AUTH_TOKEN_HMAC_OK);
> +
> +    char *token_sessiona = strdup(ctx->multi.auth_token);
> +
> +    /* Generate second token */
> +    wipe_auth_token(&ctx->multi);
> +
> +    generate_auth_token(&ctx->up, &ctx->multi);
> +    strcpy(ctx->up.password, ctx->multi.auth_token);
> +    assert_int_equal(verify_auth_token(&ctx->up, &ctx->multi, ctx->session),
> +                     AUTH_TOKEN_HMAC_OK);
> +
> +    assert_int_not_equal(0, memcmp(ctx->multi.auth_token_initial + strlen(SESSION_ID_PREFIX),
> +                                   token_sessiona + strlen(SESSION_ID_PREFIX),
> +                                   AUTH_TOKEN_SESSION_ID_LEN * 8 / 6));
> +
> +    /* The first token is valid but should trigger the invalid response since
> +     * the session id is not the same */
> +    strcpy(ctx->up.password, token_sessiona);
> +    assert_int_equal(verify_auth_token(&ctx->up, &ctx->multi, ctx->session), 0);
> +    free(token_sessiona);
> +}
> +
>  static void
>  auth_token_test_empty_user(void **state)
>  {
> @@ -341,13 +371,13 @@ auth_token_test_random_keys(void **state)
>  
>      now = 0x5c331e9c;
>      /* Preload the session id so the same session id is used here */
> -    ctx->multi.auth_token = strdup(random_token);
> +    ctx->multi.auth_token_initial = strdup(random_token);
>  
>      free_key_ctx(&ctx->multi.opt.auth_token_key);
>      auth_token_init_secret(&ctx->multi.opt.auth_token_key, random_key, true);
>  
>      /* Zero the hmac part to ensure we have a newly generated token */
> -    zerohmac(ctx->multi.auth_token);
> +    zerohmac(ctx->multi.auth_token_initial);
>  
>      generate_auth_token(&ctx->up, &ctx->multi);
>  
> @@ -385,6 +415,7 @@ main(void)
>          cmocka_unit_test_setup_teardown(auth_token_test_random_keys, setup, teardown),
>          cmocka_unit_test_setup_teardown(auth_token_test_key_load, setup, teardown),
>          cmocka_unit_test_setup_teardown(auth_token_test_timeout, setup, teardown),
> +        cmocka_unit_test_setup_teardown(auth_token_test_session_mismatch, setup, teardown)
>      };
>  
>  #if defined(ENABLE_CRYPTO_OPENSSL)
> 


The rest looks good. I like seeing more auth-token logic being moved to
auth-token.c, in the proper functions.

In any case, will still wait for Arne to clarify my doubts, as expressed
above.

[note: I am still testing..]


Regards,


-- 
Antonio Quartulli

