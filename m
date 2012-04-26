MIME-Version: 1.0
In-Reply-To: <1335441085-18186-1-git-send-email-davids@...1347...>
References: <1335441085-18186-1-git-send-email-davids@...1347...>
Date: Thu, 26 Apr 2012 19:03:40 +0300
Message-ID: <CAOazyz3-f2YkXE_vV2Oum+p4exQTUis=Q9RTOrvZ7WC0WEZymg@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Presume that Linux is always IPv6
 capable at build time
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
To: David Sommerseth <davids@...1347...>
Cc: openvpn-devel@lists.sourceforge.net

I plan to add --enable-ipv6/--disable-ipv6 to explicit support ipv6.
This is part of syshead fixups.
Cleaning a lot of code of autoconf auto detection of socket functions.

On Thu, Apr 26, 2012 at 2:51 PM, David Sommerseth <davids@...1347...> wrote:
> These days it is highly unlikely that OpenVPN will be built in a non-IPv6
> capable Linux environment. =C2=A0So remove compile-time related macros id=
entifying
> that.
>
> This also solves an issue which was introduced in commit 51bd56f46f55177c=
f0f8b
> where HAVE_TUN_PI and HAVE_IPHDR is no longer detected. =C2=A0As these ma=
cros where
> only used to detect if IPv6 support was available on Linux, it makes no s=
ense
> looking for them any more.
>
> Signed-off-by: David Sommerseth <davids@...1347...>
> ---
> =C2=A0configure.ac =C2=A0 =C2=A0 =C2=A0| =C2=A0 13 -------------
> =C2=A0src/openvpn/tun.c | =C2=A0 19 -------------------
> =C2=A02 files changed, 0 insertions(+), 32 deletions(-)
>
> diff --git a/configure.ac b/configure.ac
> index e962323..4286866 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -404,7 +404,6 @@ AC_CHECK_HEADERS(
> =C2=A0 =C2=A0 =C2=A0 =C2=A0,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0[[${SOCKET_INCLUDES}]]
> =C2=A0)
> -
> =C2=A0AC_CHECK_TYPES(
> =C2=A0 =C2=A0 =C2=A0 =C2=A0[in_addr_t],
> =C2=A0 =C2=A0 =C2=A0 =C2=A0,
> @@ -412,18 +411,6 @@ AC_CHECK_TYPES(
> =C2=A0 =C2=A0 =C2=A0 =C2=A0[[${SOCKET_INCLUDES}]]
> =C2=A0)
> =C2=A0AC_CHECK_TYPE(
> - =C2=A0 =C2=A0 =C2=A0 [struct tun_pi],
> - =C2=A0 =C2=A0 =C2=A0 [AC_DEFINE(HAVE_TUN_PI, 1, [struct tun_pi needed f=
or IPv6 support])],
> - =C2=A0 =C2=A0 =C2=A0 ,
> - =C2=A0 =C2=A0 =C2=A0 [[${SOCKET_INCLUDES}]]
> -)
> -AC_CHECK_TYPE(
> - =C2=A0 =C2=A0 =C2=A0 [struct iphdr],
> - =C2=A0 =C2=A0 =C2=A0 [AC_DEFINE(HAVE_IPHDR, 1, [struct iphdr needed for=
 IPv6 support])],
> - =C2=A0 =C2=A0 =C2=A0 ,
> - =C2=A0 =C2=A0 =C2=A0 [[${SOCKET_INCLUDES}]]
> -)
> -AC_CHECK_TYPE(
> =C2=A0 =C2=A0 =C2=A0 =C2=A0[struct sock_extended_err],
> =C2=A0 =C2=A0 =C2=A0 =C2=A0[AC_DEFINE(HAVE_SOCK_EXTENDED_ERR, 1, [struct =
sock_extended_err needed for extended socket error support])],
> =C2=A0 =C2=A0 =C2=A0 =C2=A0,
> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index b99071c..63e6f77 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -1373,14 +1373,6 @@ close_tun_generic (struct tuntap *tt)
> =C2=A0#error header file linux/sockios.h required
> =C2=A0#endif
>
> -#if defined(HAVE_TUN_PI) && defined(HAVE_IPHDR) && defined(HAVE_IOVEC) &=
& defined(ETH_P_IPV6) && defined(ETH_P_IP) && defined(HAVE_READV) && define=
d(HAVE_WRITEV)
> -#define LINUX_IPV6 1
> -/* #warning IPv6 ON */
> -#else
> -#define LINUX_IPV6 0
> -/* #warning IPv6 OFF */
> -#endif
> -
> =C2=A0#if !PEDANTIC
>
> =C2=A0void
> @@ -1388,13 +1380,6 @@ open_tun (const char *dev, const char *dev_type, c=
onst char *dev_node, struct tu
> =C2=A0{
> =C2=A0 struct ifreq ifr;
>
> - =C2=A0/* warn if a very old linux version is used & --tun-ipv6 set
> - =C2=A0 */
> -#if LINUX_IPV6 =3D=3D 0
> - =C2=A0if ( tt->ipv6 )
> - =C2=A0 =C2=A0msg (M_WARN, "NOTE: explicit support for IPv6 tun devices =
is not provided for this OS");
> -#endif
> -
> =C2=A0 /*
> =C2=A0 =C2=A0* We handle --dev null specially, we do not open /dev/null f=
or this.
> =C2=A0 =C2=A0*/
> @@ -1623,7 +1608,6 @@ close_tun (struct tuntap *tt)
> =C2=A0int
> =C2=A0write_tun (struct tuntap* tt, uint8_t *buf, int len)
> =C2=A0{
> -#if LINUX_IPV6
> =C2=A0 if (tt->ipv6)
> =C2=A0 =C2=A0 {
> =C2=A0 =C2=A0 =C2=A0 struct tun_pi pi;
> @@ -1649,14 +1633,12 @@ write_tun (struct tuntap* tt, uint8_t *buf, int l=
en)
> =C2=A0 =C2=A0 =C2=A0 return(ret - sizeof(pi));
> =C2=A0 =C2=A0 }
> =C2=A0 else
> -#endif
> =C2=A0 =C2=A0 return write (tt->fd, buf, len);
> =C2=A0}
>
> =C2=A0int
> =C2=A0read_tun (struct tuntap* tt, uint8_t *buf, int len)
> =C2=A0{
> -#if LINUX_IPV6
> =C2=A0 if (tt->ipv6)
> =C2=A0 =C2=A0 {
> =C2=A0 =C2=A0 =C2=A0 struct iovec vect[2];
> @@ -1672,7 +1654,6 @@ read_tun (struct tuntap* tt, uint8_t *buf, int len)
> =C2=A0 =C2=A0 =C2=A0 return(ret - sizeof(pi));
> =C2=A0 =C2=A0 }
> =C2=A0 else
> -#endif
> =C2=A0 =C2=A0 return read (tt->fd, buf, len);
> =C2=A0}
>
> --
> 1.7.4.4
>
>
> -------------------------------------------------------------------------=
-----
> Live Security Virtual Conference
> Exclusive live event will cover all the ways today's security and
> threat landscape has changed and how IT managers can respond. Discussions
> will include endpoint security, mobile security and the latest in malware
> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

