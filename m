References: <20190613134834.5709-4-arne@...1227...>
 <20190808145216.1198-1-arne@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <0eb21b1a-e4a7-3675-d6d5-79c5d28e88ee@...2080...>
Date: Fri, 16 Aug 2019 20:43:55 +0200
MIME-Version: 1.0
In-Reply-To: <20190808145216.1198-1-arne@...1227...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH v6 5/7] Implement a permanent session id
 in auth-token
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net
Cc: Arne Schwabe <arne@...515...>

On 08/08/2019 16:52, Arne Schwabe wrote:
> From: Arne Schwabe <arne@...515...>
> 
> This allows an external authentication method
> (e.g. management interface) to track the connection and distinguish a
> reconnection from multiple connections.
> 
> Addtionally this now also checks to workaround a problem with
> OpenVPN 3 core that sometimes uses a username hint from the config
> instead of using an empty username if the token would be valid
> with an empty username. Accepting such token can be only done
> explicitly when the external-auth keyword to auth-gen-token is present.
> 
> Patch V2: Add Empty variants to work around behaviour in openvpn 3
> Patch V3: document the behaviour of external-auth better in the man page,
>           rename 'auth' parameter to 'external-auth'
> Patch V4: Rebase on current master
> Patch V6: Fix tls_lock_username rejecting clients with empty username
>           when explicitly accepting them with external-auth
> ---
>  doc/openvpn.8            |  37 +++++++++-
>  src/openvpn/auth_token.c | 156 ++++++++++++++++++++++++++++++++++++---
>  src/openvpn/auth_token.h |  15 +++-
>  src/openvpn/init.c       |   1 +
>  src/openvpn/manage.c     |   4 +-
>  src/openvpn/options.c    |  14 +++-
>  src/openvpn/options.h    |   4 +-
>  src/openvpn/ssl_common.h |  12 ++-
>  src/openvpn/ssl_verify.c |  67 +++++++++++------
>  9 files changed, 270 insertions(+), 40 deletions(-)

[...snip...]
> @@ -97,6 +180,8 @@ generate_auth_token(const struct user_pass *up, struct tls_multi *multi)
>      hmac_ctx_t *ctx = multi->opt.auth_token_key.hmac;
>      ASSERT(hmac_ctx_size(ctx) == 256/8);
>  
> +    uint8_t sessid[AUTH_TOKEN_SESSION_ID_LEN];
> +
>      if (multi->auth_token)
>      {
>          /* Just enough space to fit 8 bytes+ 1 extra to decode a non padded
> @@ -109,27 +194,65 @@ generate_auth_token(const struct user_pass *up, struct tls_multi *multi)
>           * reuse the same session id and timestamp and null terminate it at
>           * for base64 decode it only decodes the session id part of it
>           */
> -        char *old_tsamp_initial = multi->auth_token + strlen(SESSION_ID_PREFIX);
> +        char *old_sessid = multi->auth_token + strlen(SESSION_ID_PREFIX);
> +        char *old_tsamp_initial = old_sessid + AUTH_TOKEN_SESSION_ID_LEN*8/6;
>  
>          old_tsamp_initial[12] = '\0';
>          ASSERT(openvpn_base64_decode(old_tsamp_initial, old_tstamp_decode, 9) == 9);
> -        initial_timestamp = *((uint64_t *)(old_tstamp_decode));
> +
> +        /*
> +         * Avoid old gcc (4.8.x) complaining about strict aliasing
> +         * by using a temporary variable instead of doing it in one
> +         * line
> +         */
> +        uint64_t *tstamp_ptr = (uint64_t *) old_tstamp_decode;
> +        initial_timestamp = *tstamp_ptr;
> +
> +        old_tsamp_initial[0] = '\0';
> +        ASSERT(openvpn_base64_decode(old_sessid, sessid, AUTH_TOKEN_SESSION_ID_LEN)==AUTH_TOKEN_SESSION_ID_LEN);
> +

The gcc-4.8 strict aliasing fix works, so that is good.

Could you explain (or comment) the rationale for the ASSERT() calls here?

If the decoded token is only managed by the server side, then this shouldn't
really fail.  But unless I'm misunderstanding what happens in
verify_user_pass() [ssl_verify.c:1376], we put the "password" (token) from the
client into multi->auth_token.  With the ASSERT() calls here, this could be
abused to trigger a DoS attack, by sending an invalid token value.  Or am I
missing something?

And there is a superfluous additional extra new line, which should not be needed.

[...snip...]


> diff --git a/src/openvpn/auth_token.h b/src/openvpn/auth_token.h
> index 600ac29f..c10afde9 100644
> --- a/src/openvpn/auth_token.h
> +++ b/src/openvpn/auth_token.h
[...snip...]

This file includes the following comment for verify_auth_token(), which I
believe is wrong now:

 * Also calls generate_auth_token to update the auth-token to extend
 * its validity

I don't see verify_auth_token() being close to call generate_auth_token().  Or
did I overlook something?

[...snip...]

> diff --git a/src/openvpn/options.h b/src/openvpn/options.h
> index d885f4d9..8f722497 100644
> --- a/src/openvpn/options.h
> +++ b/src/openvpn/options.h
[...snip...]
> @@ -553,9 +553,17 @@ struct tls_multi
>      /**< Auth-token sent from client has valid hmac */
>  #define  AUTH_TOKEN_EXPIRED              (1<<1)
>      /**< Auth-token sent from client has expired */
> -#endif
> +#define  AUTH_TOKEN_VALID_EMPTYUSER      (1<<2)
> +    /**<
> +     * Auth-token is only valid for an empty username
> +     * and not the username actually supplied from the client
> +     *
> +     * OpenVPN 3 clients sometimes the empty username with a
> +     * username hint from their config.

The last OpenVPN 3 paragraph is hard to understand.  Did you mean this?

  * OpenVPN 3 clients sometimes empty or replaces the username with a
  * username hint from their config.

[...snip...]

> diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
> index b392b0ac..6535ad8d 100644
> --- a/src/openvpn/ssl_verify.c
> +++ b/src/openvpn/ssl_verify.c
[...snip...]
> @@ -1134,7 +1138,8 @@ done:
>   * Verify the username and password using a plugin
>   */
>  static int
> -verify_user_pass_plugin(struct tls_session *session, const struct user_pass *up)
> +verify_user_pass_plugin(struct tls_session *session, struct tls_multi *multi,
> +                        const struct user_pass *up)
>  {
>      int retval = OPENVPN_PLUGIN_FUNC_ERROR;
>  #ifdef PLUGIN_DEF_AUTH
> @@ -1154,6 +1159,8 @@ verify_user_pass_plugin(struct tls_session *session, const struct user_pass *up)
>          /* setenv client real IP address */
>          setenv_untrusted(session);
>  
> +        /* add auth-token environment */
> +        add_session_token_env(session, multi, up);
>  #ifdef PLUGIN_DEF_AUTH
>          /* generate filename for deferred auth control file */
>          if (!key_state_gen_auth_control_file(ks, session->opt))

When looking through the code here; I wonder how this all will work with
deferred authentication and plug-ins.  Have you tested this? (I will run some
additional checks, also covering this use case)


-- 
kind regards,

David Sommerseth
OpenVPN Inc


