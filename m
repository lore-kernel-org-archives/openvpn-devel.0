MIME-Version: 1.0
In-Reply-To: <1335521425-23391-1-git-send-email-davids@...1347...>
References: <1335441085-18186-1-git-send-email-davids@...1347...>
	<1335521425-23391-1-git-send-email-davids@...1347...>
Date: Fri, 27 Apr 2012 13:48:42 +0300
Message-ID: <CAOazyz1k2E0pW=1xZsAUPzT2ja43qJ4Lkg7HEpg9h1+747GH+w@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Clean-up: Presume that Linux is always
 IPv6 capable at build time
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

ACK (regardless my disable-ipv6 plans :) )

On Fri, Apr 27, 2012 at 1:10 PM, David Sommerseth <davids@...1347...> wrote:
> These days it is highly unlikely that OpenVPN will be built in a non-IPv6
> capable Linux environment. =C2=A0So remove compile-time related macros id=
entifying
> that.
>
> This also solves an issue which was introduced in commit 51bd56f46f55177c=
f0f8b
> where HAVE_TUN_PI is no longer detected. =C2=A0The tun_pi struct is defin=
ed in
> linux/if_tun.h, which will be checked for later on. =C2=A0As this struct =
has history
> in linux/if_tun.h all back to the beginning of the kernel git tree (2.6.1=
2-rc2,
> April 2005), it is considered not needed to check for this struct explici=
t.
>
> [ v2: Commit 7c0a2b5f2b4409 modifies some of the checks this patch touche=
s. =C2=A0This
> =C2=A0 =C2=A0 =C2=A0patch just adopts to those changes ]
>
> Signed-off-by: David Sommerseth <davids@...1347...>
> ---
> =C2=A0configure.ac =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A06 ------
> =C2=A0src/openvpn/tun.c | =C2=A0 19 -------------------
> =C2=A02 files changed, 0 insertions(+), 25 deletions(-)
>
> diff --git a/configure.ac b/configure.ac
> index 8ac5ac4..e808cb4 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -415,12 +415,6 @@ AC_CHECK_TYPES(
> =C2=A0 =C2=A0 =C2=A0 =C2=A0[[${SOCKET_INCLUDES}]]
> =C2=A0)
> =C2=A0AC_CHECK_TYPE(
> - =C2=A0 =C2=A0 =C2=A0 [struct tun_pi],
> - =C2=A0 =C2=A0 =C2=A0 [AC_DEFINE([HAVE_TUN_PI], [1], [struct tun_pi need=
ed for IPv6 support])],
> - =C2=A0 =C2=A0 =C2=A0 ,
> - =C2=A0 =C2=A0 =C2=A0 [[${SOCKET_INCLUDES}]]
> -)
> -AC_CHECK_TYPE(
> =C2=A0 =C2=A0 =C2=A0 =C2=A0[struct iphdr],
> =C2=A0 =C2=A0 =C2=A0 =C2=A0[AC_DEFINE([HAVE_IPHDR], [1], [struct iphdr ne=
eded for IPv6 support])],
> =C2=A0 =C2=A0 =C2=A0 =C2=A0,
> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index 227bfde..633150f 100644
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

