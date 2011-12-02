MIME-Version: 1.0
In-Reply-To: <08FAFA87DB33410B973A78243D6791E6@...139...>
References: <1322828243-21196-1-git-send-email-davids@...1347...>
	<CAOazyz3QLENvuKcchda6sooFJCF60zT=AnrfhGnaXAhyHDBkPA@...278...>
	<08FAFA87DB33410B973A78243D6791E6@...139...>
Date: Fri, 2 Dec 2011 15:01:34 +0200
Message-ID: <CAOazyz2H-xL0e1yAjrt0aTfw2HJVrAZ0-HWZm0zLiE=R4zLuUw@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH v2] Provide an access() wrapper for
	Windows
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
To: Gisle Vanem <gvanem@...139...>
Cc: openvpn-devel@lists.sourceforge.net

If using mingw there is no reason why not use autoconf/automake.
If using MSVC you know what you get.

This is how I see it:

config-msvc.h
#define HAVE_ACCESS 1
#define access _access

compat.h
#ifndef HAVE_ACCESS
int access(...);
#endif

compat.c
#ifndef HAVE_ACCESS
int access(...) {
}
#endif

At every file:
#ifdef HAVE_CONFIG_H
#include <config.h>
#elif defined(_MSC_VER)
#include <config-msvc.h>
#endif

On Fri, Dec 2, 2011 at 2:54 PM, Gisle Vanem <gvanem@...139...> wrote:
>
> "Alon Bar-Lev" <alon.barlev@...277...> wrote:
>
> > Why not:
> > #ifdef WIN32
> > #define access _access
> > #endif
>
> We should write "#ifndef _MSC_VER". MingW's access() handles
> X_OK correctly. From MingW's <io.h>:
>
> #ifdef __USE_MINGW_ACCESS
> /* =C2=A0Old versions of MSVCRT access() just ignored X_OK, while the ver=
sion
> =C2=A0 =C2=A0shipped with Vista, returns an error code. =C2=A0This will r=
estore the
> =C2=A0 =C2=A0old behaviour =C2=A0*/
> static inline int __mingw_access (const char* __fname, int __mode)
> =C2=A0{ return =C2=A0_access (__fname, __mode & ~X_OK); }
> #define access(__f,__m) =C2=A0__mingw_access (__f, __m)
> #endif
>
> --gv
>
>
>
> -------------------------------------------------------------------------=
-----
> All the data continuously generated in your IT infrastructure
> contains a definitive record of customers, application performance,
> security threats, fraudulent activity, and more. Splunk takes this
> data and makes sense of it. IT sense. And common sense.
> http://p.sf.net/sfu/splunk-novd2d
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

