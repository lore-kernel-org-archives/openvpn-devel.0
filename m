Date: Sun, 18 Sep 2016 08:59:56 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160918065956.GY78279@...1296...>
References: <20160917132024.12570-1-gert@...1296...>
	<CAKuzo_jqgMNCqcbCHBLO7hHoa9aLDTj3Ed7UmJ446b2J++8BCw@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="e50TZzTjhnqO2fkm"
Content-Disposition: inline
In-Reply-To: <CAKuzo_jqgMNCqcbCHBLO7hHoa9aLDTj3Ed7UmJ446b2J++8BCw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Fix win32 building with C99 mode
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--e50TZzTjhnqO2fkm
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Sep 17, 2016 at 07:11:56PM -0400, Selva Nair wrote:
> On Sat, Sep 17, 2016 at 9:20 AM, Gert Doering <gert@...1296...> wrote:
>=20
> > In -std=3Dc99 mode, WIN32 is not defined to be "1" anymore, but just
> > "#define WIN32" - so the "#if WIN32" breaks, needs to be "#ifdef WIN32"
>=20
> Indeed...
>=20
> To depend on the compiler or system headers to define WIN32 was not a gre=
at
> idea anyway. Using  _WIN32 or __WIN32 is probably more reliable. Or we
> should define WIN32 in config.h. With std=3Dc99, it seems WIN32 gets defi=
ned
> by chance through some header pulled-in by syshead.h -- not something one
> can rely on.

Heiko says that "WIN32 is what everybody is testing for on Windows", so
that seems to be an official API define...

With c99, on mingw, the #define WIN32 comes from "minwindef.h", which
is included from "windef.h", which is included from "windows.h" -- but
I wonder how we ever include that in the first place, given this
code in syshead.h

#ifdef WIN32
#include <windows.h>
#include <winsock2.h>
#define sleep(x) Sleep((x)*1000)
#define random rand
#define srandom srand
#endif


... so maybe it is actually *never* set, even with my patch, and we just
do not know it's breaking because it's not linking...?


Ah.  Here we go... trying to redefine WIN32 at the end of syshead.h
shows what is happening:

In file included from /usr/share/mingw-w64/include/windef.h:8:0,
                 from /usr/share/mingw-w64/include/windows.h:69,
                 from /usr/share/mingw-w64/include/winsock2.h:23,
                 from ../../src/compat/compat.h:29,
                 from syshead.h:28,

so compat.h is pulling it via

#ifdef HAVE_WINSOCK2_H
#include <winsock2.h>
#endif

whee...


> Compiler-defined macros with std=3Dc99:
> $ x86_64-w64-mingw32-gcc -std=3Dc99 -E -dM - </dev/null | grep WIN32
> #define _WIN32 1
> #define __WIN32 1
> #define __WIN32__ 1
>=20
> As for a quick fix, the patch takes care of misc.c, but  there is an issue
> with block_dns.c as well. It does not include the required config.h and
> syshead.h at the top before #ifdef WIN32, so now the whole file gets
> skipped -- mea culpa, mea culpa...
>=20
> I think we can just remove #ifdef WIN32 from block_dns.c (its compiled on=
ly
> on Windows), and add config.h and syshead.h headers at the top. Then we
> also need -I$(top_srcdir)/src/compat in src/openvpnsev/Makefile.am as
> compat.h is included by syshead.h.

Do you have time to cook up & test such a patch?  Then I'll go and focus
a bit more on my windows testing environment in the meantime, and merge
the patch later today...

thanks,

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--e50TZzTjhnqO2fkm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBV947bKkuBuNlUUl1AQKeuQP/Szu6WKbxlgXHv1c5/k81wKbHvQNLGFiS
pLQmSpD5rUIG3DPjv4sodoY1LDyGPSwb2YldtDRlgpJW6dLzoc+sUOy8JMX8dkWv
Iyk6PkxXk5dLOflomoLI9YpE/ArMYrLzJkXwLs1jHD9a8rr5jz+XTtAnaBrgikmC
9vCVhJjrVGI=
=KssT
-----END PGP SIGNATURE-----

--e50TZzTjhnqO2fkm--

