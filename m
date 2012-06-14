Date: Thu, 14 Jun 2012 16:44:54 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120614144454.GX1059@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KxKI/R+N9hudrWbn"
Content-Disposition: inline
Subject: [Openvpn-devel] ENABLE_PF and config.h breakage
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--KxKI/R+N9hudrWbn
Content-Type: multipart/mixed; boundary="eNjIDde0W37E3OQP"
Content-Disposition: inline

--eNjIDde0W37E3OQP
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

openvpn-devel in the current openwrt tree is broken, due to upstream-
breakage.

For the record, it's built like this:

  $ ./configure --target=3Dmips-openwrt-linux --host=3Dmips-openwrt-linux -=
-build=3Di686-pc-linux-gnu --program-prefix=3D --program-suffix=3D --prefix=
=3D/usr --exec-prefix=3D/usr --bindir=3D/usr/bin --sbindir=3D/usr/sbin --li=
bexecdir=3D/usr/lib --sysconfdir=3D/etc --datadir=3D/usr/share --localstate=
dir=3D/var --mandir=3D/usr/man --infodir=3D/usr/info --disable-nls --enable=
-small --disable-selinux --disable-systemd --disable-plugins --disable-debu=
g --disable-eurephia --disable-pkcs11 --enable-lzo --disable-crypto disable=
-x509-alt-username-ssl --enable-server --disable-management --enable-socks =
--enable-http --enable-fragment --enable-multihome --disable-iproute2 --ena=
ble-def-auth --enable-pf --enable-ssl --enable-crypto --with-crypto-library=
=3Dpolarssl

... and the real breakage is the combination of --enable-pf,
--disable-plugins, --disable-management and --with-crypto-library=3Dpolarss=
l.

What this will do is:

 - config.h defines ENABLE_PF

/* Enable internal packet filter */
#define ENABLE_PF 1

 - syshead.h turns it off again

#if defined(ENABLE_DEF_AUTH) && P2MP_SERVER && defined(ENABLE_MANAGEMENT)
#define MANAGEMENT_DEF_AUTH
#endif
...
/*
 * Enable packet filter?
 */
#if defined(ENABLE_PF) && P2MP_SERVER && defined(ENABLE_PLUGIN) && defined(=
HAVE_STAT)
#define PLUGIN_PF
#endif
#if defined(ENABLE_PF) && P2MP_SERVER && defined(MANAGEMENT_DEF_AUTH)
#define MANAGEMENT_PF
#endif
#if !defined(PLUGIN_PF) && !defined(MANAGEMENT_PF)
#undef ENABLE_PF
#endif

 - so pf.c gets compiled into an empty pf.o module (all ok)

 - now, init.c does more interesting things

    - include "config.h" -> #define ENABLE_PF 1
    - include "syshead.h" -> #undef ENABLE_PF
    - include "init.h"
        include "openvpn.h"
	   include "ssl.h"
	      include "ssl_backend.h"
		 include "ssl_polarssl.h"
		    include "config.h"  --> #define ENABLE_PF 1

 - so init.c and multi.c get compiled with the function calls towards
   pf.c, but pf.o is empty -> linker fails

This cannot be triggered with --disable-pf, or OpenSSL (because ssl_openssl=
.h
does not include config.h), or if either plugins or management are enabled.


The quick fix is "remove config.h from ssl_polarssl.h" - because all .c
modules right now include this anyway, as the first thing, including all=20
SSL modules.  I would propose to do that right away (patch attached), but
would like confirmation from Adriaan that I'm not overlooking anything.

The "right" fix is manyfold (and I think I'll agree with Alon here)

 - stop calling our own include files many layers deep

 - stop modifying config.h variables from sysdep.h - if we want to
   override ENABLE_PF depending on other options, let's do it in
   configure

 - cleanup the amazing heap of #ifdefs in sysdep.h

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--eNjIDde0W37E3OQP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-Remove-include-config.h-from-ssl_polarssl.h.patch"
Content-Transfer-Encoding: quoted-printable

=46rom ac9a8b9ea08a52f7afbfa6a80ea3e6eed20e26e2 Mon Sep 17 00:00:00 2001
From: Gert Doering <gert@...1296...>
Date: Thu, 14 Jun 2012 16:41:37 +0200
Subject: [PATCH] Remove #include "config.h" from ssl_polarssl.h

This include is superfluous, as all callers already include config.h -
and under certain combinations of configure options and syshead.h

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/ssl_polarssl.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/src/openvpn/ssl_polarssl.h b/src/openvpn/ssl_polarssl.h
index 2b02a6f..456573f 100644
--- a/src/openvpn/ssl_polarssl.h
+++ b/src/openvpn/ssl_polarssl.h
@@ -31,7 +31,6 @@
 #define SSL_POLARSSL_H_
=20
 #include <polarssl/ssl.h>
-#include "config.h"
=20
 #if defined(ENABLE_PKCS11)
 #include <polarssl/pkcs11.h>
--=20
1.7.3.4


--eNjIDde0W37E3OQP--

--KxKI/R+N9hudrWbn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBT9n45akuBuNlUUl1AQIoXAP+OVh4+EMdSuXeN/QhE1UFYvITKzolPOJm
qsWdLuRHE9LnVnylwl/U1c0Gy2wm71+hnlpMQXQ1vL/NjmPorY5koAWhC0yc7MrO
HIfEVYti+qOWlnu496PyYBtxNZ6502Z8DPWhF+z0qSv2KV9PtH2JVzN6sk+6zBbm
IbKmSOfa+CQ=
=q1Th
-----END PGP SIGNATURE-----

--KxKI/R+N9hudrWbn--

