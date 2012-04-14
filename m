MIME-Version: 1.0
In-Reply-To: <1334213412-10048-1-git-send-email-dejong@...1435...>
References: <1334213412-10048-1-git-send-email-dejong@...1435...>
Date: Sat, 14 Apr 2012 19:58:01 +0300
Message-ID: <CAOazyz105_ph-aVMxjowhwn6d7012w7F9HL0N95=npF3Viv6pg@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Ensure sys/un.h autoconf detection
 includes sys/socket.h
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
To: Adriaan de Jong <dejong@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

This is strange!
As there is nothing in this file that needs dependency.
Can you please send me config.log and the un.h file for me to learn?

On Thu, Apr 12, 2012 at 9:50 AM, Adriaan de Jong <dejong@...1435...> wrote:
> This is required to build an Android binary.
>
> Signed-off-by: Adriaan de Jong <dejong@...1435...>
> ---
> =C2=A0configure.ac | =C2=A0 =C2=A04 ++--
> =C2=A01 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/configure.ac b/configure.ac
> index 70c51e7..dc5bb43 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -363,7 +363,7 @@ AC_CHECK_HEADERS([ \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0windows.h winsock2.h ws2tcpip.h \
> =C2=A0])
> =C2=A0AC_CHECK_HEADERS([ \
> - =C2=A0 =C2=A0 =C2=A0 sys/time.h sys/un.h sys/ioctl.h sys/stat.h \
> + =C2=A0 =C2=A0 =C2=A0 sys/time.h sys/ioctl.h sys/stat.h \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0sys/mman.h sys/file.h \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unistd.h signal.h libgen.h stropts.h \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0syslog.h pwd.h grp.h \
> @@ -399,7 +399,7 @@ SOCKET_INCLUDES=3D"
> =C2=A0"
>
> =C2=A0AC_CHECK_HEADERS(
> - =C2=A0 =C2=A0 =C2=A0 [net/if.h netinet/ip.h netinet/if_ether.h resolv.h=
],
> + =C2=A0 =C2=A0 =C2=A0 [net/if.h netinet/ip.h netinet/if_ether.h resolv.h=
 sys/un.h],
> =C2=A0 =C2=A0 =C2=A0 =C2=A0,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0[[${SOCKET_INCLUDES}]]
> --
> 1.7.5.4
>
>
> -------------------------------------------------------------------------=
-----
> For Developers, A Lot Can Happen In A Second.
> Boundary is the first to Know...and Tell You.
> Monitor Your Applications in Ultra-Fine Resolution. Try it FREE!
> http://p.sf.net/sfu/Boundary-d2dvs2
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

