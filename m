Message-ID: <f657a4e1-e9a9-0cf9-0fd1-58744ac9fd01@...2181...>
Date: Wed, 18 May 2022 16:23:23 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220518105157.9026-1-frank@...2641...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <20220518105157.9026-1-frank@...2641...>
Subject: Re: [Openvpn-devel] [PATCH] uncrustify: have exactly one newline at
 the end of files
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Frank Lichtenheld <frank@...2641...>, openvpn-devel@lists.sourceforge.net

Hi,

On 18/05/2022 12:51, Frank Lichtenheld wrote:
> Avoid the ugly "No newline at end of file" in git
> diffs.
> 
> Signed-off-by: Frank Lichtenheld <frank@...2641...>

It does what we want.

Acked-by: Antonio Quartulli <a@...2181...>

> ---
>   dev-tools/uncrustify.conf  | 2 ++
>   src/compat/compat-daemon.c | 1 -
>   src/openvpn/ssl_ncp.c      | 2 +-
>   3 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/dev-tools/uncrustify.conf b/dev-tools/uncrustify.conf
> index 25eb4cdd..a04c6164 100644
> --- a/dev-tools/uncrustify.conf
> +++ b/dev-tools/uncrustify.conf
> @@ -45,6 +45,8 @@ nl_enum_leave_one_liners=true
>   nl_brace_fparen=add
>   nl_max=4
>   nl_after_func_proto=2
> +nl_end_of_file_min=1
> +nl_end_of_file=force
>   
>   # Always use scoping braces for conditionals
>   mod_full_brace_if=add
> diff --git a/src/compat/compat-daemon.c b/src/compat/compat-daemon.c
> index 197bc3f1..460b9e99 100644
> --- a/src/compat/compat-daemon.c
> +++ b/src/compat/compat-daemon.c
> @@ -102,4 +102,3 @@ daemon(int nochdir, int noclose)
>   }
>   
>   #endif /* ifndef HAVE_DAEMON */
> -
> diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
> index 4a083e24..4bcbc69a 100644
> --- a/src/openvpn/ssl_ncp.c
> +++ b/src/openvpn/ssl_ncp.c
> @@ -494,4 +494,4 @@ p2p_mode_ncp(struct tls_multi *multi, struct tls_session *session)
>           multi->use_peer_id, multi->peer_id, common_cipher);
>   
>       gc_free(&gc);
> -}
> \ No newline at end of file
> +}

-- 
Antonio Quartulli

