Message-ID: <A9F464ED000E41E49522FF9AE5BCBC84@...2089...>
From: <debbie10t@...277...>
References: <1450191626-24633-1-git-send-email-samuli@...515...>
Date: Tue, 15 Dec 2015 16:29:21 -0000
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] Updates to Changes.rst
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; format="flowed"; charset="utf-8"; reply-type="original"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi
----- Original Message ----- 
From: <samuli@...515...>
To: <openvpn-devel@lists.sourceforge.net>
Sent: Tuesday, December 15, 2015 3:00 PM
Subject: [Openvpn-devel] [PATCH] Updates to Changes.rst


> From: Samuli Seppänen <samuli@...515...>
>
> This patch is for the release/2.3 branch
>
> +Overview of changes in 2.3
> +==========================
>
> New features
> ------------
>
> -Peer ID support
> +Windows DNS leak fix
> +    This feature allows blocking all out-of-tunnel communication on 
> TCP/UDP port
> +    53 (except for OpenVPN itself), preventing DNS Leaks on Windows 8.1 
> and 10.
> +

is WXP no longer supported by git-master ?

Let's call this "idiot proofing" :-)


----- Another Message ----- 
From: "Fish" <fish.thss@...277...>
To: <openvpn-devel@lists.sourceforge.net>
Sent: Monday, December 14, 2015 8:41 PM
Subject: [Openvpn-devel] [PATCH v4] Make "block-outside-dns" option
platformagnostic

> Make the "block-outside-dns" option agnostic of Windows versions by
> dynamically
> loading WFP-related functions. Cross-compiled on Linux and tested on
> Windows
> XP/10.

I thought I would give this a shot for WXP but I cannot get it to compile 
for win32



My system: uname -a
Linux [mint-172-64b] 3.16.0-38-generic #52~14.04.1-Ubuntu SMP Fri May 8
09:43:57 UTC 2015 x86_64 x86_64 x86_64 GNU/Linux


I have watched all the openvpn-dev mailing list and _tried_ to follow all
instructions ..
I hope I have just done something stupid ..
like "this does not work for 32bit"
or "you need version X of Y"
or "generic-build system cannot build this version for win32 (yet)"
or something like that .. Any help or pointers welcome.

Any clarity on what to expect of the --block-outside-dns option
and what windows version it is/will be support would help.

Thanks




What I did:
===
sudo apt-get update & upgrade
Using generic build system (which successfully built openvpn-build.git today
using: IMAGEROOT=`pwd`/image-win32 CHOST=i686-w64-mingw32 \
    CBUILD=x86_64-pc-linux-gnu ./build)

Log:
---
Tue Dec 15 14:18:35 2015 us=45270 OpenVPN 2.3.6 i686-w64-mingw32 [SSL
(OpenSSL)] [LZO] [PKCS11] [IPv6] built on Dec 15 2015
Tue Dec 15 14:18:35 2015 us=45270 library versions: OpenSSL 1.0.1j 15 Oct
2014, LZO 2.08
---


Then I used the build system like so:
===
Cloned:
github.com/OpenVPN/openvpn --to-- generic/sources/openvpn-2.3_git
execed:
autoreconf -ivf + ./configure (on that clone)
execed:
tar vzcf openvpn-2.3_git.tar.gz openvpn-2.3_git/*
(rm -rf openvpn-2.3_git)
Removed:
5 other tarballs of normal build,
left openvpn-2.3_git.tar.gz in place.
Changed build.vars:
OPENVPN_VERSION="${OPENVPN_VERSION:-2.3_git}"
execed:
IMAGEROOT=`pwd`/image-win32 CHOST=i686-w64-mingw32 \
CBUILD=x86_64-pc-linux-gnu ./build)
===


This is log where build broke:
===

i686-w64-mingw32-windres -DHAVE_CONFIG_H -I. -I../.. -I../../include  -I../../include 
 -I../../src/compat -DWIN32_LEAN_AND_MEAN -DNTDDI_VERSION=NTDDI_VISTA -D_WIN32_WINNT=_WIN32_WINNT_VISTA 
 -i "openvpn_win32_resources.rc" -o "openvpn_win32_resources.o"
mv -f .deps/cryptoapi.Tpo .deps/cryptoapi.Po
In file included from /usr/share/mingw-w64/include/ipsectypes.h:8:0,
                 from /usr/share/mingw-w64/include/fwpmtypes.h:9,
                 from /usr/share/mingw-w64/include/fwpmu.h:10,
                 from win32.c:52:
/usr/share/mingw-w64/include/iketypes.h:747:2: error: #endif without #if
 #endif /* __iketypes_h__ */
  ^
In file included from /usr/share/mingw-w64/include/fwpmtypes.h:10:0,
                 from /usr/share/mingw-w64/include/fwpmu.h:10,
                 from win32.c:52:
/usr/share/mingw-w64/include/iketypes.h:747:2: error: #endif without #if
 #endif /* __iketypes_h__ */
  ^
In file included from /usr/share/mingw-w64/include/fwpmu.h:10:0,
                 from win32.c:52:
/usr/share/mingw-w64/include/fwpmtypes.h:51:16: error: redefinition of 
‘struct FWPM_DISPLAY_DATA0_’
 typedef struct FWPM_DISPLAY_DATA0_ {
                ^
In file included from /usr/share/mingw-w64/include/fwpmu.h:9:0,
                 from win32.c:52:
/usr/share/mingw-w64/include/fwptypes.h:336:16: note: originally defined 
here
 typedef struct FWPM_DISPLAY_DATA0_ {
                ^
In file included from /usr/share/mingw-w64/include/fwpmu.h:10:0,
                 from win32.c:52:
/usr/share/mingw-w64/include/fwpmtypes.h:54:3: error: conflicting types for 
‘FWPM_DISPLAY_DATA0’
 } FWPM_DISPLAY_DATA0;
   ^
In file included from /usr/share/mingw-w64/include/fwpmu.h:9:0,
                 from win32.c:52:
/usr/share/mingw-w64/include/fwptypes.h:339:3: note: previous declaration of 
‘FWPM_DISPLAY_DATA0’ was here
 } FWPM_DISPLAY_DATA0;
   ^
In file included from /usr/share/mingw-w64/include/fwpmu.h:11:0,
                 from win32.c:52:
/usr/share/mingw-w64/include/iketypes.h:747:2: error: #endif without #if
 #endif /* __iketypes_h__ */
  ^
make[4]: *** [win32.o] Error 1
make[4]: Leaving directory 
`/home/arby/openvpn-build/20151214-after/generic/tmp/openvpn-2.3_git/src/openvpn'
make[3]: *** [install-recursive] Error 1
make[3]: Leaving directory 
`/home/arby/openvpn-build/20151214-after/generic/tmp/openvpn-2.3_git/src'
make[2]: *** [install-recursive] Error 1
make[2]: Leaving directory 
`/home/arby/openvpn-build/20151214-after/generic/tmp/openvpn-2.3_git'
make[1]: *** [install] Error 2
make[1]: Leaving directory 
`/home/arby/openvpn-build/20151214-after/generic/tmp/openvpn-2.3_git'
make: *** [install-strip] Error 2
FATAL: make openvpn


===

Thanks


