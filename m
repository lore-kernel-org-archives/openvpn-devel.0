References: <1476388771-16492-1-git-send-email-davids@...515...>
	<1476388771-16492-6-git-send-email-davids@...515...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <83c2c0fc-23e6-f03e-7151-198955416315@...1856...>
Date: Wed, 19 Oct 2016 22:12:28 +0200
MIME-Version: 1.0
In-Reply-To: <1476388771-16492-6-git-send-email-davids@...515...>
Subject: Re: [Openvpn-devel] [PATCH 5/5] auth-gen-token: Authenticate
 generated auth-tokens when client re-authenticates
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,

This feature looks very useful, and the code seems to work well.  Aside
from some nitpicking, I do have some questions on the bigger picture:

On 13-10-16 21:59, David Sommerseth wrote:
> On a server with --auth-gen-token enabled, the server will have created
> a random token and pushed it to the client.  When the client needs to
> renegotiate the connection or otherwise reconnect, it will at this point
> use the auth-token as password.

How does/should auth-token behave across the various restarts?  Should
auth-token for example be cleared on a sigusr1?

> Here we check if we have a token generated and that it has been pushed
> to the client, if so, then we check if the token matches the locally
> stored token.  If everything matches, we're done and the connection
> is still authenticated.
> 
> If the auth-token authentication fails, we delete our local copy of
> the token and changes the connection to not being authenticated.  From
> this moment of, the client needs to do a full reconnect providing
> the users password again.

How does the client know this?  This patch does not send an AUTH_FAILED
(or something similar) to the client.  Testing seems to indicate that
the server keeps refusing the token, and the client keeps resending it.

> This token authentication also considers the token lifetime, if that
> have been set via --auth-gen-token.  If the token have expired, the
> client is rejected and needs to do a full reconnect with a new
> authentication using the users password.

Similar to the above, I don't see a way for the client to understand
that the token has expired.  That results in the client sending its
token indefinitely, like above.

Some more nagging below ;)

> Signed-off-by: David Sommerseth <davids@...515...>
> ---
>  src/openvpn/ssl_verify.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
> index 24ec56e..aa982e4 100644
> --- a/src/openvpn/ssl_verify.c
> +++ b/src/openvpn/ssl_verify.c
> @@ -1139,6 +1139,55 @@ verify_user_pass(struct user_pass *up, struct tls_multi *multi,
>    string_mod_remap_name (up->username, COMMON_NAME_CHAR_CLASS);
>    string_mod (up->password, CC_PRINT, CC_CRLF, '_');
>  
> +  /* If server is configured with --auth-gen-token and we have an
> +   * authentication token for this client, base this authentication round
> +   * based on this token instead.
> +   */

base ... based, typo?

> +  if (session->opt->auth_generate_token && multi->auth_token_sent && NULL != multi->auth_token)
> +    {
> +      /* Ensure that the username have not changed */

has not changed

> +      if (!tls_lock_username(multi, up->username))
> +        {
> +          ks->authenticated = false;
> +          goto done;
> +        }
> +
> +      /* If auth-token lifetime have been enabled, ensure the token is still valid */

has been enabled

> +      if (session->opt->auth_token_lifetime > 0
> +          && (multi->auth_token_tstamp + session->opt->auth_token_lifetime) < now )
> +        {
> +          msg (D_HANDSHAKE, "Auth-token for client expired\n");
> +          ks->authenticated = false;
> +          goto done;
> +        }

As explained above, I think the client should somehow be notified of
this expiration, such that it can take action.

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
> +          msg (D_TLS_ERRORS, "TLS Auth Error: Auth token verification failed for username '%s' %s",
> +               up->username,
> +               (session->opt->ssl_flags & SSLF_USERNAME_AS_COMMON_NAME) ? "[CN SET]" : "");
> +        }

As above.  What should the client do?

-Steffan

