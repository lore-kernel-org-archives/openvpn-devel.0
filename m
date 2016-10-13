References: <20160916161354.GM78279@...1296...>
	<1476263591-12401-1-git-send-email-arne@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <38d71c0a-e3f8-437c-12f9-f654e91682b7@...2080...>
Date: Thu, 13 Oct 2016 18:08:21 +0200
MIME-Version: 1.0
In-Reply-To: <1476263591-12401-1-git-send-email-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v4] Remove tun-ipv6 Option. Instead
 assume that IPv6 is always supported.
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net, Arne Schwabe <arne@...1227...>

On 12/10/16 11:13, Arne Schwabe wrote:
> This option was useful when Ipv6 tun support was non standard and was
> an internal/user specified flag that tracked the Ipv6 capability of
> the tun device.
>=20
> All supported OS support IPv6. Also tun-ipv6 is pushable by the=20
> remote so not putting tun-ipv6 does not forbid ipv6 addresses.
>=20
> This commit also clean up a bit of the ipv6 related tun.c. Changes=20
> for most platforms are minimal.
>=20
> For linux a bit more cleanup is done: - Remove compatibility defines=20
> that were added 2008 - Always use IFF_NO_PI for the linux tun and
> not only for IPv4 only tun setups (Android also always IFF_NO_PI
> works fine with Ipv6).
>=20
> This commit also remove a non ipv6 fallback for tap driver from
> OpenVPN 2.2-beta or earlier and only warns.
>=20
> Patch V2: Integrate Gert's comments Patch V3: Remove tun_ipv4 option.
> It only used for MTU discovery and there it was wrong since it should
> on the transport protocol if at all Patch V4: Completely remove
> support for NetBSD <=3D 4.0 and remove NETBSD_MULTI_AF defines
> ---
>  Changes.rst           |   3 ++
>  src/openvpn/forward.c |   2 +-
>  src/openvpn/helper.c  |   2 -
>  src/openvpn/init.c    |   6 ---
>  src/openvpn/multi.c   |   8 ++-
>  src/openvpn/openvpn.h |   5 --
>  src/openvpn/options.c |  11 +---
>  src/openvpn/options.h |   1 -
>  src/openvpn/route.c   |  13 ++---
>  src/openvpn/tun.c     | 139 +++++++-------------------------------------=
------
>  src/openvpn/tun.h     |   2 -
>  11 files changed, 30 insertions(+), 162 deletions(-)
>=20
> diff --git a/Changes.rst b/Changes.rst
> index 9fcba75..2956003 100644
> --- a/Changes.rst
> +++ b/Changes.rst
> @@ -135,6 +135,9 @@ User-visible Changes
>    ciphers configured in the config file.  Use --ncp-disable if you don't=
 want
>    that.
>=20=20
> +- ALl tun devices on all platforms are considered always IPv6 capable. T=
he --tun-ipv6

Silly typo.  (I would have done this one in-flight, hadn't it been for
a few other minor things).
[...snip...]
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index d97dc8f..ee8d351 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -4577,7 +4569,6 @@ add_option (struct options *options,
>    else if (streq (p[0], "tun-ipv6") && !p[1])
>      {
>        VERIFY_PERMISSION (OPT_P_UP);
> -      options->tun_ipv6 =3D true;

Should we add a "Deprecated/NO-OP option used." message?

[...snip....]
aace2af..8a3bbba 100644
> --- a/src/openvpn/route.c
> +++ b/src/openvpn/route.c
> @@ -1729,10 +1729,10 @@ add_route_ipv6 (struct route_ipv6 *r6, const stru=
ct tuntap *tt, unsigned int fla
>      }
>  #endif
>=20=20
> -  if ( !tt->ipv6 )
> +  if (!tt->did_ifconfig_ipv6_setup)
>      {
> -      msg( M_INFO, "add_route_ipv6(): not adding %s/%d, no IPv6 on if %s=
",
> -		    network, r6->netbits, device );
> +      msg( M_INFO, "add_route_ipv6(): not adding %s/%d, no IPv6 ifconfig=
 on if %s",
> +		    network, r6->netbits, device);

>

Wouldn't it be nicer we said "no IPv6 address configured on
interface %s" ?  Just trying to be slightly more user friendly in the
logs.

[...snip...]

> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index b7a29f7..226ff7d 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -741,8 +741,8 @@ do_ifconfig (struct tuntap *tt,
>=20=20
>        argv_init (&argv);
>=20=20
> -      msg( M_INFO, "do_ifconfig, tt->ipv6=3D%d, tt->did_ifconfig_ipv6_se=
tup=3D%d",
> -	           tt->ipv6, tt->did_ifconfig_ipv6_setup );
> +      msg( M_INFO, "do_ifconfig, tt->did_ifconfig_ipv6_setup=3D%d",
> +	            tt->did_ifconfig_ipv6_setup );

While we're changing log lines ... could we make this one a bit less
technical, or at least increase the verb level if we want it to be so
technical?  Again, just to be more user friendly

[...snip...]

> @@ -1526,7 +1513,7 @@ open_tun_generic (const char *dev, const char *dev_=
type, const char *dev_node,
>    bool dynamic_opened =3D false;
>=20=20
>=20=20
> -  if ( tt->ipv6 && ! ipv6_explicitly_supported )
> +  if (  ! ipv6_explicitly_supported )
>      msg (M_WARN, "NOTE: explicit support for IPv6 tun devices is not pro=
vided for this OS");

Isn't this if() block a NOOP?

$ git grep -Hni ipv6_explicitly_supported
src/openvpn/tun.c:1521:  bool ipv6_explicitly_supported, bool dynamic,
src/openvpn/tun.c:1529:  if ( tt->ipv6 && ! ipv6_explicitly_supported )

Could we kill this as well?

[...snip...]

> @@ -1977,53 +1940,13 @@ close_tun (struct tuntap *tt)
>  int
>  write_tun (struct tuntap* tt, uint8_t *buf, int len)
>  {
> -  if (tt->ipv6)
> -    {
> -      struct tun_pi pi;
> -      struct iphdr *iph;
> -      struct iovec vect[2];
> -      int ret;
> -
> -      iph =3D (struct iphdr *)buf;
> -
> -      pi.flags =3D 0;
> -
> -      if(iph->version =3D=3D 6)
> -	pi.proto =3D htons(OPENVPN_ETH_P_IPV6);
> -      else
> -	pi.proto =3D htons(OPENVPN_ETH_P_IPV4);

whitespace issues.

[...snip...]

> @@ -5308,11 +5208,10 @@ open_tun (const char *dev, const char *dev_type, =
const char *dev_node, struct tu
>      /* usage of numeric constants is ugly, but this is really tied to
>       * *this* version of the driver
>       */
> -    if ( tt->ipv6 && tt->type =3D=3D DEV_TYPE_TUN &&
> +    if (tt->type =3D=3D DEV_TYPE_TUN &&
>           info[0] =3D=3D 9 && info[1] < 8)
>        {
> -	msg( M_INFO, "WARNING:  Tap-Win32 driver version %d.%d does not support=
 IPv6 in TUN mode.  IPv6 will be disabled.  Upgrade to Tap-Win32 9.8 (2.2-b=
eta3 release or later) or use TAP mode to get IPv6", (int) info[0], (int) i=
nfo[1] );
> -	tt->ipv6 =3D false;
> +	msg( M_INFO, "WARNING:  Tap-Win32 driver version %d.%d does not support=
 IPv6 in TUN mode.  IPv6 will not work.  Upgrade to Tap-Win32 9.8 (2.2-beta=
3 release or later) or use TAP mode to get IPv6", (int) info[0], (int) info=
[1] );

Maybe we should review the contents of this log line as well?  Can at
least point at the latest 2.3 release instead of a beta release.


I see that a few of my comments are not directly related to removing
--tun-ipv6.  But I'm not convinced there's any benefit in having them
in a separate patch.  I'm okay with either approach.


--
kind regards,

David Sommerseth


