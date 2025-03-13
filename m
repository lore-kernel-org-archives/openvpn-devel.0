Message-ID: <8ecfd79f-7a61-4374-bf73-89624be3cc9c@...2181...>
Date: Thu, 13 Mar 2025 01:41:41 +0100
MIME-Version: 1.0
References: <20250227032522.3734947-1-dqfext@...277...>
Content-Language: en-US
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <20250227032522.3734947-1-dqfext@...277...>
Subject: Re: [Openvpn-devel] [PATCH v3] dco: fix source IP selection when
 multihome
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
To: Qingfang Deng <dqfext@...277...>, openvpn-devel@lists.sourceforge.net

On 27/02/2025 04:25, Qingfang Deng wrote:
> When multihome option is enabled, OpenVPN passes ipi_addr to DCO, which
> is always 0.0.0.0. It should use ipi_spec_dst instead.
> 
> Signed-off-by: Qingfang Deng <dqfext@...277...>
> ---
>   src/openvpn/dco.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
> index 02fae816..d6e8ec5f 100644
> --- a/src/openvpn/dco.c
> +++ b/src/openvpn/dco.c
> @@ -562,7 +562,7 @@ dco_multi_get_localaddr(struct multi_context *m, struct multi_instance *mi,
>           {
>               struct sockaddr_in *sock_in4 = (struct sockaddr_in *)local;
>   #if defined(HAVE_IN_PKTINFO) && defined(HAVE_IPI_SPEC_DST)
> -            sock_in4->sin_addr = actual->pi.in4.ipi_addr;
> +            sock_in4->sin_addr = actual->pi.in4.ipi_spec_dst;
>   #elif defined(IP_RECVDSTADDR)
>               sock_in4->sin_addr = actual->pi.in4;
>   #else

Tested and confirmed it does what it says.

Acked-by: Antonio Quartulli <antonio@...2726...>

-- 
Antonio Quartulli


