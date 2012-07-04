Message-ID: <4FF43DD9.3030007@...515...>
Date: Wed, 04 Jul 2012 15:58:01 +0300
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050208030805090805050202"
Subject: [Openvpn-devel] OpenVPN 2.3_alpha2 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>, "openvpn-announce@lists.sourceforge.net" <openvpn-announce@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------050208030805090805050202
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

The OpenVPN community project team is proud to release OpenVPN
2.3_alpha2. It can be downloaded from here:

<http://openvpn.net/index.php/open-source/downloads.html>

The largest change in OpenVPN 2.3_alpha2 is the split into several
subprojects (thanks go to Alon Bar-Lev):

- openvpn (the core project)
- tap-windows (Windows TAP-driver)
- easy-rsa (PKI management package)
- openvpn-build (external buildsystem)
  - "generic": cross-compile on *NIX platforms (e.g. Linux -> Windows)
  - "msvc": build using MSVC on Windows
  - "windows-nsis": generate Windows installers on *NIX

These changes have resulted in a number of user-visible changes:

- Separate 32- and 64-bit installers for Windows (see INSTALL-win32.txt)
- Old "domake-win" and Python-based buildsystems have been removed
- "easy-rsa" and "tap-windows" removed from the OpenVPN Git tree
- All Windows executables and libraries cross-compiled with mingw_w64
and signed
- Rewrite of the openvpn autotools buildsystem

In addition, there a number of changes not related to the above:

- Many bugfixes
- Stabilized the PolarSSL support
- Enabled IPv6 support on OSX
- General code cleanup
- Improved UTF-8 support in Windows

Note that a few changes have been made which may affect existing
installations. A list of new features and the changelog are available here:

<https://community.openvpn.net/openvpn/wiki/ChangesInOpenvpn23>

The changelog is also attached to this email.

For generic help use these support channels:

- Official documentation:
<http://openvpn.net/index.php/open-source/documentation/howto.html>
- Wiki: <https://community.openvpn.net>
- Forums: <https://forums.openvpn.net>
- User mailing list: <http://sourceforge.net/mail/?group_id=3D48978>
- User IRC channel: #openvpn at irc.freenode.net

Please report bugs and ask development questions here:

- Bug tracker and Wiki: <https://community.openvpn.net>
- Developer mailing list: <http://sourceforge.net/mail/?group_id=3D48978>
- Developer IRC channel: #openvpn-devel at irc.freenode.net (requires
  Freenode registration)

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

--------------050208030805090805050202
Content-Type: text/plain; charset=UTF-8; name="openvpn-2.3_alpha2-changes.txt"
Content-Disposition: attachment;
 filename="openvpn-2.3_alpha2-changes.txt"
Content-Transfer-Encoding: quoted-printable

Adriaan de Jong (11):
      Fixed off-by-one in serial length calculation
      Migrated x509_get_subject to use of the garbage collector
      Migrated x509_get_serial to use the garbage collector
      Migrated x509_get_sha1_hash to use the garbage collector
      Ensure sys/un.h autoconf detection includes sys/socket.h
      Added support for new PolarSSL 1.1 RNG
      Added a configuration option to enable prediction resistance in the=
 PolarSSL random number generator.
      Use POLARSSL_CFLAGS instead of POLARSSL_CRYPTO_CFLAGS in configure.=
ac
      Removed support for PolarSSL < 1.1
      Updated README.polarssl with build system changes.
      Removed stray "Fox-IT hardening" string.

Alon Bar-Lev (94):
      build: version should not contain '-'
      package: rpm: strip should be handled by package management
      cleanup: options.c: remove redundant include
      cleanup: remove C++ warnings
      cleanup: win32.c: wrong printf format
      cleanup: remove redundant ';'
      cleanup: crypto_openssl.c: remove support for pre-openssl-0.9.6
      cleanup: tun.c: fix incorrect option in message (ip-win32)
      cleanup: memcmp.c: remove unused source
      fixup: init.c: add missing conditional for ENABLE_CLIENT_CR
      build: correct place to alter WINVER is at build system
      Update .gitignore
      build: handle printf style format in mingw
      build: rename plugin directory to plugins
      build: plugins: properly use CC, CFLAGS and LDFLAGS
      build: we need the sample.ovpn in future
      Remove install-win32
      Remove easy-rsa
      Remove tap-win32
      cleanup: rename tap-windows function from win32 to win
      build: remove windows specific build system
      build: split acinclude.m4 into m4/*
      build: m4/ax_varargs.m4: cleanup
      build: m4/ax_emptyarray.m4: cleanup
      build: m4/ax_socklen_t.m4: cleanup
      build: autotools: first pass of trivial autotools changes
      build: autoconf: remove OPENVPN_ADD_LIBS useless macro
      build: remove awk and non-standard autoconf output processing
      build: standard directory layout
      build: add libtool + windows resources for executables
      build: autoconf: commands as environment
      build: libdl usage
      build: properly detect and use socket libs
      build: autoconf: minor cleanups
      build: proper selinux detection and usage
      build: distribute pkg.m4
      build: proper pkcs11-helper detection and usage
      build: properly process lzo-stub
      build: proper lzo detection and usage
      build: proper crypto detection and usage
      build: autoconf: update defaults for options
      build: win-msvc: msbuild format
      build: move out config.h include from syshead
      build: split out compat
      build: move gettimeofday() emulation to compat
      build: move daemon() emulation into compat
      build: move inet_ntop(), inet_pton() emulation into compat
      cleanup: move console related function into its own module
      build: move wrappers into platform module
      build: windows: install version.sh to allow installer read version
      build: distribute samples in windows
      build: use tap-windows.h as external dependency
      build: ax_varargs.m4: fixups
      build: autoconf: misc sockets fixups
      build: enable lzo by default
      build: windows: set vendor to openvpn project + cleanups
      build: assume dlfcn is available on all supported platforms
      build: openbsd: detect netinet/ip.h correctly
      build: tap: search for tap header
      build: msvc: upgrade to Visual Studio 2010 + fixups
      Enable pedantic in windows compilation
      cleanup: flags should not be bool
      cleanup: avoid using ~0 - generic
      cleanup: avoid using ~0 - ipv6
      cleanup: avoid using ~0 - netmask
      cleanup: avoid using ~0 - windows
      cleanup: gc usage
      build: fix some statement left from conversion
      build: properly detect netinet/ip.h structs
      build: properly detect TUNSETPERSIST
      cleanup: plugin: support C++ plugin
      cleanup: remove C++ comments
      cleanup: add .gitattributes to control eol style explicitly
      crash: packet_id_debug_print: sl may be null
      build: use stdbool.h if available
      build: fix typo in --enable-save-password
      build: windows: convert resources to UTF-8
      build: check minimum polarssl version
      cleanup: update .gitignore
      cleanup: spec: make space/tab consistent
      build: spec: we support openssl >=3D 0.9.7
      build: insall README* document using build system
      build: detect sys/wait.h required for *bsd
      build: add git revision to --version output if build from git repos=
itory
      build: cleanup: yet another forgotten brackets
      build: update INSTALL to recent changes
      build: support platforms that does not need explicit tun headers
      build: do not support <polarssl-1.1.0
      build: add --with-special-build to provide special build string
      cleanup: pkcs11.c: resolve wanings
      build: integrate plugins build into core build
      build: plugins: set defaults based on platform
      cleanup: windows: convert argv (UCS-2 to UTF-8) at earliest
      build: msvc: chdir with change drive to script location

Arne Schwabe (7):
      Add the query to the error message. Makes the diagnose what went wr=
ong from logs easier.
      Explain that route-nopull also causes the client to ignore dhcp opt=
ions.
      Add the name of the context where option is not allowed to the erro=
r message.
      Only use tmpdir if tmp_dir is really used.
      Completely remove ancient IANA port warning.
      Remove ENABLE_INLINE_FILES conditionals
      Remove ENABLE_CONNECTIONS ifdefs

David Sommerseth (7):
      Clean-up: Presume that Linux is always IPv6 capable at build time
      Simplify check_cmd_access() function
      Change version to indicate the master branch is not a version
      Some filesystems don't like ':', which is a path 'make dist' would =
use
      Remove two unused functions
      Prepare the OpenVPN v2.3_alpha2 release
      Set the correct version number - 2.3_alpha2

Frank de Brabander (1):
      Fix reported compile issues on OSX 10.6.8

Gert Doering (10):
      repair t_client.sh test after build system revolution
      t_client.sh iproute2 script fixes
      t_client.sh - fix for iproute2, print summary line
      Implement search for "first free" tun/tap device on Solaris
      cleanup and redefine metric handling for IPv6 routes
      remove "*option" element in "struct route_ipv6"
      Remove warning about "explicit support for IPv6 tun devices is not =
provided for this OS" for MacOS X (because it *is*).
      Add missing pieces to IPv6 route gateway handling.
      Update TODO.IPv6 list
      Remove #include "config.h" from ssl_polarssl.h

Heiko Hund (3):
      remove wrapper code for Windows CryptoAPI function
      fix warnings in event.c when building for win32-64
      remove the --auto-proxy option from openvpn

Igor Novgorodov (1):
      Remove calls to OpenSSL when building with --disable-ssl

Jonathan K. Bullard (2):
      Fix file access checks on commands
      Clarified the docs and help screen about what a 'cmd' is

Samuli Sepp=C3=A4nen (1):
      Added notes about upgrading from 2.3-alpha1 and earlier to INSTALL-=
win32.txt


--------------050208030805090805050202--

