Message-ID: <54FB198E.3090402@...1856...>
Date: Sat, 07 Mar 2015 16:30:22 +0100
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
References: <1419713983-16272-1-git-send-email-gert@...1296...>
In-Reply-To: <1419713983-16272-1-git-send-email-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Remove count_netmask_bits(),
 convert users to use netmask_to_netbits2()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

ACK

The new behaviour is slightly different, because it well reject invalid 
netmasks (e.g. 8.255.255.0).  The old count_netmask_bits() would just 
happily report "there's 9 bits in that one!".  I did not trace back the 
input of these calls to verify whether the netmasks can be invalid, but 
even if this somehow borks a setup, that setup must have been broken 
already...

-Steffan

On 27-12-14 21:59, Gert Doering wrote:
> The previous Linux/iproute2 code converted binary netmasks to string
> representation (print_in_addr_t()), just to immediately scanf() it back
> to binary to count bits.  netmask_to_netbits2() directly works on the
> in_addr_t.
>
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>   src/openvpn/misc.c  | 26 --------------------------
>   src/openvpn/misc.h  |  4 ----
>   src/openvpn/route.c |  4 ++--
>   src/openvpn/route.h |  1 +
>   src/openvpn/tun.c   |  4 ++--
>   5 files changed, 5 insertions(+), 34 deletions(-)
>
> diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
> index 61bc523..5627cb9 100644
> --- a/src/openvpn/misc.c
> +++ b/src/openvpn/misc.c
> @@ -827,32 +827,6 @@ setenv_str_i (struct env_set *es, const char *name, const char *value, const int
>     gc_free (&gc);
>   }
>
> -/*
> - * taken from busybox networking/ifupdown.c
> - */
> -unsigned int
> -count_bits(unsigned int a)
> -{
> -  unsigned int result;
> -  result = (a & 0x55) + ((a >> 1) & 0x55);
> -  result = (result & 0x33) + ((result >> 2) & 0x33);
> -  return((result & 0x0F) + ((result >> 4) & 0x0F));
> -}
> -
> -int
> -count_netmask_bits(const char *dotted_quad)
> -{
> -  unsigned int result, a, b, c, d;
> -  /* Found a netmask...  Check if it is dotted quad */
> -  if (sscanf(dotted_quad, "%u.%u.%u.%u", &a, &b, &c, &d) != 4)
> -    return -1;
> -  result = count_bits(a);
> -  result += count_bits(b);
> -  result += count_bits(c);
> -  result += count_bits(d);
> -  return ((int)result);
> -}
> -
>   /* return true if filename can be opened for read */
>   bool
>   test_file (const char *filename)
> diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
> index 41748bd..5fe085e 100644
> --- a/src/openvpn/misc.h
> +++ b/src/openvpn/misc.h
> @@ -166,10 +166,6 @@ const char **make_env_array (const struct env_set *es,
>   const char **make_arg_array (const char *first, const char *parms, struct gc_arena *gc);
>   const char **make_extended_arg_array (char **p, struct gc_arena *gc);
>
> -/* convert netmasks for iproute2 */
> -int count_netmask_bits(const char *);
> -unsigned int count_bits(unsigned int );
> -
>   /* an analogue to the random() function, but use OpenSSL functions if available */
>   #ifdef ENABLE_CRYPTO
>   long int get_random(void);
> diff --git a/src/openvpn/route.c b/src/openvpn/route.c
> index 5d18213..b56f620 100644
> --- a/src/openvpn/route.c
> +++ b/src/openvpn/route.c
> @@ -1288,7 +1288,7 @@ add_route (struct route_ipv4 *r,
>     argv_printf (&argv, "%s route add %s/%d",
>     	      iproute_path,
>   	      network,
> -             count_netmask_bits(netmask));
> +              netmask_to_netbits2(r->netmask));
>
>     if (r->flags & RT_METRIC_DEFINED)
>       argv_printf_cat (&argv, "metric %d", r->metric);
> @@ -1765,7 +1765,7 @@ delete_route (struct route_ipv4 *r,
>     argv_printf (&argv, "%s route del %s/%d",
>     	      iproute_path,
>   	      network,
> -	      count_netmask_bits(netmask));
> +              netmask_to_netbits2(r->netmask));
>   #else
>     argv_printf (&argv, "%s del -net %s netmask %s",
>   	       ROUTE_PATH,
> diff --git a/src/openvpn/route.h b/src/openvpn/route.h
> index f3c0150..3cec08d 100644
> --- a/src/openvpn/route.h
> +++ b/src/openvpn/route.h
> @@ -305,6 +305,7 @@ static inline bool test_routes (const struct route_list *rl, const struct tuntap
>   #endif
>
>   bool netmask_to_netbits (const in_addr_t network, const in_addr_t netmask, int *netbits);
> +int netmask_to_netbits2 (in_addr_t netmask);
>
>   static inline in_addr_t
>   netbits_to_netmask (const int netbits)
> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index e92edc2..11a6d71 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -722,7 +722,7 @@ do_ifconfig (struct tuntap *tt,
>   				  iproute_path,
>   				  actual,
>   				  ifconfig_local,
> -				  count_netmask_bits(ifconfig_remote_netmask),
> +				  netmask_to_netbits2(tt->remote_netmask),
>   				  ifconfig_broadcast
>   				  );
>   		  argv_msg (M_INFO, &argv);
> @@ -1819,7 +1819,7 @@ close_tun (struct tuntap *tt)
>   			iproute_path,
>   			tt->actual_name,
>   			print_in_addr_t (tt->local, 0, &gc),
> -			count_netmask_bits(print_in_addr_t (tt->remote_netmask, 0, &gc))
> +		        netmask_to_netbits2(tt->remote_netmask)
>   			);
>   	      }
>   #else
>

