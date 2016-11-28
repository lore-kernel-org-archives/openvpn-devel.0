References: <1480335220-14810-1-git-send-email-steffan.karger@...1435...>
	<CAKuzo_hDcoTm-teJ3UeKQ+B=RTpStb3KMjQKLc0x7A2-_TUvoA@...278...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <68d50540-ec71-5564-99a7-7bb24ae05d17@...1856...>
Date: Mon, 28 Nov 2016 23:11:24 +0100
MIME-Version: 1.0
In-Reply-To: <CAKuzo_hDcoTm-teJ3UeKQ+B=RTpStb3KMjQKLc0x7A2-_TUvoA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Introduce and use secure_memzero() to
 erase secrets
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


On 28-11-16 17:39, Selva Nair wrote:
> 
> On Mon, Nov 28, 2016 at 7:13 AM, Steffan Karger
> <steffan.karger@...1435... <mailto:steffan.karger@...1435...>> wrote:
> 
>     As described in trac #751, and shortly after reported by Zhaomo Yang, of
>     the University of California, San Diego, we use memset() (often through
>     the CLEAR() macro) to erase secrets after use.  In some cases
>     however, the
>     compiler might optimize these calls away.
> 
>     This patch replaces these memset() calls on secrets by calls to a new
>     secure_memzero() function, that will not be optimized away.
> 
>     Since we use CLEAR() a LOT of times, I'm not changing that to use
>     secure_memzero() to prevent performance impact.  I did annotate the
>     macro
>     to point people at secure_memzero().
> 
>     This patch also replaces some CLEAR() or memset() calls with a zero-
>     initialization using "= { 0 }" if that has the same effect, because that
>     better captures the intend of that code.
> 
>     Signed-off-by: Steffan Karger <steffan.karger@...1435...
>     <mailto:steffan.karger@...1435...>>
> 
> 
> All look good except that it might have missed some memset calls that
> could benefit from a  SecureZeroMemory() or equivalent:
> 
> With no pretense of completeness, here is a list with some context:
> calls marked with <-- SecureZero
> 
> 
> --- a/src/openvpn/console_builtin.c
> +++ b/src/openvpn/console_builtin.c
> @@ -218,7 +218,7 @@ static bool get_console_input (const char *prompt,
> const bool echo, char *input,
>          if (gp)
>          {
>              strncpynt (input, gp, capacity);
> -            memset (gp, 0, strlen (gp));
> +            memset (gp, 0, strlen (gp)); <-- SecureZero
>              ret = true;
>          }
>      }
> 
> --- a/src/openvpn/misc.c
> +++ b/src/openvpn/misc.c
> @@ -501,7 +501,7 @@ remove_env_item (const char *str, const bool
> do_free, struct env_item **list)
>             *list = current->next;
>           if (do_free)
>             {
> -             memset (current->string, 0, strlen (current->string));
> +             memset (current->string, 0, strlen (current->string)); <--
> SecureZero
>               free (current->string);
>               free (current);
>             }
> 

Thanks, these make sense to include too, indeed.

> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
> @@ -1212,7 +1212,7 @@ tls_multi_free (struct tls_multi *multi, bool clear)
>  
>    if (multi->auth_token)
>      {
> -      memset (multi->auth_token, 0, AUTH_TOKEN_SIZE);
> +      memset (multi->auth_token, 0, AUTH_TOKEN_SIZE); <-- SecureZero
>        free (multi->auth_token);
>      }
>  
>  
> --- a/src/openvpn/ssl_verify.c
> +++ b/src/openvpn/ssl_verify.c
> @@ -1176,7 +1176,7 @@ verify_user_pass(struct user_pass *up, struct
> tls_multi *multi,
>        if (memcmp_constant_time(multi->auth_token, up->password,
>                   strlen(multi->auth_token)) != 0)
>          {
> -          memset (multi->auth_token, 0, AUTH_TOKEN_SIZE);
> +          memset (multi->auth_token, 0, AUTH_TOKEN_SIZE); <-- SecureZero
>            free (multi->auth_token);
> 
> 
> @@ -1262,7 +1262,7 @@ verify_user_pass(struct user_pass *up, struct
> tls_multi *multi,
>                    "No auth-token will be activated now");
>       if (multi->auth_token)
>  {
> - memset (multi->auth_token, 0, AUTH_TOKEN_SIZE);
> + memset (multi->auth_token, 0, AUTH_TOKEN_SIZE); <-- SecureZero
>   free (multi->auth_token);
>   multi->auth_token = NULL;
>  }

This is just silly, these lines are the reason I created trac #741 in
the first place...

v2 coming soon!

-Steffan

