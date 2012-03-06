MIME-Version: 1.0
In-Reply-To: <4F55E72D.2010306@...515...>
References: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
	<1330546342-17794-10-git-send-email-alon.barlev@...277...>
	<4F55E72D.2010306@...515...>
Date: Tue, 6 Mar 2012 13:13:24 +0200
Message-ID: <CAOazyz1j=gYO__gyeck89kGnJ+BmCHW=qmX8MF3KV9gBJF3k2Q@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 09/52] cleanup: memcmp.c: remove unused
	source
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

Not exactly.
This file is needed for VERY old libc implementations.
I don't think these exists anymore in supported configurations.
If we find memcmp() is missing, we add it properly to compat.

2012/3/6 Samuli Sepp=C3=A4nen <samuli@...515...>:
>
>> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
>> ---
>> =C2=A0configure.ac | =C2=A0 =C2=A03 ---
>> =C2=A0memcmp.c =C2=A0 =C2=A0 | =C2=A0 43 -------------------------------=
------------
>> =C2=A02 files changed, 0 insertions(+), 46 deletions(-)
>> =C2=A0delete mode 100644 memcmp.c
>>
>> diff --git a/configure.ac b/configure.ac
>> index 25dcc37..1c4d66c 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -564,9 +564,6 @@ else
>>
>> =C2=A0fi
>>
>> -dnl Required library functions
>> -AC_FUNC_MEMCMP
>> -
>> =C2=A0dnl
>> =C2=A0dnl Check for res_init
>> =C2=A0dnl
>> diff --git a/memcmp.c b/memcmp.c
>> deleted file mode 100644
>> index d921aac..0000000
>> --- a/memcmp.c
>> +++ /dev/null
>> @@ -1,43 +0,0 @@
>> -/*
>> - * =C2=A0OpenVPN -- An application to securely tunnel IP networks
>> - * =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 over a single TCP/UDP port=
, with support for SSL/TLS-based
>> - * =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 session authentication and=
 key exchange,
>> - * =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packet encryption, packet =
authentication, and
>> - * =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packet compression.
>> - *
>> - * =C2=A0Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...1696...=
15...>
>> - *
>> - * =C2=A0This program is free software; you can redistribute it and/or =
modify
>> - * =C2=A0it under the terms of the GNU General Public License version 2
>> - * =C2=A0as published by the Free Software Foundation.
>> - *
>> - * =C2=A0This program is distributed in the hope that it will be useful,
>> - * =C2=A0but WITHOUT ANY WARRANTY; without even the implied warranty of
>> - * =C2=A0MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =C2=A0See=
 the
>> - * =C2=A0GNU General Public License for more details.
>> - *
>> - * =C2=A0You should have received a copy of the GNU General Public Lice=
nse
>> - * =C2=A0along with this program (see the file COPYING included with th=
is
>> - * =C2=A0distribution); if not, write to the Free Software Foundation, =
Inc.,
>> - * =C2=A059 Temple Place, Suite 330, Boston, MA =C2=A002111-1307 =C2=A0=
USA
>> - */
>> -
>> -#include "syshead.h"
>> -
>> -#include "memdbg.h"
>> -
>> -int
>> -memcmp (const void *s1, const void *s2, size_t n)
>> -{
>> - =C2=A0unsigned const char *p1 =3D s1, *p2 =3D s2;
>> - =C2=A0int d;
>> -
>> - =C2=A0if (n)
>> - =C2=A0 =C2=A0while (n-- > 0)
>> - =C2=A0 =C2=A0 =C2=A0{
>> - =C2=A0 =C2=A0 d =3D *p1++ - *p2++;
>> - =C2=A0 =C2=A0 if (d !=3D 0)
>> - =C2=A0 =C2=A0 =C2=A0 return d;
>> - =C2=A0 =C2=A0 =C2=A0}
>> - =C2=A0return 0;
>> -}
>
> My C-fu is fairly low, but this still seems to make sense as there's no
> memcmp.h. The memcmp function calls in other source files seem to use
> memcmp function stored elsewhere (gcc[1], libc[2], etc.).
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
> [1] <http://justin.harmonize.fm/index.php/2009/05/exploring-memcmp>
> [2]
> <http://www.slac.stanford.edu/comp/unix/package/rtems/doc/html/libc/libc.=
info.memcmp.html>

