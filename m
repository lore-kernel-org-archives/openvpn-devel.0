From: Kristof Provost <kprovost@...2661...>
Date: Mon, 17 Oct 2022 14:06:10 +0200
Message-ID: <5A749602-2371-4305-B02D-F02735FDFF8D@...2661...>
In-Reply-To: <20221012145915.25810-1-gert@...1296...>
References: <20221012145915.25810-1-gert@...1296...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 1/2] FreeBSD: for topology subnet,
 put tun interface into IFF_BROADCAST mode
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Signed-off-by:	Kristof Provost <kprovost@...2661...>

On 12 Oct 2022, at 16:59, Gert Doering wrote:
> For reasons unknown, OpenVPN has always put FreeBSD tun(4) interfaces
> into point-to-point mode (IFF_POINTOPOINT), which means "local and
> remote address, no on-link subnet".
>
> "--topology subnet" was emulated by adding a subnet-route to the "remote"
> (which was just picking a free address from the subnet).
>
> This works well enough for classic tun(4) interfaces that have no
> next-hop resolution, and routes pointing to "that fake remote" only
> (because all routing is done inside OpenVPN and it does not matter how
> packets get there) - but for ovpn(4) interfaces, it breaks iroute setup,
> where the route next-hop must be an on-link address.
>
> Thus, change interface to IFF_BROADCAST mode, and get rid of all the
> special code needed to "fake" subnet mode.
>
> Tested with tun(4) and ovpn(4) on FreeBSD 14, client and server, and
> with tun(4) on FreeBSD 12 and 7.4
>
> To actually work with ovpn(4) / FreeBSD DCO, a followup patch for
> kernel ovpn(4) and OpenVPN dco_freebsd.c is needed.
>
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  Changes.rst       |  5 +++++
>  src/openvpn/tun.c | 37 ++++++++++++-------------------------
>  2 files changed, 17 insertions(+), 25 deletions(-)
>
> diff --git a/Changes.rst b/Changes.rst
> index df56f76a..0397cb94 100644
> --- a/Changes.rst
> +++ b/Changes.rst
> @@ -163,6 +163,11 @@ User-visible Changes
>  - :code:`link_mtu` parameter is removed from environment or replaced wit=
h 0 when scripts are
>    called with parameters. This parameter is unreliable and no longer int=
ernally calculated.
>
> +- FreeBSD tun interfaces with ``--topology subnet`` are now put into real
> +  subnet mode (IFF_BROADCAST instead of IFF_POINTOPOINT) - this might up=
set
> +  software that enumerates interfaces, looking for "broadcast capable?" =
and
> +  expecting certain results.  Normal uses should not see any difference.
> +
>  Overview of changes in 2.5
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>
> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index ddee49f9..a83ec9e6 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -1479,43 +1479,23 @@ do_ifconfig_ipv4(struct tuntap *tt, const char *i=
fname, int tun_mtu,
>
>  #elif defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)
>
> -    in_addr_t remote_end;           /* for "virtual" subnet topology */
> -
>      /* example: ifconfig tun2 10.2.0.2 10.2.0.1 mtu 1450 netmask 255.255=
.255.255 up */
> -    if (tun)
> +    if (tun)       /* point-to-point tun */
>      {
>          argv_printf(&argv, "%s %s %s %s mtu %d netmask 255.255.255.255 u=
p",
>                      IFCONFIG_PATH, ifname, ifconfig_local,
>                      ifconfig_remote_netmask, tun_mtu);
>      }
> -    else if (tt->type =3D=3D DEV_TYPE_TUN && tt->topology =3D=3D TOP_SUB=
NET)
> -    {
> -        remote_end =3D create_arbitrary_remote( tt );
> -        argv_printf(&argv, "%s %s %s %s mtu %d netmask %s up", IFCONFIG_=
PATH,
> -                    ifname, ifconfig_local, print_in_addr_t(remote_end, =
0, &gc),
> -                    tun_mtu, ifconfig_remote_netmask);
> -    }
> -    else
> +    else            /* tun with topology subnet and tap mode (always sub=
net) */
>      {
> -        argv_printf(&argv, "%s %s %s netmask %s mtu %d up", IFCONFIG_PAT=
H,
> -                    ifname, ifconfig_local, ifconfig_remote_netmask, tun=
_mtu);
> +        int netbits =3D netmask_to_netbits2(tt->remote_netmask);
> +        argv_printf(&argv, "%s %s %s/%d mtu %d up", IFCONFIG_PATH,
> +                    ifname, ifconfig_local, netbits, tun_mtu );
>      }
>
>      argv_msg(M_INFO, &argv);
>      openvpn_execve_check(&argv, es, S_FATAL, "FreeBSD ifconfig failed");
>
> -    /* Add a network route for the local tun interface */
> -    if (!tun && tt->type =3D=3D DEV_TYPE_TUN && tt->topology =3D=3D TOP_=
SUBNET)
> -    {
> -        struct route_ipv4 r;
> -        CLEAR(r);
> -        r.flags =3D RT_DEFINED;
> -        r.network =3D tt->local & tt->remote_netmask;
> -        r.netmask =3D tt->remote_netmask;
> -        r.gateway =3D remote_end;
> -        add_route(&r, tt, 0, NULL, es, NULL);
> -    }
> -
>  #elif defined(TARGET_AIX)
>      {
>          /* AIX ifconfig will complain if it can't find ODM path in env */
> @@ -2949,12 +2929,19 @@ open_tun(const char *dev, const char *dev_type, c=
onst char *dev_node, struct tun
>
>          if (tt->fd >=3D 0 && tt->type =3D=3D DEV_TYPE_TUN)
>          {
> +            /* see "Interface Flags" in ifnet(9) */
>              int i =3D IFF_POINTOPOINT | IFF_MULTICAST;
> +            if (tt->topology =3D=3D TOP_SUBNET)
> +            {
> +                i =3D IFF_BROADCAST | IFF_MULTICAST;
> +            }
>
>              if (ioctl(tt->fd, TUNSIFMODE, &i) < 0)
>              {
>                  msg(M_WARN | M_ERRNO, "ioctl(TUNSIFMODE)");
>              }
> +
> +            /* multi_af mode for v4+v6, see "tun(4)" */
>              i =3D 1;
>              if (ioctl(tt->fd, TUNSIFHEAD, &i) < 0)
>              {
> --=20
> 2.37.3
>
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

