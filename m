Message-ID: <b7194780-5729-9435-a641-9ef926926e86@...2181...>
Date: Mon, 27 Mar 2023 22:30:19 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20230327171236.51771-1-selva.nair@...277...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <20230327171236.51771-1-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Bug-fix: segfault in
 dco_get_peer_stats()
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
To: selva.nair@...277..., openvpn-devel@lists.sourceforge.net

Hi,

On 27/03/2023 19:12, selva.nair@...277... wrote:
> From: Selva Nair <selva.nair@...277...>
> 
>    We persist peer-stats when restarting, but an early restart
>    before open_tun results in a segfault in dco_get_peer_stats().
>    To reproduce, trigger a TLS handshake error due to lack of common
>    protocols, for example.
> 
>    Fix by checking  that tuntap is defined before dereferencing it.
> 
> Signed-off-by: Selva Nair <selva.nair@...277...>

Nice catch! Thanks a lot!

> ---
> I'm not entirely sure this is the right place to fix this.
> Or is it the caller at fault exercising  dco_get_peer_stats()
> when tuntap is not set?

Indeed that was my assumption.

Does somebody have the stacktrace?
I wanted to check where this call is coming from exactly.

Imho it'd be reasonable if the caller could check if we have a device 
before invoking any DCO API.

Alla other DCO API just assume that everything was properly initialized 
before being invoked, therefore it'd be nice to keep the same assumption 
here.

(better would even be if this gets_stats function would not require to 
fiddle with a struct context at all....but that's material for master)

Cheers,

> 
>   src/openvpn/dco_linux.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
> index 317f9dc0..41540c0f 100644
> --- a/src/openvpn/dco_linux.c
> +++ b/src/openvpn/dco_linux.c
> @@ -975,6 +975,11 @@ dco_get_peer_stats(struct context *c)
>       uint32_t peer_id = c->c2.tls_multi->dco_peer_id;
>       msg(D_DCO_DEBUG, "%s: peer-id %d", __func__, peer_id);
>   
> +    if (!c->c1.tuntap)
> +    {
> +        return 0;
> +    }
> +
>       dco_context_t *dco = &c->c1.tuntap->dco;
>       struct nl_msg *nl_msg = ovpn_dco_nlmsg_create(dco, OVPN_CMD_GET_PEER);
>       struct nlattr *attr = nla_nest_start(nl_msg, OVPN_ATTR_GET_PEER);

-- 
Antonio Quartulli

