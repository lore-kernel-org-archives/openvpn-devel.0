Message-ID: <f5dbcc0d-bcb4-5b3d-af06-938a8f453ef5@...2181...>
Date: Wed, 29 Mar 2023 15:01:39 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20230214135658.1034787-1-arne@...1227...>
 <20230329124644.1956530-1-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <20230329124644.1956530-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v2] Add missing check for
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



On 29/03/2023 14:46, Arne Schwabe wrote:
> This can happen if the memory alloc fails.
> 
> Patch V2: add goto error
> 
> Change-Id: Iee66caa794d267ac5f8bee584633352893047171
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>   src/openvpn/dco_linux.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
> index 41540c0f8..95fe94848 100644
> --- a/src/openvpn/dco_linux.c
> +++ b/src/openvpn/dco_linux.c
> @@ -83,6 +83,13 @@ resolve_ovpn_netlink_id(int msglevel)
>       int ret;
>       struct nl_sock *nl_sock = nl_socket_alloc();
>   
> +    if (!nl_sock)
> +    {
> +        msg(msglevel, "Allocating net link socket failed");
> +        ret = -1;

Please use -ENOMEM here - it is always better to return an actual reason 
rather than just "failed".

> +        goto err_sock;

There is no need to jump to cleanup.
You can just return -1 here and save one line.
(this is what we do in other functions of this file)

Cheers,

-- 
Antonio Quartulli

