Message-ID: <2e34206d-00ce-490d-e23e-6b536a4a682d@...2181...>
Date: Wed, 14 Dec 2022 00:08:54 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <20221213225430.1892940-1-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <20221213225430.1892940-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 1/3] Improve debug logging of DCO swap
 key message and Linux dco_new_peer
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
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net



On 13/12/2022 23:54, Arne Schwabe wrote:
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>   src/openvpn/dco.c       | 18 ++++++++++++++----
>   src/openvpn/dco_linux.c | 10 ++++++++--
>   2 files changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
> index feb38cd02..2396bcbf0 100644
> --- a/src/openvpn/dco.c
> +++ b/src/openvpn/dco.c
> @@ -55,8 +55,8 @@ dco_install_key(struct tls_multi *multi, struct key_state *ks,
>                   const char *ciphername)
>   
>   {
> -    msg(D_DCO_DEBUG, "%s: peer_id=%d keyid=%d", __func__, multi->dco_peer_id,
> -        ks->key_id);
> +    msg(D_DCO_DEBUG, "%s: peer_id=%d keyid=%d, currently installed %d",

I'd make this "num. installed" because "currently installed" makes me 
think as if what follows is the ID of something that is installed. While 
we should make it explicit that this is the number of installed keys.

> +        __func__, multi->dco_peer_id, ks->key_id, multi->dco_keys_installed);
>   
>       /* Install a key in the PRIMARY slot only when no other key exist.
>        * From that moment on, any new key will be installed in the SECONDARY
> @@ -181,8 +181,18 @@ dco_update_keys(dco_context_t *dco, struct tls_multi *multi)
>        */
>       if (primary->dco_status == DCO_INSTALLED_SECONDARY)
>       {
> -        msg(D_DCO_DEBUG, "Swapping primary and secondary keys, now: id1=%d id2=%d",
> -            primary->key_id, secondary ? secondary->key_id : -1);
> +        if (secondary)
> +        {
> +            msg(D_DCO_DEBUG, "Swapping primary and secondary keys to "
> +                "primary-id=%d secondary-id=%d",
> +                primary->key_id, secondary->key_id);
> +        }
> +        else
> +        {
> +            msg(D_DCO_DEBUG, "Swapping primary and secondary keys to"
> +                "primary-id=%d secondary-id=(to be deleted)",
> +                primary->key_id);
> +        }
>   
>           int ret = dco_swap_keys(dco, multi->dco_peer_id);
>           if (ret < 0)
> diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
> index 109358205..fbd940c28 100644
> --- a/src/openvpn/dco_linux.c
> +++ b/src/openvpn/dco_linux.c
> @@ -216,9 +216,15 @@ dco_new_peer(dco_context_t *dco, unsigned int peerid, int sd,
>                struct sockaddr *localaddr, struct sockaddr *remoteaddr,
>                struct in_addr *remote_in4, struct in6_addr *remote_in6)
>   {
> -    msg(D_DCO_DEBUG, "%s: peer-id %d, fd %d", __func__, peerid, sd);
> -
>       struct gc_arena gc = gc_new();
> +    const char *remotestr = "[undefined]";
> +    if (remoteaddr)
> +    {
> +        remotestr = print_sockaddr(remoteaddr, &gc);
> +    }
> +    msg(D_DCO_DEBUG, "%s: peer-id %d, fd %d, remote addr: %s", __func__,
> +        peerid, sd, remotestr);
> +
>       struct nl_msg *nl_msg = ovpn_dco_nlmsg_create(dco, OVPN_CMD_NEW_PEER);
>       struct nlattr *attr = nla_nest_start(nl_msg, OVPN_ATTR_NEW_PEER);
>       int ret = -EMSGSIZE;


The rest makes sense:

Acked-by: Antonio Quartulli <a@...2181...>

-- 
Antonio Quartulli

