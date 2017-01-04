References: <1483479738-17672-1-git-send-email-selva.nair@...277...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <fc5496a6-5665-efbc-0003-a707fda7fb4b@...1856...>
Date: Wed, 4 Jan 2017 01:07:48 +0100
MIME-Version: 1.0
In-Reply-To: <1483479738-17672-1-git-send-email-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Fix push options digest update
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


On 03-01-17 22:42, selva.nair@...277... wrote:
> From: Selva Nair <selva.nair@...277...>
> 
> Signed-off-by: Selva Nair <selva.nair@...277...>
> ---
>  src/openvpn/push.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/openvpn/push.c b/src/openvpn/push.c
> index f515475..c9c04a6 100644
> --- a/src/openvpn/push.c
> +++ b/src/openvpn/push.c
> @@ -692,8 +692,8 @@ push_update_digest(md_ctx_t *ctx, struct buffer *buf, const struct options *opt)
>          {
>              continue;
>          }
> +        md_ctx_update(ctx, (const uint8_t *) line, strlen(line)+1);
>      }
> -    md_ctx_update(ctx, (const uint8_t *) line, strlen(line)+1);
>  }
>  
>  int
> 

ACK.  And sorry for this 'one brace too far'...  (It did ignore the
cipher update nicely though ;) )

-Steffan

