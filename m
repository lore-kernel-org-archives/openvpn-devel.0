Message-ID: <4FDB16D3.7080309@...1114...>
Date: Fri, 15 Jun 2012 13:04:51 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <20120614144454.GX1059@...1296...>
In-Reply-To: <20120614144454.GX1059@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB13442BA50863F5681E03A36"
Subject: Re: [Openvpn-devel] ENABLE_PF and config.h breakage
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB13442BA50863F5681E03A36
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 14/06/12 16:44, Gert Doering wrote:
> Hi,
>=20
> openvpn-devel in the current openwrt tree is broken, due to upstream-
> breakage.
>=20
> For the record, it's built like this:
>=20
>   $ ./configure --target=3Dmips-openwrt-linux --host=3Dmips-openwrt-linux=
 --build=3Di686-pc-linux-gnu --program-prefix=3D --program-suffix=3D --pref=
ix=3D/usr --exec-prefix=3D/usr --bindir=3D/usr/bin --sbindir=3D/usr/sbin --=
libexecdir=3D/usr/lib --sysconfdir=3D/etc --datadir=3D/usr/share --localsta=
tedir=3D/var --mandir=3D/usr/man --infodir=3D/usr/info --disable-nls --enab=
le-small --disable-selinux --disable-systemd --disable-plugins --disable-de=
bug --disable-eurephia --disable-pkcs11 --enable-lzo --disable-crypto disab=
le-x509-alt-username-ssl --enable-server --disable-management --enable-sock=
s --enable-http --enable-fragment --enable-multihome --disable-iproute2 --e=
nable-def-auth --enable-pf --enable-ssl --enable-crypto --with-crypto-libra=
ry=3Dpolarssl
>=20
> ... and the real breakage is the combination of --enable-pf,
> --disable-plugins, --disable-management and --with-crypto-library=3Dpolar=
ssl.
>=20
> What this will do is:
>=20
>  - config.h defines ENABLE_PF
>=20
> /* Enable internal packet filter */
> #define ENABLE_PF 1
>=20
>  - syshead.h turns it off again
>=20
> #if defined(ENABLE_DEF_AUTH) && P2MP_SERVER && defined(ENABLE_MANAGEMENT)
> #define MANAGEMENT_DEF_AUTH
> #endif
> ...
> /*
>  * Enable packet filter?
>  */
> #if defined(ENABLE_PF) && P2MP_SERVER && defined(ENABLE_PLUGIN) && define=
d(HAVE_STAT)
> #define PLUGIN_PF
> #endif
> #if defined(ENABLE_PF) && P2MP_SERVER && defined(MANAGEMENT_DEF_AUTH)
> #define MANAGEMENT_PF
> #endif
> #if !defined(PLUGIN_PF) && !defined(MANAGEMENT_PF)
> #undef ENABLE_PF
> #endif
>=20
>  - so pf.c gets compiled into an empty pf.o module (all ok)
>=20
>  - now, init.c does more interesting things
>=20
>     - include "config.h" -> #define ENABLE_PF 1
>     - include "syshead.h" -> #undef ENABLE_PF
>     - include "init.h"
>         include "openvpn.h"
> 	   include "ssl.h"
> 	      include "ssl_backend.h"
> 		 include "ssl_polarssl.h"
> 		    include "config.h"  --> #define ENABLE_PF 1
>=20
>  - so init.c and multi.c get compiled with the function calls towards
>    pf.c, but pf.o is empty -> linker fails
>=20
> This cannot be triggered with --disable-pf, or OpenSSL (because ssl_opens=
sl.h
> does not include config.h), or if either plugins or management are enable=
d.
>=20
>=20
> The quick fix is "remove config.h from ssl_polarssl.h" - because all .c
> modules right now include this anyway, as the first thing, including all=
=20
> SSL modules.  I would propose to do that right away (patch attached), but
> would like confirmation from Adriaan that I'm not overlooking anything.
>=20
> The "right" fix is manyfold (and I think I'll agree with Alon here)
>=20
>  - stop calling our own include files many layers deep
>=20
>  - stop modifying config.h variables from sysdep.h - if we want to
>    override ENABLE_PF depending on other options, let's do it in
>    configure
>=20
>  - cleanup the amazing heap of #ifdefs in sysdep.h

Applied to master.


commit dc4abbb3a8a184d9c696dbba90cdb98b7da70e77
Author: Gert Doering <gert@...1296...>
Date:   Thu Jun 14 16:41:37 2012 +0200

    Remove #include "config.h" from ssl_polarssl.h
=20=20=20=20
    This include is superfluous, as all callers already include config.h -
    and under certain combinations of configure options and syshead.h
=20=20=20=20
    Signed-off-by: Gert Doering <gert@...1296...>
    Acked-by: Alon Bar-Lev <alon.barlev@...277...>
    Message-Id: 20120614144454.GX1059@...1296...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/6723
    Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth


--------------enigB13442BA50863F5681E03A36
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/bFtYACgkQDC186MBRfroO1wCggfj2MO4kLpML7m8q10+j0W5D
b4cAn2MflaahvYGR06IrnG2VN7N7BTuJ
=zNiw
-----END PGP SIGNATURE-----

--------------enigB13442BA50863F5681E03A36--

