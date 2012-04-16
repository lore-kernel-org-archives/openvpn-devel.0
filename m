MIME-Version: 1.0
In-Reply-To: <1CED409804E2164C8104F9E623B08B9012CBF29E49@...1436...>
References: <1334213412-10048-1-git-send-email-dejong@...1435...>
	<CAOazyz105_ph-aVMxjowhwn6d7012w7F9HL0N95=npF3Viv6pg@...278...>
	<1CED409804E2164C8104F9E623B08B9012CBF29E49@...1436...>
Date: Mon, 16 Apr 2012 13:17:41 +0300
Message-ID: <CAOazyz3XDZuW+2CgFjAayeQxjk1cEcu8odcdbbN-YGgJiTOgLw@...278...>
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
To: Adriaan de Jong <dejong@...1435...>, David Sommerseth <openvpn.list@...1114...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Thanks for explanation.
David, please apply.

On Mon, Apr 16, 2012 at 10:02 AM, Adriaan de Jong <dejong@...1435...> wrote:
>
> There is on Android:
>
> =C2=A0- sys/un.h includes linux/un.h
> =C2=A0- linux/un.h uses sa_family_t
> =C2=A0- sa_family_t is defined in linux/socket.h
> =C2=A0- which is included from sys/socket.h
>
> Therefore, sys/socket.h is required for linux/un.h...
>
> Hope that clarifies things,
> Adriaan
>
> -----Original Message-----
> From: Alon Bar-Lev [mailto:alon.barlev@...277...]
> Sent: zaterdag 14 april 2012 18:58
> To: Adriaan de Jong
> Cc: openvpn-devel@lists.sourceforge.net
> Subject: Re: [Openvpn-devel] [PATCH] Ensure sys/un.h autoconf detection i=
ncludes sys/socket.h
>
> This is strange!
> As there is nothing in this file that needs dependency.
> Can you please send me config.log and the un.h file for me to learn?
>
> On Thu, Apr 12, 2012 at 9:50 AM, Adriaan de Jong <dejong@...1435...> wrot=
e:
> > This is required to build an Android binary.
> >
> > Signed-off-by: Adriaan de Jong <dejong@...1435...>
> > ---
> > =C2=A0configure.ac | =C2=A0 =C2=A04 ++--
> > =C2=A01 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/configure.ac b/configure.ac index 70c51e7..dc5bb43 100644
> > --- a/configure.ac
> > +++ b/configure.ac
> > @@ -363,7 +363,7 @@ AC_CHECK_HEADERS([ \
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0windows.h winsock2.h ws2tcpip.h \
> > =C2=A0])
> > =C2=A0AC_CHECK_HEADERS([ \
> > - =C2=A0 =C2=A0 =C2=A0 sys/time.h sys/un.h sys/ioctl.h sys/stat.h \
> > + =C2=A0 =C2=A0 =C2=A0 sys/time.h sys/ioctl.h sys/stat.h \
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0sys/mman.h sys/file.h \
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0unistd.h signal.h libgen.h stropts.h \
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0syslog.h pwd.h grp.h \
> > @@ -399,7 +399,7 @@ SOCKET_INCLUDES=3D"
> > =C2=A0"
> >
> > =C2=A0AC_CHECK_HEADERS(
> > - =C2=A0 =C2=A0 =C2=A0 [net/if.h netinet/ip.h netinet/if_ether.h resolv=
.h],
> > + =C2=A0 =C2=A0 =C2=A0 [net/if.h netinet/ip.h netinet/if_ether.h resolv=
.h sys/un.h],
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0[[${SOCKET_INCLUDES}]]
> > --
> > 1.7.5.4
> >
> >
> > ----------------------------------------------------------------------
> > -------- For Developers, A Lot Can Happen In A Second.
> > Boundary is the first to Know...and Tell You.
> > Monitor Your Applications in Ultra-Fine Resolution. Try it FREE!
> > http://p.sf.net/sfu/Boundary-d2dvs2
> > _______________________________________________
> > Openvpn-devel mailing list
> > Openvpn-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/openvpn-devel

