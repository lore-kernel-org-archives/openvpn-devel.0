Date: Fri, 30 Jun 2023 12:48:14 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <ZJ6y7hPvY4MgKGby@...2685...>
References: <20230629215611.3292788-1-arne@...1227...>
 <20230629215611.3292788-6-arne@...1227...>
MIME-Version: 1.0
In-Reply-To: <20230629215611.3292788-6-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 4/4] Avoid unused function warning/error
 on FreeBSD
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

On Thu, Jun 29, 2023 at 11:56:11PM +0200, Arne Schwabe wrote:
> the funktion is_on_link is not used on FreeBSD and triggers a
> warning/error (-Werror) on FreeBSD.
> 
> Change-Id: I6757d6509ff3ff522d6de417372a21e73ccca3ba
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  src/openvpn/route.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/src/openvpn/route.c b/src/openvpn/route.c
> index d18acd016..2180b7d1a 100644
> --- a/src/openvpn/route.c
> +++ b/src/openvpn/route.c
> @@ -1541,13 +1541,15 @@ local_route(in_addr_t network,
>      return LR_NOMATCH;
>  }
>  
> -/* Return true if the "on-link" form of the route should be used.  This is when the gateway for a
> +/* Return true if the "on-link" form of the route should be used.  This is when the gateway for
>   * a route is specified as an interface rather than an address. */
> +#ifndef TARGET_FREEBSD

The actual condition seems to be

#if defined(TARGET_LINUX) || defined(_WIN32) || defined(TARGET_DARWIN)

>  static inline bool
>  is_on_link(const int is_local_route, const unsigned int flags, const struct route_gateway_info *rgi)
>  {
>      return rgi && (is_local_route == LR_MATCH || ((flags & ROUTE_REF_GW) && (rgi->flags & RGI_ON_LINK)));
>  }
> +#endif
>  
>  bool
>  add_route(struct route_ipv4 *r,

Regards,
-- 
  Frank Lichtenheld

