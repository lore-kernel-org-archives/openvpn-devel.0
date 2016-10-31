MIME-Version: 1.0
In-Reply-To: <1477684124-26083-5-git-send-email-davids@...515...>
References: <1477684124-26083-1-git-send-email-davids@...515...>
	<1477684124-26083-5-git-send-email-davids@...515...>
From: Steffan Karger <steffan@...1856...>
Date: Mon, 31 Oct 2016 11:52:14 +0100
Message-ID: <CAA1AbxLoaOkA2Kz=pHgMQxHCi6+1vS4Hq3su3Uhu2CZYeAYR=g@...278...>
Subject: Re: [Openvpn-devel] [PATCH v2 3/4] auth-gen-token: Push generated
 auth-tokens to the client
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: David Sommerseth <davids@...515...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On 28 October 2016 at 21:48, David Sommerseth <davids@...515...> wrote:
> If --auth-gen-token has been enabled and a token has been generated,
> ensure this token is pushed to the client using the 'auth-token' option.
>
> This patch will also remove the logging of auth-token values being
> pushed, unless --verb level is 7 or higher.
>
>   v2 - Don't exceed 80 chars line length
>      - Clarify the magic in sanitize_control_message()
>      - Relocate auth_token_sent struct member slightly
>
> Signed-off-by: David Sommerseth <davids@...515...>
> ---
>  src/openvpn/misc.c       |  9 +++++++++
>  src/openvpn/push.c       | 12 +++++++++++-
>  src/openvpn/ssl_common.h |  2 ++
>  3 files changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
> index 225f0bf..b06d446 100644
> --- a/src/openvpn/misc.c
> +++ b/src/openvpn/misc.c
> @@ -2073,6 +2073,15 @@ sanitize_control_message(const char *src, struct gc_arena *gc)
>           skip = 4;
>           redact = true;
>         }
> +      else if (!check_debug_level(D_SHOW_KEYS)
> +               && (c == 'a' && !strncmp(src, "auth-token ", 11)))
> +       {
> +          /* Unless --verb is 7 or higher (D_SHOW_KEYS), hide
> +           * the auth-token value coming in the src string
> +           */
> +         skip = 10;
> +         redact = true;
> +       }
>
>        if (c == ',') /* end of redacted item? */
>         {
> diff --git a/src/openvpn/push.c b/src/openvpn/push.c
> index 4f24b58..f86bdd3 100644
> --- a/src/openvpn/push.c
> +++ b/src/openvpn/push.c
> @@ -309,7 +309,7 @@ prepare_push_reply (struct context *c, struct gc_arena *gc,
>                     struct push_list *push_list)
>  {
>    const char *optstr = NULL;
> -  const struct tls_multi *tls_multi = c->c2.tls_multi;
> +  struct tls_multi *tls_multi = c->c2.tls_multi;
>    const char * const peer_info = tls_multi->peer_info;
>    struct options *o = &c->options;
>
> @@ -371,6 +371,16 @@ prepare_push_reply (struct context *c, struct gc_arena *gc,
>           push_option_fmt(gc, push_list, M_USAGE, "cipher %s", o->ciphername);
>         }
>      }
> +
> +  /* If server uses --auth-gen-token and we have an auth token
> +   * to send to the client
> +   */
> +  if (false == tls_multi->auth_token_sent && NULL != tls_multi->auth_token)
> +    {
> +      push_option_fmt(gc, push_list, M_USAGE,
> +                      "auth-token %s", tls_multi->auth_token);
> +      tls_multi->auth_token_sent = true;
> +    }
>    return true;
>  }
>
> diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
> index 9b63a12..b04a24c 100644
> --- a/src/openvpn/ssl_common.h
> +++ b/src/openvpn/ssl_common.h
> @@ -533,6 +533,8 @@ struct tls_multi
>                            *   user/pass authentications in this session.
>                            */
>    time_t auth_token_tstamp; /**< timestamp of the generated token */
> +  bool auth_token_sent;  /**< If server uses --auth-gen-token and
> +                          *   token has been sent to client */
>    /*
>     * Our session objects.
>     */
> --

ACK - all my previous nagging points are resolved now.

-Steffan

