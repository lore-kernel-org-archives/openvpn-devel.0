References: <20210421134348.1950392-1-arne@...1227...>
 <20210421134348.1950392-4-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <b4147c3d-e538-941f-1b71-54740635f5b0@...2181...>
Date: Thu, 22 Apr 2021 02:21:21 +0200
MIME-Version: 1.0
In-Reply-To: <20210421134348.1950392-4-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 4/7] Fix a number of mingw warnings
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi,

On 21/04/2021 15:43, Arne Schwabe wrote:
> Move to definition inside the ifdef where they are used to avoid
> unused warnings.
> 
> Fix a few printf related warnings when DWORD is used as paramter and
> the printf format should be %lu (long unsigned int)
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  src/openvpn/route.c  | 4 ++--
>  src/openvpn/socket.c | 3 ++-
>  src/openvpn/tun.c    | 2 +-
>  3 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/src/openvpn/route.c b/src/openvpn/route.c
> index c6b3dc584..c83bd9e2b 100644
> --- a/src/openvpn/route.c
> +++ b/src/openvpn/route.c
> @@ -2360,7 +2360,6 @@ delete_route_ipv6(const struct route_ipv6 *r6, const struct tuntap *tt,
>  #else
>      int metric;
>  #endif
> -    const char *device = tt->actual_name;
>      bool gateway_needed = false;
>  
>      if ((r6->flags & (RT_DEFINED|RT_ADDED)) != (RT_DEFINED|RT_ADDED))
> @@ -2369,6 +2368,7 @@ delete_route_ipv6(const struct route_ipv6 *r6, const struct tuntap *tt,
>      }
>  
>  #ifndef _WIN32
> +    const char *device = tt->actual_name;

This variable is not used in all cases embraced by "ifndef _WIN32".
I.e. I think it is not used when any of the following is defined:
TARGET_OPENBSD
TARGET_NETBSD
TARGET_AIX

Therefore this change would fix *only* the warning on Windows.
Do we want to go this way? or should we rather rearrange the ifdefs a
bit so that we have a cleaner change/function?



>      if (r6->iface != NULL)              /* vpn server special route */
>      {
>          device = r6->iface;
> @@ -2713,7 +2713,7 @@ get_default_gateway_row(const MIB_IPFORWARDTABLE *routes)
>              const DWORD index = row->dwForwardIfIndex;
>              const DWORD metric = row->dwForwardMetric1;
>  
> -            dmsg(D_ROUTE_DEBUG, "GDGR: route[%d] %s/%s i=%d m=%d",
> +            dmsg(D_ROUTE_DEBUG, "GDGR: route[%lu] %s/%s i=%d m=%d",

shouldn't be enough to convert to %u ? (/me is not a DOWRD expert though)


>                   i,
>                   print_in_addr_t((in_addr_t) net, 0, &gc),
>                   print_in_addr_t((in_addr_t) mask, 0, &gc),
> diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
> index b13d2e0f1..8a6e42cc6 100644
> --- a/src/openvpn/socket.c
> +++ b/src/openvpn/socket.c
> @@ -2837,10 +2837,11 @@ print_link_socket_actual_ex(const struct link_socket_actual *act,
>  {
>      if (act)
>      {
> -        char ifname[IF_NAMESIZE] = "[undef]";
>          struct buffer out = alloc_buf_gc(128, gc);
>          buf_printf(&out, "%s", print_sockaddr_ex(&act->dest.addr.sa, separator, flags, gc));
>  #if ENABLE_IP_PKTINFO
> +        char ifname[IF_NAMESIZE] = "[undef]";

This makes sense.

> +
>          if ((flags & PS_SHOW_PKTINFO) && addr_defined_ipi(act))
>          {
>              switch (act->dest.addr.sa.sa_family)
> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index 2c1b270dd..4ef34e4eb 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -5606,7 +5606,7 @@ windows_set_mtu(const int iface_index, const short family,
>  
>      if (err != NO_ERROR)
>      {
> -        msg(M_WARN, "TUN: Setting %s mtu failed: %s [status=%u if_index=%d]",
> +        msg(M_WARN, "TUN: Setting %s mtu failed: %s [status=%lu if_index=%d]",

same question as above.

>              family_name, strerror_win32(err, &gc), err, iface_index);
>      }
>      else
> 


Regards,

-- 
Antonio Quartulli

