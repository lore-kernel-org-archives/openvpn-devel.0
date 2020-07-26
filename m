References: <20200725235143.22736-1-arne@...1227...>
From: tincanteksup <tincanteksup@...277...>
Message-ID: <5c15f1f1-351f-4602-64af-ced891e67b9f@...277...>
Date: Sun, 26 Jul 2020 14:05:18 +0100
MIME-Version: 1.0
In-Reply-To: <20200725235143.22736-1-arne@...1227...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] Refuse PUSH_REQUEST as client/refactor
 process_incoming_push_request
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

Sanity check:

On 26/07/2020 00:51, Arne Schwabe wrote:
> When a server sends a client a push request, the client will reply
> with a push reply. The reply is bogus and almost empty since almost
> all the options that are normally set (remote ip etc) are unset.
> 
> I checked 2.4 and master and this does not have any security implications
> or other bugs but it is still better to refuse this.
> 
> This code also refactors the method to get rid of the ret variable to
> make the code flow easier to understand.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>   src/openvpn/push.c | 40 ++++++++++++++++++++++------------------
>   1 file changed, 22 insertions(+), 18 deletions(-)
> 
> diff --git a/src/openvpn/push.c b/src/openvpn/push.c
> index 1c4f2033..84193afe 100644
> --- a/src/openvpn/push.c
> +++ b/src/openvpn/push.c
> @@ -733,13 +733,19 @@ push_remove_option(struct options *o, const char *p)
>   int
>   process_incoming_push_request(struct context *c)
>   {
> -    int ret = PUSH_MSG_ERROR;
> +    /* if we receive a message a client we do not want to reply to it
> +     * so limit this to multi server */

This sentence does not make sense, suggestion:

If a client receives a push request then ignore it.  Only multi server 
will reply to a push requests.

Something like that ..




> +    if (c->options.mode != MODE_SERVER)
> +    {
> +        return PUSH_MSG_ERROR;
> +    }
> +
>   
>       if (tls_authentication_status(c->c2.tls_multi, 0) == TLS_AUTHENTICATION_FAILED || c->c2.context_auth == CAS_FAILED)
>       {
>           const char *client_reason = tls_client_reason(c->c2.tls_multi);
>           send_auth_failed(c, client_reason);
> -        ret = PUSH_MSG_AUTH_FAILURE;
> +        return PUSH_MSG_AUTH_FAILURE;
>       }
>       else if (c->c2.context_auth == CAS_SUCCEEDED)
>       {
> @@ -748,29 +754,27 @@ process_incoming_push_request(struct context *c)
>           openvpn_time(&now);
>           if (c->c2.sent_push_reply_expiry > now)
>           {
> -            ret = PUSH_MSG_ALREADY_REPLIED;
> +            return PUSH_MSG_ALREADY_REPLIED;
>           }
> -        else
> -        {
> -            /* per-client push options - peer-id, cipher, ifconfig, ipv6-ifconfig */
> -            struct push_list push_list = { 0 };
> -            struct gc_arena gc = gc_new();
>   
> -            if (prepare_push_reply(c, &gc, &push_list)
> -                && send_push_reply(c, &push_list))
> -            {
> -                ret = PUSH_MSG_REQUEST;
> -                c->c2.sent_push_reply_expiry = now + 30;
> -            }
> -            gc_free(&gc);
> +        int ret = PUSH_MSG_ERROR;
> +        /* per-client push options - peer-id, cipher, ifconfig, ipv6-ifconfig */
> +        struct push_list push_list = { 0 };
> +        struct gc_arena gc = gc_new();
> +
> +        if (prepare_push_reply(c, &gc, &push_list)
> +            && send_push_reply(c, &push_list))
> +        {
> +            ret = PUSH_MSG_REQUEST;
> +            c->c2.sent_push_reply_expiry = now + 30;
>           }
> +        gc_free(&gc);
> +        return ret;
>       }
>       else
>       {
> -        ret = PUSH_MSG_REQUEST_DEFERRED;
> +        return PUSH_MSG_REQUEST_DEFERRED;
>       }
> -
> -    return ret;
>   }
>   
>   static void
> 

