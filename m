References: <1464130427-25002-1-git-send-email-selva.nair@...277...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <57457A80.4030506@...2080...>
Date: Wed, 25 May 2016 12:12:16 +0200
MIME-Version: 1.0
In-Reply-To: <1464130427-25002-1-git-send-email-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Pass echo option to systemd-ask-password
Reply-To: openvpn-devel@lists.sourceforge.net
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
To: Selva Nair <selva.nair@...277...>, openvpn-devel@lists.sourceforge.net

On 25/05/16 00:53, Selva Nair wrote:
> Do not mask input when echo is requested. Useful for username
> input and sometimes for challenge response.
> 
> Signed-off-by: Selva Nair <selva.nair@...277...>
> ---
>  src/openvpn/console.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/src/openvpn/console.c b/src/openvpn/console.c
> index 86331a1..8a8acb4 100644
> --- a/src/openvpn/console.c
> +++ b/src/openvpn/console.c
> @@ -167,7 +167,10 @@ get_console_input_systemd (const char *prompt, const bool echo, char *input, con
>  
>    argv_init (&argv);
>    argv_printf (&argv, SYSTEMD_ASK_PASSWORD_PATH);
> -  argv_printf_cat (&argv, "%s", prompt);
> +  if (echo)
> +    argv_printf_cat (&argv, "--echo %s", prompt);
> +  else
> +    argv_printf_cat (&argv, "%s", prompt);
>  
>    if ((std_out = openvpn_popen (&argv, NULL)) < 0) {
>  	  return false;
> 

Hi Selva,

Thanks a lot!  This patch do make sense, feature wise.  And we already
have basically that in a patch queue already.  The problem with this
approach is that it may break systems with systemd older than version 216.

Gert also requested that this whole interface should be made less "linux
specific" [1], so I started on a patchset which makes the
query-user-input interface far more modular.  But I need to get start
hacking on a v4 of that patch set as Gert didn't like several things in
the previous attempt [2].

[1] <http://thread.gmane.org/gmane.network.openvpn.devel/9085/focus=9091>
[2] <http://thread.gmane.org/gmane.network.openvpn.devel/10021/>

I've just changed employer, and OpenVPN is truly part of what I will be
working on.  So getting the query-user-input patches through is high up
on my list.  I just need to get settled with my new employer and I'll
start hacking on it.  But your patch is pretty much identical to what
I've already proposed [3].

[3] <http://thread.gmane.org/gmane.network.openvpn.devel/10021/focus=10019>


-- 
kind regards,

David Sommerseth


