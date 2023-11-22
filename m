Message-ID: <2341305a-ec20-459d-ac70-86d3538c3451@...2181...>
Date: Wed, 22 Nov 2023 13:35:37 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <20230214135658.1034787-1-arne@...1227...>
 <20231121170603.886801-1-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <20231121170603.886801-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v3] Add missing check for
 nl_socket_alloc failure
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

Hi,

On 21/11/2023 18:06, Arne Schwabe wrote:
> This can happen if the memory alloc fails.
> 
> Patch V2: add goto error
> Patch V3: return -ENOMEM instead of going to error
> 
> Change-Id: Iee66caa794d267ac5f8bee584633352893047171
> Signed-off-by: Arne Schwabe <arne@...1227...>

Acked-by: Antonio Quartulli <a@...2181...>

> ---
>   src/openvpn/dco_linux.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
> index b033f8543..3c91606b7 100644
> --- a/src/openvpn/dco_linux.c
> +++ b/src/openvpn/dco_linux.c
> @@ -81,6 +81,12 @@ resolve_ovpn_netlink_id(int msglevel)
>       int ret;
>       struct nl_sock *nl_sock = nl_socket_alloc();
>   
> +    if (!nl_sock)
> +    {
> +        msg(msglevel, "Allocating net link socket failed");
> +        return -ENOMEM;
> +    }
> +
>       ret = genl_connect(nl_sock);
>       if (ret)
>       {

-- 
Antonio Quartulli

