Message-ID: <4c469f03-c631-6839-7bd3-3ddda1b4f0b2@...1227...>
Date: Fri, 6 Jan 2023 11:32:31 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20221227223506.34136-1-gert@...1296...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20221227223506.34136-1-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Undo FreeBSD 12.x workaround on IPv6
 ifconfig for 12.4 and up
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
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

Am 27.12.22 um 23:35 schrieb Gert Doering:
> commit 5e19cc2c1bf22d introduced a workaround for a race condition
> that showed itself on IPv6 ifconfig on FreeBSD 12.x - sometimes breaking
> IPv6 connectivity on tun/tap interfaces.
> 
> This was fixed on the FreeBSD side in 12.4, 13.1 and up, and 13.0 is
> no longer supported.  So conditionalize the workaround on "12.0..12.3",
> to be fully removed later when 12.3 is also running out of support.
> 
> Trac: 1226
> 
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>   src/openvpn/tun.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index a83ec9e6..399e851b 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -1104,8 +1104,9 @@ do_ifconfig_ipv6(struct tuntap *tt, const char *ifname, int tun_mtu,
>       openvpn_execve_check(&argv, es, S_FATAL,
>                            "generic BSD ifconfig inet6 failed");
>   
> -#if defined(TARGET_FREEBSD) && __FreeBSD_version >= 1200000
> -    /* On FreeBSD 12 and up, there is ipv6_activate_all_interfaces="YES"
> +#if defined(TARGET_FREEBSD) && __FreeBSD_version >= 1200000 \
> +	&& __FreeBSD_version <= 1200000
> +    /* On FreeBSD 12.0-12.3, there is ipv6_activate_all_interfaces="YES"


That does not look right. Should the second one be < 1300000? Otherwise 
I would rather simplify the expression to __FreeBSD_version == 1200000 
since that is what it currently is.

>        * in rc.conf, which is not set by default.  If it is *not* set,
>        * "all new interfaces that are not already up" are configured by
>        * devd + /etc/pccard_ether as "inet6 ifdisabled".


