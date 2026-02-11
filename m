From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 11 Feb 2026 17:21:33 +0000
References: <gerrit.1770830490000.I7462869a473a7afe2e9ed9474c69de0af96c011c@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <25b28d2e99e8a457289118e2fc6827ab2585e377-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="cbJUvskkbqU="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--cbJUvskkbqU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1518?usp=3Demail

to review the following change.


Change subject: vcpkg-ports: Review pkcs11-helper port
......................................................................

vcpkg-ports: Review pkcs11-helper port

- Replace deprecated functions with newer alternatives
- Improve vcpkg.json by documenting openssl dependency
- Remove unnecessary duplicated version number
- Fix whitespaces

Change-Id: I7462869a473a7afe2e9ed9474c69de0af96c011c
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M contrib/vcpkg-ports/pkcs11-helper/portfile.cmake
M contrib/vcpkg-ports/pkcs11-helper/vcpkg.json
2 files changed, 26 insertions(+), 25 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/18/1518/1

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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7462869a473a7afe2e9ed9474c69de0af96c011c
Gerrit-Change-Number: 1518
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--cbJUvskkbqU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1518?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">vcpkg-ports: Review pkcs11-helper port<br><=
br>- Replace deprecated functions with newer alternatives<br>- Improve vcpk=
g.json by documenting openssl dependency<br>- Remove unnecessary duplicated=
 version number<br>- Fix whitespaces<br><br>Change-Id: I7462869a473a7afe2e9=
ed9474c69de0af96c011c<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2746...=
...&gt;<br>---<br>M contrib/vcpkg-ports/pkcs11-helper/portfile.cmake<br>M c=
ontrib/vcpkg-ports/pkcs11-helper/vcpkg.json<br>2 files changed, 26 insertio=
ns(+), 25 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.ope=
nvpn.net:29418/openvpn refs/changes/18/1518/1</pre><pre style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/contrib/=
vcpkg-ports/pkcs11-helper/portfile.cmake b/contrib/vcpkg-ports/pkcs11-helpe=
r/portfile.cmake</span><br><span>index af19831..f5742a4 100644</span><br><s=
pan>--- a/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake</span><br><span>=
+++ b/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake</span><br><span>@@ -=
1,15 +1,12 @@</span><br><span style=3D"color: hsl(0, 100%, 40%);">-set(VERS=
ION 1.31.0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span> vcpkg_download_distfile(ARCHIVE</span><br><span>     URLS &quot;htt=
ps://github.com/OpenSC/pkcs11-helper/releases/download/pkcs11-helper-${VERS=
ION}/pkcs11-helper-${VERSION}.tar.bz2&quot;</span><br><span>     FILENAME &=
quot;pkcs11-helper-${VERSION}.tar.bz2&quot;</span><br><span>     SHA512 083=
3efc59e9093dd398a54640d858b01a830ef7adfb40321c1e0ed0afa004500fc1259cc66bc49=
c5263935adeda0a3bfe658de538eefd66888685a71f731c484</span><br><span> )</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-vcpkg_ext=
ract_source_archive_ex(</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    OUT_SOURCE_PATH SOURCE_PATH</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+vcpkg_extract_source_archive(</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    SOURCE_PATH</span><br><span>     ARCHIVE ${ARCH=
IVE}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    REF ${VERSION=
}</span><br><span>     PATCHES</span><br><span>         nmake-compatibility=
-with-vcpkg-nmake.patch</span><br><span>         config-w32-vc.h.in-indicat=
e-OpenSSL.patch</span><br><span>@@ -33,20 +30,20 @@</span><br><span>   file=
(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/lib/libpkcs11-help=
er-1.dll DESTINATION ${CURRENT_PACKAGES_DIR}/debug/bin)</span><br><span> </=
span><br><span>   set(PACKAGE_VERSION &quot;${VERSION}&quot;)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    set(libdir [[${prefix}/lib]])</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    set(exec_prefix [[$=
{prefix}]])</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    set(PK=
CS11H_FEATURES key_prompt openssl engine_crypto_cryptoapi engine_crypto_ope=
nssl debug threading token data certificate slotevent engine_crypto)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    set(LIBS -lkernel32 -lus=
er32 -lgdi32 -lwinspool -lshell32 -lole32 -loleaut32 -luuid -lcomdlg32 -lad=
vapi32)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if(NOT DEF=
INED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL &quot;release&quot;)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        set(includedir [[=
${prefix}/include]])</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       set(outfile &quot;${CURRENT_PACKAGES_DIR}/lib/pkgconfig/libpkcs11-he=
lper-1.pc&quot;)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   configure_file(&quot;${SOURCE_PATH}/lib/libpkcs11-helper-1.pc.in&quot; &=
quot;${outfile}&quot; @ONLY)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    endif()</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL &quot;debug&q=
uot;)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        set(incl=
udedir [[${prefix}/../include]])</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        set(outfile &quot;${CURRENT_PACKAGES_DIR}/debug/lib/pkgc=
onfig/libpkcs11-helper-1.pc&quot;)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        configure_file(&quot;${SOURCE_PATH}/lib/libpkcs11-help=
er-1.pc.in&quot; &quot;${outfile}&quot; @ONLY)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    endif()</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  set(libdir [[${prefix}/lib]])</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  set(exec_prefix [[${prefix}]])</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+  set(PKCS11H_FEATURES key_prompt=
 openssl engine_crypto_cryptoapi engine_crypto_openssl debug threading toke=
n data certificate slotevent engine_crypto)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+  set(LIBS -lkernel32 -luser32 -lgdi32 -lwinspool -=
lshell32 -lole32 -loleaut32 -luuid -lcomdlg32 -ladvapi32)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+  if(NOT DEFINED VCPKG_BUILD_TYPE OR =
VCPKG_BUILD_TYPE STREQUAL &quot;release&quot;)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+      set(includedir [[${prefix}/include]])</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+      set(outfile &quot;=
${CURRENT_PACKAGES_DIR}/lib/pkgconfig/libpkcs11-helper-1.pc&quot;)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+      configure_file(&quot;$=
{SOURCE_PATH}/lib/libpkcs11-helper-1.pc.in&quot; &quot;${outfile}&quot; @ON=
LY)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  endif()</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  if(NOT DEFINED VCPKG_BUI=
LD_TYPE OR VCPKG_BUILD_TYPE STREQUAL &quot;debug&quot;)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+      set(includedir [[${prefix}/../inc=
lude]])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      set(ou=
tfile &quot;${CURRENT_PACKAGES_DIR}/debug/lib/pkgconfig/libpkcs11-helper-1.=
pc&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      conf=
igure_file(&quot;${SOURCE_PATH}/lib/libpkcs11-helper-1.pc.in&quot; &quot;${=
outfile}&quot; @ONLY)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  endif()</span><br><span> </span><br><span>   file(INSTALL ${SOURCE_PATH=
}/include/pkcs11-helper-1.0 DESTINATION ${CURRENT_PACKAGES_DIR}/include/)</=
span><br><span> </span><br><span>@@ -66,4 +63,4 @@</span><br><span> vcpkg_f=
ixup_pkgconfig()</span><br><span> vcpkg_copy_pdbs()</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-file(INSTALL ${SOURCE_PATH}=
/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+vcpkg_install_copy=
right(FILE_LIST &quot;${SOURCE_PATH}/COPYING&quot;)</span><br><span>diff --=
git a/contrib/vcpkg-ports/pkcs11-helper/vcpkg.json b/contrib/vcpkg-ports/pk=
cs11-helper/vcpkg.json</span><br><span>index 382a3d3..da54646 100644</span>=
<br><span>--- a/contrib/vcpkg-ports/pkcs11-helper/vcpkg.json</span><br><spa=
n>+++ b/contrib/vcpkg-ports/pkcs11-helper/vcpkg.json</span><br><span>@@ -1,=
7 +1,11 @@</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    &quot;name&quot;: &quot;pkcs11-helper&quot;,</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    &quot;version&quot;: &quot;1.31.0&qu=
ot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &quot;descrip=
tion&quot;: &quot;pkcs11-helper is a library that simplifies the interactio=
n with PKCS#11 providers for end-user applications.&quot;,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    &quot;homepage&quot;: &quot;https:=
//github.com/OpenSC/pkcs11-helper&quot;,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    &quot;license&quot;: &quot;BSD-3-Clause OR GPL-2.0-o=
nly&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &quot;$s=
chema&quot;: &quot;https://raw.githubusercontent.com/microsoft/vcpkg/master=
/scripts/vcpkg.schema.json&quot;,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+  &quot;name&quot;: &quot;pkcs11-helper&quot;,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  &quot;version&quot;: &quot;1.31.=
0&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &quot;des=
cription&quot;: &quot;pkcs11-helper is a library that simplifies the intera=
ction with PKCS#11 providers for end-user applications.&quot;,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  &quot;homepage&quot;: &quot;ht=
tps://github.com/OpenSC/pkcs11-helper&quot;,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+  &quot;license&quot;: &quot;BSD-3-Clause OR GPL-2=
.0-only&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &qu=
ot;dependencies&quot;: [</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    &quot;openssl&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  ]</span><br><span> }</span><br><span></span><br></pre><p>To view=
, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1518?usp=3Demail">=
change 1518</a>. To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><=
div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1518?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7462869a473a7afe2e9ed9474c6=
9de0af96c011c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1518 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--cbJUvskkbqU=--

