References: <20200813072923.24385-1-eric@...1918...>
 <20200813072923.24385-2-eric@...1918...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <c3780124-ce81-af7d-8ef3-72a9e02bb2ea@...1227...>
Date: Thu, 25 Mar 2021 01:00:18 +0100
MIME-Version: 1.0
In-Reply-To: <20200813072923.24385-2-eric@...1918...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH 2/2] Allows a plugin to provide a
 client_reason for authentication failure
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
To: Eric Thorpe <eric@...1918...>, openvpn-devel@lists.sourceforge.net


I am just going through some older patches and this one of them that I
didn't review last time.

This patch does not apply cleanly to master anymore but there some other
things that should be fixed regardless. So it would be good to have a
version 2 of this patch.

> diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
> index 8d8531c7..356b30fd 100644
> --- a/src/openvpn/ssl_verify.c
> +++ b/src/openvpn/ssl_verify.c
> @@ -1157,6 +1157,9 @@ verify_user_pass_plugin(struct tls_session *session, struct tls_multi *multi,
>      /* Is username defined? */
>      if ((session->opt->ssl_flags & SSLF_AUTH_USER_PASS_OPTIONAL) || strlen(up->username))
>      {
> +        struct plugin_return pr, prfetch;
Move to when it is used.

> +        plugin_return_init(&pr);


>          /* set username/password in private env space */
>          setenv_str(session->opt->es, "username", up->username);
>          setenv_str(session->opt->es, "password", up->password);
> @@ -1180,7 +1183,23 @@ verify_user_pass_plugin(struct tls_session *session, struct tls_multi *multi,
>  #endif
>  
>          /* call command */
> -        retval = plugin_call(session->opt->plugins, OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY, NULL, NULL, session->opt->es);
> +        retval = plugin_call(session->opt->plugins, OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY, NULL, &pr, session->opt->es);
> +
> +        /* Fetch client reason */
> +        plugin_return_get_column(&pr, &prfetch, "client_reason");
> +        if (plugin_return_defined(&prfetch))
> +        {
> +            int i;> +            for (i = 0; i < prfetch.n; ++i)
Mov int i into for loop.


> +            {
> +                if (prfetch.list[i] && prfetch.list[i]->value)
> +                {
> +                    auth_set_client_reason(multi, prfetch.list[i]->value);
> +                }
> +            }
> +        }
> +
> +        plugin_return_free(&pr);
>  
>  #ifdef PLUGIN_DEF_AUTH
>          /* purge auth control filename (and file itself) for non-deferred returns */
> @@ -1436,8 +1455,16 @@ verify_user_pass(struct user_pass *up, struct tls_multi *multi,
>          if (multi->connection_established)
>          {
>              /* Notify the client */
> -            send_push_reply_auth_failed(multi, "SESSION:Auth failed");
> -
> +            const char *client_reason;
> +            if (multi->client_reason != NULL)
> +            {
> +                client_reason = multi->client_reason;
> +            }
> +            else
> +            {
> +                client_reason = "SESSION:Auth failed";
> +            }
> +            send_push_reply_auth_failed(multi, client_reason);

The patch is missing documentation in the openvpn-plugin.h. Currently
the patch adds an undocumented feature, which we want to avoid.

Arne

