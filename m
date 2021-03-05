MIME-Version: 1.0
References: <CAGyAFMWGUfXeiw6sp5LE1SsH88-TF_K20y6z62MYrOJ_PcMLGg@...278...>
 <20210303123818.16012-1-arne@...1227...>
In-Reply-To: <20210303123818.16012-1-arne@...1227...>
From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 5 Mar 2021 14:50:34 +0200
Message-ID: <CAGyAFMXL8we+X1+G65kuctZYtCEfBhR1c9OQCkguUQc-t9xEcQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH v3] Implement server side of
 AUTH_PENDING with extending timeout
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Acked-by: Lev Stipakov <lstipakov@...277...>

ke 3. maalisk. 2021 klo 14.39 Arne Schwabe (arne@...1227...) kirjoitti:
>
> Patch V2: eliminate parse_kid function, fix style
> Patch V3: adding missing parameter in function, this was added
>           by a later patch in the original series
>
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  src/openvpn/manage.c     | 23 +++++++++--------
>  src/openvpn/manage.h     |  3 ++-
>  src/openvpn/multi.c      | 27 +++-----------------
>  src/openvpn/push.c       | 55 +++++++++++++++++++++++++++++++++++++---
>  src/openvpn/push.h       | 14 +++++++++-
>  src/openvpn/ssl.c        |  1 +
>  src/openvpn/ssl_common.h |  1 +
>  7 files changed, 84 insertions(+), 40 deletions(-)
>
> diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
> index 169e645f..df987f53 100644
> --- a/src/openvpn/manage.c
> +++ b/src/openvpn/manage.c
> @@ -975,15 +975,15 @@ parse_cid(const char *str, unsigned long *cid)
>  }
>
>  static bool
> -parse_kid(const char *str, unsigned int *kid)
> +parse_uint(const char *str, const char* what, unsigned int *uint)
>  {
> -    if (sscanf(str, "%u", kid) == 1)
> +    if (sscanf(str, "%u", uint) == 1)
>      {
>          return true;
>      }
>      else
>      {
> -        msg(M_CLIENT, "ERROR: cannot parse KID");
> +        msg(M_CLIENT, "ERROR: cannot parse %s", what);
>          return false;
>      }
>  }
> @@ -998,15 +998,18 @@ parse_kid(const char *str, unsigned int *kid)
>   *                      the information of the additional steps
>   */
>  static void
> -man_client_pending_auth(struct management *man, const char *cid_str, const char *extra)
> +man_client_pending_auth(struct management *man, const char *cid_str,
> +                        const char *extra, const char *timeout_str)
>  {
>      unsigned long cid = 0;
> -    if (parse_cid(cid_str, &cid))
> +    unsigned int timeout = 0;
> +    if (parse_cid(cid_str, &cid)
> +        && parse_uint(timeout_str, "TIMEOUT", &timeout))
>      {
>          if (man->persist.callback.client_pending_auth)
>          {
>              bool ret = (*man->persist.callback.client_pending_auth)
> -                           (man->persist.callback.arg, cid, extra);
> +                           (man->persist.callback.arg, cid, extra, timeout);
>
>              if (ret)
>              {
> @@ -1032,7 +1035,7 @@ man_client_auth(struct management *man, const char *cid_str, const char *kid_str
>      mc->in_extra_cid = 0;
>      mc->in_extra_kid = 0;
>      if (parse_cid(cid_str, &mc->in_extra_cid)
> -        && parse_kid(kid_str, &mc->in_extra_kid))
> +        && parse_uint(kid_str, "KID", &mc->in_extra_kid))
>      {
>          mc->in_extra_cmd = IEC_CLIENT_AUTH;
>          in_extra_reset(mc, IER_NEW);
> @@ -1048,7 +1051,7 @@ man_client_deny(struct management *man, const char *cid_str, const char *kid_str
>  {
>      unsigned long cid = 0;
>      unsigned int kid = 0;
> -    if (parse_cid(cid_str, &cid) && parse_kid(kid_str, &kid))
> +    if (parse_cid(cid_str, &cid) && parse_uint(kid_str, "KID", &kid))
>      {
>          if (man->persist.callback.client_auth)
>          {
> @@ -1563,9 +1566,9 @@ man_dispatch_command(struct management *man, struct status_output *so, const cha
>      }
>      else if (streq(p[0], "client-pending-auth"))
>      {
> -        if (man_need(man, p, 2, 0))
> +        if (man_need(man, p, 3, 0))
>          {
> -            man_client_pending_auth(man, p[1], p[2]);
> +            man_client_pending_auth(man, p[1], p[2], p[3]);
>          }
>      }
>  #ifdef MANAGEMENT_PF
> diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
> index 9797842b..41eacc02 100644
> --- a/src/openvpn/manage.h
> +++ b/src/openvpn/manage.h
> @@ -173,7 +173,8 @@ struct management_callback
>                           struct buffer_list *cc_config); /* ownership transferred */
>      bool (*client_pending_auth) (void *arg,
>                                   const unsigned long cid,
> -                                 const char *url);
> +                                 const char *extra,
> +                                 unsigned int timeout);
>      char *(*get_peer_info) (void *arg, const unsigned long cid);
>  #ifdef MANAGEMENT_PF
>      bool (*client_pf)(void *arg,
> diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
> index dd713049..ac5d3f5b 100644
> --- a/src/openvpn/multi.c
> +++ b/src/openvpn/multi.c
> @@ -1768,28 +1768,6 @@ multi_client_connect_setenv(struct multi_context *m,
>      gc_free(&gc);
>  }
>
> -/**
> - * Extracts the IV_PROTO variable and returns its value or 0
> - * if it cannot be extracted.
> - *
> - */
> -static unsigned int
> -extract_iv_proto(const char *peer_info)
> -{
> -
> -    const char *optstr = peer_info ? strstr(peer_info, "IV_PROTO=") : NULL;
> -    if (optstr)
> -    {
> -        int proto = 0;
> -        int r = sscanf(optstr, "IV_PROTO=%d", &proto);
> -        if (r == 1 && proto > 0)
> -        {
> -            return proto;
> -        }
> -    }
> -    return 0;
> -}
> -
>  /**
>   * Calculates the options that depend on the client capabilities
>   * based on local options and available peer info
> @@ -3918,14 +3896,15 @@ management_kill_by_cid(void *arg, const unsigned long cid, const char *kill_msg)
>  static bool
>  management_client_pending_auth(void *arg,
>                                 const unsigned long cid,
> -                               const char *extra)
> +                               const char *extra,
> +                               unsigned int timeout)
>  {
>      struct multi_context *m = (struct multi_context *) arg;
>      struct multi_instance *mi = lookup_by_cid(m, cid);
>      if (mi)
>      {
>          /* sends INFO_PRE and AUTH_PENDING messages to client */
> -        bool ret = send_auth_pending_messages(&mi->context, extra);
> +        bool ret = send_auth_pending_messages(&mi->context, extra, timeout);
>          multi_schedule_context_wakeup(m, mi);
>          return ret;
>      }
> diff --git a/src/openvpn/push.c b/src/openvpn/push.c
> index 9a67e036..46267835 100644
> --- a/src/openvpn/push.c
> +++ b/src/openvpn/push.c
> @@ -361,26 +361,57 @@ send_auth_failed(struct context *c, const char *client_reason)
>      gc_free(&gc);
>  }
>
> +
>  bool
> -send_auth_pending_messages(struct context *c, const char *extra)
> +send_auth_pending_messages(struct context *c, const char *extra,
> +                           unsigned int timeout)
>  {
> -    send_control_channel_string(c, "AUTH_PENDING", D_PUSH);
> +    struct tls_multi *tls_multi = c->c2.tls_multi;
> +    struct key_state *ks = &tls_multi->session[TM_ACTIVE].key[KS_PRIMARY];
>
>      static const char info_pre[] = "INFO_PRE,";
>
> +    const char *const peer_info = tls_multi->peer_info;
> +    unsigned int proto = extract_iv_proto(peer_info);
> +
>
> -    size_t len = strlen(extra)+1 + sizeof(info_pre);
> +    /* Calculate the maximum timeout and subtract the time we already waited */
> +    unsigned int max_timeout = max_uint(tls_multi->opt.renegotiate_seconds/2,
> +                                        tls_multi->opt.handshake_window);
> +    max_timeout = max_timeout - (now - ks->initial);
> +    timeout = min_uint(max_timeout, timeout);
> +
> +    struct gc_arena gc = gc_new();
> +    if ((proto & IV_PROTO_AUTH_PENDING_KW) == 0)
> +    {
> +        send_control_channel_string(c, "AUTH_PENDING", D_PUSH);
> +    }
> +    else
> +    {
> +        static const char auth_pre[] = "AUTH_PENDING,timeout ";
> +        // Assume a worst case of 8 byte uint64 in decimal which
> +        // needs 20 bytes
> +        size_t len = 20 + 1 + sizeof(auth_pre);
> +        struct buffer buf = alloc_buf_gc(len, &gc);
> +        buf_printf(&buf, auth_pre);
> +        buf_printf(&buf, "%u", timeout);
> +        send_control_channel_string(c, BSTR(&buf), D_PUSH);
> +    }
> +
> +    size_t len = strlen(extra) + 1 + sizeof(info_pre);
>      if (len > PUSH_BUNDLE_SIZE)
>      {
> +        gc_free(&gc);
>          return false;
>      }
> -    struct gc_arena gc = gc_new();
>
>      struct buffer buf = alloc_buf_gc(len, &gc);
>      buf_printf(&buf, info_pre);
>      buf_printf(&buf, "%s", extra);
>      send_control_channel_string(c, BSTR(&buf), D_PUSH);
>
> +    ks->auth_deferred_expire = now + timeout;
> +
>      gc_free(&gc);
>      return true;
>  }
> @@ -1028,4 +1059,20 @@ remove_iroutes_from_push_route_list(struct options *o)
>      }
>  }
>
> +unsigned int
> +extract_iv_proto(const char *peer_info)
> +{
> +    const char *optstr = peer_info ? strstr(peer_info, "IV_PROTO=") : NULL;
> +    if (optstr)
> +    {
> +        int proto = 0;
> +        int r = sscanf(optstr, "IV_PROTO=%d", &proto);
> +        if (r == 1 && proto > 0)
> +        {
> +            return proto;
> +        }
> +    }
> +    return 0;
> +}
> +
>  #endif /* if P2MP */
> diff --git a/src/openvpn/push.h b/src/openvpn/push.h
> index 01847671..e7271de2 100644
> --- a/src/openvpn/push.h
> +++ b/src/openvpn/push.h
> @@ -77,7 +77,9 @@ void send_auth_failed(struct context *c, const char *client_reason);
>   * doc/management-notes.txt under client-pending-auth for
>   * more details on message format
>   */
> -bool send_auth_pending_messages(struct context *c, const char *extra);
> +bool
> +send_auth_pending_messages(struct context *c, const char *extra,
> +                           unsigned int timeout);
>
>  void send_restart(struct context *c, const char *kill_msg);
>
> @@ -89,6 +91,16 @@ void send_restart(struct context *c, const char *kill_msg);
>   */
>  void send_push_reply_auth_token(struct tls_multi *multi);
>
> +
> +/**
> + * Extracts the IV_PROTO variable and returns its value or 0
> + * if it cannot be extracted.
> + *
> + * @param peer_info     peer info string to search for IV_PROTO
> + */
> +unsigned int
> +extract_iv_proto(const char *peer_info);
> +
>  /**
>   * Parses an AUTH_PENDING message and if in pull mode extends the timeout
>   *
> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> index 56cd4c60..1389322e 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
> @@ -2659,6 +2659,7 @@ tls_process(struct tls_multi *multi,
>              buf = reliable_get_buf_output_sequenced(ks->send_reliable);
>              if (buf)
>              {
> +                ks->initial = now;
>                  ks->must_negotiate = now + session->opt->handshake_window;
>                  ks->auth_deferred_expire = now + auth_deferred_expire_window(session->opt);
>
> diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
> index bbb8135d..bf7f9ba3 100644
> --- a/src/openvpn/ssl_common.h
> +++ b/src/openvpn/ssl_common.h
> @@ -175,6 +175,7 @@ struct key_state
>
>      struct key_state_ssl ks_ssl; /* contains SSL object and BIOs for the control channel */
>
> +    time_t initial;             /* when we created this session */
>      time_t established;         /* when our state went S_ACTIVE */
>      time_t must_negotiate;      /* key negotiation times out if not finished before this time */
>      time_t must_die;            /* this object is destroyed at this time */
> --
> 2.30.1
>
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel



-- 
-Lev

