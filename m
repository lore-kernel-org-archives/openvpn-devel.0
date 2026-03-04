From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 4 Mar 2026 21:50:33 +0000
In-Reply-To: <gerrit.1770830490000.I7462869a473a7afe2e9ed9474c69de0af96c011c@...2715...>
References: <gerrit.1770830490000.I7462869a473a7afe2e9ed9474c69de0af96c011c@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 yura.uddr@...277...
Message-ID: <4948dfec7955954886e94a11a55067531b065a3e-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="1W8C8HRpm/o="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: vcpkg-ports: Review
 pkcs11-helper port
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: uddr <yura.uddr@...277...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--1W8C8HRpm/o=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/15=
18?usp=3Demail )

Change subject: vcpkg-ports: Review pkcs11-helper port
......................................................................

vcpkg-ports: Review pkcs11-helper port

- Replace deprecated functions with newer alternatives
- Improve vcpkg.json by documenting openssl dependency
- Remove unnecessary duplicated version number
- Fix whitespaces

Change-Id: I7462869a473a7afe2e9ed9474c69de0af96c011c
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Yuriy Darnobyt <yura.uddr@...277...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1518
Message-Id: <20260212110935.19541-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
599.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M contrib/vcpkg-ports/pkcs11-helper/portfile.cmake
M contrib/vcpkg-ports/pkcs11-helper/vcpkg.json
2 files changed, 26 insertions(+), 25 deletions(-)




diff --git a/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake b/contrib/vcp=
kg-ports/pkcs11-helper/portfile.cmake
index af19831..f5742a4 100644
--- a/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake
+++ b/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake
@@ -1,15 +1,12 @@
-set(VERSION 1.31.0)
-
 vcpkg_download_distfile(ARCHIVE
     URLS "https://github.com/OpenSC/pkcs11-helper/releases/download/pkcs11=
-helper-${VERSION}/pkcs11-helper-${VERSION}.tar.bz2"
     FILENAME "pkcs11-helper-${VERSION}.tar.bz2"
     SHA512 0833efc59e9093dd398a54640d858b01a830ef7adfb40321c1e0ed0afa00450=
0fc1259cc66bc49c5263935adeda0a3bfe658de538eefd66888685a71f731c484
 )

-vcpkg_extract_source_archive_ex(
-    OUT_SOURCE_PATH SOURCE_PATH
+vcpkg_extract_source_archive(
+    SOURCE_PATH
     ARCHIVE ${ARCHIVE}
-    REF ${VERSION}
     PATCHES
         nmake-compatibility-with-vcpkg-nmake.patch
         config-w32-vc.h.in-indicate-OpenSSL.patch
@@ -33,20 +30,20 @@
   file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/lib/libpkcs=
11-helper-1.dll DESTINATION ${CURRENT_PACKAGES_DIR}/debug/bin)

   set(PACKAGE_VERSION "${VERSION}")
-    set(libdir [[${prefix}/lib]])
-    set(exec_prefix [[${prefix}]])
-    set(PKCS11H_FEATURES key_prompt openssl engine_crypto_cryptoapi engine=
_crypto_openssl debug threading token data certificate slotevent engine_cry=
pto)
-    set(LIBS -lkernel32 -luser32 -lgdi32 -lwinspool -lshell32 -lole32 -lol=
eaut32 -luuid -lcomdlg32 -ladvapi32)
-    if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "release")
-        set(includedir [[${prefix}/include]])
-        set(outfile "${CURRENT_PACKAGES_DIR}/lib/pkgconfig/libpkcs11-helpe=
r-1.pc")
-        configure_file("${SOURCE_PATH}/lib/libpkcs11-helper-1.pc.in" "${ou=
tfile}" @ONLY)
-    endif()
-    if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "debug")
-        set(includedir [[${prefix}/../include]])
-        set(outfile "${CURRENT_PACKAGES_DIR}/debug/lib/pkgconfig/libpkcs11=
-helper-1.pc")
-        configure_file("${SOURCE_PATH}/lib/libpkcs11-helper-1.pc.in" "${ou=
tfile}" @ONLY)
-    endif()
+  set(libdir [[${prefix}/lib]])
+  set(exec_prefix [[${prefix}]])
+  set(PKCS11H_FEATURES key_prompt openssl engine_crypto_cryptoapi engine_c=
rypto_openssl debug threading token data certificate slotevent engine_crypt=
o)
+  set(LIBS -lkernel32 -luser32 -lgdi32 -lwinspool -lshell32 -lole32 -lolea=
ut32 -luuid -lcomdlg32 -ladvapi32)
+  if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "release")
+      set(includedir [[${prefix}/include]])
+      set(outfile "${CURRENT_PACKAGES_DIR}/lib/pkgconfig/libpkcs11-helper-=
1.pc")
+      configure_file("${SOURCE_PATH}/lib/libpkcs11-helper-1.pc.in" "${outf=
ile}" @ONLY)
+  endif()
+  if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "debug")
+      set(includedir [[${prefix}/../include]])
+      set(outfile "${CURRENT_PACKAGES_DIR}/debug/lib/pkgconfig/libpkcs11-h=
elper-1.pc")
+      configure_file("${SOURCE_PATH}/lib/libpkcs11-helper-1.pc.in" "${outf=
ile}" @ONLY)
+  endif()

   file(INSTALL ${SOURCE_PATH}/include/pkcs11-helper-1.0 DESTINATION ${CURR=
ENT_PACKAGES_DIR}/include/)

@@ -66,4 +63,4 @@
 vcpkg_fixup_pkgconfig()
 vcpkg_copy_pdbs()

-file(INSTALL ${SOURCE_PATH}/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/sh=
are/${PORT} RENAME copyright)
+vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/COPYING")
diff --git a/contrib/vcpkg-ports/pkcs11-helper/vcpkg.json b/contrib/vcpkg-p=
orts/pkcs11-helper/vcpkg.json
index 382a3d3..da54646 100644
--- a/contrib/vcpkg-ports/pkcs11-helper/vcpkg.json
+++ b/contrib/vcpkg-ports/pkcs11-helper/vcpkg.json
@@ -1,7 +1,11 @@
 {
-    "name": "pkcs11-helper",
-    "version": "1.31.0",
-    "description": "pkcs11-helper is a library that simplifies the interac=
tion with PKCS#11 providers for end-user applications.",
-    "homepage": "https://github.com/OpenSC/pkcs11-helper",
-    "license": "BSD-3-Clause OR GPL-2.0-only"
+  "$schema": "https://raw.githubusercontent.com/microsoft/vcpkg/master/scr=
ipts/vcpkg.schema.json",
+  "name": "pkcs11-helper",
+  "version": "1.31.0",
+  "description": "pkcs11-helper is a library that simplifies the interacti=
on with PKCS#11 providers for end-user applications.",
+  "homepage": "https://github.com/OpenSC/pkcs11-helper",
+  "license": "BSD-3-Clause OR GPL-2.0-only",
+  "dependencies": [
+    "openssl"
+  ]
 }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1518?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7462869a473a7afe2e9ed9474c69de0af96c011c
Gerrit-Change-Number: 1518
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: uddr <yura.uddr@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--1W8C8HRpm/o=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1518?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">vcpkg-ports: Review pkcs11-helper port<br><br>- =
Replace deprecated functions with newer alternatives<br>- Improve vcpkg.jso=
n by documenting openssl dependency<br>- Remove unnecessary duplicated vers=
ion number<br>- Fix whitespaces<br><br>Change-Id: I7462869a473a7afe2e9ed947=
4c69de0af96c011c<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&g=
t;<br>Acked-by: Yuriy Darnobyt &lt;yura.uddr@...277...&gt;<br>Gerrit URL: h=
ttps://gerrit.openvpn.net/c/openvpn/+/1518<br>Message-Id: &lt;2026021211093=
5.19541-1-frank@...2641...&gt;<br>URL: https://www.mail-archive.com/openvpn=
-devel@lists.sourceforge.net/msg35599.html<br>Signed-off-by: Gert Doering &=
lt;gert@...1296...&gt;<br>---<br>M contrib/vcpkg-ports/pkcs11-helper/portfi=
le.cmake<br>M contrib/vcpkg-ports/pkcs11-helper/vcpkg.json<br>2 files chang=
ed, 26 insertions(+), 25 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake b/contrib/=
vcpkg-ports/pkcs11-helper/portfile.cmake</span><br><span>index af19831..f57=
42a4 100644</span><br><span>--- a/contrib/vcpkg-ports/pkcs11-helper/portfil=
e.cmake</span><br><span>+++ b/contrib/vcpkg-ports/pkcs11-helper/portfile.cm=
ake</span><br><span>@@ -1,15 +1,12 @@</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-set(VERSION 1.31.0)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span> vcpkg_download_distfile(ARCHIVE</span><br><=
span>     URLS &quot;https://github.com/OpenSC/pkcs11-helper/releases/downl=
oad/pkcs11-helper-${VERSION}/pkcs11-helper-${VERSION}.tar.bz2&quot;</span><=
br><span>     FILENAME &quot;pkcs11-helper-${VERSION}.tar.bz2&quot;</span><=
br><span>     SHA512 0833efc59e9093dd398a54640d858b01a830ef7adfb40321c1e0ed=
0afa004500fc1259cc66bc49c5263935adeda0a3bfe658de538eefd66888685a71f731c484<=
/span><br><span> )</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-vcpkg_extract_source_archive_ex(</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    OUT_SOURCE_PATH SOURCE_PATH</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+vcpkg_extract_source_archive(</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    SOURCE_PATH</span><br><=
span>     ARCHIVE ${ARCHIVE}</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    REF ${VERSION}</span><br><span>     PATCHES</span><br><span>    =
     nmake-compatibility-with-vcpkg-nmake.patch</span><br><span>         co=
nfig-w32-vc.h.in-indicate-OpenSSL.patch</span><br><span>@@ -33,20 +30,20 @@=
</span><br><span>   file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET=
}-dbg/lib/libpkcs11-helper-1.dll DESTINATION ${CURRENT_PACKAGES_DIR}/debug/=
bin)</span><br><span> </span><br><span>   set(PACKAGE_VERSION &quot;${VERSI=
ON}&quot;)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    set(lib=
dir [[${prefix}/lib]])</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    set(exec_prefix [[${prefix}]])</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    set(PKCS11H_FEATURES key_prompt openssl engine_crypto_cry=
ptoapi engine_crypto_openssl debug threading token data certificate sloteve=
nt engine_crypto)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
set(LIBS -lkernel32 -luser32 -lgdi32 -lwinspool -lshell32 -lole32 -loleaut3=
2 -luuid -lcomdlg32 -ladvapi32)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL =
&quot;release&quot;)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       set(includedir [[${prefix}/include]])</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        set(outfile &quot;${CURRENT_PACKAGES_DIR}/li=
b/pkgconfig/libpkcs11-helper-1.pc&quot;)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        configure_file(&quot;${SOURCE_PATH}/lib/libpkcs1=
1-helper-1.pc.in&quot; &quot;${outfile}&quot; @ONLY)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    endif()</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TY=
PE STREQUAL &quot;debug&quot;)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        set(includedir [[${prefix}/../include]])</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        set(outfile &quot;${CURRENT_PAC=
KAGES_DIR}/debug/lib/pkgconfig/libpkcs11-helper-1.pc&quot;)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        configure_file(&quot;${SOURCE=
_PATH}/lib/libpkcs11-helper-1.pc.in&quot; &quot;${outfile}&quot; @ONLY)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    endif()</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+  set(libdir [[${prefix}/lib]])</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  set(exec_prefix [[$=
{prefix}]])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  set(PK=
CS11H_FEATURES key_prompt openssl engine_crypto_cryptoapi engine_crypto_ope=
nssl debug threading token data certificate slotevent engine_crypto)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  set(LIBS -lkernel32 -lus=
er32 -lgdi32 -lwinspool -lshell32 -lole32 -loleaut32 -luuid -lcomdlg32 -lad=
vapi32)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  if(NOT DEF=
INED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL &quot;release&quot;)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+      set(includedir [[=
${prefix}/include]])</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+      set(outfile &quot;${CURRENT_PACKAGES_DIR}/lib/pkgconfig/libpkcs11-he=
lper-1.pc&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
   configure_file(&quot;${SOURCE_PATH}/lib/libpkcs11-helper-1.pc.in&quot; &=
quot;${outfile}&quot; @ONLY)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  endif()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL &quot;debug&q=
uot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      set(incl=
udedir [[${prefix}/../include]])</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+      set(outfile &quot;${CURRENT_PACKAGES_DIR}/debug/lib/pkgc=
onfig/libpkcs11-helper-1.pc&quot;)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+      configure_file(&quot;${SOURCE_PATH}/lib/libpkcs11-help=
er-1.pc.in&quot; &quot;${outfile}&quot; @ONLY)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+  endif()</span><br><span> </span><br><span>   f=
ile(INSTALL ${SOURCE_PATH}/include/pkcs11-helper-1.0 DESTINATION ${CURRENT_=
PACKAGES_DIR}/include/)</span><br><span> </span><br><span>@@ -66,4 +63,4 @@=
</span><br><span> vcpkg_fixup_pkgconfig()</span><br><span> vcpkg_copy_pdbs(=
)</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-fi=
le(INSTALL ${SOURCE_PATH}/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/share=
/${PORT} RENAME copyright)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+vcpkg_install_copyright(FILE_LIST &quot;${SOURCE_PATH}/COPYING&quot;=
)</span><br><span>diff --git a/contrib/vcpkg-ports/pkcs11-helper/vcpkg.json=
 b/contrib/vcpkg-ports/pkcs11-helper/vcpkg.json</span><br><span>index 382a3=
d3..da54646 100644</span><br><span>--- a/contrib/vcpkg-ports/pkcs11-helper/=
vcpkg.json</span><br><span>+++ b/contrib/vcpkg-ports/pkcs11-helper/vcpkg.js=
on</span><br><span>@@ -1,7 +1,11 @@</span><br><span> {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    &quot;name&quot;: &quot;pkcs11-helper&=
quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &quot;versi=
on&quot;: &quot;1.31.0&quot;,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    &quot;description&quot;: &quot;pkcs11-helper is a library that =
simplifies the interaction with PKCS#11 providers for end-user applications=
.&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &quot;hom=
epage&quot;: &quot;https://github.com/OpenSC/pkcs11-helper&quot;,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    &quot;license&quot;: &quot;=
BSD-3-Clause OR GPL-2.0-only&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  &quot;$schema&quot;: &quot;https://raw.githubusercontent.c=
om/microsoft/vcpkg/master/scripts/vcpkg.schema.json&quot;,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  &quot;name&quot;: &quot;pkcs11-hel=
per&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &quot;v=
ersion&quot;: &quot;1.31.0&quot;,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+  &quot;description&quot;: &quot;pkcs11-helper is a library t=
hat simplifies the interaction with PKCS#11 providers for end-user applicat=
ions.&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &quot=
;homepage&quot;: &quot;https://github.com/OpenSC/pkcs11-helper&quot;,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+  &quot;license&quot;: &q=
uot;BSD-3-Clause OR GPL-2.0-only&quot;,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+  &quot;dependencies&quot;: [</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    &quot;openssl&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  ]</span><br><span> }</span><br><span></=
span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/1518?usp=3Demail">change 1518</a>. To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3D=
email">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailM=
essage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vi=
ewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/1518?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></d=
iv></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7462869a473a7afe2e9ed9474c6=
9de0af96c011c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1518 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: uddr &lt;yura.uddr@...277...&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--1W8C8HRpm/o=--

