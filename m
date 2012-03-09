MIME-Version: 1.0
In-Reply-To: <CABT9mj_+3KRELoLQBGK5B14Q=Y_HGGjS48E6bEWnDPuCwBXgtw@...278...>
References: <CABT9mj_+3KRELoLQBGK5B14Q=Y_HGGjS48E6bEWnDPuCwBXgtw@...278...>
Date: Fri, 9 Mar 2012 19:08:21 +0200
Message-ID: <CAOazyz0zS1WjVrLv1u22ZN+cr18ewuzeZnc-5PrSHjss1Cn=ew@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] mingw32-built openvpn-2.3-alpha1
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
To: Athanasios Douitsis <aduitsis@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Hello,

I am just in the process of rewriting the openvpn build system.

Some documentation is available[1].

In your case, as you build on Windows, cygwin environment is the
appropriate environment. cygwin contains the new mingw toolchain from
mingw-w64 (including 32bit).

cygwin is maintain, while msys is long dead.

Please try it out.

Thanks,
Alon Bar-Lev.

[1] https://community.openvpn.net/openvpn/wiki/BuildingUsingGenericBuildsys=
tem

On Fri, Mar 9, 2012 at 6:51 PM, Athanasios Douitsis <aduitsis@...277...> wr=
ote:
> Hi everyone,
>
> First of all, let me say that I am delighted to see 2.3 approaching final
> release. This is truly great.
>
> Just wanted to let you know that there may be some rough edges when trying
> to use the source tarball to compile openvpn using mingw32. I suppose nob=
ody
> uses mingw anymore, so this not too important, but anyway:
>
> 1.To get pass the ./configure phase in makeopenvpn, I had to insert a
> CFLAGS=3D' -I /c/mingw/include/ddk' before the ./configure invocation. The
> following check:
>
> dnl ipv6 support
> AC_CHECKING([for struct sockaddr_in6 for IPv6 support])
> AC_CHECK_TYPE(
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [struct sockaddr_in6],
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [],
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [AC_MSG_ERROR([struct sockaddr_in6 not fou=
nd, needed for ipv6
> transport support.])],
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [#include "syshead.h"])
>
> in configure.ac could not find the ntddndis.h (located among other places=
 in
> /c/mingw/include/ddk) which is included in syshead.h:357. Maybe the
> configure.ac needs a little change but I'm not sure what change exactly.
> Note, my installation used to be able to compile everything up to 2.2.1
> without tinkering. Since these headers are a seemingly new requirement,
> maybe a new command line option is needed in the configure script?
>
> 2.There is also a small error in makeopenvpn, in line 59, instead of GENO=
UT,
> it says GENOOUT. Which, of course, leads to breakage :) Easily fixed, that
> one.
> 3.Also, compiling OpenSSL from the source package leads to lib/ and bin/
> directories under the openssl target path, so the relevant openvpn script
> (getopenssl) needs adjustment. Attaching my version for your reference. T=
his
> is not strictly an error, just letting everyone know.
>
> Best Regards,
> --
> Athanasios Douitsis
>
>
>
>
> -------------------------------------------------------------------------=
-----
> Virtualization & Cloud Management Using Capacity Planning
> Cloud computing makes use of virtualization - but cloud computing
> also focuses on allowing computing to be delivered as a service.
> http://www.accelacomm.com/jaw/sfnl/114/51521223/
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

