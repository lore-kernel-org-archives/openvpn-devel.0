MIME-Version: 1.0
In-Reply-To: <CAAbSJMWS36mkdv0vswbRGOMdjLEe2rrQdmc3pCWDb5qwFo6t=Q@...278...>
References: <CAAbSJMWS36mkdv0vswbRGOMdjLEe2rrQdmc3pCWDb5qwFo6t=Q@...278...>
Date: Fri, 24 Feb 2012 16:44:35 +0200
Message-ID: <CAOazyz0MromdXAB8h4ej0hU7K3Z5xi-U9R6WydqCbONk_-VsMQ@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Add gateway argument to Linux ip route
	del
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Mickael Chazaux <mickael.chazaux@...277...>
Cc: openvpn-devel@lists.sourceforge.net

If tool does not use it, environment should be used.

On Fri, Feb 24, 2012 at 4:29 PM, Mickael Chazaux
<mickael.chazaux@...277...> wrote:
> In some use cases, it is valuable to have the gateway
> passed when deleting a route. Even if is ignored by
> iproute2, custom tools selected via the --iproute option
> can make use of it.
>
> Signed-off-by: Mickael Chazaux <mickael.chazaux@...277...>
> ---
>
> =C2=A0route.c | =C2=A0 =C2=A06 ++++--
> =C2=A01 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/route.c b/route.c
> index cf9a5ea..6fd44ca 100644
> --- a/route.c
> +++ b/route.c
> @@ -1718,10 +1718,12 @@ delete_route (struct route *r,
>
> =C2=A0#if defined(TARGET_LINUX)
> =C2=A0#ifdef CONFIG_FEATURE_IPROUTE
> - =C2=A0argv_printf (&argv, "%s route del %s/%d",
> + =C2=A0argv_printf (&argv, "%s route del %s/%d via %s",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iproute_path,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 network,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 count_netmask_bits(netmask));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 count_netmask_bits(netmask),
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gateway
> + =C2=A0 =C2=A0 =C2=A0 );
> =C2=A0#else
> =C2=A0argv_printf (&argv, "%s del -net %s netmask %s",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ROUTE_PATH,
> --
> 1.7.0.4
>
> -------------------------------------------------------------------------=
-----
> Virtualization & Cloud Management Using Capacity Planning
> Cloud computing makes use of virtualization - but cloud computing
> also focuses on allowing computing to be delivered as a service.
> http://www.accelacomm.com/jaw/sfnl/114/51521223/
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

