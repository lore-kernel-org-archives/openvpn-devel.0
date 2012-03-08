MIME-Version: 1.0
In-Reply-To: <4F58AD4F.7080805@...515...>
References: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
	<1330546342-17794-48-git-send-email-alon.barlev@...277...>
	<4F58AD4F.7080805@...515...>
Date: Thu, 8 Mar 2012 21:29:17 +0200
Message-ID: <CAOazyz1X1rdSrZ0=-RkgQJC3+TA=OAiGpwYh-w+YELfJMW160A@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 47/52] build: move inet_ntop(),
 inet_pton() emulation into compat
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
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: "Openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

Not exactly... windows has this in Vista and above.
As long as we need to support XP we need to implement replacement functiona=
lity.

2012/3/8 Samuli Sepp=C3=A4nen <samuli@...515...>:
> Windows has this functionality, but not under the same function names as
> UNIX. So thse two are just wrappers around the Windows-specific
> functionality. In any case, I think it makes sense to move inet_pton and
> inet_ntop under src/compat. The actual code changes seem fairly trivial.
>
> ACK.
>
> --
> Samuli Sepp=C3=A4nen
> Community Manager
> OpenVPN Technologies, Inc
>
> irc freenode net: mattock
>
>
> PS. These links should cover the basic idea, in case somebody is interest=
ed:
>
> <http://us.generation-nt.com/inet-pton-windows-convert-address-presentati=
on-format-network-format-help-37036482.html>
> <http://pubs.opengroup.org/onlinepubs/009604599/functions/inet_ntop.html>
>> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
>> ---
>> =C2=A0configure.ac =C2=A0I recall many issues with inet_ntop and inet_pt=
on.
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A02=
 +-
>> =C2=A0src/compat/Makefile.am =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A04=
 ++-
>> =C2=A0src/compat/compat-inet_ntop.c | =C2=A0 76 ++++++++++++++++++++++++=
+++++++++++++++
>> =C2=A0src/compat/compat-inet_pton.c | =C2=A0 79 ++++++++++++++++++++++++=
+++++++++++++++++
>> =C2=A0src/compat/compat.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 17=
 ++++++++-
>> =C2=A0src/compat/compat.vcproj =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A08 ++++
>> =C2=A0src/openvpn/socket.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 55=
 ----------------------------
>> =C2=A0src/openvpn/win32.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =
=C2=A06 ---
>> =C2=A08 files changed, 183 insertions(+), 64 deletions(-)
>> =C2=A0create mode 100644 src/compat/compat-inet_ntop.c
>> =C2=A0create mode 100644 src/compat/compat-inet_pton.c
>>
>> diff --git a/configure.ac b/configure.ac
>> index dc138ba..d53a74a 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -522,7 +522,7 @@ AC_CHECK_FUNCS([ \
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 chsize ftruncate execve getpeereid umask bas=
ename dirname access \
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 epoll_create \
>> =C2=A0])
>> -AC_CHECK_FUNCS([sendmsg recvmsg])
>> +AC_CHECK_FUNCS([sendmsg recvmsg inet_ntop inet_pton])
>> =C2=A0AC_CHECK_FUNCS(
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 [res_init],
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ,
>> diff --git a/src/compat/Makefile.am b/src/compat/Makefile.am
>> index c8a92ce..91b7f40 100644
>> --- a/src/compat/Makefile.am
>> +++ b/src/compat/Makefile.am
>> @@ -22,4 +22,6 @@ libcompat_la_SOURCES =3D \
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 compat-dirname.c \
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 compat-basename.c \
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 compat-gettimeofday.c \
>> - =C2=A0 =C2=A0 =C2=A0 compat-daemon.c
>> + =C2=A0 =C2=A0 =C2=A0 compat-daemon.c \
>> + =C2=A0 =C2=A0 =C2=A0 compat-inet_ntop.c \
>> + =C2=A0 =C2=A0 =C2=A0 compat-inet_pton.c
>> diff --git a/src/compat/compat-inet_ntop.c b/src/compat/compat-inet_ntop=
.c
>> new file mode 100644
>> index 0000000..0d52142
>> --- /dev/null
>> +++ b/src/compat/compat-inet_ntop.c
>> @@ -0,0 +1,76 @@
>> +/*
>> + * =C2=A0OpenVPN -- An application to securely tunnel IP networks
>> + * =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 over a single UDP port, wi=
th support for SSL/TLS-based
>> + * =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 session authentication and=
 key exchange,
>> + * =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packet encryption, packet =
authentication, and
>> + * =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packet compression.
>> + *
>> + * =C2=A0Copyright (C) 2011 - David Sommerseth <davids@...1347...>
>> + *
>> + * =C2=A0This program is free software; you can redistribute it and/or =
modify
>> + * =C2=A0it under the terms of the GNU General Public License version 2
>> + * =C2=A0as published by the Free Software Foundation.
>> + *
>> + * =C2=A0This program is distributed in the hope that it will be useful,
>> + * =C2=A0but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * =C2=A0MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =C2=A0See=
 the
>> + * =C2=A0GNU General Public License for more details.
>> + *
>> + * =C2=A0You should have received a copy of the GNU General Public Lice=
nse
>> + * =C2=A0along with this program (see the file COPYING included with th=
is
>> + * =C2=A0distribution); if not, write to the Free Software Foundation, =
Inc.,
>> + * =C2=A059 Temple Place, Suite 330, Boston, MA =C2=A002111-1307 =C2=A0=
USA
>> + */
>> +
>> +#ifdef HAVE_CONFIG_H
>> +#include "config.h"
>> +#elif defined(_MSC_VER)
>> +#include "config-msvc.h"
>> +#endif
>> +
>> +#ifndef HAVE_INET_NTOP
>> +
>> +#include "compat.h"
>> +
>> +#ifdef WIN32
>> +
>> +#include <windows.h>
>> +
>> +/*
>> + * inet_ntop() and inet_pton() wrap-implementations using
>> + * WSAAddressToString() and WSAStringToAddress() functions
>> + *
>> + * this is needed as long as we support running OpenVPN on WinXP
>> + */
>> +
>> +const char *
>> +inet_ntop(int af, const void *src, char *dst, socklen_t size)
>> +{
>> + =C2=A0struct sockaddr_storage ss;
>> + =C2=A0unsigned long s =3D size;
>> +
>> + =C2=A0ZeroMemory(&ss, sizeof(ss));
>> + =C2=A0ss.ss_family =3D af;
>> +
>> + =C2=A0switch(af) {
>> + =C2=A0 =C2=A0case AF_INET:
>> + =C2=A0 =C2=A0 =C2=A0((struct sockaddr_in *)&ss)->sin_addr =3D *(struct=
 in_addr *)src;
>> + =C2=A0 =C2=A0 =C2=A0break;
>> + =C2=A0 =C2=A0case AF_INET6:
>> + =C2=A0 =C2=A0 =C2=A0((struct sockaddr_in6 *)&ss)->sin6_addr =3D *(stru=
ct in6_addr *)src;
>> + =C2=A0 =C2=A0 =C2=A0break;
>> + =C2=A0 =C2=A0default:
>> + =C2=A0 =C2=A0 =C2=A0return NULL;
>> + =C2=A0}
>> + =C2=A0/* cannot direclty use &size because of strict aliasing rules */
>> + =C2=A0return (WSAAddressToString((struct sockaddr *)&ss, sizeof(ss), N=
ULL, dst, &s) =3D=3D 0)?
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dst : NULL;
>> +}
>> +
>> +#else
>> +
>> +#error no emulation for inet_ntop
>> +
>> +#endif
>> +
>> +#endif
>> diff --git a/src/compat/compat-inet_pton.c b/src/compat/compat-inet_pton=
.c
>> new file mode 100644
>> index 0000000..cdc8d4b
>> --- /dev/null
>> +++ b/src/compat/compat-inet_pton.c
>> @@ -0,0 +1,79 @@
>> +/*
>> + * =C2=A0OpenVPN -- An application to securely tunnel IP networks
>> + * =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 over a single UDP port, wi=
th support for SSL/TLS-based
>> + * =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 session authentication and=
 key exchange,
>> + * =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packet encryption, packet =
authentication, and
>> + * =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packet compression.
>> + *
>> + * =C2=A0Copyright (C) 2011 - David Sommerseth <davids@...1347...>
>> + *
>> + * =C2=A0This program is free software; you can redistribute it and/or =
modify
>> + * =C2=A0it under the terms of the GNU General Public License version 2
>> + * =C2=A0as published by the Free Software Foundation.
>> + *
>> + * =C2=A0This program is distributed in the hope that it will be useful,
>> + * =C2=A0but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * =C2=A0MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =C2=A0See=
 the
>> + * =C2=A0GNU General Public License for more details.
>> + *
>> + * =C2=A0You should have received a copy of the GNU General Public Lice=
nse
>> + * =C2=A0along with this program (see the file COPYING included with th=
is
>> + * =C2=A0distribution); if not, write to the Free Software Foundation, =
Inc.,
>> + * =C2=A059 Temple Place, Suite 330, Boston, MA =C2=A002111-1307 =C2=A0=
USA
>> + */
>> +
>> +#ifdef HAVE_CONFIG_H
>> +#include "config.h"
>> +#elif defined(_MSC_VER)
>> +#include "config-msvc.h"
>> +#endif
>> +
>> +#ifndef HAVE_INET_PTON
>> +
>> +#include "compat.h"
>> +
>> +#ifdef WIN32
>> +
>> +#include <windows.h>
>> +#include <string.h>
>> +
>> +/*
>> + * inet_ntop() and inet_pton() wrap-implementations using
>> + * WSAAddressToString() and WSAStringToAddress() functions
>> + *
>> + * this is needed as long as we support running OpenVPN on WinXP
>> + */
>> +
>> +
>> +int
>> +inet_pton(int af, const char *src, void *dst)
>> +{
>> + =C2=A0struct sockaddr_storage ss;
>> + =C2=A0int size =3D sizeof(ss);
>> + =C2=A0char src_copy[INET6_ADDRSTRLEN+1];
>> +
>> + =C2=A0ZeroMemory(&ss, sizeof(ss));
>> + =C2=A0/* stupid non-const API */
>> + =C2=A0strncpy (src_copy, src, INET6_ADDRSTRLEN+1);
>> + =C2=A0src_copy[INET6_ADDRSTRLEN] =3D 0;
>> +
>> + =C2=A0if (WSAStringToAddress(src_copy, af, NULL, (struct sockaddr *)&s=
s, &size) =3D=3D 0) {
>> + =C2=A0 =C2=A0switch(af) {
>> + =C2=A0 =C2=A0 =C2=A0case AF_INET:
>> + =C2=A0 =C2=A0 =C2=A0 *(struct in_addr *)dst =3D ((struct sockaddr_in *=
)&ss)->sin_addr;
>> + =C2=A0 =C2=A0 =C2=A0 return 1;
>> + =C2=A0 =C2=A0 =C2=A0case AF_INET6:
>> + =C2=A0 =C2=A0 =C2=A0 *(struct in6_addr *)dst =3D ((struct sockaddr_in6=
 *)&ss)->sin6_addr;
>> + =C2=A0 =C2=A0 =C2=A0 return 1;
>> + =C2=A0 =C2=A0}
>> + =C2=A0}
>> + =C2=A0return 0;
>> +}
>> +
>> +#else
>> +
>> +#error no emulation for inet_ntop
>> +
>> +#endif
>> +
>> +#endif
>> diff --git a/src/compat/compat.h b/src/compat/compat.h
>> index e9d51b8..021573e 100644
>> --- a/src/compat/compat.h
>> +++ b/src/compat/compat.h
>> @@ -26,14 +26,21 @@
>> =C2=A0#define COMPAT_H
>>
>> =C2=A0#ifdef HAVE_WINSOCK2_H
>> -/* timeval */
>> =C2=A0#include <winsock2.h>
>> =C2=A0#endif
>>
>> +#ifdef HAVE_WS2TCPIP_H
>> +#include <ws2tcpip.h>
>> +#endif
>> +
>> =C2=A0#ifdef HAVE_SYS_TIME_H
>> =C2=A0#include <sys/time.h>
>> =C2=A0#endif
>>
>> +#ifdef HAVE_SYS_SOCKET_H
>> +#include <sys/socket.h>
>> +#endif
>> +
>> =C2=A0#ifndef HAVE_DIRNAME
>> =C2=A0char * dirname(char *str);
>> =C2=A0#endif /* HAVE_DIRNAME */
>> @@ -50,4 +57,12 @@ int gettimeofday (struct timeval *tv, void *tz);
>> =C2=A0int daemon(int nochdir, int noclose);
>> =C2=A0#endif
>>
>> +#ifndef HAVE_INET_NTOP
>> +const char * inet_ntop(int af, const void *src, char *dst, socklen_t si=
ze);
>> +#endif
>> +
>> +#ifndef HAVE_INET_PTON
>> +int inet_pton(int af, const char *src, void *dst);
>> +#endif
>> +
>> =C2=A0#endif /* COMPAT_H */
>> diff --git a/src/compat/compat.vcproj b/src/compat/compat.vcproj
>> index efdecb4..43fc0c2 100644
>> --- a/src/compat/compat.vcproj
>> +++ b/src/compat/compat.vcproj
>> @@ -163,6 +163,14 @@
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 >
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 </File>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 <File
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RelativePath=3D".\compat-inet_ntop.c"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 >
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 </File>
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 <File
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RelativePath=3D".\compat-inet_pton.c"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 >
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 </File>
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 <File
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RelativePath=3D".\compat-daemon.c"
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 >
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 </File>
>> diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
>> index e1526ff..608213b 100644
>> --- a/src/openvpn/socket.c
>> +++ b/src/openvpn/socket.c
>> @@ -3086,61 +3086,6 @@ link_socket_write_udp_posix_sendmsg (struct link_=
socket *sock,
>>
>> =C2=A0#ifdef WIN32
>>
>> -/*
>> - * inet_ntop() and inet_pton() wrap-implementations using
>> - * WSAAddressToString() and WSAStringToAddress() functions
>> - *
>> - * this is needed as long as we support running OpenVPN on WinXP
>> - */
>> -
>> -const char *
>> -openvpn_inet_ntop(int af, const void *src, char *dst, socklen_t size)
>> -{
>> - =C2=A0struct sockaddr_storage ss;
>> - =C2=A0unsigned long s =3D size;
>> -
>> - =C2=A0CLEAR(ss);
>> - =C2=A0ss.ss_family =3D af;
>> -
>> - =C2=A0switch(af) {
>> - =C2=A0 =C2=A0case AF_INET:
>> - =C2=A0 =C2=A0 =C2=A0((struct sockaddr_in *)&ss)->sin_addr =3D *(struct=
 in_addr *)src;
>> - =C2=A0 =C2=A0 =C2=A0break;
>> - =C2=A0 =C2=A0case AF_INET6:
>> - =C2=A0 =C2=A0 =C2=A0((struct sockaddr_in6 *)&ss)->sin6_addr =3D *(stru=
ct in6_addr *)src;
>> - =C2=A0 =C2=A0 =C2=A0break;
>> - =C2=A0 =C2=A0default:
>> - =C2=A0 =C2=A0 =C2=A0ASSERT (0);
>> - =C2=A0}
>> - =C2=A0/* cannot direclty use &size because of strict aliasing rules */
>> - =C2=A0return (WSAAddressToString((struct sockaddr *)&ss, sizeof(ss), N=
ULL, dst, &s) =3D=3D 0)?
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dst : NULL;
>> -}
>> -
>> -int
>> -openvpn_inet_pton(int af, const char *src, void *dst)
>> -{
>> - =C2=A0struct sockaddr_storage ss;
>> - =C2=A0int size =3D sizeof(ss);
>> - =C2=A0char src_copy[INET6_ADDRSTRLEN+1];
>> -
>> - =C2=A0CLEAR(ss);
>> - =C2=A0/* stupid non-const API */
>> - =C2=A0strncpynt(src_copy, src, INET6_ADDRSTRLEN+1);
>> -
>> - =C2=A0if (WSAStringToAddress(src_copy, af, NULL, (struct sockaddr *)&s=
s, &size) =3D=3D 0) {
>> - =C2=A0 =C2=A0switch(af) {
>> - =C2=A0 =C2=A0 =C2=A0case AF_INET:
>> - =C2=A0 =C2=A0 =C2=A0 *(struct in_addr *)dst =3D ((struct sockaddr_in *=
)&ss)->sin_addr;
>> - =C2=A0 =C2=A0 =C2=A0 return 1;
>> - =C2=A0 =C2=A0 =C2=A0case AF_INET6:
>> - =C2=A0 =C2=A0 =C2=A0 *(struct in6_addr *)dst =3D ((struct sockaddr_in6=
 *)&ss)->sin6_addr;
>> - =C2=A0 =C2=A0 =C2=A0 return 1;
>> - =C2=A0 =C2=A0}
>> - =C2=A0}
>> - =C2=A0return 0;
>> -}
>> -
>> =C2=A0int
>> =C2=A0socket_recv_queue (struct link_socket *sock, int maxsize)
>> =C2=A0{
>> diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h
>> index 09f897a..d87e987 100644
>> --- a/src/openvpn/win32.h
>> +++ b/src/openvpn/win32.h
>> @@ -266,12 +266,6 @@ char *get_win_sys_path (void);
>> =C2=A0/* call self in a subprocess */
>> =C2=A0void fork_to_self (const char *cmdline);
>>
>> -const char *openvpn_inet_ntop(int af, const void *src,
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char *dst, socklen_t size);
>> -int openvpn_inet_pton(int af, const char *src, void *dst);
>> -#define inet_ntop(af,src,dst,size) openvpn_inet_ntop(af,src,dst,size)
>> -#define inet_pton(af,src,dst) =C2=A0 =C2=A0 =C2=A0openvpn_inet_pton(af,=
src,dst)
>> -
>> =C2=A0/* Find temporary directory */
>> =C2=A0const char *win_get_tempdir();
>>
>> --
>> 1.7.3.4
>>
>>
>> ------------------------------------------------------------------------=
------
>> Virtualization & Cloud Management Using Capacity Planning
>> Cloud computing makes use of virtualization - but cloud computing
>> also focuses on allowing computing to be delivered as a service.
>> http://www.accelacomm.com/jaw/sfnl/114/51521223/
>> _______________________________________________
>> Openvpn-devel mailing list
>> Openvpn-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>
>

