MIME-Version: 1.0
In-Reply-To: <4F881610.5010304@...515...>
References: <4F881610.5010304@...515...>
Date: Sat, 14 Apr 2012 19:39:24 +0300
Message-ID: <CAOazyz3RcTS4b8Gc-_ort0T0Zw-hEbUMz-NYab21Ww4pZ4Bxkw@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] MSVC build tests on Git "master"
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
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hello Samuli,

I was out, reducing my backlog.

2012/4/13 Samuli Sepp=C3=A4nen <samuli@...515...>
>
> Hi all,
>
> I did a number of MSVC build tests using Visual Studio 2010 Express. I
> tried both Git "master"[1] and Alon's openvpn-build repo[2].
>
> I encountered a number of issues with [1]. First, unlike in [2],
> dependency fetching is not automatic - not sure if that's intentional,

Sure, this is intentional.
The openvpn repository builds openvpn using autotools or vc, there is
no difference between the two, both do  not build dependencies.

> but it is/was a really nice feature. Due to this, "master"[1] did not
> build at all[3] without copying the build dependencies to a directory
> manually, and adding a "msvc-build-env-local.bat" to point the build to
> those:

Master can be built using correct environment... use first the
openvpn-build/msvc to build dependencies only using set DO_ONLY_DEPS=3D1

> set OPENVPN_DEPROOT=3Dc:\Users\Samuli\openvpn-build\build-deps-alon

This should be sufficient... the default location of the dependencies would=
 be:
c:\Users\Samuli\openvpn-build\image

> This allowed the build to proceed, but then I got tons of errors. Those
> seem to be caused by Visual Studio 2010 peculiarities; see [4] for a
> partial log. The full error log is 1396k in size - If you need it just
> let me know.

I don't quite understand who you tried to build this... manually or
using the openvpn-build/msvc.
If you try to build manually, please send me the exact commands you used.

>
> Samuli
>
> [1] =C2=A0<git://openvpn.git.sourceforge.net/gitroot/openvpn/openvpn.git>
> [2] <https://github.com/alonbl/openvpn-build.git>
> [3] <http://pastie.org/3780063>
> [4] <http://pastie.org/3780024>

Thanks!
Alon.

