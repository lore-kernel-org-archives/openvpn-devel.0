From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 28 Apr 2026 13:56:36 +0000
In-Reply-To: <gerrit.1777376956000.Icfa559d9923d7dacb4b72e47b22688a4225c4708@...2715...>
References: <gerrit.1777376956000.Icfa559d9923d7dacb4b72e47b22688a4225c4708@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <5269e14c63335228f0ce296d0091b14285bc37d8-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="CHmFOX1AFh4="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Fix pkgcs11 vcpkg
 port installing debug files on release builds
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--CHmFOX1AFh4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/16=
40?usp=3Demail )

Change subject: Fix pkgcs11 vcpkg port installing debug files on release bu=
ilds
......................................................................

Fix pkgcs11 vcpkg port installing debug files on release builds

Change-Id: Icfa559d9923d7dacb4b72e47b22688a4225c4708
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1640
Message-Id: <20260428124810.29709-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36=
762.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M contrib/vcpkg-ports/pkcs11-helper/portfile.cmake
1 file changed, 8 insertions(+), 5 deletions(-)




diff --git a/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake b/contrib/vcp=
kg-ports/pkcs11-helper/portfile.cmake
index f5742a4..8186719 100644
--- a/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake
+++ b/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake
@@ -23,11 +23,14 @@
         OPENSSL_HOME=3D${CURRENT_PACKAGES_DIR}/../openssl_${TARGET_TRIPLET}
   )

-  file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/lib/pkcs11-=
helper.dll.lib DESTINATION ${CURRENT_PACKAGES_DIR}/lib RENAME pkcs11-helper=
.lib)
-  file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/lib/pkcs11-=
helper.dll.lib DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib RENAME pkcs11-=
helper.lib)
-
-  file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/lib/libpkcs=
11-helper-1.dll DESTINATION ${CURRENT_PACKAGES_DIR}/bin)
-  file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/lib/libpkcs=
11-helper-1.dll DESTINATION ${CURRENT_PACKAGES_DIR}/debug/bin)
+  if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "release")
+    file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/lib/pkcs1=
1-helper.dll.lib DESTINATION ${CURRENT_PACKAGES_DIR}/lib RENAME pkcs11-help=
er.lib)
+    file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/lib/libpk=
cs11-helper-1.dll DESTINATION ${CURRENT_PACKAGES_DIR}/bin)
+  endif()
+  if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "debug")
+    file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/lib/pkcs1=
1-helper.dll.lib DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib RENAME pkcs1=
1-helper.lib)
+    file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/lib/libpk=
cs11-helper-1.dll DESTINATION ${CURRENT_PACKAGES_DIR}/debug/bin)
+  endif()

   set(PACKAGE_VERSION "${VERSION}")
   set(libdir [[${prefix}/lib]])

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1640?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Icfa559d9923d7dacb4b72e47b22688a4225c4708
Gerrit-Change-Number: 1640
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--CHmFOX1AFh4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1640?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">Fix pkgcs11 vcpkg port installing debug files on=
 release builds<br><br>Change-Id: Icfa559d9923d7dacb4b72e47b22688a4225c4708=
<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: =
Frank Lichtenheld &lt;frank@...2641...&gt;<br>Gerrit URL: https://gerrit.op=
envpn.net/c/openvpn/+/1640<br>Message-Id: &lt;20260428124810.29709-1-gert@...220...=
..1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1439...=
ceforge.net/msg36762.html<br>Signed-off-by: Gert Doering &lt;gert@...2132...=
.&gt;<br>---<br>M contrib/vcpkg-ports/pkcs11-helper/portfile.cmake<br>1 fil=
e changed, 8 insertions(+), 5 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake b/contrib/=
vcpkg-ports/pkcs11-helper/portfile.cmake</span><br><span>index f5742a4..818=
6719 100644</span><br><span>--- a/contrib/vcpkg-ports/pkcs11-helper/portfil=
e.cmake</span><br><span>+++ b/contrib/vcpkg-ports/pkcs11-helper/portfile.cm=
ake</span><br><span>@@ -23,11 +23,14 @@</span><br><span>         OPENSSL_HO=
ME=3D${CURRENT_PACKAGES_DIR}/../openssl_${TARGET_TRIPLET}</span><br><span> =
  )</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
  file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/lib/pkcs11-h=
elper.dll.lib DESTINATION ${CURRENT_PACKAGES_DIR}/lib RENAME pkcs11-helper.=
lib)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  file(INSTALL ${=
CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/lib/pkcs11-helper.dll.lib DES=
TINATION ${CURRENT_PACKAGES_DIR}/debug/lib RENAME pkcs11-helper.lib)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-  file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET=
_TRIPLET}-rel/lib/libpkcs11-helper-1.dll DESTINATION ${CURRENT_PACKAGES_DIR=
}/bin)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  file(INSTALL =
${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/lib/libpkcs11-helper-1.dll =
DESTINATION ${CURRENT_PACKAGES_DIR}/debug/bin)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+  if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD=
_TYPE STREQUAL &quot;release&quot;)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET=
}-rel/lib/pkcs11-helper.dll.lib DESTINATION ${CURRENT_PACKAGES_DIR}/lib REN=
AME pkcs11-helper.lib)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/lib/lib=
pkcs11-helper-1.dll DESTINATION ${CURRENT_PACKAGES_DIR}/bin)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  endif()</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+  if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_B=
UILD_TYPE STREQUAL &quot;debug&quot;)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPL=
ET}-dbg/lib/pkcs11-helper.dll.lib DESTINATION ${CURRENT_PACKAGES_DIR}/debug=
/lib RENAME pkcs11-helper.lib)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg=
/lib/libpkcs11-helper-1.dll DESTINATION ${CURRENT_PACKAGES_DIR}/debug/bin)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+  endif()</span><br>=
<span> </span><br><span>   set(PACKAGE_VERSION &quot;${VERSION}&quot;)</spa=
n><br><span>   set(libdir [[${prefix}/lib]])</span><br><span></span><br></p=
re><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1640?=
usp=3Demail">change 1640</a>. To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">setti=
ngs</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><l=
ink itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1640?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Icfa559d9923d7dacb4b72e47b22=
688a4225c4708 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1640 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--CHmFOX1AFh4=--

