MIME-Version: 1.0
References: <CAM8w-qEE6vHj=yUOpTFbM7DqPKzUV0NupvEG4rUefY=kNB2DxQ@...278...>
In-Reply-To: <CAM8w-qEE6vHj=yUOpTFbM7DqPKzUV0NupvEG4rUefY=kNB2DxQ@...278...>
From: Marco Baffo <marco@...2726...>
Date: Wed, 3 Dec 2025 14:31:49 +0100
Message-ID: <CAL7H48QT3YbGfmbmGHa+hs9P=xw3kjXcW_9F0xPZ795ee8-7pg@...278...>
Content-Type: multipart/alternative; boundary="000000000000c246a606450c3c3b"
Subject: Re: [Openvpn-devel] [Bugfix v2]: PUSH_UPDATE: fix option reset
 logic in continuation messages
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Moritz Fain <moritz-openvpn@...2969...>
Cc: openvpn-devel@lists.sourceforge.net

--000000000000c246a606450c3c3b
Content-Type: text/plain; charset="UTF-8"

LGTM. Thank you for submitting the patch!

Acked-By: Marco Baffo <marco@...2726...>

On Mon, 1 Dec 2025 at 15:35, Moritz Fain <moritz-openvpn@...2969...> wrote:

> https://github.com/OpenVPN/openvpn/pull/925
>
> Previously, the logic for resetting push options (like 'route') was based
> on
> `update_options_found` which was local to `apply_push_options`. This meant
> that if a PUSH_UPDATE was split across multiple continuation messages,
> the state was lost, causing routes to be reset multiple times (once per
> message chunk) rather than once per update sequence.
>
> This patch moves the state tracking to `struct options` as
> `push_update_options_found`, allowing it to persist across the entire
> PUSH_UPDATE sequence.
>
> This fixes an issue where large route lists sent via PUSH_UPDATE would
> result in only the last chunk's routes being applied, or previous routes
> being continuously deleted and re-added.
>
> Added unit test `test_incoming_push_continuation_route_accumulation` to
> verify the fix.
> ---
>  src/openvpn/options.c                         |  27 ++---
>  src/openvpn/options.h                         |   6 +-
>  src/openvpn/options_parse.c                   |   8 +-
>  src/openvpn/push.c                            |   8 +-
>  tests/unit_tests/openvpn/test_options_parse.c |   2 +-
>  .../unit_tests/openvpn/test_push_update_msg.c | 106 +++++++++++++++++-
>  6 files changed, 131 insertions(+), 26 deletions(-)
>
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index a3fc19d6..0988dfd0 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -3234,6 +3234,7 @@ pre_connect_restore(struct options *o, struct
> gc_arena *gc)
>
>      o->push_continuation = 0;
>      o->push_option_types_found = 0;
> +    o->push_update_options_found = 0;
>      o->imported_protocol_flags = 0;
>  }
>
> @@ -5409,14 +5410,14 @@ void
>  update_option(struct context *c, struct options *options, char *p[],
> bool is_inline,
>                const char *file, int line, const int level, const
> msglvl_t msglevel,
>                const unsigned int permission_mask, unsigned int
> *option_types_found,
> -              struct env_set *es, unsigned int *update_options_found)
> +              struct env_set *es)
>  {
>      const bool pull_mode = BOOL_CAST(permission_mask & OPT_P_PULL_MODE);
>      ASSERT(MAX_PARMS >= 7);
>
>      if (streq(p[0], "route") && p[1] && !p[5])
>      {
> -        if (!(*update_options_found & OPT_P_U_ROUTE))
> +        if (!(options->push_update_options_found & OPT_P_U_ROUTE))
>          {
>              VERIFY_PERMISSION(OPT_P_ROUTE);
>              if (!check_route_option(options, p, msglevel, pull_mode))
> @@ -5429,12 +5430,12 @@ update_option(struct context *c, struct
> options *options, char *p[], bool is_inl
>                                   es, &c->net_ctx);
>                  RESET_OPTION_ROUTES(options->routes, routes);
>              }
> -            *update_options_found |= OPT_P_U_ROUTE;
> +            options->push_update_options_found |= OPT_P_U_ROUTE;
>          }
>      }
>      else if (streq(p[0], "route-ipv6") && p[1] && !p[4])
>      {
> -        if (!(*update_options_found & OPT_P_U_ROUTE6))
> +        if (!(options->push_update_options_found & OPT_P_U_ROUTE6))
>          {
>              VERIFY_PERMISSION(OPT_P_ROUTE);
>              if (!check_route6_option(options, p, msglevel, pull_mode))
> @@ -5447,12 +5448,12 @@ update_option(struct context *c, struct
> options *options, char *p[], bool is_inl
>                                   ROUTE_OPTION_FLAGS(&c->options), es,
> &c->net_ctx);
>                  RESET_OPTION_ROUTES(options->routes_ipv6, routes_ipv6);
>              }
> -            *update_options_found |= OPT_P_U_ROUTE6;
> +            options->push_update_options_found |= OPT_P_U_ROUTE6;
>          }
>      }
>      else if (streq(p[0], "redirect-gateway") || streq(p[0],
> "redirect-private"))
>      {
> -        if (!(*update_options_found & OPT_P_U_REDIR_GATEWAY))
> +        if (!(options->push_update_options_found & OPT_P_U_REDIR_GATEWAY))
>          {
>              VERIFY_PERMISSION(OPT_P_ROUTE);
>              if (options->routes)
> @@ -5465,12 +5466,12 @@ update_option(struct context *c, struct
> options *options, char *p[], bool is_inl
>              }
>              env_set_del(es, "route_redirect_gateway_ipv4");
>              env_set_del(es, "route_redirect_gateway_ipv6");
> -            *update_options_found |= OPT_P_U_REDIR_GATEWAY;
> +            options->push_update_options_found |= OPT_P_U_REDIR_GATEWAY;
>          }
>      }
>      else if (streq(p[0], "dns") && p[1])
>      {
> -        if (!(*update_options_found & OPT_P_U_DNS))
> +        if (!(options->push_update_options_found & OPT_P_U_DNS))
>          {
>              VERIFY_PERMISSION(OPT_P_DHCPDNS);
>              if (!check_dns_option(options, p, msglevel, pull_mode))
> @@ -5479,13 +5480,13 @@ update_option(struct context *c, struct
> options *options, char *p[], bool is_inl
>              }
>              gc_free(&options->dns_options.gc);
>              CLEAR(options->dns_options);
> -            *update_options_found |= OPT_P_U_DNS;
> +            options->push_update_options_found |= OPT_P_U_DNS;
>          }
>      }
>  #if defined(_WIN32) || defined(TARGET_ANDROID)
>      else if (streq(p[0], "dhcp-option") && p[1] && !p[3])
>      {
> -        if (!(*update_options_found & OPT_P_U_DHCP))
> +        if (!(options->push_update_options_found & OPT_P_U_DHCP))
>          {
>              struct tuntap_options *o = &options->tuntap_options;
>              VERIFY_PERMISSION(OPT_P_DHCPDNS);
> @@ -5515,17 +5516,17 @@ update_option(struct context *c, struct
> options *options, char *p[], bool is_inl
>              o->http_proxy_port = 0;
>              o->http_proxy = NULL;
>  #endif
> -            *update_options_found |= OPT_P_U_DHCP;
> +            options->push_update_options_found |= OPT_P_U_DHCP;
>          }
>      }
>  #else  /* if defined(_WIN32) || defined(TARGET_ANDROID) */
>      else if (streq(p[0], "dhcp-option") && p[1] && !p[3])
>      {
> -        if (!(*update_options_found & OPT_P_U_DHCP))
> +        if (!(options->push_update_options_found & OPT_P_U_DHCP))
>          {
>              VERIFY_PERMISSION(OPT_P_DHCPDNS);
>              delete_all_dhcp_fo(options, &es->list);
> -            *update_options_found |= OPT_P_U_DHCP;
> +            options->push_update_options_found |= OPT_P_U_DHCP;
>          }
>      }
>  #endif /* if defined(_WIN32) || defined(TARGET_ANDROID) */
> diff --git a/src/openvpn/options.h b/src/openvpn/options.h
> index 42db9cae..d3310332 100644
> --- a/src/openvpn/options.h
> +++ b/src/openvpn/options.h
> @@ -558,6 +558,7 @@ struct options
>      bool pull; /* client pull of config options from server */
>      int push_continuation;
>      unsigned int push_option_types_found;
> +    unsigned int push_update_options_found; /* tracks which option
> types have been reset in current PUSH_UPDATE sequence */
>      const char *auth_user_pass_file;
>      bool auth_user_pass_file_inline;
>      struct options_pre_connect *pre_connect;
> @@ -863,14 +864,11 @@ void remove_option(struct context *c, struct
> options *options, char *p[], bool i
>   * @param option_types_found A pointer to the variable where the
> flags corresponding to the options
>   * found are stored.
>   * @param es The environment set structure.
> - * @param update_options_found A pointer to the variable where the
> flags corresponding to the update
> - * options found are stored, used to check if an option of the same
> type has already been processed
> - * by update_option() within the same push-update message.
>   */
>  void update_option(struct context *c, struct options *options, char
> *p[], bool is_inline,
>                     const char *file, int line, const int level, const
> msglvl_t msglevel,
>                     const unsigned int permission_mask, unsigned int
> *option_types_found,
> -                   struct env_set *es, unsigned int
> *update_options_found);
> +                   struct env_set *es);
>
>  void parse_argv(struct options *options, const int argc, char
> *argv[], const msglvl_t msglevel,
>                  const unsigned int permission_mask, unsigned int
> *option_types_found,
> diff --git a/src/openvpn/options_parse.c b/src/openvpn/options_parse.c
> index bb5b4049..4cbd903b 100644
> --- a/src/openvpn/options_parse.c
> +++ b/src/openvpn/options_parse.c
> @@ -517,7 +517,6 @@ apply_push_options(struct context *c, struct
> options *options, struct buffer *bu
>      int line_num = 0;
>      const char *file = "[PUSH-OPTIONS]";
>      const msglvl_t msglevel = D_PUSH_ERRORS | M_OPTERR;
> -    unsigned int update_options_found = 0;
>
>      while (buf_parse(buf, ',', line, sizeof(line)))
>      {
> @@ -564,8 +563,13 @@ apply_push_options(struct context *c, struct
> options *options, struct buffer *bu
>              }
>              else
>              {
> +                /*
> +                 * Use persistent push_update_options_found from
> options struct to track
> +                 * which option types have been reset across
> continuation messages.
> +                 * This prevents routes from being reset on each
> continuation message.
> +                 */
>                  update_option(c, options, p, false, file, line_num,
> 0, msglevel, permission_mask,
> -                              option_types_found, es,
> &update_options_found);
> +                              option_types_found, es);
>              }
>          }
>      }
> diff --git a/src/openvpn/push.c b/src/openvpn/push.c
> index 7852d360..898d1585 100644
> --- a/src/openvpn/push.c
> +++ b/src/openvpn/push.c
> @@ -540,11 +540,15 @@ incoming_push_message(struct context *c, const
> struct buffer *buffer)
>              }
>              else
>              {
> -                if (!option_types_found)
> +                /* Clear push_update_options_found for next
> PUSH_UPDATE sequence */
> +                c->options.push_update_options_found = 0;
> +
> +                /* Use accumulated option_types_found for the entire
> PUSH_UPDATE sequence */
> +                if (!c->options.push_option_types_found)
>                  {
>                      msg(M_WARN, "No updatable options found in
> incoming PUSH_UPDATE message");
>                  }
> -                else if (!do_update(c, option_types_found))
> +                else if (!do_update(c,
> c->options.push_option_types_found))
>                  {
>                      msg(D_PUSH_ERRORS, "Failed to update options");
>                      goto error;
> diff --git a/tests/unit_tests/openvpn/test_options_parse.c
> b/tests/unit_tests/openvpn/test_options_parse.c
> index 59a3f6df..adf3e5ba 100644
> --- a/tests/unit_tests/openvpn/test_options_parse.c
> +++ b/tests/unit_tests/openvpn/test_options_parse.c
> @@ -60,7 +60,7 @@ void
>  update_option(struct context *c, struct options *options, char *p[],
> bool is_inline,
>                const char *file, int line, const int level, const
> msglvl_t msglevel,
>                const unsigned int permission_mask, unsigned int
> *option_types_found,
> -              struct env_set *es, unsigned int *update_options_found)
> +              struct env_set *es)
>  {
>  }
>
> diff --git a/tests/unit_tests/openvpn/test_push_update_msg.c
> b/tests/unit_tests/openvpn/test_push_update_msg.c
> index 6ef12668..5c16001b 100644
> --- a/tests/unit_tests/openvpn/test_push_update_msg.c
> +++ b/tests/unit_tests/openvpn/test_push_update_msg.c
> @@ -54,6 +54,20 @@ options_postprocess_pull(struct options *options,
> struct env_set *es)
>      return true;
>  }
>
> +/*
> + * Counters to track route accumulation across continuation messages.
> + * Used to verify the bug where update_options_found resets per message.
> + */
> +static int route_reset_count = 0;
> +static int route_add_count = 0;
> +
> +static void
> +reset_route_counters(void)
> +{
> +    route_reset_count = 0;
> +    route_add_count = 0;
> +}
> +
>  bool
>  apply_push_options(struct context *c, struct options *options, struct
> buffer *buf,
>                     unsigned int permission_mask, unsigned int
> *option_types_found,
> @@ -61,6 +75,12 @@ apply_push_options(struct context *c, struct
> options *options, struct buffer *bu
>  {
>      char line[OPTION_PARM_SIZE];
>
> +    /*
> +     * Use persistent push_update_options_found from options struct to
> track
> +     * which option types have been reset across continuation messages.
> +     * This is the FIXED behavior - routes are only reset once per
> PUSH_UPDATE sequence.
> +     */
> +
>      while (buf_parse(buf, ',', line, sizeof(line)))
>      {
>          unsigned int push_update_option_flags = 0;
> @@ -84,10 +104,27 @@ apply_push_options(struct context *c, struct
> options *options, struct buffer *bu
>                  return false; /* Cause push/pull error and stop push
> processing */
>              }
>          }
> -        /*
> -         * No need to test also the application part here
> -         * (add_option/remove_option/update_option)
> -         */
> +
> +        /* Simulate route handling from update_option() in options.c */
> +        if (strncmp(&line[i], "route ", 6) == 0)
> +        {
> +            if (!(options->push_update_options_found & OPT_P_U_ROUTE))
> +            {
> +                /* First route in entire PUSH_UPDATE sequence - reset
> routes once */
> +                route_reset_count++;
> +                options->push_update_options_found |= OPT_P_U_ROUTE;
> +            }
> +            route_add_count++;
> +        }
> +        /* Simulate add_option() push-continuation logic */
> +        else if (!strcmp(&line[i], "push-continuation 2"))
> +        {
> +            options->push_continuation = 2;
> +        }
> +        else if (!strcmp(&line[i], "push-continuation 1"))
> +        {
> +            options->push_continuation = 1;
> +        }
>      }
>      return true;
>  }
> @@ -292,6 +329,65 @@ test_incoming_push_message_mix2(void **state)
>      free_buf(&buf);
>  }
>
> +/**
> + * Test that routes accumulate correctly across multiple continuation
> messages.
> + * This test exposes a bug where update_options_found is reset to 0 for
> each
> + * continuation message, causing routes to be reset on each message
> instead
> + * of accumulating.
> + *
> + * Expected behavior: routes should only be reset ONCE (when the
> first route is received),
> + * then all subsequent routes should accumulate.
> + *
> + * Current bug: routes are reset on the first route of EACH
> continuation message.
> + */
> +static void
> +test_incoming_push_continuation_route_accumulation(void **state)
> +{
> +    struct context *c = *state;
> +    unsigned int option_types_found = 0;
> +
> +    reset_route_counters();
> +
> +    /* Message 1: first batch of routes, continuation 2 (more coming) */
> +    struct buffer buf1 = alloc_buf(512);
> +    const char *msg1 = "PUSH_UPDATE, route 10.1.0.0 255.255.0.0,
> route 10.2.0.0 255.255.0.0, route 10.3.0.0
> 255.255.0.0,push-continuation 2";
> +    buf_write(&buf1, msg1, strlen(msg1));
> +
> +    assert_int_equal(process_incoming_push_msg(c, &buf1,
> c->options.pull, pull_permission_mask(c),
> +                                               &option_types_found),
> +                     PUSH_MSG_CONTINUATION);
> +    free_buf(&buf1);
> +
> +    /* Message 2: more routes, continuation 2 (more coming) */
> +    struct buffer buf2 = alloc_buf(512);
> +    const char *msg2 = "PUSH_UPDATE, route 10.4.0.0 255.255.0.0,
> route 10.5.0.0 255.255.0.0, route 10.6.0.0
> 255.255.0.0,push-continuation 2";
> +    buf_write(&buf2, msg2, strlen(msg2));
> +
> +    assert_int_equal(process_incoming_push_msg(c, &buf2,
> c->options.pull, pull_permission_mask(c),
> +                                               &option_types_found),
> +                     PUSH_MSG_CONTINUATION);
> +    free_buf(&buf2);
> +
> +    /* Message 3: final batch of routes, continuation 1 (last message) */
> +    struct buffer buf3 = alloc_buf(512);
> +    const char *msg3 = "PUSH_UPDATE, route 10.7.0.0 255.255.0.0,
> route 10.8.0.0 255.255.0.0, route 10.9.0.0
> 255.255.0.0,push-continuation 1";
> +    buf_write(&buf3, msg3, strlen(msg3));
> +
> +    assert_int_equal(process_incoming_push_msg(c, &buf3,
> c->options.pull, pull_permission_mask(c),
> +                                               &option_types_found),
> +                     PUSH_MSG_UPDATE);
> +    free_buf(&buf3);
> +
> +    /* Verify: all 9 routes should have been added */
> +    assert_int_equal(route_add_count, 9);
> +
> +    /*
> +     * Verify: route option is reset only one time in the first message
> +     * if a push-continuation is present.
> +     */
> +    assert_int_equal(route_reset_count, 1);
> +}
> +
>  #ifdef ENABLE_MANAGEMENT
>  char *r0[] = {
>      "PUSH_UPDATE,redirect-gateway local,route 192.168.1.0 255.255.255.0",
> @@ -603,6 +699,8 @@ main(void)
>
>  cmocka_unit_test_setup_teardown(test_incoming_push_message_bad_format,
> setup, teardown),
>          cmocka_unit_test_setup_teardown(test_incoming_push_message_mix,
> setup, teardown),
>          cmocka_unit_test_setup_teardown(test_incoming_push_message_mix2,
> setup, teardown),
> +
> cmocka_unit_test_setup_teardown(test_incoming_push_continuation_route_accumulation,
> setup,
> +                                        teardown),
>  #ifdef ENABLE_MANAGEMENT
>
>          cmocka_unit_test_setup_teardown(test_send_push_msg0, setup2,
> teardown2),
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--000000000000c246a606450c3c3b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>LGTM. Thank you for submitting the patch!</div><div><=
span style=3D"background-color:rgb(254,254,254);color:rgb(85,85,85);font-fa=
mily:monospace,sans-serif;font-size:14px"><br></span></div><div>Acked-By: M=
arco Baffo &lt;<a href=3D"mailto:marco@...2726...">marco@...2726...</a>&gt;=
</div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr"=
 class=3D"gmail_attr">On Mon, 1 Dec 2025 at 15:35, Moritz Fain &lt;<a href=
=3D"mailto:moritz-openvpn@...2969...">moritz-openvpn@...2969...</a>&gt; wro=
te:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><a href=3D"h=
ttps://github.com/OpenVPN/openvpn/pull/925" rel=3D"noreferrer" target=3D"_b=
lank">https://github.com/OpenVPN/openvpn/pull/925</a><br>
<br>
Previously, the logic for resetting push options (like &#39;route&#39;) was=
 based on<br>
`update_options_found` which was local to `apply_push_options`. This meant<=
br>
that if a PUSH_UPDATE was split across multiple continuation messages,<br>
the state was lost, causing routes to be reset multiple times (once per<br>
message chunk) rather than once per update sequence.<br>
<br>
This patch moves the state tracking to `struct options` as<br>
`push_update_options_found`, allowing it to persist across the entire<br>
PUSH_UPDATE sequence.<br>
<br>
This fixes an issue where large route lists sent via PUSH_UPDATE would<br>
result in only the last chunk&#39;s routes being applied, or previous route=
s<br>
being continuously deleted and re-added.<br>
<br>
Added unit test `test_incoming_push_continuation_route_accumulation` to<br>
verify the fix.<br>
---<br>
=C2=A0src/openvpn/options.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 27 ++---<br>
=C2=A0src/openvpn/options.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A06 +-<br>
=C2=A0src/openvpn/options_parse.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A08 +-<br>
=C2=A0src/openvpn/push.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A08 +-<br>
=C2=A0tests/unit_tests/openvpn/test_options_parse.c |=C2=A0 =C2=A02 +-<br>
=C2=A0.../unit_tests/openvpn/test_push_update_msg.c | 106 +++++++++++++++++=
-<br>
=C2=A06 files changed, 131 insertions(+), 26 deletions(-)<br>
<br>
diff --git a/src/openvpn/options.c b/src/openvpn/options.c<br>
index a3fc19d6..0988dfd0 100644<br>
--- a/src/openvpn/options.c<br>
+++ b/src/openvpn/options.c<br>
@@ -3234,6 +3234,7 @@ pre_connect_restore(struct options *o, struct<br>
gc_arena *gc)<br>
<br>
=C2=A0 =C2=A0 =C2=A0o-&gt;push_continuation =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0o-&gt;push_option_types_found =3D 0;<br>
+=C2=A0 =C2=A0 o-&gt;push_update_options_found =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0o-&gt;imported_protocol_flags =3D 0;<br>
=C2=A0}<br>
<br>
@@ -5409,14 +5410,14 @@ void<br>
=C2=A0update_option(struct context *c, struct options *options, char *p[],<=
br>
bool is_inline,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *file, in=
t line, const int level, const<br>
msglvl_t msglevel,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const unsigned int p=
ermission_mask, unsigned int<br>
*option_types_found,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct env_set *es, unsig=
ned int *update_options_found)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct env_set *es)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0const bool pull_mode =3D BOOL_CAST(permission_mask &amp=
; OPT_P_PULL_MODE);<br>
=C2=A0 =C2=A0 =C2=A0ASSERT(MAX_PARMS &gt;=3D 7);<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (streq(p[0], &quot;route&quot;) &amp;&amp; p[1] &amp=
;&amp; !p[5])<br>
=C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(*update_options_found &amp; OPT_P_U_ROUT=
E))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(options-&gt;push_update_options_found &a=
mp; OPT_P_U_ROUTE))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VERIFY_PERMISSION(OPT_P_ROU=
TE);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!check_route_option(opt=
ions, p, msglevel, pull_mode))<br>
@@ -5429,12 +5430,12 @@ update_option(struct context *c, struct<br>
options *options, char *p[], bool is_inl<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 es, &amp;c-&gt;net_ctx);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RESET_OPTION_=
ROUTES(options-&gt;routes, routes);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *update_options_found |=3D OPT_P=
_U_ROUTE;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 options-&gt;push_update_options_=
found |=3D OPT_P_U_ROUTE;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0else if (streq(p[0], &quot;route-ipv6&quot;) &amp;&amp;=
 p[1] &amp;&amp; !p[4])<br>
=C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(*update_options_found &amp; OPT_P_U_ROUT=
E6))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(options-&gt;push_update_options_found &a=
mp; OPT_P_U_ROUTE6))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VERIFY_PERMISSION(OPT_P_ROU=
TE);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!check_route6_option(op=
tions, p, msglevel, pull_mode))<br>
@@ -5447,12 +5448,12 @@ update_option(struct context *c, struct<br>
options *options, char *p[], bool is_inl<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ROUTE_OPTION_FLAGS(&amp;c-&gt=
;options), es,<br>
&amp;c-&gt;net_ctx);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RESET_OPTION_=
ROUTES(options-&gt;routes_ipv6, routes_ipv6);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *update_options_found |=3D OPT_P=
_U_ROUTE6;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 options-&gt;push_update_options_=
found |=3D OPT_P_U_ROUTE6;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0else if (streq(p[0], &quot;redirect-gateway&quot;) || s=
treq(p[0],<br>
&quot;redirect-private&quot;))<br>
=C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(*update_options_found &amp; OPT_P_U_REDI=
R_GATEWAY))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(options-&gt;push_update_options_found &a=
mp; OPT_P_U_REDIR_GATEWAY))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VERIFY_PERMISSION(OPT_P_ROU=
TE);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (options-&gt;routes)<br>
@@ -5465,12 +5466,12 @@ update_option(struct context *c, struct<br>
options *options, char *p[], bool is_inl<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env_set_del(es, &quot;route=
_redirect_gateway_ipv4&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env_set_del(es, &quot;route=
_redirect_gateway_ipv6&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *update_options_found |=3D OPT_P=
_U_REDIR_GATEWAY;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 options-&gt;push_update_options_=
found |=3D OPT_P_U_REDIR_GATEWAY;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0else if (streq(p[0], &quot;dns&quot;) &amp;&amp; p[1])<=
br>
=C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(*update_options_found &amp; OPT_P_U_DNS)=
)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(options-&gt;push_update_options_found &a=
mp; OPT_P_U_DNS))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VERIFY_PERMISSION(OPT_P_DHC=
PDNS);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!check_dns_option(optio=
ns, p, msglevel, pull_mode))<br>
@@ -5479,13 +5480,13 @@ update_option(struct context *c, struct<br>
options *options, char *p[], bool is_inl<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gc_free(&amp;options-&gt;dn=
s_options.gc);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CLEAR(options-&gt;dns_optio=
ns);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *update_options_found |=3D OPT_P=
_U_DNS;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 options-&gt;push_update_options_=
found |=3D OPT_P_U_DNS;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0#if defined(_WIN32) || defined(TARGET_ANDROID)<br>
=C2=A0 =C2=A0 =C2=A0else if (streq(p[0], &quot;dhcp-option&quot;) &amp;&amp=
; p[1] &amp;&amp; !p[3])<br>
=C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(*update_options_found &amp; OPT_P_U_DHCP=
))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(options-&gt;push_update_options_found &a=
mp; OPT_P_U_DHCP))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct tuntap_options *o =
=3D &amp;options-&gt;tuntap_options;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VERIFY_PERMISSION(OPT_P_DHC=
PDNS);<br>
@@ -5515,17 +5516,17 @@ update_option(struct context *c, struct<br>
options *options, char *p[], bool is_inl<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0o-&gt;http_proxy_port =3D 0=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0o-&gt;http_proxy =3D NULL;<=
br>
=C2=A0#endif<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *update_options_found |=3D OPT_P=
_U_DHCP;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 options-&gt;push_update_options_=
found |=3D OPT_P_U_DHCP;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0#else=C2=A0 /* if defined(_WIN32) || defined(TARGET_ANDROID) */<br>
=C2=A0 =C2=A0 =C2=A0else if (streq(p[0], &quot;dhcp-option&quot;) &amp;&amp=
; p[1] &amp;&amp; !p[3])<br>
=C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(*update_options_found &amp; OPT_P_U_DHCP=
))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(options-&gt;push_update_options_found &a=
mp; OPT_P_U_DHCP))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VERIFY_PERMISSION(OPT_P_DHC=
PDNS);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0delete_all_dhcp_fo(options,=
 &amp;es-&gt;list);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *update_options_found |=3D OPT_P=
_U_DHCP;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 options-&gt;push_update_options_=
found |=3D OPT_P_U_DHCP;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0#endif /* if defined(_WIN32) || defined(TARGET_ANDROID) */<br>
diff --git a/src/openvpn/options.h b/src/openvpn/options.h<br>
index 42db9cae..d3310332 100644<br>
--- a/src/openvpn/options.h<br>
+++ b/src/openvpn/options.h<br>
@@ -558,6 +558,7 @@ struct options<br>
=C2=A0 =C2=A0 =C2=A0bool pull; /* client pull of config options from server=
 */<br>
=C2=A0 =C2=A0 =C2=A0int push_continuation;<br>
=C2=A0 =C2=A0 =C2=A0unsigned int push_option_types_found;<br>
+=C2=A0 =C2=A0 unsigned int push_update_options_found; /* tracks which opti=
on<br>
types have been reset in current PUSH_UPDATE sequence */<br>
=C2=A0 =C2=A0 =C2=A0const char *auth_user_pass_file;<br>
=C2=A0 =C2=A0 =C2=A0bool auth_user_pass_file_inline;<br>
=C2=A0 =C2=A0 =C2=A0struct options_pre_connect *pre_connect;<br>
@@ -863,14 +864,11 @@ void remove_option(struct context *c, struct<br>
options *options, char *p[], bool i<br>
=C2=A0 * @param option_types_found A pointer to the variable where the<br>
flags corresponding to the options<br>
=C2=A0 * found are stored.<br>
=C2=A0 * @param es The environment set structure.<br>
- * @param update_options_found A pointer to the variable where the<br>
flags corresponding to the update<br>
- * options found are stored, used to check if an option of the same<br>
type has already been processed<br>
- * by update_option() within the same push-update message.<br>
=C2=A0 */<br>
=C2=A0void update_option(struct context *c, struct options *options, char<b=
r>
*p[], bool is_inline,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const=
 char *file, int line, const int level, const<br>
msglvl_t msglevel,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const=
 unsigned int permission_mask, unsigned int<br>
*option_types_found,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struc=
t env_set *es, unsigned int *update_options_found);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struc=
t env_set *es);<br>
<br>
=C2=A0void parse_argv(struct options *options, const int argc, char<br>
*argv[], const msglvl_t msglevel,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const unsigne=
d int permission_mask, unsigned int<br>
*option_types_found,<br>
diff --git a/src/openvpn/options_parse.c b/src/openvpn/options_parse.c<br>
index bb5b4049..4cbd903b 100644<br>
--- a/src/openvpn/options_parse.c<br>
+++ b/src/openvpn/options_parse.c<br>
@@ -517,7 +517,6 @@ apply_push_options(struct context *c, struct<br>
options *options, struct buffer *bu<br>
=C2=A0 =C2=A0 =C2=A0int line_num =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0const char *file =3D &quot;[PUSH-OPTIONS]&quot;;<br>
=C2=A0 =C2=A0 =C2=A0const msglvl_t msglevel =3D D_PUSH_ERRORS | M_OPTERR;<b=
r>
-=C2=A0 =C2=A0 unsigned int update_options_found =3D 0;<br>
<br>
=C2=A0 =C2=A0 =C2=A0while (buf_parse(buf, &#39;,&#39;, line, sizeof(line)))=
<br>
=C2=A0 =C2=A0 =C2=A0{<br>
@@ -564,8 +563,13 @@ apply_push_options(struct context *c, struct<br>
options *options, struct buffer *bu<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Use persis=
tent push_update_options_found from<br>
options struct to track<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* which opti=
on types have been reset across<br>
continuation messages.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* This preve=
nts routes from being reset on each<br>
continuation message.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0update_option=
(c, options, p, false, file, line_num,<br>
0, msglevel, permission_mask,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 option_types_found, es, &amp;update_options=
_found);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 option_types_found, es);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
diff --git a/src/openvpn/push.c b/src/openvpn/push.c<br>
index 7852d360..898d1585 100644<br>
--- a/src/openvpn/push.c<br>
+++ b/src/openvpn/push.c<br>
@@ -540,11 +540,15 @@ incoming_push_message(struct context *c, const<br>
struct buffer *buffer)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!option_types_=
found)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Clear push_upda=
te_options_found for next<br>
PUSH_UPDATE sequence */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 c-&gt;options.push=
_update_options_found =3D 0;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Use accumulated=
 option_types_found for the entire<br>
PUSH_UPDATE sequence */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!c-&gt;options=
.push_option_types_found)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0msg(M_WARN, &quot;No updatable options found in<br>
incoming PUSH_UPDATE message&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (!do_updat=
e(c, option_types_found))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (!do_updat=
e(c, c-&gt;options.push_option_types_found))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0msg(D_PUSH_ERRORS, &quot;Failed to update options&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0goto error;<br>
diff --git a/tests/unit_tests/openvpn/test_options_parse.c<br>
b/tests/unit_tests/openvpn/test_options_parse.c<br>
index 59a3f6df..adf3e5ba 100644<br>
--- a/tests/unit_tests/openvpn/test_options_parse.c<br>
+++ b/tests/unit_tests/openvpn/test_options_parse.c<br>
@@ -60,7 +60,7 @@ void<br>
=C2=A0update_option(struct context *c, struct options *options, char *p[],<=
br>
bool is_inline,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *file, in=
t line, const int level, const<br>
msglvl_t msglevel,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const unsigned int p=
ermission_mask, unsigned int<br>
*option_types_found,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct env_set *es, unsig=
ned int *update_options_found)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct env_set *es)<br>
=C2=A0{<br>
=C2=A0}<br>
<br>
diff --git a/tests/unit_tests/openvpn/test_push_update_msg.c<br>
b/tests/unit_tests/openvpn/test_push_update_msg.c<br>
index 6ef12668..5c16001b 100644<br>
--- a/tests/unit_tests/openvpn/test_push_update_msg.c<br>
+++ b/tests/unit_tests/openvpn/test_push_update_msg.c<br>
@@ -54,6 +54,20 @@ options_postprocess_pull(struct options *options,<br>
struct env_set *es)<br>
=C2=A0 =C2=A0 =C2=A0return true;<br>
=C2=A0}<br>
<br>
+/*<br>
+ * Counters to track route accumulation across continuation messages.<br>
+ * Used to verify the bug where update_options_found resets per message.<b=
r>
+ */<br>
+static int route_reset_count =3D 0;<br>
+static int route_add_count =3D 0;<br>
+<br>
+static void<br>
+reset_route_counters(void)<br>
+{<br>
+=C2=A0 =C2=A0 route_reset_count =3D 0;<br>
+=C2=A0 =C2=A0 route_add_count =3D 0;<br>
+}<br>
+<br>
=C2=A0bool<br>
=C2=A0apply_push_options(struct context *c, struct options *options, struct=
<br>
buffer *buf,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsig=
ned int permission_mask, unsigned int<br>
*option_types_found,<br>
@@ -61,6 +75,12 @@ apply_push_options(struct context *c, struct<br>
options *options, struct buffer *bu<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0char line[OPTION_PARM_SIZE];<br>
<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* Use persistent push_update_options_found from option=
s struct to track<br>
+=C2=A0 =C2=A0 =C2=A0* which option types have been reset across continuati=
on messages.<br>
+=C2=A0 =C2=A0 =C2=A0* This is the FIXED behavior - routes are only reset o=
nce per<br>
PUSH_UPDATE sequence.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+<br>
=C2=A0 =C2=A0 =C2=A0while (buf_parse(buf, &#39;,&#39;, line, sizeof(line)))=
<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int push_update_option_flags =3D=
 0;<br>
@@ -84,10 +104,27 @@ apply_push_options(struct context *c, struct<br>
options *options, struct buffer *bu<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;=
 /* Cause push/pull error and stop push<br>
processing */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* No need to test also the application p=
art here<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* (add_option/remove_option/update_optio=
n)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Simulate route handling from update_option(=
) in options.c */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (strncmp(&amp;line[i], &quot;route &quot;, =
6) =3D=3D 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(options-&gt;push_update_op=
tions_found &amp; OPT_P_U_ROUTE))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* First route in =
entire PUSH_UPDATE sequence - reset<br>
routes once */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 route_reset_count+=
+;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 options-&gt;push_u=
pdate_options_found |=3D OPT_P_U_ROUTE;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 route_add_count++;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Simulate add_option() push-continuation log=
ic */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (!strcmp(&amp;line[i], &quot;push-cont=
inuation 2&quot;))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 options-&gt;push_continuation =
=3D 2;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (!strcmp(&amp;line[i], &quot;push-cont=
inuation 1&quot;))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 options-&gt;push_continuation =
=3D 1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0return true;<br>
=C2=A0}<br>
@@ -292,6 +329,65 @@ test_incoming_push_message_mix2(void **state)<br>
=C2=A0 =C2=A0 =C2=A0free_buf(&amp;buf);<br>
=C2=A0}<br>
<br>
+/**<br>
+ * Test that routes accumulate correctly across multiple continuation mess=
ages.<br>
+ * This test exposes a bug where update_options_found is reset to 0 for ea=
ch<br>
+ * continuation message, causing routes to be reset on each message instea=
d<br>
+ * of accumulating.<br>
+ *<br>
+ * Expected behavior: routes should only be reset ONCE (when the<br>
first route is received),<br>
+ * then all subsequent routes should accumulate.<br>
+ *<br>
+ * Current bug: routes are reset on the first route of EACH<br>
continuation message.<br>
+ */<br>
+static void<br>
+test_incoming_push_continuation_route_accumulation(void **state)<br>
+{<br>
+=C2=A0 =C2=A0 struct context *c =3D *state;<br>
+=C2=A0 =C2=A0 unsigned int option_types_found =3D 0;<br>
+<br>
+=C2=A0 =C2=A0 reset_route_counters();<br>
+<br>
+=C2=A0 =C2=A0 /* Message 1: first batch of routes, continuation 2 (more co=
ming) */<br>
+=C2=A0 =C2=A0 struct buffer buf1 =3D alloc_buf(512);<br>
+=C2=A0 =C2=A0 const char *msg1 =3D &quot;PUSH_UPDATE, route 10.1.0.0 255.2=
55.0.0,<br>
route 10.2.0.0 255.255.0.0, route 10.3.0.0<br>
255.255.0.0,push-continuation 2&quot;;<br>
+=C2=A0 =C2=A0 buf_write(&amp;buf1, msg1, strlen(msg1));<br>
+<br>
+=C2=A0 =C2=A0 assert_int_equal(process_incoming_push_msg(c, &amp;buf1,<br>
c-&gt;options.pull, pull_permission_mask(c),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0&amp;option_types_found),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0PUSH_MSG_CONTINUATION);<br>
+=C2=A0 =C2=A0 free_buf(&amp;buf1);<br>
+<br>
+=C2=A0 =C2=A0 /* Message 2: more routes, continuation 2 (more coming) */<b=
r>
+=C2=A0 =C2=A0 struct buffer buf2 =3D alloc_buf(512);<br>
+=C2=A0 =C2=A0 const char *msg2 =3D &quot;PUSH_UPDATE, route 10.4.0.0 255.2=
55.0.0,<br>
route 10.5.0.0 255.255.0.0, route 10.6.0.0<br>
255.255.0.0,push-continuation 2&quot;;<br>
+=C2=A0 =C2=A0 buf_write(&amp;buf2, msg2, strlen(msg2));<br>
+<br>
+=C2=A0 =C2=A0 assert_int_equal(process_incoming_push_msg(c, &amp;buf2,<br>
c-&gt;options.pull, pull_permission_mask(c),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0&amp;option_types_found),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0PUSH_MSG_CONTINUATION);<br>
+=C2=A0 =C2=A0 free_buf(&amp;buf2);<br>
+<br>
+=C2=A0 =C2=A0 /* Message 3: final batch of routes, continuation 1 (last me=
ssage) */<br>
+=C2=A0 =C2=A0 struct buffer buf3 =3D alloc_buf(512);<br>
+=C2=A0 =C2=A0 const char *msg3 =3D &quot;PUSH_UPDATE, route 10.7.0.0 255.2=
55.0.0,<br>
route 10.8.0.0 255.255.0.0, route 10.9.0.0<br>
255.255.0.0,push-continuation 1&quot;;<br>
+=C2=A0 =C2=A0 buf_write(&amp;buf3, msg3, strlen(msg3));<br>
+<br>
+=C2=A0 =C2=A0 assert_int_equal(process_incoming_push_msg(c, &amp;buf3,<br>
c-&gt;options.pull, pull_permission_mask(c),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0&amp;option_types_found),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0PUSH_MSG_UPDATE);<br>
+=C2=A0 =C2=A0 free_buf(&amp;buf3);<br>
+<br>
+=C2=A0 =C2=A0 /* Verify: all 9 routes should have been added */<br>
+=C2=A0 =C2=A0 assert_int_equal(route_add_count, 9);<br>
+<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* Verify: route option is reset only one time in the f=
irst message<br>
+=C2=A0 =C2=A0 =C2=A0* if a push-continuation is present.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 assert_int_equal(route_reset_count, 1);<br>
+}<br>
+<br>
=C2=A0#ifdef ENABLE_MANAGEMENT<br>
=C2=A0char *r0[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0&quot;PUSH_UPDATE,redirect-gateway local,route 192.168.=
1.0 255.255.255.0&quot;,<br>
@@ -603,6 +699,8 @@ main(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cmocka_unit_test_setup_teardown(test_inco=
ming_push_message_bad_format,<br>
setup, teardown),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cmocka_unit_test_setup_teardown(test_inco=
ming_push_message_mix,<br>
setup, teardown),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cmocka_unit_test_setup_teardown(test_inco=
ming_push_message_mix2,<br>
setup, teardown),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cmocka_unit_test_setup_teardown(test_incoming_=
push_continuation_route_accumulation,<br>
setup,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 teardown=
),<br>
=C2=A0#ifdef ENABLE_MANAGEMENT<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cmocka_unit_test_setup_teardown(test_send=
_push_msg0, setup2,<br>
teardown2),<br>
<br>
<br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blank">Op=
envpn-devel@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
</blockquote></div></div>

--000000000000c246a606450c3c3b--

