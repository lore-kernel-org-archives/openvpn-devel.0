MIME-Version: 1.0
In-Reply-To: <1477684124-26083-6-git-send-email-davids@...515...>
References: <1477684124-26083-1-git-send-email-davids@...515...>
	<1477684124-26083-6-git-send-email-davids@...515...>
From: Steffan Karger <steffan@...1856...>
Date: Mon, 31 Oct 2016 11:54:20 +0100
Message-ID: <CAA1AbxJWv5ZJjU7ZA4NCB2sH8kELv-ip=41=xke=tzZbvxRKXQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH v2 4/4] auth-gen-token: Authenticate
 generated auth-tokens when client re-authenticates
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
> On a server with --auth-gen-token enabled, the server will have created
> a random token and pushed it to the client.  When the client needs to
> renegotiate the connection or otherwise reconnect, it will at this point
> use the auth-token as password.
>
> Here we check if we have a token generated and that it has been pushed
> to the client, if so, then we check if the token matches the locally
> stored token.  If everything matches, we're done and the connection
> is still authenticated.
>
> If the auth-token authentication fails, we delete our local copy of
> the token and changes the connection to not being authenticated.  From
> this moment of, the client needs to do a full reconnect providing
> the users password again.
>
> This token authentication also considers the token lifetime, if that
> have been set via --auth-gen-token.  If the token have expired, the
> client is rejected and needs to do a full reconnect with a new
> authentication using the users password.
>
>   v2 - Rename auth_generate_token to auth_token_generate
>      - Wrap lines exceeding 80 chars
>      - Improved several comments (rephrasing, grammar)
>
> Signed-off-by: David Sommerseth <davids@...515...>
> ---
>  src/openvpn/ssl_verify.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
>
> diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
> index 0ac5689..99a2f70 100644
> --- a/src/openvpn/ssl_verify.c
> +++ b/src/openvpn/ssl_verify.c
> @@ -1139,6 +1139,63 @@ verify_user_pass(struct user_pass *up, struct tls_multi *multi,
>    string_mod_remap_name (up->username, COMMON_NAME_CHAR_CLASS);
>    string_mod (up->password, CC_PRINT, CC_CRLF, '_');
>
> +  /* If server is configured with --auth-gen-token and we have an
> +   * authentication token for this client, this authentication
> +   * round will be done internally using the token instead of
> +   * calling any external authentication modules.
> +   */
> +  if (session->opt->auth_token_generate && multi->auth_token_sent
> +      && NULL != multi->auth_token)
> +    {
> +      unsigned int ssl_flags = session->opt->ssl_flags;

You could make this a 'const'.

> +
> +      /* Ensure that the username has not changed */
> +      if (!tls_lock_username(multi, up->username))
> +        {
> +          ks->authenticated = false;
> +          goto done;
> +        }
> +
> +      /* If auth-token lifetime has been enabled,
> +       * ensure the token has not expired
> +       */
> +      if (session->opt->auth_token_lifetime > 0
> +          && (multi->auth_token_tstamp + session->opt->auth_token_lifetime) < now)
> +        {
> +          msg (D_HANDSHAKE, "Auth-token for client expired\n");
> +          ks->authenticated = false;
> +          goto done;
> +        }
> +
> +      /* The core authentication of the token itself */
> +      if (memcmp_constant_time(multi->auth_token, up->password,
> +                 strlen(multi->auth_token)) != 0)
> +        {
> +          memset (multi->auth_token, 0, AUTH_TOKEN_SIZE);
> +          free (multi->auth_token);
> +          multi->auth_token = NULL;
> +          multi->auth_token_sent = false;
> +          ks->authenticated = false;
> +          tls_deauthenticate (multi);
> +
> +          msg (D_TLS_ERRORS, "TLS Auth Error: Auth-token verification "
> +               "failed for username '%s' %s", up->username,
> +               (ssl_flags & SSLF_USERNAME_AS_COMMON_NAME) ? "[CN SET]" : "");
> +        }
> +      else
> +        {
> +          ks->authenticated = true;
> +
> +          if (ssl_flags & SSLF_USERNAME_AS_COMMON_NAME)
> +            set_common_name (session, up->username);
> +          msg (D_HANDSHAKE, "TLS: Username/auth-token authentication "
> +               "succeeded for username '%s' %s",
> +               up->username,
> +               (ssl_flags & SSLF_USERNAME_AS_COMMON_NAME) ? "[CN SET]" : "");
> +        }
> +      goto done;
> +    }
> +
>    /* call plugin(s) and/or script */
>  #ifdef MANAGEMENT_DEF_AUTH
>    if (man_def_auth == KMDA_DEF)
> @@ -1232,6 +1289,7 @@ verify_user_pass(struct user_pass *up, struct tls_multi *multi,
>        msg (D_TLS_ERRORS, "TLS Auth Error: Auth Username/Password verification failed for peer");
>      }
>
> + done:
>    gc_free (&gc);
>  }
>
> --

Whether you decide to add the const or not, ACK.  (Knowing that you'll
continue with makes this *really* useful by fixing reauthentication is
later patches.)

-Steffan

