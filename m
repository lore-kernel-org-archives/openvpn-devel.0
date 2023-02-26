Message-ID: <762ddf09-c27e-3086-d9b8-30c837998294@...2181...>
Date: Sun, 26 Feb 2023 21:55:17 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <20230217122156.541-1-lstipakov@...277...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <20230217122156.541-1-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Avoid management log loop with verb >= 6
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
To: Lev Stipakov <lstipakov@...277...>, openvpn-devel@lists.sourceforge.net
Cc: Lev Stipakov <lev@...515...>

Hi,

On 17/02/2023 13:21, Lev Stipakov wrote:
> From: Lev Stipakov <lev@...515...>
> 
> This log message is printed within check_tls(),
> which is called by pre_select(), which is called
> on every iteration of event loop.
> 
> When management is attached (and doesn't use own event loop),
> this message sets management state to "wait write",
> which arms event loop. When on the next iteration iowait
> returns with "management write event is set", we call
> pre_select() and print that message again, causing the loop.
> 
> Fix by simply removing this log message.
> 
> Signed-off-by: Lev Stipakov <lev@...515...>

As discussed on IRC, removing this message is a good thing as it serves 
no real purpose.

On top of that this message is causing this log infinite recursion, 
therefore it should just go.

OTOH we may still have *some* recursion due to other messages printed by 
this function. However, this messages will print only once, therefore 
they won't cause the recursion to continue indefinitely.

Acked-by: Antonio Quartulli <a@...2181...>

> ---
>   src/openvpn/dco.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
> index 3087a0df..b53332a8 100644
> --- a/src/openvpn/dco.c
> +++ b/src/openvpn/dco.c
> @@ -133,8 +133,6 @@ dco_get_secondary_key(struct tls_multi *multi, const struct key_state *primary)
>   bool
>   dco_update_keys(dco_context_t *dco, struct tls_multi *multi)
>   {
> -    msg(D_DCO_DEBUG, "%s: peer_id=%d", __func__, multi->dco_peer_id);
> -
>       /* this function checks if keys have to be swapped or erased, therefore it
>        * can't do much if we don't have any key installed
>        */

-- 
Antonio Quartulli

