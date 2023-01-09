Date: Mon, 9 Jan 2023 13:41:18 +0100
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <Y7wLbnHGIiy8M893@...2685...>
References: <20230105175614.405385-1-arne@...1227...>
 <20230106143841.506504-1-arne@...1227...>
MIME-Version: 1.0
In-Reply-To: <20230106143841.506504-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v2] Add connect-freq-initial option to
 limit initial connection responses
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

On Fri, Jan 06, 2023 at 03:38:41PM +0100, Arne Schwabe wrote:
> This limits the nubmer of packets OpenVPN will respond to. This avoid
> OpenVPN server being abused for refelection attacks in a large scale
> as we gotten a lot more efficient with the cookie approach in our
> initial connection approach.
> 
> The defaults of 100 attempts per 10s should work for most people,
> esepcially since completed three way handshakes are not counted. So
> the default will throttle connection attempts on server with high packet
> loss or that are actually under a DOS.
> 
> The 100 per 10s are similar in size to the old 2.5 and earlier behaviour
> where every initial connection attempt would take up a slot of the
> max-clients sessions and those would only expire after the TLS timeout.
> This roughly translates to 1024 connection attempts in 60s on an
> empty server.
> 
[...]
> diff --git a/doc/man-sections/server-options.rst b/doc/man-sections/server-options.rst
> index 99263fff3..cbb2c3c92 100644
> --- a/doc/man-sections/server-options.rst
> +++ b/doc/man-sections/server-options.rst
> @@ -184,6 +184,25 @@ fast hardware. SSL/TLS authentication must be used in this mode.
>    For the best protection against DoS attacks in server mode, use
>    ``--proto udp`` and either ``--tls-auth`` or ``--tls-crypt``.

I think we should add a sentence about the relationship between connect-freq and
connect-freq-initial. Because users will wonder. Specifically are there attacks
that connect-freq protects against that connect-freq-initial does not?

>  
> +--connect-freq-initial args
> +  (UDP only) Allow a maximum of ``n`` initial connection packet responses
> +  per ``sec`` seconds from to clients.

Remove "from"?

> +
> +  Valid syntax:
> +  ::
> +
> +     connect-freq-initial n sec
> +
> +  OpenVPN starting at 2.6 is very efficient in responding to initial
> +  connection packets. When not limiting the initial responses
> +  an OpenVPN daemon can be abused in reflection attacks.
> +  This option is designed to limit the rate OpenVPN will respond to initial
> +  attacks.
> +
> +  Connection attempts that complete the initial three-way handshake
> +  will not be counted against the limit. The default is to allow
> +  100 initial connection per 10s.
> +
>  --duplicate-cn
>    Allow multiple clients with the same common name to concurrently
>    connect. In the absence of this option, OpenVPN will disconnect a client
[...]
> diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
> index c27c6da5b..4ef2f355b 100644
> --- a/src/openvpn/mudp.c
> +++ b/src/openvpn/mudp.c
> @@ -82,6 +82,16 @@ do_pre_decrypt_check(struct multi_context *m,
>      struct openvpn_sockaddr *from = &m->top.c2.from.dest;
>      int handwindow = m->top.options.handshake_window;
>  
> +    if (verdict == VERDICT_VALID_RESET_V3 || verdict == VERDICT_VALID_RESET_V2)
> +    {
> +        /* Check if we are still below our limit for sending out
> +         * responses */
> +        if (!reflect_filter_rate_limit_check(m->initial_rate_limiter))
> +        {
> +            return false;
> +        }
> +    }
> +
>      if (verdict == VERDICT_VALID_RESET_V3)
>      {
>          /* Extract the packet id to check if it has the special format that
> @@ -244,6 +254,10 @@ multi_get_create_instance_udp(struct multi_context *m, bool *floated)
>  
>                  if (frequency_limit_event_allowed(m->new_connection_limiter))
>                  {
> +                    /* a successful three-way handshake only counts against
> +                     * connect-freq but not against connect-req-initial */

"connect-freq-initial"

> +                    reflect_filter_rate_limit_decrease(m->initial_rate_limiter);
> +
>                      mi = multi_create_instance(m, &real);
>                      if (mi)
>                      {
> diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
> index 0ba509fa0..1a7f278f7 100644
> --- a/src/openvpn/multi.c
> +++ b/src/openvpn/multi.c
> @@ -52,6 +52,7 @@
>  #include "crypto_backend.h"
>  #include "ssl_util.h"
>  #include "dco.h"
> +#include "reflect_filter.h"
>  
>  /*#define MULTI_DEBUG_EVENT_LOOP*/
>  
> @@ -368,6 +369,8 @@ multi_init(struct multi_context *m, struct context *t, bool tcp_mode)
>       */
>      m->new_connection_limiter = frequency_limit_init(t->options.cf_max,
>                                                       t->options.cf_per);
> +    m->initial_rate_limiter = initial_rate_limit_init(t->options.cf_initial_max,
> +                                                      t->options.cf_initial_per);
>  
>      /*
>       * Allocate broadcast/multicast buffer list
> @@ -729,6 +732,7 @@ multi_uninit(struct multi_context *m)
>          mbuf_free(m->mbuf);
>          ifconfig_pool_free(m->ifconfig_pool);
>          frequency_limit_free(m->new_connection_limiter);
> +        initial_rate_limit_free(m->initial_rate_limiter);
>          multi_reap_free(m->reaper);
>          mroute_helper_free(m->route_helper);
>          multi_tcp_free(m->mtcp);
[...]
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index ee3783046..e756af948 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -480,6 +480,7 @@ static const char usage_message[] =
>      "                  as well as pushes it to connecting clients.\n"
>      "--learn-address cmd : Run command cmd to validate client virtual addresses.\n"
>      "--connect-freq n s : Allow a maximum of n new connections per s seconds.\n"
> +    "--connect-freq-initial n s : Allow a maximum of n replies for initial connections attempts per s seconds.\n"
>      "--max-clients n : Allow a maximum of n simultaneously connected clients.\n"
>      "--max-routes-per-client n : Allow a maximum of n internal routes per client.\n"
>      "--stale-routes-check n [t] : Remove routes with a last activity timestamp\n"
> @@ -864,6 +865,8 @@ init_options(struct options *o, const bool init_gc)
>      o->n_bcast_buf = 256;
>      o->tcp_queue_limit = 64;
>      o->max_clients = 1024;
> +    o->cf_initial_per = 10;
> +    o->cf_initial_max = 100;
>      o->max_routes_per_client = 256;
>      o->stale_routes_check_interval = 0;
>      o->ifconfig_pool_persist_refresh_freq = 600;
> @@ -1555,6 +1558,8 @@ show_p2mp_parms(const struct options *o)
>      SHOW_BOOL(duplicate_cn);
>      SHOW_INT(cf_max);
>      SHOW_INT(cf_per);
> +    SHOW_INT(cf_initial_max);
> +    SHOW_INT(cf_initial_per);
>      SHOW_INT(max_clients);
>      SHOW_INT(max_routes_per_client);
>      SHOW_STR(auth_user_pass_verify_script);
> @@ -7452,6 +7457,22 @@ add_option(struct options *options,
>          options->cf_max = cf_max;
>          options->cf_per = cf_per;
>      }
> +    else if (streq(p[0], "connect-freq-initial") && p[1] && p[2] && !p[3])
> +    {
> +        long cf_max, cf_per;
> +
> +        VERIFY_PERMISSION(OPT_P_GENERAL);
> +        char *e1, *e2;
> +        cf_max = strtol(p[1], &e1, 10);
> +        cf_per = strtol(p[2], &e2, 10);
> +        if (cf_max < 0 || cf_per < 0 || *e1 != '\0' || *e2 != '\0')
> +        {
> +            msg(msglevel, "--connect-freq-initial parameters must be integers and >= 0");
> +            goto err;
> +        }
> +        options->cf_initial_max = cf_max;
> +        options->cf_initial_per = cf_per;
> +    }
>      else if (streq(p[0], "max-clients") && p[1] && !p[2])
>      {
>          int max_clients;

Regards,
-- 
  Frank Lichtenheld

