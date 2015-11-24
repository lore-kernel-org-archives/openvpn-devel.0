References: <1448370550-23897-1-git-send-email-gert@...1296...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <565468B3.5010903@...1435...>
Date: Tue, 24 Nov 2015 14:40:03 +0100
MIME-Version: 1.0
In-Reply-To: <1448370550-23897-1-git-send-email-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] remove unused gc_arena in FreeBSD
 close_tun()
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

On 24-11-15 14:09, Gert Doering wrote:
> not used, and a small mem leak on every tunnel close...
> 
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  src/openvpn/tun.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index 8139afc..c293e1e 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -2539,7 +2539,6 @@ close_tun (struct tuntap *tt)
>      }
>    else if (tt)				/* close and destroy */
>      {
> -      struct gc_arena gc = gc_new ();
>        struct argv argv;
>  
>        /* setup command, close tun dev (clears tt->actual_name!), run command
> 

ACK

-Steffan

