Message-ID: <4F59BCD4.2070209@...515...>
Date: Fri, 09 Mar 2012 10:18:28 +0200
From: =?UTF-8?B?U2FtdWxpIFNlcHDDpG5lbg==?= <samuli@...515...>
MIME-Version: 1.0
References: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
	<1330546342-17794-48-git-send-email-alon.barlev@...277...>
	<4F58AD4F.7080805@...515...>
	<CAOazyz1X1rdSrZ0=-RkgQJC3+TA=OAiGpwYh-w+YELfJMW160A@...278...>
In-Reply-To: <CAOazyz1X1rdSrZ0=-RkgQJC3+TA=OAiGpwYh-w+YELfJMW160A@...278...>
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
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "Openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

Ok. We need this for at least 2 years when XP has EOL and I think compat
is the right place. ACK just as earlier :).

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock



> Not exactly... windows has this in Vista and above.
> As long as we need to support XP we need to implement replacement functio=
nality.
>
> 2012/3/8 Samuli Sepp=C3=A4nen <samuli@...515...>:
>> Windows has this functionality, but not under the same function names as
>> UNIX. So thse two are just wrappers around the Windows-specific
>> functionality. In any case, I think it makes sense to move inet_pton and
>> inet_ntop under src/compat. The actual code changes seem fairly trivial.
>>
>> ACK.
>>
>> --
>> Samuli Sepp=C3=A4nen
>> Community Manager
>> OpenVPN Technologies, Inc
>>
>> irc freenode net: mattock
>>
>>
>> PS. These links should cover the basic idea, in case somebody is interes=
ted:
>>
>> <http://us.generation-nt.com/inet-pton-windows-convert-address-presentat=
ion-format-network-format-help-37036482.html>
>> <http://pubs.opengroup.org/onlinepubs/009604599/functions/inet_ntop.html>
>>> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
>>> ---
>>>  configure.ac  I recall many issues with inet_ntop and inet_pton.
>>>
>>>                 |    2 +-
>>>  src/compat/Makefile.am        |    4 ++-
>>>  src/compat/compat-inet_ntop.c |   76 +++++++++++++++++++++++++++++++++=
++++++
>>>  src/compat/compat-inet_pton.c |   79 +++++++++++++++++++++++++++++++++=
++++++++
>>>  src/compat/compat.h           |   17 ++++++++-
>>>  src/compat/compat.vcproj      |    8 ++++
>>>  src/openvpn/socket.c          |   55 ----------------------------
>>>  src/openvpn/win32.h           |    6 ---
>>>  8 files changed, 183 insertions(+), 64 deletions(-)
>>>  create mode 100644 src/compat/compat-inet_ntop.c
>>>  create mode 100644 src/compat/compat-inet_pton.c
>>>
>>> diff --git a/configure.ac b/configure.ac
>>> index dc138ba..d53a74a 100644
>>> --- a/configure.ac
>>> +++ b/configure.ac
>>> @@ -522,7 +522,7 @@ AC_CHECK_FUNCS([ \
>>>         chsize ftruncate execve getpeereid umask basename dirname acces=
s \
>>>         epoll_create \
>>>  ])
>>> -AC_CHECK_FUNCS([sendmsg recvmsg])
>>> +AC_CHECK_FUNCS([sendmsg recvmsg inet_ntop inet_pton])
>>>  AC_CHECK_FUNCS(
>>>         [res_init],
>>>         ,
>>> diff --git a/src/compat/Makefile.am b/src/compat/Makefile.am
>>> index c8a92ce..91b7f40 100644
>>> --- a/src/compat/Makefile.am
>>> +++ b/src/compat/Makefile.am
>>> @@ -22,4 +22,6 @@ libcompat_la_SOURCES =3D \
>>>         compat-dirname.c \
>>>         compat-basename.c \
>>>         compat-gettimeofday.c \
>>> -       compat-daemon.c
>>> +       compat-daemon.c \
>>> +       compat-inet_ntop.c \
>>> +       compat-inet_pton.c
>>> diff --git a/src/compat/compat-inet_ntop.c b/src/compat/compat-inet_nto=
p.c
>>> new file mode 100644
>>> index 0000000..0d52142
>>> --- /dev/null
>>> +++ b/src/compat/compat-inet_ntop.c
>>> @@ -0,0 +1,76 @@
>>> +/*
>>> + *  OpenVPN -- An application to securely tunnel IP networks
>>> + *             over a single UDP port, with support for SSL/TLS-based
>>> + *             session authentication and key exchange,
>>> + *             packet encryption, packet authentication, and
>>> + *             packet compression.
>>> + *
>>> + *  Copyright (C) 2011 - David Sommerseth <davids@...1347...>
>>> + *
>>> + *  This program is free software; you can redistribute it and/or modi=
fy
>>> + *  it under the terms of the GNU General Public License version 2
>>> + *  as published by the Free Software Foundation.
>>> + *
>>> + *  This program is distributed in the hope that it will be useful,
>>> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> + *  GNU General Public License for more details.
>>> + *
>>> + *  You should have received a copy of the GNU General Public License
>>> + *  along with this program (see the file COPYING included with this
>>> + *  distribution); if not, write to the Free Software Foundation, Inc.,
>>> + *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
>>> + */
>>> +
>>> +#ifdef HAVE_CONFIG_H
>>> +#include "config.h"
>>> +#elif defined(_MSC_VER)
>>> +#include "config-msvc.h"
>>> +#endif
>>> +
>>> +#ifndef HAVE_INET_NTOP
>>> +
>>> +#include "compat.h"
>>> +
>>> +#ifdef WIN32
>>> +
>>> +#include <windows.h>
>>> +
>>> +/*
>>> + * inet_ntop() and inet_pton() wrap-implementations using
>>> + * WSAAddressToString() and WSAStringToAddress() functions
>>> + *
>>> + * this is needed as long as we support running OpenVPN on WinXP
>>> + */
>>> +
>>> +const char *
>>> +inet_ntop(int af, const void *src, char *dst, socklen_t size)
>>> +{
>>> +  struct sockaddr_storage ss;
>>> +  unsigned long s =3D size;
>>> +
>>> +  ZeroMemory(&ss, sizeof(ss));
>>> +  ss.ss_family =3D af;
>>> +
>>> +  switch(af) {
>>> +    case AF_INET:
>>> +      ((struct sockaddr_in *)&ss)->sin_addr =3D *(struct in_addr *)src;
>>> +      break;
>>> +    case AF_INET6:
>>> +      ((struct sockaddr_in6 *)&ss)->sin6_addr =3D *(struct in6_addr *)=
src;
>>> +      break;
>>> +    default:
>>> +      return NULL;
>>> +  }
>>> +  /* cannot direclty use &size because of strict aliasing rules */
>>> +  return (WSAAddressToString((struct sockaddr *)&ss, sizeof(ss), NULL,=
 dst, &s) =3D=3D 0)?
>>> +          dst : NULL;
>>> +}
>>> +
>>> +#else
>>> +
>>> +#error no emulation for inet_ntop
>>> +
>>> +#endif
>>> +
>>> +#endif
>>> diff --git a/src/compat/compat-inet_pton.c b/src/compat/compat-inet_pto=
n.c
>>> new file mode 100644
>>> index 0000000..cdc8d4b
>>> --- /dev/null
>>> +++ b/src/compat/compat-inet_pton.c
>>> @@ -0,0 +1,79 @@
>>> +/*
>>> + *  OpenVPN -- An application to securely tunnel IP networks
>>> + *             over a single UDP port, with support for SSL/TLS-based
>>> + *             session authentication and key exchange,
>>> + *             packet encryption, packet authentication, and
>>> + *             packet compression.
>>> + *
>>> + *  Copyright (C) 2011 - David Sommerseth <davids@...1347...>
>>> + *
>>> + *  This program is free software; you can redistribute it and/or modi=
fy
>>> + *  it under the terms of the GNU General Public License version 2
>>> + *  as published by the Free Software Foundation.
>>> + *
>>> + *  This program is distributed in the hope that it will be useful,
>>> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> + *  GNU General Public License for more details.
>>> + *
>>> + *  You should have received a copy of the GNU General Public License
>>> + *  along with this program (see the file COPYING included with this
>>> + *  distribution); if not, write to the Free Software Foundation, Inc.,
>>> + *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
>>> + */
>>> +
>>> +#ifdef HAVE_CONFIG_H
>>> +#include "config.h"
>>> +#elif defined(_MSC_VER)
>>> +#include "config-msvc.h"
>>> +#endif
>>> +
>>> +#ifndef HAVE_INET_PTON
>>> +
>>> +#include "compat.h"
>>> +
>>> +#ifdef WIN32
>>> +
>>> +#include <windows.h>
>>> +#include <string.h>
>>> +
>>> +/*
>>> + * inet_ntop() and inet_pton() wrap-implementations using
>>> + * WSAAddressToString() and WSAStringToAddress() functions
>>> + *
>>> + * this is needed as long as we support running OpenVPN on WinXP
>>> + */
>>> +
>>> +
>>> +int
>>> +inet_pton(int af, const char *src, void *dst)
>>> +{
>>> +  struct sockaddr_storage ss;
>>> +  int size =3D sizeof(ss);
>>> +  char src_copy[INET6_ADDRSTRLEN+1];
>>> +
>>> +  ZeroMemory(&ss, sizeof(ss));
>>> +  /* stupid non-const API */
>>> +  strncpy (src_copy, src, INET6_ADDRSTRLEN+1);
>>> +  src_copy[INET6_ADDRSTRLEN] =3D 0;
>>> +
>>> +  if (WSAStringToAddress(src_copy, af, NULL, (struct sockaddr *)&ss, &=
size) =3D=3D 0) {
>>> +    switch(af) {
>>> +      case AF_INET:
>>> +       *(struct in_addr *)dst =3D ((struct sockaddr_in *)&ss)->sin_add=
r;
>>> +       return 1;
>>> +      case AF_INET6:
>>> +       *(struct in6_addr *)dst =3D ((struct sockaddr_in6 *)&ss)->sin6_=
addr;
>>> +       return 1;
>>> +    }
>>> +  }
>>> +  return 0;
>>> +}
>>> +
>>> +#else
>>> +
>>> +#error no emulation for inet_ntop
>>> +
>>> +#endif
>>> +
>>> +#endif
>>> diff --git a/src/compat/compat.h b/src/compat/compat.h
>>> index e9d51b8..021573e 100644
>>> --- a/src/compat/compat.h
>>> +++ b/src/compat/compat.h
>>> @@ -26,14 +26,21 @@
>>>  #define COMPAT_H
>>>
>>>  #ifdef HAVE_WINSOCK2_H
>>> -/* timeval */
>>>  #include <winsock2.h>
>>>  #endif
>>>
>>> +#ifdef HAVE_WS2TCPIP_H
>>> +#include <ws2tcpip.h>
>>> +#endif
>>> +
>>>  #ifdef HAVE_SYS_TIME_H
>>>  #include <sys/time.h>
>>>  #endif
>>>
>>> +#ifdef HAVE_SYS_SOCKET_H
>>> +#include <sys/socket.h>
>>> +#endif
>>> +
>>>  #ifndef HAVE_DIRNAME
>>>  char * dirname(char *str);
>>>  #endif /* HAVE_DIRNAME */
>>> @@ -50,4 +57,12 @@ int gettimeofday (struct timeval *tv, void *tz);
>>>  int daemon(int nochdir, int noclose);
>>>  #endif
>>>
>>> +#ifndef HAVE_INET_NTOP
>>> +const char * inet_ntop(int af, const void *src, char *dst, socklen_t s=
ize);
>>> +#endif
>>> +
>>> +#ifndef HAVE_INET_PTON
>>> +int inet_pton(int af, const char *src, void *dst);
>>> +#endif
>>> +
>>>  #endif /* COMPAT_H */
>>> diff --git a/src/compat/compat.vcproj b/src/compat/compat.vcproj
>>> index efdecb4..43fc0c2 100644
>>> --- a/src/compat/compat.vcproj
>>> +++ b/src/compat/compat.vcproj
>>> @@ -163,6 +163,14 @@
>>>                                 >
>>>                         </File>
>>>                         <File
>>> +                               RelativePath=3D".\compat-inet_ntop.c"
>>> +                               >
>>> +                       </File>
>>> +                       <File
>>> +                               RelativePath=3D".\compat-inet_pton.c"
>>> +                               >
>>> +                       </File>
>>> +                       <File
>>>                                 RelativePath=3D".\compat-daemon.c"
>>>                                 >
>>>                         </File>
>>> diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
>>> index e1526ff..608213b 100644
>>> --- a/src/openvpn/socket.c
>>> +++ b/src/openvpn/socket.c
>>> @@ -3086,61 +3086,6 @@ link_socket_write_udp_posix_sendmsg (struct link=
_socket *sock,
>>>
>>>  #ifdef WIN32
>>>
>>> -/*
>>> - * inet_ntop() and inet_pton() wrap-implementations using
>>> - * WSAAddressToString() and WSAStringToAddress() functions
>>> - *
>>> - * this is needed as long as we support running OpenVPN on WinXP
>>> - */
>>> -
>>> -const char *
>>> -openvpn_inet_ntop(int af, const void *src, char *dst, socklen_t size)
>>> -{
>>> -  struct sockaddr_storage ss;
>>> -  unsigned long s =3D size;
>>> -
>>> -  CLEAR(ss);
>>> -  ss.ss_family =3D af;
>>> -
>>> -  switch(af) {
>>> -    case AF_INET:
>>> -      ((struct sockaddr_in *)&ss)->sin_addr =3D *(struct in_addr *)src;
>>> -      break;
>>> -    case AF_INET6:
>>> -      ((struct sockaddr_in6 *)&ss)->sin6_addr =3D *(struct in6_addr *)=
src;
>>> -      break;
>>> -    default:
>>> -      ASSERT (0);
>>> -  }
>>> -  /* cannot direclty use &size because of strict aliasing rules */
>>> -  return (WSAAddressToString((struct sockaddr *)&ss, sizeof(ss), NULL,=
 dst, &s) =3D=3D 0)?
>>> -          dst : NULL;
>>> -}
>>> -
>>> -int
>>> -openvpn_inet_pton(int af, const char *src, void *dst)
>>> -{
>>> -  struct sockaddr_storage ss;
>>> -  int size =3D sizeof(ss);
>>> -  char src_copy[INET6_ADDRSTRLEN+1];
>>> -
>>> -  CLEAR(ss);
>>> -  /* stupid non-const API */
>>> -  strncpynt(src_copy, src, INET6_ADDRSTRLEN+1);
>>> -
>>> -  if (WSAStringToAddress(src_copy, af, NULL, (struct sockaddr *)&ss, &=
size) =3D=3D 0) {
>>> -    switch(af) {
>>> -      case AF_INET:
>>> -       *(struct in_addr *)dst =3D ((struct sockaddr_in *)&ss)->sin_add=
r;
>>> -       return 1;
>>> -      case AF_INET6:
>>> -       *(struct in6_addr *)dst =3D ((struct sockaddr_in6 *)&ss)->sin6_=
addr;
>>> -       return 1;
>>> -    }
>>> -  }
>>> -  return 0;
>>> -}
>>> -
>>>  int
>>>  socket_recv_queue (struct link_socket *sock, int maxsize)
>>>  {
>>> diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h
>>> index 09f897a..d87e987 100644
>>> --- a/src/openvpn/win32.h
>>> +++ b/src/openvpn/win32.h
>>> @@ -266,12 +266,6 @@ char *get_win_sys_path (void);
>>>  /* call self in a subprocess */
>>>  void fork_to_self (const char *cmdline);
>>>
>>> -const char *openvpn_inet_ntop(int af, const void *src,
>>> -                              char *dst, socklen_t size);
>>> -int openvpn_inet_pton(int af, const char *src, void *dst);
>>> -#define inet_ntop(af,src,dst,size) openvpn_inet_ntop(af,src,dst,size)
>>> -#define inet_pton(af,src,dst)      openvpn_inet_pton(af,src,dst)
>>> -
>>>  /* Find temporary directory */
>>>  const char *win_get_tempdir();
>>>
>>> --
>>> 1.7.3.4
>>>
>>>
>>> -----------------------------------------------------------------------=
-------
>>> Virtualization & Cloud Management Using Capacity Planning
>>> Cloud computing makes use of virtualization - but cloud computing
>>> also focuses on allowing computing to be delivered as a service.
>>> http://www.accelacomm.com/jaw/sfnl/114/51521223/
>>> _______________________________________________
>>> Openvpn-devel mailing list
>>> Openvpn-devel@lists.sourceforge.net
>>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>>



