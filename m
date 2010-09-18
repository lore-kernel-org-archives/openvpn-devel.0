MIME-Version: 1.0
In-Reply-To: <AANLkTin2N8TOJ9H+kDFVojiTaaG+AxM+dNc9xFM9XpuF@...278...>
References: <AANLkTin2N8TOJ9H+kDFVojiTaaG+AxM+dNc9xFM9XpuF@...278...>
Date: Sat, 18 Sep 2010 20:49:58 +0200
Message-ID: <AANLkTi=38x2QcHWWZ4B3rcVjDHh36E=haRM=wWJPy-pw@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] Windows build was messed up!
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
To: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

Samuli,
Please peek this up.
Thanks.

On Mon, Sep 13, 2010 at 6:21 PM, Alon Bar-Lev <alon.barlev@...277...> wrote:
> Hello,
>
> Does anyone know why the socklet_t detection was added this way?
>
> I mean the TYPE_SOCKLEN_T m4 macro.
>
> First, it should be sufficient to just try to see if socklen_t is defined.
> Next, on all platforms it would be int in all other platforms.
> And, there is no need to check for the type in monolitic environment
> like Windows, as it will be always the same.
>
> Currently it fails cross compile windows in mingw-w64 compiler, as
> winsock.h is as follows:
> """
> /* define WINSOCK_API_LINKAGE and WSAAPI for less
> =C2=A0* diff output between winsock.h and winsock2.h, but
> =C2=A0* remember to undefine them at the end of file */
> """
> And the macro uses these macros which are internal winsock macros and
> should not be used anyway.
>
> Also, when did the autodefs.h went mandatory? Why is it in
> tap-win32/common.h while no constant is actually used?
>
> The use of WSA_IO_INCOMPLETE without including winsock2.h is invalid!
> Look at [1].
>
> Attached is a patch to solve all these issues for now. Apply to both 2.1,=
 2.2.
>
> The whole build environment of openvpn is malformed, using two
> separate build systems for windows and posix, invalid use of autoconf,
> and the mixture of different projects: openvpn, tap, windows
> installer, easy-rsa.
>
> Alon.
>
> [1] http://msdn.microsoft.com/en-us/library/aa921087.aspx
>

