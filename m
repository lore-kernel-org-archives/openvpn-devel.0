From: "Alon Bar-Lev" <alon.barlev@...277...>
Date: Mon, 2 Feb 2009 10:39:30 +0200
References: <499929A843E2C541A8AD31A881A2B6A202DAB58F@...1006...>
	<9e0cf0bf0901290345s15a32d2dm63a6ad7a3312d559@...278...>
	<499929A843E2C541A8AD31A881A2B6A202DAB769@...1006...>
In-Reply-To: <499929A843E2C541A8AD31A881A2B6A202DAB769@...1006...>
MIME-Version: 1.0
Message-Id: <200902021039.30326.alon.barlev@...277...>
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

On Thursday 29 January 2009 16:05:00 David Balazic wrote:
> 
> the new patch, against trunk:
> diff -u openvpn_trunk/route.c openvpn_patched/route.c
> --- openvpn_trunk/route.c       2009-01-29 15:00:04.525034400 +0100
> +++ openvpn_patched/route.c     2009-01-29 15:03:41.116012000 +0100
> @@ -45,7 +45,7 @@
>  
>  static void add_route (struct route *r, const struct tuntap *tt,
> unsigned int flags, const struct env_set *es);
>  static void delete_route (const struct route *r, const struct tuntap
> *tt, unsigned int flags, const struct env_set *es);

Please disable word wrap, and try to apply the patch before you send it.
Please resend.

Alon.

