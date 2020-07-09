References: <20200709101603.11941-1-arne@...1227...>
 <20200709101603.11941-2-arne@...1227...>
From: tincanteksup <tincanteksup@...277...>
Message-ID: <7a64695d-4eb9-ecba-4154-d1fd023e4b6c@...277...>
Date: Thu, 9 Jul 2020 14:11:22 +0100
MIME-Version: 1.0
In-Reply-To: <20200709101603.11941-2-arne@...1227...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH 2/8] Make key_state->authenticated more
 state machine like
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Typo

On 09/07/2020 11:15, Arne Schwabe wrote:
> This order the states from unauthenticated to authenticated and also
> changes the comparison for KS_AUTH_FALSE from != to >
> 
> It also add comments and documents part using the state machine
> better.
> 
> Remove a now obsolete comment and two obsolete ifdefs. While
> keeping the ifdef in ssl_verify would save a few bytes of code,
> this is too minor to justify keeping the ifdef
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>   src/openvpn/multi.c      | 12 +++++++++---
>   src/openvpn/ssl.c        |  7 ++++---
>   src/openvpn/ssl_common.h | 22 ++++++++++++++++------
>   src/openvpn/ssl_verify.c | 18 +++++++-----------
>   4 files changed, 36 insertions(+), 23 deletions(-)
> 
> diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
> index f1ced9b7..f1332c8d 100644
> --- a/src/openvpn/multi.c
> +++ b/src/openvpn/multi.c
> @@ -2352,12 +2352,12 @@ multi_process_post(struct multi_context *m, struct multi_instance *mi, const uns
>       if (!IS_SIG(&mi->context) && ((flags & MPP_PRE_SELECT) || ((flags & MPP_CONDITIONAL_PRE_SELECT) && !ANY_OUT(&mi->context))))
>       {
>   #if defined(ENABLE_ASYNC_PUSH) && defined(ENABLE_DEF_AUTH)
> -        bool was_authenticated = false;
> +        bool was_unauthenticated = true;
>           struct key_state *ks = NULL;
>           if (mi->context.c2.tls_multi)
>           {
>               ks = &mi->context.c2.tls_multi->session[TM_ACTIVE].key[KS_PRIMARY];
> -            was_authenticated = ks->authenticated;
> +            was_unauthenticated = (ks->authenticated == KS_AUTH_FALSE);
>           }
>   #endif
>   
> @@ -2366,7 +2366,13 @@ multi_process_post(struct multi_context *m, struct multi_instance *mi, const uns
>           pre_select(&mi->context);
>   
>   #if defined(ENABLE_ASYNC_PUSH) && defined(ENABLE_DEF_AUTH)
> -        if (ks && ks->auth_control_file && ks->auth_deferred && !was_authenticated)
> +        /*
> +         * if we see the state transition from unauthenticated to deferred
> +         * and a auth_control_file, we assume it got just added and add
> +         * inotify watch to that file
> +         */
> +        if (ks && ks->auth_control_file && was_unauthenticated
> +            && (ks->authenticated == KS_AUTH_DEFERRED))
>           {
>               /* watch acf file */
>               long watch_descriptor = inotify_add_watch(m->top.c2.inotify_fd, ks->auth_control_file, IN_CLOSE_WRITE | IN_ONESHOT);
> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> index 9df7552d..f3fe0ecf 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
> @@ -2466,7 +2466,7 @@ key_method_2_write(struct buffer *buf, struct tls_session *session)
>       if (session->opt->server && !(session->opt->ncp_enabled
>                                     && session->opt->mode == MODE_SERVER && ks->key_id <= 0))
>       {
> -        if (ks->authenticated != KS_AUTH_FALSE)
> +        if (ks->authenticated > KS_AUTH_FALSE)
>           {
>               if (!tls_session_generate_data_channel_keys(session))
>               {
> @@ -2659,7 +2659,7 @@ key_method_2_read(struct buffer *buf, struct tls_multi *multi, struct tls_sessio
>       secure_memzero(up, sizeof(*up));
>   
>       /* Perform final authentication checks */
> -    if (ks->authenticated != KS_AUTH_FALSE)
> +    if (ks->authenticated > KS_AUTH_FALSE)
>       {
>           verify_final_auth_checks(multi, session);
>       }
> @@ -2684,7 +2684,7 @@ key_method_2_read(struct buffer *buf, struct tls_multi *multi, struct tls_sessio
>        * Call OPENVPN_PLUGIN_TLS_FINAL plugin if defined, for final
>        * veto opportunity over authentication decision.
>        */
> -    if ((ks->authenticated != KS_AUTH_FALSE)
> +    if ((ks->authenticated > KS_AUTH_FALSE)
>           && plugin_defined(session->opt->plugins, OPENVPN_PLUGIN_TLS_FINAL))
>       {
>           key_state_export_keying_material(&ks->ks_ssl, session);
> @@ -2715,6 +2715,7 @@ key_method_2_read(struct buffer *buf, struct tls_multi *multi, struct tls_sessio
>       return true;
>   
>   error:
> +    ks->authenticated = KS_AUTH_FALSE;
>       secure_memzero(ks->key_src, sizeof(*ks->key_src));
>       if (up)
>       {
> diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
> index fdf589b5..dd82b77d 100644
> --- a/src/openvpn/ssl_common.h
> +++ b/src/openvpn/ssl_common.h
> @@ -127,10 +127,23 @@ struct key_source2 {
>       struct key_source server;   /**< Random provided by server. */
>   };
>   
> +
> +/**
> + * This refelects the (server side) state auf authentication after the TLS

refelects -> reflects



