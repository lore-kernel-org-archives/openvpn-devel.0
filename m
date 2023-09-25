From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 25 Sep 2023 20:23:37 +0000
In-Reply-To: <gerrit.1689947729000.Ie61fed8758e44576939a8bb0a04bc95245a3ce18@...2715...>
References: <gerrit.1689947729000.Ie61fed8758e44576939a8bb0a04bc95245a3ce18@...2715...>
Reply-To: gert@...1296..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <540bd25362bbbc889f91aa8959128df01b75402c-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="nGARDnqggck="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[release/2.6]:
 vcpkg-ports/pkcs11-helper: Backport MinGW series from master to relea...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>, d12fk <heiko@...515...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--nGARDnqggck=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/311?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by d12fk


Change subject: vcpkg-ports/pkcs11-helper: Backport MinGW series from maste=
r to release/2.6
......................................................................

vcpkg-ports/pkcs11-helper: Backport MinGW series from master to release/2.6

Contains the following commits:
- Make compatible with mingw build
  (commit 17746e53f65249b42017256056c5415099df288d)
- Convert CONTROL to vcpkg.json
  (commit a2160d3e42a1eff59aee3d984fd3354907f4379f)
- reference upstream PRs in patches
  (commit 9577ffe92f033d8452cff0a3dbdfdc943655c5b8)
- rename patches to make file names shorter
  (commit 0c25a5462e945f537d1836b47a5f147a2132875c)

Change-Id: Ie61fed8758e44576939a8bb0a04bc95245a3ce18
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Heiko Hund <heiko@...515...>
Message-Id: <20230922160324.166907-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27=
083.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M .github/workflows/build.yaml
D contrib/vcpkg-ports/pkcs11-helper/CONTROL
A contrib/vcpkg-ports/pkcs11-helper/Fix-build-with-disable-shared.patch
R contrib/vcpkg-ports/pkcs11-helper/config-w32-vc.h.in-indicate-OpenSSL.pat=
ch
R contrib/vcpkg-ports/pkcs11-helper/nmake-compatibility-with-vcpkg-nmake.pa=
tch
M contrib/vcpkg-ports/pkcs11-helper/pkcs11-helper-001-RFC7512.patch
M contrib/vcpkg-ports/pkcs11-helper/pkcs11-helper-002-dynamic_loader_flags.=
patch
M contrib/vcpkg-ports/pkcs11-helper/portfile.cmake
A contrib/vcpkg-ports/pkcs11-helper/vcpkg.json
A contrib/vcpkg-triplets/x64-mingw-ovpn.cmake
A contrib/vcpkg-triplets/x86-mingw-ovpn.cmake
11 files changed, 104 insertions(+), 13 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/11/311/2

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index d152505..34ade61 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -441,6 +441,7 @@
         uses: lukka/run-vcpkg@...2637...
         with:
           vcpkgGitCommitId: 'd10d511f25620ca0f315cd83dcef6485efc63010'
+          vcpkgJsonGlob: '**/openvpn/vcpkg.json'
           appendedCacheKey: '${{matrix.triplet}}'

       - name: Run MSBuild consuming vcpkg.json
diff --git a/contrib/vcpkg-ports/pkcs11-helper/CONTROL b/contrib/vcpkg-port=
s/pkcs11-helper/CONTROL
deleted file mode 100644
index 1ead697..0000000
--- a/contrib/vcpkg-ports/pkcs11-helper/CONTROL
+++ /dev/null
@@ -1,4 +0,0 @@
-Source: pkcs11-helper
-Version: 1.29-1
-Homepage: https://github.com/OpenSC/pkcs11-helper
-Description: pkcs11-helper is a library that simplifies the interaction wi=
th PKCS#11 providers for end-user applications.
diff --git a/contrib/vcpkg-ports/pkcs11-helper/Fix-build-with-disable-share=
d.patch b/contrib/vcpkg-ports/pkcs11-helper/Fix-build-with-disable-shared.p=
atch
new file mode 100644
index 0000000..16fa704
--- /dev/null
+++ b/contrib/vcpkg-ports/pkcs11-helper/Fix-build-with-disable-shared.patch
@@ -0,0 +1,48 @@
+From 7171396a151a2edb3474c7a321b7ae4ff7e171fc Mon Sep 17 00:00:00 2001
+From: Frank Lichtenheld <frank@...2641...>
+Date: Wed, 29 Mar 2023 12:44:44 +0200
+Subject: [PATCH] Allow the build to succeed if configured with
+ --disable-shared
+
+Do not try to install a file that does not exist.
+
+Signed-off-by: Frank Lichtenheld <frank@...2641...>
+---
+ configure.ac    | 1 +
+ lib/Makefile.am | 2 ++
+ 2 files changed, 3 insertions(+)
+
+upstream PR: https://github.com/OpenSC/pkcs11-helper/pull/62
+
+diff --git a/configure.ac b/configure.ac
+index a7e9760..f154ae3 100644
+--- a/configure.ac
++++ b/configure.ac
+@@ -581,6 +581,7 @@ AC_SUBST([LIBPKCS11_HELPER_LT_AGE])
+ AC_SUBST([LIBPKCS11_HELPER_LT_OLDEST])
+ AC_SUBST([WIN_LIBPREFIX])
+ AC_SUBST([PKCS11H_FEATURES])
++AM_CONDITIONAL([ENABLE_SHARED], [test "${enable_shared}" =3D "yes" ])
+ AM_CONDITIONAL([WIN32], [test "${WIN32}" =3D "yes"])
+ AM_CONDITIONAL([CYGWIN], [test "${CYGWIN}" =3D "yes"])
+ AM_CONDITIONAL([ENABLE_DOC], [test "${enable_doc}" =3D "yes"])
+diff --git a/lib/Makefile.am b/lib/Makefile.am
+index 31b928f..3cba32f 100644
+--- a/lib/Makefile.am
++++ b/lib/Makefile.am
+@@ -128,10 +128,12 @@ if ENABLE_PKCS11H_TOKEN
+ endif
+
+ if WIN32
++if ENABLE_SHARED
+ mylibdir=3D$(libdir)
+ mylib_DATA=3D.libs/@WIN_LIBPREFIX@...2727...@LIBPKCS11_HELPER_LT_OLDEST@...220...=
..2728...
+ .libs/@WIN_LIBPREFIX@...2727...@LIBPKCS11_HELPER_LT_OLDEST@...2728...:	li=
bpkcs11-helper.la
+ endif
++endif
+
+ RCCOMPILE =3D $(RC) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) \
+ 	$(AM_CPPFLAGS) $(CPPFLAGS)
+--
+2.34.1
+
diff --git a/contrib/vcpkg-ports/pkcs11-helper/0002-config-w32-vc.h.in-indi=
cate-OpenSSL.patch b/contrib/vcpkg-ports/pkcs11-helper/config-w32-vc.h.in-i=
ndicate-OpenSSL.patch
similarity index 100%
rename from contrib/vcpkg-ports/pkcs11-helper/0002-config-w32-vc.h.in-indic=
ate-OpenSSL.patch
rename to contrib/vcpkg-ports/pkcs11-helper/config-w32-vc.h.in-indicate-Ope=
nSSL.patch
diff --git a/contrib/vcpkg-ports/pkcs11-helper/0001-nmake-compatibility-wit=
h-vcpkg-nmake.patch b/contrib/vcpkg-ports/pkcs11-helper/nmake-compatibility=
-with-vcpkg-nmake.patch
similarity index 100%
rename from contrib/vcpkg-ports/pkcs11-helper/0001-nmake-compatibility-with=
-vcpkg-nmake.patch
rename to contrib/vcpkg-ports/pkcs11-helper/nmake-compatibility-with-vcpkg-=
nmake.patch
diff --git a/contrib/vcpkg-ports/pkcs11-helper/pkcs11-helper-001-RFC7512.pa=
tch b/contrib/vcpkg-ports/pkcs11-helper/pkcs11-helper-001-RFC7512.patch
index 84fba08..56e3486 100644
--- a/contrib/vcpkg-ports/pkcs11-helper/pkcs11-helper-001-RFC7512.patch
+++ b/contrib/vcpkg-ports/pkcs11-helper/pkcs11-helper-001-RFC7512.patch
@@ -1,3 +1,5 @@
+upstream PR: https://github.com/OpenSC/pkcs11-helper/pull/4
+
 commit 90590b02085edc3830bdfe0942a46c4e7bf3f1ab (HEAD -> master)
 Author: David Woodhouse <David.Woodhouse@...753...>
 Date:   Thu Apr 30 14:58:24 2015 +0100
diff --git a/contrib/vcpkg-ports/pkcs11-helper/pkcs11-helper-002-dynamic_lo=
ader_flags.patch b/contrib/vcpkg-ports/pkcs11-helper/pkcs11-helper-002-dyna=
mic_loader_flags.patch
index 325dea8..6d67458 100644
--- a/contrib/vcpkg-ports/pkcs11-helper/pkcs11-helper-002-dynamic_loader_fl=
ags.patch
+++ b/contrib/vcpkg-ports/pkcs11-helper/pkcs11-helper-002-dynamic_loader_fl=
ags.patch
@@ -11,6 +11,8 @@
  lib/pkcs11h-core.c                       | 13 +++++++++++--
  3 files changed, 23 insertions(+), 3 deletions(-)

+upstream PR: https://github.com/OpenSC/pkcs11-helper/pull/59
+
 diff --git a/include/pkcs11-helper-1.0/pkcs11h-core.h b/include/pkcs11-hel=
per-1.0/pkcs11h-core.h
 index 9028c277..56f87718 100644
 --- a/include/pkcs11-helper-1.0/pkcs11h-core.h
diff --git a/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake b/contrib/vcp=
kg-ports/pkcs11-helper/portfile.cmake
index 1c6ceda..47919bc 100644
--- a/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake
+++ b/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake
@@ -11,26 +11,45 @@
     ARCHIVE ${ARCHIVE}
     REF ${VERSION}
     PATCHES
-        0001-nmake-compatibility-with-vcpkg-nmake.patch
-        0002-config-w32-vc.h.in-indicate-OpenSSL.patch
+        nmake-compatibility-with-vcpkg-nmake.patch
+        config-w32-vc.h.in-indicate-OpenSSL.patch
+        Fix-build-with-disable-shared.patch
         pkcs11-helper-001-RFC7512.patch
         pkcs11-helper-002-dynamic_loader_flags.patch
 )

-vcpkg_build_nmake(
+if(VCPKG_TARGET_IS_WINDOWS AND NOT VCPKG_TARGET_IS_MINGW)
+  vcpkg_build_nmake(
     SOURCE_PATH ${SOURCE_PATH}
     PROJECT_SUBPATH lib
     PROJECT_NAME Makefile.w32-vc
     OPTIONS
         OPENSSL=3D1
         OPENSSL_HOME=3D${CURRENT_PACKAGES_DIR}/../openssl_${TARGET_TRIPLET}
-)
+  )

-file(INSTALL ${SOURCE_PATH}/include/pkcs11-helper-1.0 DESTINATION ${CURREN=
T_PACKAGES_DIR}/include/)
-file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/lib/pkcs11-he=
lper.dll.lib DESTINATION ${CURRENT_PACKAGES_DIR}/lib)
-file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/lib/pkcs11-he=
lper.dll.lib DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib)
+  file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/lib/pkcs11-=
helper.dll.lib DESTINATION ${CURRENT_PACKAGES_DIR}/lib)
+  file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/lib/pkcs11-=
helper.dll.lib DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib)

-file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/lib/libpkcs11=
-helper-1.dll DESTINATION ${CURRENT_PACKAGES_DIR}/bin)
-file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/lib/libpkcs11=
-helper-1.dll DESTINATION ${CURRENT_PACKAGES_DIR}/debug/bin)
+  file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/lib/libpkcs=
11-helper-1.dll DESTINATION ${CURRENT_PACKAGES_DIR}/bin)
+  file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/lib/libpkcs=
11-helper-1.dll DESTINATION ${CURRENT_PACKAGES_DIR}/debug/bin)
+
+  file(INSTALL ${SOURCE_PATH}/include/pkcs11-helper-1.0 DESTINATION ${CURR=
ENT_PACKAGES_DIR}/include/)
+
+else()
+  find_program(man_to_html man2html REQUIRED)
+
+  vcpkg_configure_make(
+    SOURCE_PATH ${SOURCE_PATH}
+    OPTIONS --disable-crypto-engine-gnutls --disable-crypto-engine-nss
+    --disable-crypto-engine-polarssl --disable-crypto-engine-mbedtls
+    )
+  vcpkg_install_make()
+  vcpkg_fixup_pkgconfig()
+
+  file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")
+endif()
+
+vcpkg_copy_pdbs()

 file(INSTALL ${SOURCE_PATH}/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/sh=
are/${PORT} RENAME copyright)
diff --git a/contrib/vcpkg-ports/pkcs11-helper/vcpkg.json b/contrib/vcpkg-p=
orts/pkcs11-helper/vcpkg.json
new file mode 100644
index 0000000..12f918b
--- /dev/null
+++ b/contrib/vcpkg-ports/pkcs11-helper/vcpkg.json
@@ -0,0 +1,7 @@
+{
+    "name": "pkcs11-helper",
+    "version": "1.29.0",
+    "description": "pkcs11-helper is a library that simplifies the interac=
tion with PKCS#11 providers for end-user applications.",
+    "homepage": "https://github.com/OpenSC/pkcs11-helper",
+    "license": "BSD-3-Clause OR GPL-2.0-only"
+}
diff --git a/contrib/vcpkg-triplets/x64-mingw-ovpn.cmake b/contrib/vcpkg-tr=
iplets/x64-mingw-ovpn.cmake
new file mode 100644
index 0000000..3676cdb
--- /dev/null
+++ b/contrib/vcpkg-triplets/x64-mingw-ovpn.cmake
@@ -0,0 +1,8 @@
+set(VCPKG_TARGET_ARCHITECTURE x64)
+set(VCPKG_CRT_LINKAGE dynamic)
+set(VCPKG_LIBRARY_LINKAGE static)
+set(VCPKG_ENV_PASSTHROUGH PATH)
+
+set(VCPKG_CMAKE_SYSTEM_NAME MinGW)
+
+set(VCPKG_MAKE_BUILD_TRIPLET --host=3Dx86_64-w64-mingw32)
diff --git a/contrib/vcpkg-triplets/x86-mingw-ovpn.cmake b/contrib/vcpkg-tr=
iplets/x86-mingw-ovpn.cmake
new file mode 100644
index 0000000..9e65f67
--- /dev/null
+++ b/contrib/vcpkg-triplets/x86-mingw-ovpn.cmake
@@ -0,0 +1,8 @@
+set(VCPKG_TARGET_ARCHITECTURE x86)
+set(VCPKG_CRT_LINKAGE dynamic)
+set(VCPKG_LIBRARY_LINKAGE static)
+set(VCPKG_ENV_PASSTHROUGH PATH)
+
+set(VCPKG_CMAKE_SYSTEM_NAME MinGW)
+
+set(VCPKG_MAKE_BUILD_TRIPLET --host=3Di686-w64-mingw32)

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/311?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: Ie61fed8758e44576939a8bb0a04bc95245a3ce18
Gerrit-Change-Number: 311
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: d12fk <heiko@...515...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--nGARDnqggck=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/311?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by d12fk</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">vcpkg-ports/pkcs11-helper: Backport MinGW series fro=
m master to release/2.6<br><br>Contains the following commits:<br>- Make co=
mpatible with mingw build<br>  (commit 17746e53f65249b42017256056c5415099df=
288d)<br>- Convert CONTROL to vcpkg.json<br>  (commit a2160d3e42a1eff59aee3=
d984fd3354907f4379f)<br>- reference upstream PRs in patches<br>  (commit 95=
77ffe92f033d8452cff0a3dbdfdc943655c5b8)<br>- rename patches to make file na=
mes shorter<br>  (commit 0c25a5462e945f537d1836b47a5f147a2132875c)<br><br>C=
hange-Id: Ie61fed8758e44576939a8bb0a04bc95245a3ce18<br>Signed-off-by: Frank=
 Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Heiko Hund &lt;heiko@...493...=
515...&gt;<br>Message-Id: &lt;20230922160324.166907-1-frank@...2641...&gt;<=
br>URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/ms=
g27083.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<b=
r>M .github/workflows/build.yaml<br>D contrib/vcpkg-ports/pkcs11-helper/CON=
TROL<br>A contrib/vcpkg-ports/pkcs11-helper/Fix-build-with-disable-shared.p=
atch<br>R contrib/vcpkg-ports/pkcs11-helper/config-w32-vc.h.in-indicate-Ope=
nSSL.patch<br>R contrib/vcpkg-ports/pkcs11-helper/nmake-compatibility-with-=
vcpkg-nmake.patch<br>M contrib/vcpkg-ports/pkcs11-helper/pkcs11-helper-001-=
RFC7512.patch<br>M contrib/vcpkg-ports/pkcs11-helper/pkcs11-helper-002-dyna=
mic_loader_flags.patch<br>M contrib/vcpkg-ports/pkcs11-helper/portfile.cmak=
e<br>A contrib/vcpkg-ports/pkcs11-helper/vcpkg.json<br>A contrib/vcpkg-trip=
lets/x64-mingw-ovpn.cmake<br>A contrib/vcpkg-triplets/x86-mingw-ovpn.cmake<=
br>11 files changed, 104 insertions(+), 13 deletions(-)<br><br></pre><pre s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull =
ssh://gerrit.openvpn.net:29418/openvpn refs/changes/11/311/2</pre><pre styl=
e=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff -=
-git a/.github/workflows/build.yaml b/.github/workflows/build.yaml</span><b=
r><span>index d152505..34ade61 100644</span><br><span>--- a/.github/workflo=
ws/build.yaml</span><br><span>+++ b/.github/workflows/build.yaml</span><br>=
<span>@@ -441,6 +441,7 @@</span><br><span>         uses: lukka/run-vcpkg@...1186...=
.2637...</span><br><span>         with:</span><br><span>           vcpkgGit=
CommitId: &#39;d10d511f25620ca0f315cd83dcef6485efc63010&#39;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+          vcpkgJsonGlob: &#39;**/o=
penvpn/vcpkg.json&#39;</span><br><span>           appendedCacheKey: &#39;${=
{matrix.triplet}}&#39;</span><br><span> </span><br><span>       - name: Run=
 MSBuild consuming vcpkg.json</span><br><span>diff --git a/contrib/vcpkg-po=
rts/pkcs11-helper/CONTROL b/contrib/vcpkg-ports/pkcs11-helper/CONTROL</span=
><br><span>deleted file mode 100644</span><br><span>index 1ead697..0000000<=
/span><br><span>--- a/contrib/vcpkg-ports/pkcs11-helper/CONTROL</span><br><=
span>+++ /dev/null</span><br><span>@@ -1,4 +0,0 @@</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-Source: pkcs11-helper</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-Version: 1.29-1</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-Homepage: https://github.com/OpenSC/pkcs11-helper</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-Description: pkcs11-help=
er is a library that simplifies the interaction with PKCS#11 providers for =
end-user applications.</span><br><span>diff --git a/contrib/vcpkg-ports/pkc=
s11-helper/Fix-build-with-disable-shared.patch b/contrib/vcpkg-ports/pkcs11=
-helper/Fix-build-with-disable-shared.patch</span><br><span>new file mode 1=
00644</span><br><span>index 0000000..16fa704</span><br><span>--- /dev/null<=
/span><br><span>+++ b/contrib/vcpkg-ports/pkcs11-helper/Fix-build-with-disa=
ble-shared.patch</span><br><span>@@ -0,0 +1,48 @@</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+From 7171396a151a2edb3474c7a321b7ae4ff7e171fc=
 Mon Sep 17 00:00:00 2001</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+From: Frank Lichtenheld &lt;frank@...2641...&gt;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+Date: Wed, 29 Mar 2023 12:44:44 +0200</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+Subject: [PATCH] Allow=
 the build to succeed if configured with</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ --disable-shared</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
Do not try to install a file that does not exist.</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+---</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ configure.ac    | 1 +</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ lib/Makefile.am | 2 ++</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ 2 files changed, 3 insertions(+)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+upstream PR: https://github.com/OpenSC/=
pkcs11-helper/pull/62</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+diff --git a/conf=
igure.ac b/configure.ac</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+index a7e9760..f154ae3 100644</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+--- a/configure.ac</span><br><span>++++ b/configure.ac</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+@@ -581,6 +581,7 @@ AC_SUB=
ST([LIBPKCS11_HELPER_LT_AGE])</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ AC_SUBST([LIBPKCS11_HELPER_LT_OLDEST])</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ AC_SUBST([WIN_LIBPREFIX])</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ AC_SUBST([PKCS11H_FEATURES])</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">++AM_CONDITIONAL([ENABLE_SHAR=
ED], [test &quot;${enable_shared}&quot; =3D &quot;yes&quot; ])</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ AM_CONDITIONAL([WIN32], [test &=
quot;${WIN32}&quot; =3D &quot;yes&quot;])</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ AM_CONDITIONAL([CYGWIN], [test &quot;${CYGWIN}&quot;=
 =3D &quot;yes&quot;])</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ AM_CONDITIONAL([ENABLE_DOC], [test &quot;${enable_doc}&quot; =3D &quot;=
yes&quot;])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+diff --g=
it a/lib/Makefile.am b/lib/Makefile.am</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+index 31b928f..3cba32f 100644</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+--- a/lib/Makefile.am</span><br><span>++++ b/l=
ib/Makefile.am</span><br><span style=3D"color: hsl(120, 100%, 40%);">+@@ -1=
28,10 +128,12 @@ if ENABLE_PKCS11H_TOKEN</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ endif</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ </span><br><span style=3D"color: hsl(120, 100%, 40%);">+ if WIN32<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">++if ENABLE_SHARED</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ mylibdir=3D$(libdir)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ mylib_DATA=3D.libs/=
@WIN_LIBPREFIX@...2727...@LIBPKCS11_HELPER_LT_OLDEST@...2728...</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ .libs/@WIN_LIBPREFIX@...2747...=
.@...2748...@...2728...:	libpkcs11-helper.la</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ endif</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">++endif</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ </span><br><span style=3D"color: hsl(120, 100%, 40%);">+ RC=
COMPILE =3D $(RC) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) \</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ 	$(AM_CPPFLAGS) $(CPPFLAGS)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+-- </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+2.34.1</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span>diff --git a/contrib/vcpkg-ports/pkcs=
11-helper/0002-config-w32-vc.h.in-indicate-OpenSSL.patch b/contrib/vcpkg-po=
rts/pkcs11-helper/config-w32-vc.h.in-indicate-OpenSSL.patch</span><br><span=
>similarity index 100%</span><br><span>rename from contrib/vcpkg-ports/pkcs=
11-helper/0002-config-w32-vc.h.in-indicate-OpenSSL.patch</span><br><span>re=
name to contrib/vcpkg-ports/pkcs11-helper/config-w32-vc.h.in-indicate-OpenS=
SL.patch</span><br><span>diff --git a/contrib/vcpkg-ports/pkcs11-helper/000=
1-nmake-compatibility-with-vcpkg-nmake.patch b/contrib/vcpkg-ports/pkcs11-h=
elper/nmake-compatibility-with-vcpkg-nmake.patch</span><br><span>similarity=
 index 100%</span><br><span>rename from contrib/vcpkg-ports/pkcs11-helper/0=
001-nmake-compatibility-with-vcpkg-nmake.patch</span><br><span>rename to co=
ntrib/vcpkg-ports/pkcs11-helper/nmake-compatibility-with-vcpkg-nmake.patch<=
/span><br><span>diff --git a/contrib/vcpkg-ports/pkcs11-helper/pkcs11-helpe=
r-001-RFC7512.patch b/contrib/vcpkg-ports/pkcs11-helper/pkcs11-helper-001-R=
FC7512.patch</span><br><span>index 84fba08..56e3486 100644</span><br><span>=
--- a/contrib/vcpkg-ports/pkcs11-helper/pkcs11-helper-001-RFC7512.patch</sp=
an><br><span>+++ b/contrib/vcpkg-ports/pkcs11-helper/pkcs11-helper-001-RFC7=
512.patch</span><br><span>@@ -1,3 +1,5 @@</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+upstream PR: https://github.com/OpenSC/pkcs11-helper/=
pull/4</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan> commit 90590b02085edc3830bdfe0942a46c4e7bf3f1ab (HEAD -&gt; master)</s=
pan><br><span> Author: David Woodhouse &lt;David.Woodhouse@...753...&gt;</s=
pan><br><span> Date:   Thu Apr 30 14:58:24 2015 +0100</span><br><span>diff =
--git a/contrib/vcpkg-ports/pkcs11-helper/pkcs11-helper-002-dynamic_loader_=
flags.patch b/contrib/vcpkg-ports/pkcs11-helper/pkcs11-helper-002-dynamic_l=
oader_flags.patch</span><br><span>index 325dea8..6d67458 100644</span><br><=
span>--- a/contrib/vcpkg-ports/pkcs11-helper/pkcs11-helper-002-dynamic_load=
er_flags.patch</span><br><span>+++ b/contrib/vcpkg-ports/pkcs11-helper/pkcs=
11-helper-002-dynamic_loader_flags.patch</span><br><span>@@ -11,6 +11,8 @@<=
/span><br><span>  lib/pkcs11h-core.c                       | 13 +++++++++++=
--</span><br><span>  3 files changed, 23 insertions(+), 3 deletions(-)</spa=
n><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+upstre=
am PR: https://github.com/OpenSC/pkcs11-helper/pull/59</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span> diff --git a/include/p=
kcs11-helper-1.0/pkcs11h-core.h b/include/pkcs11-helper-1.0/pkcs11h-core.h<=
/span><br><span> index 9028c277..56f87718 100644</span><br><span> --- a/inc=
lude/pkcs11-helper-1.0/pkcs11h-core.h</span><br><span>diff --git a/contrib/=
vcpkg-ports/pkcs11-helper/portfile.cmake b/contrib/vcpkg-ports/pkcs11-helpe=
r/portfile.cmake</span><br><span>index 1c6ceda..47919bc 100644</span><br><s=
pan>--- a/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake</span><br><span>=
+++ b/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake</span><br><span>@@ -=
11,26 +11,45 @@</span><br><span>     ARCHIVE ${ARCHIVE}</span><br><span>   =
  REF ${VERSION}</span><br><span>     PATCHES</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        0001-nmake-compatibility-with-vcpkg-nmake.p=
atch</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        0002-conf=
ig-w32-vc.h.in-indicate-OpenSSL.patch</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        nmake-compatibility-with-vcpkg-nmake.patch</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        config-w32-vc.h.in=
-indicate-OpenSSL.patch</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        Fix-build-with-disable-shared.patch</span><br><span>         pk=
cs11-helper-001-RFC7512.patch</span><br><span>         pkcs11-helper-002-dy=
namic_loader_flags.patch</span><br><span> )</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-vcpkg_build_nmake(</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+if(VCPKG_TARGET_IS_WINDOWS AND NOT V=
CPKG_TARGET_IS_MINGW)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  vcpkg_build_nmake(</span><br><span>     SOURCE_PATH ${SOURCE_PATH}</spa=
n><br><span>     PROJECT_SUBPATH lib</span><br><span>     PROJECT_NAME Make=
file.w32-vc</span><br><span>     OPTIONS</span><br><span>         OPENSSL=
=3D1</span><br><span>         OPENSSL_HOME=3D${CURRENT_PACKAGES_DIR}/../ope=
nssl_${TARGET_TRIPLET}</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  )</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-file(INSTALL ${SO=
URCE_PATH}/include/pkcs11-helper-1.0 DESTINATION ${CURRENT_PACKAGES_DIR}/in=
clude/)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-file(INSTALL $=
{CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/lib/pkcs11-helper.dll.lib DE=
STINATION ${CURRENT_PACKAGES_DIR}/lib)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-d=
bg/lib/pkcs11-helper.dll.lib DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  file(INSTALL ${CU=
RRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/lib/pkcs11-helper.dll.lib DESTI=
NATION ${CURRENT_PACKAGES_DIR}/lib)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+  file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-=
dbg/lib/pkcs11-helper.dll.lib DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib=
)</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-fi=
le(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/lib/libpkcs11-he=
lper-1.dll DESTINATION ${CURRENT_PACKAGES_DIR}/bin)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TA=
RGET_TRIPLET}-dbg/lib/libpkcs11-helper-1.dll DESTINATION ${CURRENT_PACKAGES=
_DIR}/debug/bin)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  f=
ile(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/lib/libpkcs11-h=
elper-1.dll DESTINATION ${CURRENT_PACKAGES_DIR}/bin)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  file(INSTALL ${CURRENT_BUILDTREES_DIR}/=
${TARGET_TRIPLET}-dbg/lib/libpkcs11-helper-1.dll DESTINATION ${CURRENT_PACK=
AGES_DIR}/debug/bin)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  file(INSTALL ${S=
OURCE_PATH}/include/pkcs11-helper-1.0 DESTINATION ${CURRENT_PACKAGES_DIR}/i=
nclude/)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+else()</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  find_program(man_to_html man2html REQUI=
RED)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  vcpkg_configure_make(</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    SOURCE_PATH ${SOURCE_PATH}=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OPTIONS --disab=
le-crypto-engine-gnutls --disable-crypto-engine-nss</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    --disable-crypto-engine-polarssl --di=
sable-crypto-engine-mbedtls</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    )</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  vcpk=
g_install_make()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  v=
cpkg_fixup_pkgconfig()</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  file(REMOVE_RE=
CURSE &quot;${CURRENT_PACKAGES_DIR}/debug/share&quot;)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+endif()</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+vcpkg_copy_pdbs()</span><br><span> </span><br><span> file(INSTALL ${SOU=
RCE_PATH}/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME =
copyright)</span><br><span>diff --git a/contrib/vcpkg-ports/pkcs11-helper/v=
cpkg.json b/contrib/vcpkg-ports/pkcs11-helper/vcpkg.json</span><br><span>ne=
w file mode 100644</span><br><span>index 0000000..12f918b</span><br><span>-=
-- /dev/null</span><br><span>+++ b/contrib/vcpkg-ports/pkcs11-helper/vcpkg.=
json</span><br><span>@@ -0,0 +1,7 @@</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   &quot;name&quot;: &quot;pkcs11-helper&quot;,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    &quot;version&quot;: &quot;1.29.0&quot;,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;description&=
quot;: &quot;pkcs11-helper is a library that simplifies the interaction wit=
h PKCS#11 providers for end-user applications.&quot;,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    &quot;homepage&quot;: &quot;https://g=
ithub.com/OpenSC/pkcs11-helper&quot;,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    &quot;license&quot;: &quot;BSD-3-Clause OR GPL-2.0-on=
ly&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br=
><span>diff --git a/contrib/vcpkg-triplets/x64-mingw-ovpn.cmake b/contrib/v=
cpkg-triplets/x64-mingw-ovpn.cmake</span><br><span>new file mode 100644</sp=
an><br><span>index 0000000..3676cdb</span><br><span>--- /dev/null</span><br=
><span>+++ b/contrib/vcpkg-triplets/x64-mingw-ovpn.cmake</span><br><span>@@=
 -0,0 +1,8 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+set(VC=
PKG_TARGET_ARCHITECTURE x64)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+set(VCPKG_CRT_LINKAGE dynamic)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+set(VCPKG_LIBRARY_LINKAGE static)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+set(VCPKG_ENV_PASSTHROUGH PATH)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+set(VCPKG_CMAKE_SYSTEM_NAME MinGW)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+set(VCPKG_MAKE_BUILD_TRIPLET --host=3Dx86_64-w64-min=
gw32)</span><br><span>diff --git a/contrib/vcpkg-triplets/x86-mingw-ovpn.cm=
ake b/contrib/vcpkg-triplets/x86-mingw-ovpn.cmake</span><br><span>new file =
mode 100644</span><br><span>index 0000000..9e65f67</span><br><span>--- /dev=
/null</span><br><span>+++ b/contrib/vcpkg-triplets/x86-mingw-ovpn.cmake</sp=
an><br><span>@@ -0,0 +1,8 @@</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+set(VCPKG_TARGET_ARCHITECTURE x86)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+set(VCPKG_CRT_LINKAGE dynamic)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+set(VCPKG_LIBRARY_LINKAGE static)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+set(VCPKG_ENV_PASSTHROUGH =
PATH)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+set(VCPKG_CMAKE_SYSTEM_NAME MinGW=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+set(VCPKG_MAKE_BUILD_TRIPLET --host=
=3Di686-w64-mingw32)</span><br><span></span><br></pre><p>To view, visit <a =
href=3D"http://gerrit.openvpn.net/c/openvpn/+/311?usp=3Demail">change 311</=
a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D=
"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtyp=
e=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/311?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie61fed8758e44576939a8bb0a04=
bc95245a3ce18 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 311 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: d12fk &lt;heiko@...515...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--nGARDnqggck=--

