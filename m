References: <1570537606-29323-1-git-send-email-lstipakov@...277...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <393dce92-d103-03a3-a7a7-46c00df40087@...1227...>
Date: Tue, 8 Oct 2019 14:36:28 +0200
MIME-Version: 1.0
In-Reply-To: <1570537606-29323-1-git-send-email-lstipakov@...277...>
Content-Language: de-DE
Subject: Re: [Openvpn-devel] [PATCH 1/2] push.c: fix Visual Studio build
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
To: Lev Stipakov <lstipakov@...277...>, openvpn-devel@lists.sourceforge.net

Am 08.10.19 um 14:26 schrieb Lev Stipakov:
> From: Lev Stipakov <lev@...515...>
> 
> Visual Studio doesn't support designated initializers
> for C code, so replace it with CLEAR() macro.
> 
> Signed-off-by: Lev Stipakov <lev@...515...>
> ---
>  src/openvpn/push.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/src/openvpn/push.c b/src/openvpn/push.c
> index 49b9d1b..213e2b6 100644
> --- a/src/openvpn/push.c
> +++ b/src/openvpn/push.c
> @@ -504,9 +504,10 @@ void
>  send_push_reply_auth_token(struct tls_multi *multi)
>  {
>      struct gc_arena gc = gc_new();
> +    struct push_list push_list;
>  
> +    CLEAR(push_list);
>  
> -    struct push_list push_list = {};
>      prepare_auth_token_push_reply(multi, &gc, &push_list);
>  
>      /* prepare auth token should always add the auth-token option */
> 

Acked-By: Arne Schwabe

I thought we had those in other places. But I guess I was wrong.

Arne

