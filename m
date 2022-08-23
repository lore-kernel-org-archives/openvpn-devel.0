From: Kristof Provost <kprovost@...2661...>
Date: Tue, 23 Aug 2022 10:12:10 +0200
Message-ID: <897D0F2D-C600-4CC3-8065-A49889C65DAA@...2661...>
In-Reply-To: <20220820140124.11325-1-gert@...1296...>
References: <20220820140124.11325-1-gert@...1296...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] DCO: require valid netbits setting for
 non-primary iroutes.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

On 20 Aug 2022, at 16:01, Gert Doering wrote:
> The existing DCO code had extra logic for "if this is not
> MR_WITH_NETBITS, set 32/128 as address length", but only for
> iroute addition.  For iroute deletion, this was missing, and
> subsequently iroute deletion for IPv4 host routes failed on
> FreeBSD DCO (commit 3433577a99).
>
> Iroute handling differenciates between "primary" iroutes (coming
> from anm IP pool or ccd/ifconfig-push), and "non-primary" iroutes,
> coming from --iroute and --iroute-ipv6 statements in per-client config.
>
> "Primary" iroutes always use "-1" for their netbits, but since these
> are not installed via DCO, this is of no concern here.  Whether these
> can and should be changed needs further study on internal route
> learning and cleanup.
>
> Refactor options.c and multi.c to ensure that netbits is always set
> for non-primary iroutes - and ASSERT() on this in the DCO path, so we can
> find out if there might be other code violating this.
>
> Change options.c::option_iroute() to always set netbits=3D32 for IPv4
> host routes (options_iroute_ipv6() never differenciated).  Since
> netmask_to_netbits() also insists on "-1" for host routes, change
> to netmask_to_netbits2().
>
> Remove all the extra MR_WITH_NETBITS logic from dco.c, where it should
> have never appeared.
>
> Signed-off-by: Gert Doering <gert@...1296...>

Seems sane to me. Passes the FreeBSD automated tests.
Minor style nitpicks below.

Acked-by: Kristof Provost <kprovost@...2661...>

> diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
> index 95414429..1f9d0201 100644
> --- a/src/openvpn/multi.c
> +++ b/src/openvpn/multi.c
> @@ -1241,6 +1241,7 @@ multi_learn_in_addr_t(struct multi_context *m,
>          /* "primary" is the VPN ifconfig address of the peer and already
>           * known to DCO, so only install "extra" iroutes (primary =3D fa=
lse)
>           */
> +        ASSERT(netbits>=3D0);		/* DCO requires populated netbits */
I=E2=80=99d put spaces around the comparison, so =E2=80=98ASSERT(netbits >=
=3D 0);=E2=80=99. That seems to be what=E2=80=99s done in all conditionals =
anyway.

> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 2b0bb20c..21e2f69b 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -1572,12 +1572,14 @@ option_iroute(struct options *o,
>
>      ALLOC_OBJ_GC(ir, struct iroute, &o->gc);
>      ir->network =3D getaddr(GETADDR_HOST_ORDER, network_str, 0, NULL, NU=
LL);
> -    ir->netbits =3D -1;
> +    ir->netbits =3D 32;		/* host route if no netmask given */
>
>      if (netmask_str)
>      {
>          const in_addr_t netmask =3D getaddr(GETADDR_HOST_ORDER, netmask_=
str, 0, NULL, NULL);
> -        if (!netmask_to_netbits(ir->network, netmask, &ir->netbits))
> +        ir->netbits =3D netmask_to_netbits2(netmask);
> +
> +        if (ir->netbits<0)
And here too. So =E2=80=98if (ir->netbits < 0)=E2=80=99

>          {
>              msg(msglevel, "in --iroute %s %s : Bad network/subnet specif=
ication",
>                  network_str,

Regards,
Kristof

