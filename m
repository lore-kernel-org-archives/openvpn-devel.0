References: <1542032175-5716-1-git-send-email-lstipakov@...277...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <f57a2e41-3243-b6ee-aebc-3be050e4e660@...1856...>
Date: Sat, 19 Jan 2019 14:40:07 +0100
MIME-Version: 1.0
In-Reply-To: <1542032175-5716-1-git-send-email-lstipakov@...277...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] Fix broken fragment/mssfix with NCP
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
To: openvpn-devel@lists.sourceforge.net

Hi,

On 12-11-18 15:16, Lev Stipakov wrote:
> From: Lev Stipakov <lev@...515...>
> 
> NCP negotiation replaces worst cast crypto overhead
> with actual one in data channel frame. That frame
> params are used by mssfix.
> 
> Fragment frame still contains worst case overhead.
> Because of that TCP packets are fragmented, since
> MSS value exceeds max fragment size.
> 
> Fix by replacing worst case crypto overhead with
> actual one for fragment frame, as it is done for data
> channel frame.
> 
> Trac #1140

Thanks for digging into this!

> Signed-off-by: Lev Stipakov <lstipakov@...277...>
> ---
>  src/openvpn/forward.c |  1 +
>  src/openvpn/init.c    | 12 +++++++++++-
>  src/openvpn/openvpn.h |  1 +
>  src/openvpn/push.c    |  9 ++++++++-
>  src/openvpn/ssl.c     | 19 ++++++++++++++++++-
>  src/openvpn/ssl.h     | 13 ++++++++-----
>  6 files changed, 47 insertions(+), 8 deletions(-)
> 
> diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
> index f8faa81..773f5d7 100644
> --- a/src/openvpn/forward.c
> +++ b/src/openvpn/forward.c
> @@ -1090,6 +1090,7 @@ process_incoming_link_part1(struct context *c, struct link_socket_info *lsi, boo
>                  if (is_hard_reset(opcode, c->options.key_method))
>                  {
>                      c->c2.frame = c->c2.frame_initial;
> +                    c->c2.frame_fragment = c->c2.frame_fragment_initial;

This breaks --disable-fragment builds:

src/openvpn/forward.c:1096:27: error: no member named 'frame_fragment'
in 'struct context_2'
                    c->c2.frame_fragment = c->c2.frame_fragment_initial;
                    ~~~~~ ^
src/openvpn/forward.c:1096:50: error: no member named
'frame_fragment_initial' in 'struct context_2'
                    c->c2.frame_fragment = c->c2.frame_fragment_initial;
                                           ~~~~~ ^
2 errors generated.
Makefile:676: recipe for target 'forward.o' failed


>                  }
>  
>                  interval_action(&c->c2.tmp_int);
> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index 39e8ca5..db96353 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -2300,9 +2300,18 @@ do_deferred_options(struct context *c, const unsigned int found)
>          {
>              tls_poor_mans_ncp(&c->options, c->c2.tls_multi->remote_ciphername);
>          }
> +        struct frame *frame_fragment = NULL;
> +#ifdef ENABLE_FRAGMENT
> +        if (c->options.ce.fragment)
> +        {
> +            frame_fragment = &c->c2.frame_fragment;
> +        }
> +#endif
> +
>          /* Do not regenerate keys if server sends an extra push reply */
>          if (!session->key[KS_PRIMARY].crypto_options.key_ctx_bi.initialized
> -            && !tls_session_update_crypto_params(session, &c->options, &c->c2.frame))
> +            && !tls_session_update_crypto_params(session, &c->options, &c->c2.frame,
> +                                                 frame_fragment))
>          {
>              msg(D_TLS_ERRORS, "OPTIONS ERROR: failed to import crypto options");
>              return false;
> @@ -3082,6 +3091,7 @@ do_init_frame(struct context *c)
>       */
>      c->c2.frame_fragment = c->c2.frame;
>      frame_subtract_extra(&c->c2.frame_fragment, &c->c2.frame_fragment_omit);
> +    c->c2.frame_fragment_initial = c->c2.frame_fragment;
>  #endif
>  
>  #if defined(ENABLE_FRAGMENT) && defined(ENABLE_OCC)
> diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
> index d11f61d..a5d250f 100644
> --- a/src/openvpn/openvpn.h
> +++ b/src/openvpn/openvpn.h
> @@ -265,6 +265,7 @@ struct context_2
>      /* Object to handle advanced MTU negotiation and datagram fragmentation */
>      struct fragment_master *fragment;
>      struct frame frame_fragment;
> +    struct frame frame_fragment_initial;
>      struct frame frame_fragment_omit;
>  #endif
>  
> diff --git a/src/openvpn/push.c b/src/openvpn/push.c
> index 72f0996..a44646a 100644
> --- a/src/openvpn/push.c
> +++ b/src/openvpn/push.c
> @@ -274,11 +274,18 @@ incoming_push_message(struct context *c, const struct buffer *buffer)
>      {
>          if (c->options.mode == MODE_SERVER)
>          {
> +            struct frame *frame_fragment = NULL;
> +#ifdef ENABLE_FRAGMENT
> +            if (c->options.ce.fragment)
> +            {
> +                frame_fragment = &c->c2.frame_fragment;
> +            }
> +#endif
>              struct tls_session *session = &c->c2.tls_multi->session[TM_ACTIVE];
>              /* Do not regenerate keys if client send a second push request */
>              if (!session->key[KS_PRIMARY].crypto_options.key_ctx_bi.initialized
>                  && !tls_session_update_crypto_params(session, &c->options,
> -                                                     &c->c2.frame))
> +                                                     &c->c2.frame, frame_fragment))
>              {
>                  msg(D_TLS_ERRORS, "TLS Error: initializing data channel failed");
>                  goto error;
> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> index 74b88ce..8942f71 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
> @@ -1986,7 +1986,8 @@ cleanup:
>  
>  bool
>  tls_session_update_crypto_params(struct tls_session *session,
> -                                 struct options *options, struct frame *frame)
> +                                 struct options *options, struct frame *frame,
> +                                 struct frame *frame_fragment)
>  {
>      if (!session->opt->server
>          && 0 != strcmp(options->ciphername, session->opt->config_ciphername)
> @@ -2030,6 +2031,22 @@ tls_session_update_crypto_params(struct tls_session *session,
>      frame_init_mssfix(frame, options);
>      frame_print(frame, D_MTU_INFO, "Data Channel MTU parms");
>  
> +    /*
> +     * mssfix uses data channel framing, which at this point contains
> +     * actual overhead. Fragmentation logic uses frame_fragment, which
> +     * still contains worst case overhead. Replace it with actual overhead
> +     * to prevent unneeded fragmentation.
> +     */
> +
> +    if (frame_fragment)
> +    {
> +        frame_remove_from_extra_frame(frame_fragment, crypto_max_overhead());
> +        crypto_adjust_frame_parameters(frame_fragment, &session->opt->key_type,
> +	                               options->replay, packet_id_long_form);
> +        frame_set_mtu_dynamic(frame_fragment, options->ce.fragment, SET_MTU_UPPER_BOUND);
> +        frame_print(frame_fragment, D_MTU_INFO, "Fragmentation MTU parms");
> +    }
> +
>      return tls_session_generate_data_channel_keys(session);
>  }
>  
> diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
> index ac6fef7..4802e62 100644
> --- a/src/openvpn/ssl.h
> +++ b/src/openvpn/ssl.h
> @@ -474,15 +474,18 @@ void tls_update_remote_addr(struct tls_multi *multi,
>   * Update TLS session crypto parameters (cipher and auth) and derive data
>   * channel keys based on the supplied options.
>   *
> - * @param session       The TLS session to update.
> - * @param options       The options to use when updating session.
> - * @param frame         The frame options for this session (frame overhead is
> - *                      adjusted based on the selected cipher/auth).
> + * @param session         The TLS session to update.
> + * @param options         The options to use when updating session.
> + * @param frame           The frame options for this session (frame overhead is
> + *                        adjusted based on the selected cipher/auth).
> + * @param frame_fragment  The fragment frame options.
>   *
>   * @return true if updating succeeded, false otherwise.
>   */
>  bool tls_session_update_crypto_params(struct tls_session *session,
> -                                      struct options *options, struct frame *frame);
> +                                      struct options *options,
> +                                      struct frame *frame,
> +                                      struct frame *frame_fragment);
>  
>  /**
>   * "Poor man's NCP": Use peer cipher if it is an allowed (NCP) cipher.
> 

Otherwise this patch looks good to me. I recall finding weird behaviour
when I tested this patch earlier, but can't reproduce it anymore based
on my notes from then. I tried (large) pings and TCP transfers, using
--fragment 500 and 1000 and inspected the packet sizes using tcpdump.
Both for client-to-server and server-to-client traffic. Although
--fragment for non-TCP traffic still seems to behave suboptimal, this
patch does improve behaviour for TCP streams. Since that is probably the
majority or traffic where people need performance, this is very useful.

Once the --disable-fragment builds have been fixed, I have no objections
to merging that patch. But I would prefer to have one of the networking
guys to take a good look at this too before merging.

-Steffan

