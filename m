References: <20200709101603.11941-1-arne@...1227...>
 <20200709101603.11941-3-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <8e78b96b-9e96-0f56-8430-b570d59d8995@...2181...>
Date: Thu, 9 Jul 2020 17:42:23 +0200
MIME-Version: 1.0
In-Reply-To: <20200709101603.11941-3-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 3/8] Extract process_incoming_push_reply
 from process_incoming_push_msg
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi,

another nice patch that makes one more step towards having a more
readable code base!

On 09/07/2020 12:15, Arne Schwabe wrote:
> This is a small refactoring to make both function more readable. It also
> eliminates the ret variable in process_incoming_push_msg that now serves
> no purpose anymore.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  src/openvpn/push.c | 113 +++++++++++++++++++++++++--------------------
>  1 file changed, 64 insertions(+), 49 deletions(-)
> 
> diff --git a/src/openvpn/push.c b/src/openvpn/push.c
> index 56d652a3..d74323db 100644
> --- a/src/openvpn/push.c
> +++ b/src/openvpn/push.c
> @@ -855,6 +855,63 @@ push_update_digest(md_ctx_t *ctx, struct buffer *buf, const struct options *opt)
>      }
>  }
>  
> +static int
> +process_incoming_push_reply(struct context *c,
> +                            unsigned int permission_mask,
> +                            const unsigned int *option_types_found,
> +                            struct buffer *buf)
> +{
> +    int ret = PUSH_MSG_ERROR;
> +    const uint8_t ch = buf_read_u8(buf);
> +    if (ch == ',')
> +    {
> +        struct buffer buf_orig = (*buf);
> +        if (!c->c2.pulled_options_digest_init_done)
> +        {
> +            c->c2.pulled_options_state = md_ctx_new();
> +            md_ctx_init(c->c2.pulled_options_state, md_kt_get("SHA256"));
> +            c->c2.pulled_options_digest_init_done = true;
> +        }
> +        if (!c->c2.did_pre_pull_restore)
> +        {
> +            pre_pull_restore(&c->options, &c->c2.gc);
> +            c->c2.did_pre_pull_restore = true;
> +        }
> +        if (apply_push_options(&c->options,
> +                               buf,
> +                               permission_mask,
> +                               option_types_found,
> +                               c->c2.es))
> +        {
> +            push_update_digest(c->c2.pulled_options_state, &buf_orig,
> +                               &c->options);
> +            switch (c->options.push_continuation)
> +            {
> +                case 0:
> +                case 1:
> +                    md_ctx_final(c->c2.pulled_options_state,
> +                                 c->c2.pulled_options_digest.digest);
> +                    md_ctx_cleanup(c->c2.pulled_options_state);
> +                    md_ctx_free(c->c2.pulled_options_state);
> +                    c->c2.pulled_options_state = NULL;
> +                    c->c2.pulled_options_digest_init_done = false;
> +                    ret = PUSH_MSG_REPLY;
> +                    break;
> +
> +                case 2:
> +                    ret = PUSH_MSG_CONTINUATION;
> +                    break;
> +            }
> +        }
> +    }
> +    else if (ch == '\0')
> +    {
> +        ret = PUSH_MSG_REPLY;
> +    }
> +    /* show_settings (&c->options); */
> +    return ret;
> +}
> +
>  int
>  process_incoming_push_msg(struct context *c,
>                            const struct buffer *buffer,
> @@ -862,64 +919,22 @@ process_incoming_push_msg(struct context *c,
>                            unsigned int permission_mask,
>                            unsigned int *option_types_found)

                             ^^^ this should now be made const,
otherwise you'll trigger a warning because process_incoming_push_reply()
wants const.

>  {
> -    int ret = PUSH_MSG_ERROR;
>      struct buffer buf = *buffer;
>  
>      if (buf_string_compare_advance(&buf, "PUSH_REQUEST"))
>      {
> -        ret = process_incoming_push_request(c);
> +        return process_incoming_push_request(c);
>      }
>      else if (honor_received_options
>               && buf_string_compare_advance(&buf, "PUSH_REPLY"))
>      {
> -        const uint8_t ch = buf_read_u8(&buf);
> -        if (ch == ',')
> -        {
> -            struct buffer buf_orig = buf;
> -            if (!c->c2.pulled_options_digest_init_done)
> -            {
> -                c->c2.pulled_options_state = md_ctx_new();
> -                md_ctx_init(c->c2.pulled_options_state, md_kt_get("SHA256"));
> -                c->c2.pulled_options_digest_init_done = true;
> -            }
> -            if (!c->c2.did_pre_pull_restore)
> -            {
> -                pre_pull_restore(&c->options, &c->c2.gc);
> -                c->c2.did_pre_pull_restore = true;
> -            }
> -            if (apply_push_options(&c->options,
> -                                   &buf,
> -                                   permission_mask,
> -                                   option_types_found,
> -                                   c->c2.es))
> -            {
> -                push_update_digest(c->c2.pulled_options_state, &buf_orig,
> -                                   &c->options);
> -                switch (c->options.push_continuation)
> -                {
> -                    case 0:
> -                    case 1:
> -                        md_ctx_final(c->c2.pulled_options_state, c->c2.pulled_options_digest.digest);
> -                        md_ctx_cleanup(c->c2.pulled_options_state);
> -                        md_ctx_free(c->c2.pulled_options_state);
> -                        c->c2.pulled_options_state = NULL;
> -                        c->c2.pulled_options_digest_init_done = false;
> -                        ret = PUSH_MSG_REPLY;
> -                        break;
> -
> -                    case 2:
> -                        ret = PUSH_MSG_CONTINUATION;
> -                        break;
> -                }
> -            }
> -        }
> -        else if (ch == '\0')
> -        {
> -            ret = PUSH_MSG_REPLY;
> -        }
> -        /* show_settings (&c->options); */
> +        return process_incoming_push_reply(c, permission_mask,
> +                                           option_types_found, &buf);
> +    }
> +    else
> +    {
> +        return PUSH_MSG_ERROR;
>      }
> -    return ret;
>  }
>  
>  
> 

The rest looks good!
Tested on the client side and the PUSH_REPLY was still properly
processed as expected,


Assuming that const gets fixed:

Acked-by: Antonio Quartulli <a@...2181...>

-- 
Antonio Quartulli

