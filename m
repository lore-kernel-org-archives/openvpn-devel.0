References: <20200313165913.12682-1-lstipakov@...277...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <184a134b-2d7c-d175-ea9b-059048b66618@...1227...>
Date: Wed, 15 Apr 2020 21:24:56 +0200
MIME-Version: 1.0
In-Reply-To: <20200313165913.12682-1-lstipakov@...277...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] Fix broken async push with NCP is used
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
To: Lev Stipakov <lstipakov@...277...>, openvpn-devel@lists.sourceforge.net
Cc: Lev Stipakov <lev@...515...>

Am 13.03.20 um 17:59 schrieb Lev Stipakov:
> From: Lev Stipakov <lev@...515...>
> 
> With NCP and deferred auth, we perform cipher negotiation and
> generate data channel keys on incoming push request, assuming that auth
> succeeded. With async push, when auth succeeds in between push requests,
> we send push reply immediately.
> 
> The code which generates data channel keys is only called on handling incoming
> push requests (incoming_push_message). It might not be called with NCP,
> deferred auth and async push because on incoming push request auth might not
> be complete yet. When auth is complete in between push requests, push reply
> is sent and it is assumed that connection is established. However, since data channel keys
> are not generated on the server side, connection doesn't work.
> 
> Fix by generating data channel keys when async push is triggered.
> 
> Reported-by: smaxfield@...2543...
> Signed-off-by: Lev Stipakov <lev@...515...>
> ---
>  src/openvpn/init.c  |  6 ++----
>  src/openvpn/multi.c | 24 +++++++++++++++++++++++-
>  src/openvpn/push.c  |  6 ++----
>  src/openvpn/ssl.c   |  6 ++++++
>  src/openvpn/ssl.h   |  5 +++--
>  5 files changed, 36 insertions(+), 11 deletions(-)
> 
> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index 824b6667..b3096dc8 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -2343,10 +2343,8 @@ do_deferred_options(struct context *c, const unsigned int found)
>          }
>  #endif
>  
> -        /* Do not regenerate keys if server sends an extra push reply */
> -        if (!session->key[KS_PRIMARY].crypto_options.key_ctx_bi.initialized
> -            && !tls_session_update_crypto_params(session, &c->options, &c->c2.frame,
> -                                                 frame_fragment))
> +        if (!tls_session_update_crypto_params(session, &c->options, &c->c2.frame,
> +                                              frame_fragment))
>          {
>              msg(D_TLS_ERRORS, "OPTIONS ERROR: failed to import crypto options");
>              return false;
> diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
> index da0aeeba..b42bcec9 100644
> --- a/src/openvpn/multi.c
> +++ b/src/openvpn/multi.c
> @@ -2137,8 +2137,30 @@ multi_process_file_closed(struct multi_context *m, const unsigned int mpp_flags)
>          {
>              if (mi)
>              {
> -                /* continue authentication and send push_reply */
> +                /* continue authentication, perform NCP negotiation and send push_reply */
>                  multi_process_post(m, mi, mpp_flags);
> +
> +                /* With NCP and deferred authentication, we perform cipher negotiation and
> +                 * data channel keys generation on incoming push request, assuming that auth
> +                 * succeeded. When auth succeeds in between push requests and async push is used,
> +                 * we send push reply immediately. Above multi_process_post() call performs
> +                 * NCP negotiation and here we do keys generation. */
> +
> +                struct context *c = &mi->context;
> +                struct frame *frame_fragment = NULL;
> +#ifdef ENABLE_FRAGMENT
> +                if (c->options.ce.fragment)
> +                {
> +                    frame_fragment = &c->c2.frame_fragment;
> +                }
> +#endif
> +                struct tls_session *session = &c->c2.tls_multi->session[TM_ACTIVE];
> +                if (!tls_session_update_crypto_params(session, &c->options,
> +                                                      &c->c2.frame, frame_fragment))
> +                {
> +                    msg(D_TLS_ERRORS, "TLS Error: initializing data channel failed");
> +                    register_signal(c, SIGUSR1, "init-data-channel-failed");
> +                }

I am not happy to see this code fragment being copied here and having
the same code now three times almost identical.

This is the point where we should put it into its own fuction.



Otherwise the code looks good.
So

Semi-Acked-By: Arne Schwabe <arne@...1227...>

