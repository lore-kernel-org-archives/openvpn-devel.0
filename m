From: "Alon Bar-Lev" <alon.barlev@...277...>
Date: Mon, 2 Feb 2009 12:18:12 +0200
References: <499929A843E2C541A8AD31A881A2B6A202DF38BE@...1006...>
In-Reply-To: <499929A843E2C541A8AD31A881A2B6A202DF38BE@...1006...>
MIME-Version: 1.0
Message-Id: <200902021218.12326.alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Fix for "Cannot read current default
	gateway" problem on Linux
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: David Balazic <David.Balazic@...1005...>
Cc: openvpn-devel@lists.sourceforge.net

On Monday 02 February 2009 11:49:50 David Balazic wrote:
> diff -u openvpn_trunk/route.c openvpn_patched/route.c
> --- openvpn_trunk/route.c	2009-01-29 15:00:04.525034400 +0100
> +++ openvpn_patched/route.c	2009-01-29 15:03:41.116012000 +0100
> @@ -45,7 +45,7 @@
>  
>  static void add_route (struct route *r, const struct tuntap *tt, unsigned int flags, const struct env_set *es);
>  static void delete_route (const struct route *r, const struct tuntap *tt, unsigned int flags, const struct env_set *es);
> -static bool get_default_gateway (in_addr_t *ret);
> +static bool get_default_gateway (in_addr_t *ret, char *gw_if_name);
>  
>  struct route_option_list *
>  new_route_option_list (struct gc_arena *a)

Which version of diffutils do you use?
How come there is a tab after file name in the header?
How come the above hank has 8 lines but reported as 7 lines?

Alon.

