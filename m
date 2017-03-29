References: <20170328191900.8488-1-davids@...515...>
	<20170328205346.18844-1-davids@...515...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <20309635-60d2-3e3c-a905-4d33b3a674f8@...1435...>
Date: Wed, 29 Mar 2017 11:22:30 +0200
MIME-Version: 1.0
In-Reply-To: <20170328205346.18844-1-davids@...515...>
Subject: Re: [Openvpn-devel] [PATCH v2] auth-token: Ensure tokens are always
 wiped on de-auth
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 28-03-17 22:53, David Sommerseth wrote:
> If tls_deauthenticate() was called, it could in some scenarios leave the
> authentication token for a session in memory.  This change just ensures
> auth-tokens are always wiped as soon as a TLS session is considered
> broken.
> 
> Signed-off-by: David Sommerseth <davids@...515...>
> 
> ---
> 
> The wipe_auth_token() function is otherwise moved to be declared before
> tls_deauthenticate() and the latter function is also slightly modified to
> make use of the C99 feature of inline declaration - mostly to have a more
> reasonable coding style when adding the wipe_auth_token() call.
> 
> v2 - Fixed coding style issues after changes in wipe_auth_token()
>    - Added wipe_auth_token() call when --ccd-exclusive auth fails
> ---
>  src/openvpn/ssl_verify.c | 47 +++++++++++++++++++++++++++--------------------
>  1 file changed, 27 insertions(+), 20 deletions(-)
> 
> diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
> index a6e9be3..bc578fa 100644
> --- a/src/openvpn/ssl_verify.c
> +++ b/src/openvpn/ssl_verify.c
> @@ -80,6 +80,28 @@ setenv_untrusted(struct tls_session *session)
>      setenv_link_socket_actual(session->opt->es, "untrusted", &session->untrusted_addr, SA_IP_PORT);
>  }
>  
> +
> +/**
> + *  Wipes the authentication token out of the memory, frees and cleans up related buffers and flags
> + *
> + *  @param multi  Pointer to a multi object holding the auth_token variables
> + */
> +static void
> +wipe_auth_token(struct tls_multi *multi)
> +{
> +    if( multi )
> +    {
> +        if (multi->auth_token )
> +        {

This still has weird spaces: "if( multi )" should be "if (multi)", and
"if (multi->auth_token )" should be "if (multi->auth_token)".

> +            secure_memzero(multi->auth_token, AUTH_TOKEN_SIZE);
> +            free(multi->auth_token);
> +        }
> +        multi->auth_token = NULL;
> +        multi->auth_token_sent = false;
> +    }
> +}
> +
> +
>  /*
>   * Remove authenticated state from all sessions in the given tunnel
>   */
> @@ -88,10 +110,10 @@ tls_deauthenticate(struct tls_multi *multi)
>  {
>      if (multi)
>      {
> -        int i, j;
> -        for (i = 0; i < TM_SIZE; ++i)
> +        wipe_auth_token(multi);
> +        for (int i = 0; i < TM_SIZE; ++i)
>          {
> -            for (j = 0; j < KS_SIZE; ++j)
> +            for (int j = 0; j < KS_SIZE; ++j)
>              {
>                  multi->session[i].key[j].authenticated = false;
>              }
> @@ -1219,21 +1241,6 @@ verify_user_pass_management(struct tls_session *session, const struct user_pass
>  }
>  #endif /* ifdef MANAGEMENT_DEF_AUTH */
>  
> -/**
> - *  Wipes the authentication token out of the memory, frees and cleans up related buffers and flags
> - *
> - *  @param multi  Pointer to a multi object holding the auth_token variables
> - */
> -static void
> -wipe_auth_token(struct tls_multi *multi)
> -{
> -    secure_memzero(multi->auth_token, AUTH_TOKEN_SIZE);
> -    free(multi->auth_token);
> -    multi->auth_token = NULL;
> -    multi->auth_token_sent = false;
> -}
> -
> -
>  /*
>   * Main username/password verification entry point
>   */
> @@ -1285,7 +1292,7 @@ verify_user_pass(struct user_pass *up, struct tls_multi *multi,
>          /* Ensure that the username has not changed */
>          if (!tls_lock_username(multi, up->username))
>          {
> -            wipe_auth_token(multi);
> +            /* auth-token cleared in tls_lock_username() on failure */
>              ks->authenticated = false;
>              goto done;
>          }
> @@ -1306,7 +1313,6 @@ verify_user_pass(struct user_pass *up, struct tls_multi *multi,
>          if (memcmp_constant_time(multi->auth_token, up->password,
>                                   strlen(multi->auth_token)) != 0)
>          {
> -            wipe_auth_token(multi);
>              ks->authenticated = false;
>              tls_deauthenticate(multi);
>  
> @@ -1478,6 +1484,7 @@ verify_final_auth_checks(struct tls_multi *multi, struct tls_session *session)
>          if (!cn || !strcmp(cn, CCD_DEFAULT) || !test_file(path))
>          {
>              ks->authenticated = false;
> +            wipe_auth_tokens(multi);

This should be wipe_auth_token(), not wipe_auth_tokens().

>              msg(D_TLS_ERRORS, "TLS Auth Error: --client-config-dir authentication failed for common name '%s' file='%s'",
>                  session->common_name,
>                  path ? path : "UNDEF");
> 

Otherwise this looks good.  So if the above two comments are processed,
ACK.  I'm fine with you doing that on-the-fly.

-Steffan

