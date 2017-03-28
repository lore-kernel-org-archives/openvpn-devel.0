References: <20170328191900.8488-1-davids@...515...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <cb195f68-3e49-e766-926f-61271e7c3ec2@...1856...>
Date: Tue, 28 Mar 2017 22:24:32 +0200
MIME-Version: 1.0
In-Reply-To: <20170328191900.8488-1-davids@...515...>
Subject: Re: [Openvpn-devel] [PATCH] auth-token: Ensure tokens are always
 wiped on de-auth
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

On 28-03-17 21:19, David Sommerseth wrote:
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
> ---
>  src/openvpn/ssl_verify.c | 44 ++++++++++++++++++++++++--------------------
>  1 file changed, 24 insertions(+), 20 deletions(-)
> 
> diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
> index a6e9be3..008a60d 100644
> --- a/src/openvpn/ssl_verify.c
> +++ b/src/openvpn/ssl_verify.c
> @@ -80,6 +80,26 @@ setenv_untrusted(struct tls_session *session)
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
> +    if( multi ) {
> +	if (multi->auth_token ) {

The spaces in theses lines look a bit odd.

> +	    secure_memzero(multi->auth_token, AUTH_TOKEN_SIZE);
> +	    free(multi->auth_token);
> +	}
> +	multi->auth_token = NULL;
> +	multi->auth_token_sent = false;
> +    }
> +}
> +
> +
>  /*
>   * Remove authenticated state from all sessions in the given tunnel
>   */
> @@ -88,10 +108,10 @@ tls_deauthenticate(struct tls_multi *multi)
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
> @@ -1219,21 +1239,6 @@ verify_user_pass_management(struct tls_session *session, const struct user_pass
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
> @@ -1285,7 +1290,7 @@ verify_user_pass(struct user_pass *up, struct tls_multi *multi,
>          /* Ensure that the username has not changed */
>          if (!tls_lock_username(multi, up->username))
>          {
> -            wipe_auth_token(multi);
> +            /* auth-token cleared in tls_lock_username() on failure */
>              ks->authenticated = false;
>              goto done;
>          }
> @@ -1306,7 +1311,6 @@ verify_user_pass(struct user_pass *up, struct tls_multi *multi,
>          if (memcmp_constant_time(multi->auth_token, up->password,
>                                   strlen(multi->auth_token)) != 0)
>          {
> -            wipe_auth_token(multi);
>              ks->authenticated = false;
>              tls_deauthenticate(multi);
>  
> 

Shouldn't we also clear the token if the ccd authentication check in
verify_final_auth_checks() fails?

-Steffan

