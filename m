Message-ID: <55422ED0.7010304@...1227...>
Date: Thu, 30 Apr 2015 15:32:00 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <1430398960-10300-1-git-send-email-gert@...1296...>
In-Reply-To: <1430398960-10300-1-git-send-email-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] plugin-down-root: only include <err.h>
 if system has it.
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



Am 30.04.15 um 15:02 schrieb Gert Doering:
> down-root.c was missing an #ifdef HAVE_ERR_H around <err.h>
> (only relevant on AIX, it seems)
>
> Trac #495
>
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  src/plugins/down-root/down-root.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/src/plugins/down-root/down-root.c b/src/plugins/down-root/down-root.c
> index 6931bec..42db064 100644
> --- a/src/plugins/down-root/down-root.c
> +++ b/src/plugins/down-root/down-root.c
> @@ -42,7 +42,9 @@
>  #include <signal.h>
>  #include <syslog.h>
>  #include <errno.h>
> +#ifdef HAVE_ERR_H
>  #include <err.h>
> +#endif
>  
>  #include <openvpn-plugin.h>
>  
ACK.

Arne

