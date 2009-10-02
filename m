MIME-Version: 1.0
In-Reply-To: <200910012022.30820.mailinglists@...1145...>
References: <7bb795fd0909251436v2369d6d5q674e63e0621fcd56@...278...> 
	<200910011141.52317.mailinglists@...1145...>
	<7bb795fd0910010314m5db10bedx448cf3b3a502fe82@...278...> 
	<200910012022.30820.mailinglists@...1145...>
From: JuanJo Ciarlante <jjo+ml@...410...>
Date: Fri, 2 Oct 2009 09:27:01 +0200
Message-ID: <7bb795fd0910020027n4bbefb38mee816d5f2afb91c4@...278...>
Subject: Re: [Openvpn-devel] [PATCH] openvpn over ipv6 support -v0.4.6
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-1?Q?Marcel_Pennewi=DF?= <mailinglists@...1145...>
Cc: openvpn-devel@lists.sourceforge.net

On Thu, Oct 1, 2009 at 8:22 PM, Marcel Pennewi=DF
<mailinglists@...1145...> wrote:
>
> On Thursday 01 October 2009 12:14:14 JuanJo Ciarlante wrote:
> > Could you please show a diff between config.h from stock
> > and patched build?
>
> the problem seems to be caused by
> ./configure ... --disable-iproute2.

this worked ok for me (?)

>
> if i enable iproute2:
> ./configure ... --enable-iproute2
> the build of openvpn works.
>
> But if the first client connects the openvpn server generate a segfault (=
with
> tcp-server and tcp6-server as option).
> The last lines via strace - maybe they could help you:

Thanks for the detailed report, I'll try to reproduce this
and come back to you.

Cheers,

>
> [ =A0 =A02b82cc06da13] epoll_wait(6, {{EPOLLIN, {u32=3D2, u64=3D2}}}, 102=
8, 10000) =3D 1
> [ =A0 =A02b82cbd8e840]
> read(5, "\377\377\377\377\377\377\0\377Gs\311\210\10\6\0\1\10\0\6\4\0\1\0=
\377Gs\311\210\300\250*s\0"...,
> 1532) =3D 42
> [ =A0 =A02b82cc06da13] epoll_wait(6, {{EPOLLIN, {u32=3D2, u64=3D2}}}, 102=
8, 10000) =3D 1
> [ =A0 =A02b82cbd8e840]
> read(5, "\377\377\377\377\377\377\0\377Gs\311\210\10\6\0\1\10\0\6\4\0\1\0=
\377Gs\311\210\300\250*s\0"...,
> 1532) =3D 42
> [ =A0 =A02b82cc06da13] epoll_wait(6, {{EPOLLIN, {u32=3D2, u64=3D2}}}, 102=
8, 10000) =3D 1
> [ =A0 =A02b82cbd8e840]
> read(5, "\377\377\377\377\377\377\0\377Gs\311\210\10\6\0\1\10\0\6\4\0\1\0=
\377Gs\311\210\300\250*s\0"...,
> 1532) =3D 42
> [ =A0 =A02b82cc06da13] epoll_wait(6, {{EPOLLIN, {u32=3D1, u64=3D1}}}, 102=
8, 10000) =3D 1
> [ =A0 =A02b82cc06e4b5] sendto(3, "<29>Oct =A01 20:24:45 openvpn[15698"...=
, 72,
> MSG_NOSIGNAL, NULL, 0) =3D 72
> [ =A0 =A02b82cc06e4b5] sendto(3, "<29>Oct =A01 20:24:45 openvpn[15698"...=
, 61,
> MSG_NOSIGNAL, NULL, 0) =3D 61
> [ =A0 =A02b82cc06a2ea] mmap(NULL, 266240, PROT_READ|PROT_WRITE, MAP_PRIVA=
TE|
> MAP_ANONYMOUS, -1, 0) =3D 0x2b82cb190000
> [ =A0 =A02b82cc06e4b5] sendto(3, "<29>Oct =A01 20:24:45 openvpn[15698"...=
, 64,
> MSG_NOSIGNAL, NULL, 0) =3D 64
> [ =A0 =A02b82cc06602a] brk(0x6dd000) =A0 =A0 =A0 =A0=3D 0x6dd000
> [ =A0 =A02b82cc06e4b5] sendto(3, "<29>Oct =A01 20:24:45 openvpn[15698"...=
, 100,
> MSG_NOSIGNAL, NULL, 0) =3D 100
> [ =A0 =A02b82cc06e4b5] sendto(3, "<29>Oct =A01 20:24:45 openvpn[15698"...=
, 108,
> MSG_NOSIGNAL, NULL, 0) =3D 108
> [ =A0 =A02b82cc06e4b5] sendto(3, "<29>Oct =A01 20:24:45 openvpn[15698"...=
, 76,
> MSG_NOSIGNAL, NULL, 0) =3D 76
> [ =A0 =A02b82cc06e4b5] sendto(3, "<29>Oct =A01 20:24:45 openvpn[15698"...=
, 86,
> MSG_NOSIGNAL, NULL, 0) =3D 86
> [ =A0 =A02b82cbd8eac0] accept(4, {sa_family=3DAF_INET6, sin6_port=3Dhtons=
(55430),
> inet_pton(AF_INET6, "::ffff:141.xx.xx.xxx", &sin6_addr), sin6_flowinfo=3D=
0,
> sin6_scope_id=3D0}, [30146066212978716]) =3D 7
> [ =A0 =A02b82cc06e4b5] sendto(3, "<29>Oct =A01 20:24:45 openvpn[15698"...=
, 105,
> MSG_NOSIGNAL, NULL, 0) =3D 105
> [ =A0 =A02b82cc06e20a] getsockopt(7, SOL_SOCKET, SO_SNDBUF, [17180000256]=
, [4]) =3D
> 0
> [ =A0 =A02b82cc06e20a] getsockopt(7, SOL_SOCKET, SO_RCVBUF, [301460662131=
09760],
> [4]) =3D 0
> [ =A0 =A02b82cc06e68a] setsockopt(7, SOL_SOCKET, SO_SNDBUF, [65536], 4) =
=3D 0
> [ =A0 =A02b82cc06e68a] setsockopt(7, SOL_SOCKET, SO_RCVBUF, [65536], 4) =
=3D 0
> [ =A0 =A02b82cc06e20a] getsockopt(7, SOL_SOCKET, SO_SNDBUF, [17180000256]=
, [4]) =3D
> 0
> [ =A0 =A02b82cc06e20a] getsockopt(7, SOL_SOCKET, SO_RCVBUF, [301460662131=
09760],
> [4]) =3D 0
> [ =A0 =A02b82cc06e4b5] sendto(3, "<29>Oct =A01 20:24:45 openvpn[15698"...=
, 90,
> MSG_NOSIGNAL, NULL, 0) =3D 90
> [ =A0 =A02b82cbd8ea1b] fcntl(7, F_SETFL, O_RDONLY|O_NONBLOCK) =3D 0
> [ =A0 =A02b82cbd8ea1b] fcntl(7, F_SETFD, FD_CLOEXEC) =3D 0
> [ =A0 =A02b82cc06e68a] setsockopt(7, SOL_IP, IP_RECVERR, [1], 4) =3D 0
> [ =A0 =A02b82cc017fd0] --- SIGSEGV (Segmentation fault) @ 0 (0) ---
> Process 15698 detached
>
>
> Oct =A01 20:09:45 larissa openvpn[15446]: segfault at 0000000000000002 rip
> 00002b07e075bfd0 rsp 00007fffcb1f79b8 error 4
>
> Marcel
>
>
> -------------------------------------------------------------------------=
-----
> Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
> is the only developer event you need to attend this year. Jumpstart your
> developing skills, take BlackBerry mobile applications to market and stay
> ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#3=
3;
> http://p.sf.net/sfu/devconf
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel



--
--JuanJo ; echo jAjo@...1263... | sed 's/[SPAM]//g'

