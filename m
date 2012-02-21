MIME-Version: 1.0
Date: Tue, 21 Feb 2012 08:47:36 +0100
Message-ID: <CAOBzU4PN6qDxf39+s4noXEiW8hNbDy-hkQWGSauBd3hX0pu2hw@...278...>
From: Frank de Brabander <debrabander@...277...>
Subject: Re: [Openvpn-devel] [PATCH 00/35] build revolution
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

I did a quick test on OS X (Lion) and the build fails.

mekboek:openvpn_src brabander$ git clone --branch build
https://github.com/alonbl/openvpn.git openvpn_alonbl
mekboek:openvpn_src brabander$ cd openvpn_alonbl/
mekboek:openvpn_alonbl brabander$ autoreconf -i -v
autoreconf: Entering directory `.'
autoreconf: configure.ac: not using Gettext
autoreconf: running: aclocal -I m4
configure.ac:337: warning: AC_CACHE_VAL(VAR, ...): suspicious presence
of an AC_DEFINE in the second argument, where no actions should be
taken
/private/var/tmp/autoconf/autoconf-17.1~539/SRC/autoconf/lib/autoconf/general.m4:1905:
AC_CACHE_VAL is expanded from...
/private/var/tmp/autoconf/autoconf-17.1~539/SRC/autoconf/lib/autoconf/general.m4:1918:
AC_CACHE_CHECK is expanded from...
/private/var/tmp/autoconf/autoconf-17.1~539/SRC/autoconf/lib/m4sugar/m4sh.m4:523:
AS_IF is expanded from...
/private/var/tmp/autoconf/autoconf-17.1~539/SRC/autoconf/lib/autoconf/types.m4:243:
AC_CHECK_TYPE is expanded from...
m4/ax_socklen_t.m4:63: AX_TYPE_SOCKLEN_T is expanded from...
configure.ac:337: the top level
autoreconf: configure.ac: tracing
configure.ac:337: warning: AC_CACHE_VAL(VAR, ...): suspicious presence
of an AC_DEFINE in the second argument, where no actions should be
taken
/private/var/tmp/autoconf/autoconf-17.1~539/SRC/autoconf/lib/autoconf/general.m4:1905:
AC_CACHE_VAL is expanded from...
/private/var/tmp/autoconf/autoconf-17.1~539/SRC/autoconf/lib/autoconf/general.m4:1918:
AC_CACHE_CHECK is expanded from...
/private/var/tmp/autoconf/autoconf-17.1~539/SRC/autoconf/lib/m4sugar/m4sh.m4:523:
AS_IF is expanded from...
/private/var/tmp/autoconf/autoconf-17.1~539/SRC/autoconf/lib/autoconf/types.m4:243:
AC_CHECK_TYPE is expanded from...
m4/ax_socklen_t.m4:63: AX_TYPE_SOCKLEN_T is expanded from...
configure.ac:337: the top level
autoreconf: running: glibtoolize --copy
glibtoolize: putting auxiliary files in AC_CONFIG_AUX_DIR, `.'.
glibtoolize: copying file `./ltmain.sh'
glibtoolize: putting macros in AC_CONFIG_MACRO_DIR, `m4'.
glibtoolize: copying file `m4/libtool.m4'
glibtoolize: copying file `m4/ltoptions.m4'
glibtoolize: copying file `m4/ltsugar.m4'
glibtoolize: copying file `m4/ltversion.m4'
glibtoolize: copying file `m4/lt~obsolete.m4'
configure.ac:337: warning: AC_CACHE_VAL(VAR, ...): suspicious presence
of an AC_DEFINE in the second argument, where no actions should be
taken
/private/var/tmp/autoconf/autoconf-17.1~539/SRC/autoconf/lib/autoconf/general.m4:1905:
AC_CACHE_VAL is expanded from...
/private/var/tmp/autoconf/autoconf-17.1~539/SRC/autoconf/lib/autoconf/general.m4:1918:
AC_CACHE_CHECK is expanded from...
/private/var/tmp/autoconf/autoconf-17.1~539/SRC/autoconf/lib/m4sugar/m4sh.m4:523:
AS_IF is expanded from...
/private/var/tmp/autoconf/autoconf-17.1~539/SRC/autoconf/lib/autoconf/types.m4:243:
AC_CHECK_TYPE is expanded from...
m4/ax_socklen_t.m4:63: AX_TYPE_SOCKLEN_T is expanded from...
configure.ac:337: the top level
autoreconf: running: /usr/bin/autoconf
configure.ac:337: warning: AC_CACHE_VAL(VAR, ...): suspicious presence
of an AC_DEFINE in the second argument, where no actions should be
taken
/private/var/tmp/autoconf/autoconf-17.1~539/SRC/autoconf/lib/autoconf/general.m4:1905:
AC_CACHE_VAL is expanded from...
/private/var/tmp/autoconf/autoconf-17.1~539/SRC/autoconf/lib/autoconf/general.m4:1918:
AC_CACHE_CHECK is expanded from...
/private/var/tmp/autoconf/autoconf-17.1~539/SRC/autoconf/lib/m4sugar/m4sh.m4:523:
AS_IF is expanded from...
/private/var/tmp/autoconf/autoconf-17.1~539/SRC/autoconf/lib/autoconf/types.m4:243:
AC_CHECK_TYPE is expanded from...
m4/ax_socklen_t.m4:63: AX_TYPE_SOCKLEN_T is expanded from...
configure.ac:337: the top level
configure.ac:31: error: possibly undefined macro: AC_DEFINE
      If this token and others are legitimate, please use m4_pattern_allow.
      See the Autoconf documentation.
configure.ac:545: error: possibly undefined macro: AC_CHECK_LIB
configure:14349: error: possibly undefined macro: AS_VAR_IF
autoreconf: /usr/bin/autoconf failed with exit status: 1

