References: <1481543265-21474-1-git-send-email-lstipakov@...277...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <32cf485a-88f4-57cf-0d1d-3eb7a907ac65@...1435...>
Date: Wed, 14 Dec 2016 13:48:01 +0100
MIME-Version: 1.0
In-Reply-To: <1481543265-21474-1-git-send-email-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Make --enable-async-push depend on
 --enable-plugins
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

On 12-12-16 12:47, Lev Stipakov wrote:
> Async push functionality makes sense only with deferred authentication,
> which requires plugins.
> 
> Trac #783
> 
> Signed-off-by: Lev Stipakov <lstipakov@...277...>
> ---
>  configure.ac | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/configure.ac b/configure.ac
> index 27bdcc3..946f3db 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -1204,6 +1204,10 @@ if test "${enable_plugin_auth_pam}" = "yes"; then
>  fi
>  
>  if test "${enable_async_push}" = "yes"; then
> +	if test "${enable_plugins}" = "no"; then
> +		AC_MSG_ERROR([--enable_async_push requires --enable-plugins])
> +	fi
> +
>  	AC_CHECK_HEADERS(
>  		[sys/inotify.h],
>  		AC_DEFINE([ENABLE_ASYNC_PUSH], [1], [Enable async push]),
> 

I followed the discussion, gave the arguments some more thought, but
still believe this is The Right Thing.  So, ACK.

-Steffan

