Resent-To: openvpn-devel@lists.sourceforge.net
Resent-Message-ID: <b758a118-6040-1258-9234-cf1ba7bde9f1@...2162...>
References: <20200930131317.1299-1-arne@...1227...>
 <20200930131317.1299-11-arne@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <43dc2d46-04a7-0d23-e3bc-587992d5020d@...2080...>
Date: Thu, 21 Jan 2021 18:29:52 +0100
MIME-Version: 1.0
In-Reply-To: <20200930131317.1299-11-arne@...1227...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH 09/11] Implement deferred auth for
 scripts
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>

On 30/09/2020 15:13, Arne Schwabe wrote:
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>   Changes.rst                         |  9 +++++
>   doc/man-sections/script-options.rst | 14 +++++++-
>   src/openvpn/ssl_verify.c            | 56 ++++++++++++++++++++++++-----
>   3 files changed, 70 insertions(+), 9 deletions(-)
> 

Only glared at the code here too.  In addition to prior merge conflicts, 
commit bbcada8abb410 seems to add even more confusion when applying this 
patch.

> diff --git a/Changes.rst b/Changes.rst
> index f67e1d76..7e60eb64 100644
> --- a/Changes.rst
> +++ b/Changes.rst

Ignoring merge conflicts here though.  Not important in this round.

> diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
> index fc3a1116..5e15fa32 100644
> --- a/src/openvpn/ssl_verify.c
> +++ b/src/openvpn/ssl_verify.c
> @@ -1189,14 +1189,14 @@ tls_authenticate_key(struct tls_multi *multi, const unsigned int mda_key_id, con
>   /*
>    * Verify the user name and password using a script
>    */
> -static bool
> +static int
>   verify_user_pass_script(struct tls_session *session, struct tls_multi *multi,
>                           const struct user_pass *up)
>   {
>       struct gc_arena gc = gc_new();
>       struct argv argv = argv_new();
>       const char *tmp_file = "";
> -    bool ret = OPENVPN_PLUGIN_FUNC_ERROR;
> +    int retval = OPENVPN_PLUGIN_FUNC_ERROR;

Good fixing this mistake from previous round, but incorrect indenting.

>   
>       /* Is username defined? */
>       if ((session->opt->ssl_flags & SSLF_AUTH_USER_PASS_OPTIONAL) || strlen(up->username))
> @@ -1247,10 +1247,45 @@ verify_user_pass_script(struct tls_session *session, struct tls_multi *multi,
>           argv_parse_cmd(&argv, session->opt->auth_user_pass_verify_script);
>           argv_printf_cat(&argv, "%s", tmp_file);
>   
> +        /* Add files needed for deferred auth */
> +        key_state_gen_auth_control_files(&session->key[KS_PRIMARY],
> +                                         session->opt);
> +
>           /* call command */
> -        ret = openvpn_run_script(&argv, session->opt->es, 0,
> -                                 "--auth-user-pass-verify");
> +        int script_ret = openvpn_run_script(&argv, session->opt->es, S_EXITCODE,
> +                                            "--auth-user-pass-verify");

Perhaps move the retval declaration down here, as we're touching it 
anyhow?  This switch() is the first place we use it, unless I'm 
overlooking something.

> +        switch (script_ret)
> +        {
> +           case 0:
> +               retval = OPENVPN_PLUGIN_FUNC_SUCCESS;
> +               break;
> +           case 2:
> +               retval = OPENVPN_PLUGIN_FUNC_DEFERRED;
> +               break;
> +           default:
> +               retval = OPENVPN_PLUGIN_FUNC_ERROR;
> +               break;
> +           }
[...snip...]
>   
>   /*
> @@ -1406,7 +1441,7 @@ verify_user_pass(struct user_pass *up, struct tls_multi *multi,
>                    struct tls_session *session)
>   {
>       int s1 = OPENVPN_PLUGIN_FUNC_SUCCESS;
> -    bool s2 = true;
> +    int s2 = OPENVPN_PLUGIN_FUNC_SUCCESS;

Indenting issues?

[...snip...]

> @@ -1499,7 +1534,11 @@ verify_user_pass(struct user_pass *up, struct tls_multi *multi,
>   #ifdef PLUGIN_DEF_AUTH
>            || s1 == OPENVPN_PLUGIN_FUNC_DEFERRED
>   #endif
> -         ) && s2
> +         ) &&
> +        ((s2 == OPENVPN_PLUGIN_FUNC_SUCCESS)
> +#ifdef ENABLE_DEF_AUTH
> +         || s2 ==  OPENVPN_PLUGIN_FUNC_DEFERRED)
> +#endif
>   #ifdef MANAGEMENT_DEF_AUTH
>           && man_def_auth != KMDA_ERROR
>   #endif

Yikes!  This if() statement is unreadable.  Since you are doing changes 
here, could we improve this whole logic.  Perhaps using a helper macro 
like this (incorrect code-style, for e-mail readability)

      #define PLUGIN_AUTH_RESULT_PASS(s) \
           (OPENVPN_PLUGIN_FUNC_SUCCESS == s\
            || OPENVPN_PLUGIN_FUNC_DEFERRED == s)

      [...]
      if (PLUGIN_AUTH_RESULT_PASS(s1)
          && PLUGIN_AUTH_RESULT_PASS(s2)
          && tls_lock_username(multi, up->username))
      {
#ifdef ENABLE_MANGEMENT
	if (KMDA_ERROR == man_def_auth)
	{
		/* ... error handling ... */
		goto error;
         }
	if (KMDA_UNDEF == man_def_auth)
	{
		ks->authenticated = KS_AUTH_DEFERRED;
	}
#endif  // ENABLE_MANAGEMENT

         /* ... rest of the if block content ... */

	return;  // Success
       }

error:
      /* ... existing error handling from if-else block... */


This is just a quick draft skeleton.  Right now the code is pretty 
messy, and we should improve the code quality on such critical code 
paths such as user authentication.



-- 
kind regards,

David Sommerseth
OpenVPN Inc


