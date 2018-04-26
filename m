MIME-Version: 1.0
In-Reply-To: <d75b57da-d1ca-d4ca-41c1-f9af06ec54bb@...1918...>
References: <d75b57da-d1ca-d4ca-41c1-f9af06ec54bb@...1918...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 25 Apr 2018 23:47:17 -0400
Message-ID: <CAKuzo_gkxRUtf-YtAy54x6aj3=+GaG9sau_gOzDZ-o69ysSeNw@...278...>
Subject: Re: [Openvpn-devel] [Patch] Support client reason from auth plugin
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
To: Eric Thorpe <eric@...1918...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi

Thanks for the patch.This feature (and a similar support for plugins)
is something very nice to have

But this implementation is inadequate.

The main problem is that multi->client_reason is sent back to the client only
during the initial auth not during reauth (renegotiations). So this will work
in the first round and will fail during renegotiation. The client will not get
the "AUTH_FAILED,reason" message and stall until ping-restart.

This is the same issue that affects gen-auth-token expiry as well although
there the reason text is not CRV1:foo but SESSION:foo

Management-def-auth with dynamic CR works because of its support
for calling send_auth_failed() during reauth.
See management_client_auth() in multi.c (~line 3270)

That is not to say that dynamic challenge need to be raised during every
reauth --- in most cases not. But the plugin or script decides how to handle
that. The daemon should be ready to send back the reason to the client
whenever the plugin asks it to.

And, a minor comment below:

> diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
> index 25395b2..6266fb3 100644
> --- a/src/openvpn/ssl_verify.c
> +++ b/src/openvpn/ssl_verify.c
> @@ -1167,7 +1167,7 @@  done:
>   * Verify the username and password using a plugin
>   */
>  static int
> -verify_user_pass_plugin(struct tls_session *session, const struct user_pass *up, const char *raw_username)
> +verify_user_pass_plugin(struct tls_session *session, struct tls_multi *multi, const struct user_pass *up, const char *raw_username)
>  {
>      int retval = OPENVPN_PLUGIN_FUNC_ERROR;
>  #ifdef PLUGIN_DEF_AUTH
> @@ -1177,6 +1177,9 @@  verify_user_pass_plugin(struct tls_session *session, const struct user_pass *up,
>      /* Is username defined? */
>      if ((session->opt->ssl_flags & SSLF_AUTH_USER_PASS_OPTIONAL) || strlen(up->username))
>      {
> +        struct plugin_return pr, prfetch;
> +        plugin_return_init(&pr);
> +
>          /* set username/password in private env space */
>          setenv_str(session->opt->es, "username", (raw_username ? raw_username : up->username));
>          setenv_str(session->opt->es, "password", up->password);
> @@ -1198,7 +1201,23 @@  verify_user_pass_plugin(struct tls_session *session, const struct user_pass *up,
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
> +            int i;
> +            for (i = 0; i < prfetch.n; ++i)
> +            {
> +                if (prfetch.list[i] && prfetch.list[i]->value)
> +                {
> +                    man_def_auth_set_client_reason(multi, prfetch.list[i]->value);

man_def_auth_set_client_reason() is defined only when
MANAGEMENT_DEF_AUTH is defined. So this will fail to build in
some cases.

> +                }
> +            }
> +        }
> +
> +        plugin_return_free(&pr);
>
>  #ifdef PLUGIN_DEF_AUTH
>          /* purge auth control filename (and file itself) for non-deferred returns */
> @@ -1378,7 +1397,7 @@  verify_user_pass(struct user_pass *up, struct tls_multi *multi,
>  #endif
>      if (plugin_defined(session->opt->plugins, OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY))
>      {
> -        s1 = verify_user_pass_plugin(session, up, raw_username);
> +        s1 = verify_user_pass_plugin(session, multi, up, raw_username);
>      }
>      if (session->opt->auth_user_pass_verify_script)
>      {

Selva

