Date: Mon, 26 Mar 2012 11:36:30 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120326093629.GN1359@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="P8VDRTGkfyc6BSVj"
Content-Disposition: inline
Subject: [Openvpn-devel] build problems on FreeBSD of latest openvpn git
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--P8VDRTGkfyc6BSVj
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

buildbot tried to build openvpn after David's merge yesterday, and failed
miserably.  To see what happened I tried to reproduce on my FreeBSD 7.4
build slave, and found this, in a fresh git clone:

gert@...1703...:/home/gert$ git clone git://openvpn.git.sourceforge.net/git=
root/openvpn/openvpn.git
...
gert@...1703...:/home/gert/openvpn$ autoreconf -vi
autoreconf-2.68: Entering directory `.'
autoreconf-2.68: configure.ac: not using Gettext
autoreconf-2.68: running: aclocal -I m4
autoreconf-2.68: configure.ac: tracing
autoreconf-2.68: configure.ac: not using Libtool
autoreconf-2.68: running: /usr/local/bin/autoconf-2.68
configure.ac:328: error: possibly undefined macro: AC_LIBTOOL_WIN32_DLL
      If this token and others are legitimate, please use m4_pattern_allow.
      See the Autoconf documentation.
configure.ac:329: error: possibly undefined macro: AC_LIBTOOL_RC
configure.ac:330: error: possibly undefined macro: AC_PROG_LIBTOOL
autoreconf-2.68: /usr/local/bin/autoconf-2.68 failed with exit status: 1

running this again:

gert@...1703...:/home/gert/openvpn$ autoreconf -vi
autoreconf-2.68: Entering directory `.'
autoreconf-2.68: configure.ac: not using Gettext
autoreconf-2.68: running: aclocal -I m4
autoreconf-2.68: configure.ac: tracing
autoreconf-2.68: configure.ac: not using Libtool
autoreconf-2.68: running: /usr/local/bin/autoconf-2.68
autoreconf-2.68: running: /usr/local/bin/autoheader-2.68
autoreconf-2.68: running: automake --add-missing --copy --no-force
configure.ac:39: installing `./config.guess'
configure.ac:39: installing `./config.sub'
configure.ac:38: installing `./install-sh'
configure.ac:38: installing `./missing'
src/compat/Makefile.am:18: Libtool library used but `LIBTOOL' is undefined
src/compat/Makefile.am:18:   The usual way to define `LIBTOOL' is to add `A=
C_PROG_LIBTOOL'
src/compat/Makefile.am:18:   to `configure.ac' and run `aclocal' and `autoc=
onf' again.
src/compat/Makefile.am:18:   If `AC_PROG_LIBTOOL' is in `configure.ac', mak=
e sure
src/compat/Makefile.am:18:   its definition is in aclocal's search path.
src/compat/Makefile.am: installing `./depcomp'
autoreconf-2.68: automake failed with exit status: 1

This upsets buildbot, because it expects "autoreconf" to run through - so
it fails in the "git clone, autoreconf" phase.


It does create a working "configure", though, so when I try to build
from it, something more happens

gert@...1703...:/home/gert/test$ ../openvpn/configure
...
checking for SSL_CTX_new in -lssl... yes
checking for EVP_CIPHER_CTX_set_key_length... yes
checking for ENGINE_load_builtin_engines... yes
checking for ENGINE_register_all_complete... yes
checking for ENGINE_cleanup... yes
checking for ssl_init in -lpolarssl... no
checking for aes_crypt_cbc in -lpolarssl... no
checking for lzo1x_1_15_compress in -llzo2... yes
checking lzo/lzoutil.h usability... yes
checking lzo/lzoutil.h presence... yes
checking for lzo/lzoutil.h... yes
checking lzo/lzo1x.h usability... yes
checking lzo/lzo1x.h presence... yes
checking for lzo/lzo1x.h... yes
checking for PKCS11_HELPER... no
configure: error: libdl is required for plugins

Now, this needs fixing - there is no libdl on FreeBSD, because dlopen()
and friends are part of libc:

----------------------------------------------------------------------------
DLOPEN(3)              FreeBSD Library Functions Manual              DLOPEN=
(3)

NAME
     dlopen, dlsym, dlfunc, dlerror, dlclose -- programmatic interface to t=
he
     dynamic linker

LIBRARY
     Standard C Library (libc, -lc)
----------------------------------------------------------------------------

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--P8VDRTGkfyc6BSVj
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT3A4nakuBuNlUUl1AQLv1gP+JGssN7RcLEDOZCMpes2ro78l48xOgIa5
lIYmv7knxkDH5efpDj/W8IV2CsGfVvRbr3UTk0FGG593T+9j4FUApDlZojW68fDC
zB2bxy6FpNt1i8s1LwAO9yt8yfWfeVdXLSW+PfSile+dbNwQwUVx8VtfuI1f5JxF
Rm/An49YaBw=
=6TZs
-----END PGP SIGNATURE-----

--P8VDRTGkfyc6BSVj--

