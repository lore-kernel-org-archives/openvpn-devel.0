References: <1481728374-7196-1-git-send-email-davids@...515...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <6083f8ec-b180-5cc3-b776-dd7e1e14d94a@...1856...>
Date: Wed, 14 Dec 2016 22:08:25 +0100
MIME-Version: 1.0
In-Reply-To: <1481728374-7196-1-git-send-email-davids@...515...>
Subject: Re: [Openvpn-devel] [PATCH] auth-gen-token: Hardening memory
 cleanup on auth-token failuers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 14-12-16 16:12, David Sommerseth wrote:
> Further improve the memory management when a clients --auth-token
> fails the server side token authentication enabled via --auth-gen-token.
> 
> Signed-off-by: David Sommerseth <davids@...515...>
> ---
>  src/openvpn/ssl_verify.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
> index 4328828..1effdf5 100644
> --- a/src/openvpn/ssl_verify.c
> +++ b/src/openvpn/ssl_verify.c
> @@ -1108,6 +1108,21 @@ verify_user_pass_management (struct tls_session *session, const struct user_pass
>  }
>  #endif
>  
> +/**
> + *  Wipes the authentication token out of the memory, frees and cleans up related buffers and flags
> + *
> + *  @param multi  Pointer to a multi object holding the auth_token variables
> + */
> +static void
> +wipe_auth_token(struct tls_multi *multi)
> +{
> +  secure_memzero (multi->auth_token, AUTH_TOKEN_SIZE);
> +  free (multi->auth_token);
> +  multi->auth_token = NULL;
> +  multi->auth_token_sent = false;
> +}
> +
> +
>  /*
>   * Main username/password verification entry point
>   */
> @@ -1157,6 +1172,7 @@ verify_user_pass(struct user_pass *up, struct tls_multi *multi,
>        /* Ensure that the username has not changed */
>        if (!tls_lock_username(multi, up->username))
>          {
> +          wipe_auth_token(multi);
>            ks->authenticated = false;
>            goto done;
>          }
> @@ -1168,6 +1184,7 @@ verify_user_pass(struct user_pass *up, struct tls_multi *multi,
>            && (multi->auth_token_tstamp + session->opt->auth_token_lifetime) < now)
>          {
>            msg (D_HANDSHAKE, "Auth-token for client expired\n");
> +          wipe_auth_token(multi);
>            ks->authenticated = false;
>            goto done;
>          }
> @@ -1176,10 +1193,7 @@ verify_user_pass(struct user_pass *up, struct tls_multi *multi,
>        if (memcmp_constant_time(multi->auth_token, up->password,
>                   strlen(multi->auth_token)) != 0)
>          {
> -          secure_memzero (multi->auth_token, AUTH_TOKEN_SIZE);
> -          free (multi->auth_token);
> -          multi->auth_token = NULL;
> -          multi->auth_token_sent = false;
> +          wipe_auth_token(multi);
>            ks->authenticated = false;
>            tls_deauthenticate (multi);
>  

Looks good, but I think there's one more occurance you should
incorporate in the patch:

  if (openvpn_base64_encode(tok, AUTH_TOKEN_SIZE,
                            &multi->auth_token) < AUTH_TOKEN_SIZE)
    {
      msg(D_TLS_ERRORS, "BASE64 encoding of token failed. "
          "No auth-token will be activated now");
      if (multi->auth_token)
        {
          secure_memzero(multi->auth_token, AUTH_TOKEN_SIZE);
          free(multi->auth_token);
          multi->auth_token = NULL;
        }

-Steffan

