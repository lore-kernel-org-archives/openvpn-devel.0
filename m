References: <20200715141600.26610-1-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <b84824b5-7a98-db7f-78c1-cac25853fb28@...2181...>
Date: Wed, 15 Jul 2020 16:59:59 +0200
MIME-Version: 1.0
In-Reply-To: <20200715141600.26610-1-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v6 8/14] client-connect: Add
 CC_RET_DEFERRED and cope with deferred client-connect
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

On 15/07/2020 16:16, Arne Schwabe wrote:
[CUT]

> -    multi_client_connect_early_setup(m, mi);
> +    handler = &client_connect_handlers[defer_state->cur_handler_index];
>  
> -    for (int i = 0; cc_succeeded && handlers[i]; i++)
> +    while (cc_succeeded && handler->main != NULL)
>      {
> -        ret = handlers[i](m, mi, &option_types_found);
> -        cc_succeeded = cc_check_return(&cc_succeeded_count, ret);
> +        enum client_connect_return ret;
> +        if (from_deferred)
> +        {
> +            ret = handler->deferred(m, mi, &(defer_state->option_types_found));
> +            from_deferred = false;
> +        }
> +        else
> +        {
> +            ret = handler->main(m, mi, &(defer_state->option_types_found));
> +        }
> +
> +        if (ret == CC_RET_SUCCEEDED)
> +        {
> +            /*
> +             * Remember that we already had at least one handler
> +             * returning a result should go to into deferred state
> +             */
> +            mi->context.c2.context_auth = CAS_PENDING_DEFERRED_PARTIAL;
> +        }
> +        else if (ret == CC_RET_SKIPPED)
> +        {
> +            /*
> +             * Move on with the next handler without modifying any
> +             * other state
> +             */
> +        }
> +        else if (ret == CC_RET_DEFERRED)
> +        {
> +            /*
> +             * we already set client_connect_status to DEFERRED_RESULT or
> +             * DEFERRED_NO_RESULT and increased index. We just return
> +             * from the function as having client_connect_status
> +             */
> +            return;
> +        }
> +        else if (ret == CC_RET_FAILED)
> +        {
> +            /*
> +             * One handler failed. We abort the chain and set the final
> +             * result to failed
> +             */
> +            cc_succeeded = false;
> +        }
> +        else
> +        {
> +            ASSERT(0);
> +        }
> +
> +        handler = &client_connect_handlers[defer_state->cur_handler_index];
> +        (defer_state->cur_handler_index)++;

shouldn't these 2 lines above be inverted?
(these parenthesis....)


Cheers,





-- 
Antonio Quartulli

