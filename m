Date: Sat, 26 Apr 2014 20:41:42 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140426184131.GE16637@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="21wxXApbhHFpxH4c"
Content-Disposition: inline
Subject: [Openvpn-devel] IV_GUI_VER and the windows gui
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--21wxXApbhHFpxH4c
Content-Type: multipart/mixed; boundary="+u84DknIvDG47jDR"
Content-Disposition: inline

--+u84DknIvDG47jDR
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hiya,

"I thought this would be just an easy walk in the park", and then both
our build system and windows came to haunt me.

What I *want* is "have the windows gui send a string back to the
server that tells the server the version of the gui plus the installer".

Like in:

  IV_GUI_VER=3DOpenVPN_GUI_601_build_I901

what I get is:

  IV_GUI_VER=3D_____________________1____________1_____________________1

the "_"s are "non printable characters that the server converts to '_'=20
before passing to the shell or the log file"...


To actually get to this point, I had to patch both the gui source to
accept an extra string for the "build version" (GUI version alone is
not enough to identify a given client version) - attached as=20
  "0001-Accept-BUILD_STRING-from-caller-add-to-IV_GUI_VER-se.patch"=20

and the build system itself, attached as
  "0001-Pass-installer-version-to-openvpn-gui-building.patch"

... so now I have an openvpn-gui.exe that the shows all the strings
I want to have in there with "strings", but on the way to the command
line, the string seems to be massacred into a wide string (_sntprintf_0()=20
is a wrapper for _vsntprintf(), which expands to _vsnwprintf() if UNICODE
is defined, and that one seems to, well, create wide characters) that
openvpn.exe happily passes on, but the server cannot make sense of.

(Something else seems to go on, though, as the string length isn't exactly
doubled, and I had expected it to show every second character just fine)


So...

  ... any elegant ideas how to solve this?

(the patches are "work in progress", obviously, to see whether I could
get anywhere)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--+u84DknIvDG47jDR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-Accept-BUILD_STRING-from-caller-add-to-IV_GUI_VER-se.patch"
Content-Transfer-Encoding: quoted-printable

=46rom 396d34190f50865685188e1e9965725169422afc Mon Sep 17 00:00:00 2001
From: Gert Doering <gert@...1296...>
Date: Sat, 26 Apr 2014 20:31:41 +0200
Subject: [PATCH] Accept BUILD_STRING from caller, add to IV_GUI_VER setting

Signed-off-by: Gert Doering <gert@...1296...>
---
 Makefile.am |    2 +-
 openvpn.c   |    5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index c4d754c..668f769 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -39,7 +39,7 @@ dist_doc_DATA =3D \
=20
 INCLUDES =3D $(OPENSSL_CRYPTO_CFLAGS)
 AM_CPPFLAGS =3D -D_UNICODE
-AM_CFLAGS =3D -municode
+AM_CFLAGS =3D -municode -DBUILD_STRING=3D"\"$(BUILD_STRING)\""
=20
 openvpn_gui_RESOURCES =3D \
 	res/openvpn-gui-res.rc \
diff --git a/openvpn.c b/openvpn.c
index 79696f3..89d9601 100644
--- a/openvpn.c
+++ b/openvpn.c
@@ -684,9 +684,10 @@ StartOpenVPN(connection_t *c)
=20
     /* Construct command line */
     _sntprintf_0(cmdline, _T("openvpn --config \"%s\" "
-        "--setenv IV_GUI_VER \"%s\" --service %s 0 --log%s \"%s\" --auth-r=
etry interact "
+        "--setenv IV_GUI_VER \"%s%s\" --service %s 0 --log%s \"%s\" --auth=
-retry interact "
         "--management %S %hd stdin --management-query-passwords %s"
-        "--management-hold"), c->config_file, PACKAGE_STRING, exit_event_n=
ame,
+        "--management-hold"), c->config_file, PACKAGE_STRING, BUILD_STRING=
,=20
+	exit_event_name,
         (o.append_string[0] =3D=3D '1' ? _T("-append") : _T("")), c->log_p=
ath,
         inet_ntoa(c->manage.skaddr.sin_addr), ntohs(c->manage.skaddr.sin_p=
ort),
         (o.proxy_source !=3D config ? _T("--management-query-proxy ") : _T=
("")));
--=20
1.7.9.5


--+u84DknIvDG47jDR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-Pass-installer-version-to-openvpn-gui-building.patch"
Content-Transfer-Encoding: quoted-printable

=46rom 1fdd993905e711acbc4b3042ff7912ef71d337c4 Mon Sep 17 00:00:00 2001
From: Gert Doering <gert@...1296...>
Date: Sat, 26 Apr 2014 20:33:56 +0200
Subject: [PATCH] Pass installer version to openvpn-gui building.

build-complete knows the installer version, generic/build doesn't, so
add a new option (--build-string), and pass on the string to the
openvpn-gui build.

Also fix the "downloading of tar balls" function to check for the actual
file to download, not just "anything that has the same name with any(!)
number after it".

Signed-off-by: Gert Doering <gert@...1296...>
---
 generic/build               |   15 +++++++++++----
 windows-nsis/build-complete |    1 +
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/generic/build b/generic/build
index db30348..0f030a3 100755
--- a/generic/build
+++ b/generic/build
@@ -82,9 +82,11 @@ geturl() {
=20
 download1() {
 	local url=3D"$1"
-	local prefix=3D"$(basename "${url}" | sed 's/-[0-9].*//g')"
+	local filename=3D"$(basename "${url}")"
=20
-	if ! [ -n "$(ls "${SOURCESROOT}/${prefix}-"[0-9]* 2> /dev/null)" ]; then
+	if [ -f "${SOURCESROOT}/${filename}" ] ; then
+		echo "$filename already there, skip download."
+	else
 		geturl ${url} || die "Cannot download ${url}"
 	fi
 }
@@ -300,10 +302,12 @@ build_openvpn_gui() {
 	fixup_la
=20
 	echo "Build openvpn-gui"
-	cd "${BUILDROOT}/openvpn-gui"* || die "cd openvpn gui"
+	cd "${BUILDROOT}/openvpn-gui-${OPENVPN_GUI_VERSION}" || \
+		die "cd ${BUILDROOT}/openvpn-gui-${OPENVPN_GUI_VERSION}"
 	./configure ${CONFIGOPTS} ${EXTRA_OPENVPN_GUI_CONFIG} \
 		|| die "Configure openvpn-gui"
-	${MAKE} ${MAKEOPTS} ${MAKE_AUTOCONF_INSTALL_TARGET} DESTDIR=3D"${OPENVPN_=
ROOT}" || die "make openvpn-gui"
+	${MAKE} ${MAKEOPTS} ${MAKE_AUTOCONF_INSTALL_TARGET} \
+		BUILD_STRING=3D"${BUILD_STRING}" DESTDIR=3D"${OPENVPN_ROOT}" || die "mak=
e openvpn-gui"
=20
 	fixup_la
=20
@@ -501,6 +505,9 @@ while [ -n "$1" ]; do
 					;;
 			esac
 			;;
+		--build-string=3D*)
+			BUILD_STRING=3D"${v}"
+			;;
 		--special-build=3D*)
 			SPECIAL_BUILD=3D"${v}"
 			;;
diff --git a/windows-nsis/build-complete b/windows-nsis/build-complete
index 7a0bf11..b7eccc4 100755
--- a/windows-nsis/build-complete
+++ b/windows-nsis/build-complete
@@ -20,6 +20,7 @@ main() {
 			BUILDROOT=3D"${TMPDIR}/build-${arch}" \
 			CHOST=3D${arch}-w64-mingw32 \
 			../generic/build \
+				--build-string=3D" build ${INSTALLER_VERSION}" \
 				--special-build=3D"${SPECIAL_BUILD}" \
 				${WIN_USE_DEPCACHE:+--use-depcache=3Dwin-$arch} \
 				${WIN_SAVE_DEPCACHE:+--save-depcache=3Dwin-$arch} \
--=20
1.7.9.5


--+u84DknIvDG47jDR--

--21wxXApbhHFpxH4c
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBU1v95qkuBuNlUUl1AQKPVQP9FDE1QcnXkaAN+SWrriDLNML+ST6KSZfR
t7bAQfaq7Ton30gWTswUBhfFytifb+owG67GWH55d4qFwevH4ahLi1YDqwb4/OT8
j1urCTGdkQXTow2+e9MFp/Lix7OQ9lobBJgYPxMC+CDZeS/uRKz6v64JpE8bQsuX
4HG9axZY46A=
=cXLJ
-----END PGP SIGNATURE-----

--21wxXApbhHFpxH4c--

