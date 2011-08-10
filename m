MIME-Version: 1.0
In-Reply-To: <1312980908-25157-3-git-send-email-heiko.hund@...1489...>
References: <1312980908-25157-1-git-send-email-heiko.hund@...1489...>
	<1312980908-25157-3-git-send-email-heiko.hund@...1489...>
Date: Wed, 10 Aug 2011 23:40:28 +0300
Message-ID: <CAOazyz3rzcfQaCpS0stJiGHHxyP_5D+ZcAmXH+8_JoJhsUw_uA@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] don't use struct in6_addr s6_addr32
 member anymore
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
To: Heiko Hund <heiko.hund@...1489...>
Cc: openvpn-devel@lists.sourceforge.net

Hello,
I think this should be done by autoconf.
And hand added into win32 for MSVC.
Alon.

On Wed, Aug 10, 2011 at 3:55 PM, Heiko Hund <heiko.hund@...1489...> wrote:
> The s6_addr32 member of struct in6_addr is not available when building
> for WIN32. To work around this, a local union is defined that allows
> accessing 32 bit chunks of the IPv6 address passed to add_in6_addr().
>
> Signed-off-by: Heiko Hund <heiko.hund@...1489...>
> ---
> =C2=A0socket.c | =C2=A0 16 +++++++---------
> =C2=A01 files changed, 7 insertions(+), 9 deletions(-)
>
> diff --git a/socket.c b/socket.c
> index 6b855c0..887569c 100644
> --- a/socket.c
> +++ b/socket.c
> @@ -2622,13 +2622,6 @@ print_in6_addr (struct in6_addr a6, unsigned int f=
lags, struct gc_arena *gc)
> =C2=A0/* add some offset to an ipv6 address
> =C2=A0* (add in steps of 32 bits, taking overflow into next round)
> =C2=A0*/
> -#ifndef s6_addr32
> -# ifdef TARGET_SOLARIS
> -# =C2=A0define s6_addr32 _S6_un._S6_u32
> -# else
> -# =C2=A0define s6_addr32 __u6_addr.__u6_addr32
> -# endif
> -#endif
> =C2=A0#ifndef UINT32_MAX
> =C2=A0# define UINT32_MAX (4294967295U)
> =C2=A0#endif
> @@ -2637,10 +2630,15 @@ struct in6_addr add_in6_addr( struct in6_addr bas=
e, uint32_t add )
> =C2=A0 =C2=A0 int i;
> =C2=A0 =C2=A0 uint32_t h;
>
> + =C2=A0 =C2=A0union {
> + =C2=A0 =C2=A0 =C2=A0uint8_t =C2=A0*addr;
> + =C2=A0 =C2=A0 =C2=A0uint32_t *addr32;
> + =C2=A0 =C2=A0} in6 =3D { .addr =3D base.s6_addr };
> +
> =C2=A0 =C2=A0 for( i=3D3; i>=3D0 && add > 0 ; i-- )
> =C2=A0 =C2=A0 {
> - =C2=A0 =C2=A0 =C2=A0 h =3D ntohl( base.s6_addr32[i] );
> - =C2=A0 =C2=A0 =C2=A0 base.s6_addr32[i] =3D htonl( (h+add) & UINT32_MAX =
);
> + =C2=A0 =C2=A0 =C2=A0 h =3D ntohl( in6.addr32[i] );
> + =C2=A0 =C2=A0 =C2=A0 in6.addr32[i] =3D htonl( (h+add) & UINT32_MAX );
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* 32-bit overrun?
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * caveat: can't do "h+add > UINT32_MAX" with =
32bit math!
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> --
> 1.7.5.4
>
>
> -------------------------------------------------------------------------=
-----
> uberSVN's rich system and user administration capabilities and model
> configuration take the hassle out of deploying and managing Subversion and
> the tools developers use with it. Learn more about uberSVN and get a free
> download at: =C2=A0http://p.sf.net/sfu/wandisco-dev2dev
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

