From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 28 Apr 2026 11:49:19 +0000
References: <gerrit.1777376956000.Icfa559d9923d7dacb4b72e47b22688a4225c4708@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <22334e3062b2d1edf9b178e2ac646fdc3538d32a-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dWCwUjJKNMc="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--dWCwUjJKNMc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1640?usp=3Demail

to review the following change.


Change subject: Fix pkgcs11 vcpkg port installing debug files on release bu=
ilds
......................................................................

Fix pkgcs11 vcpkg port installing debug files on release builds

Change-Id: Icfa559d9923d7dacb4b72e47b22688a4225c4708
---
M contrib/vcpkg-ports/pkcs11-helper/portfile.cmake
1 file changed, 8 insertions(+), 5 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/40/1640/1

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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Icfa559d9923d7dacb4b72e47b22688a4225c4708
Gerrit-Change-Number: 1640
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--dWCwUjJKNMc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1640?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">Fix pkgcs11 vcpkg port installing debug fil=
es on release builds<br><br>Change-Id: Icfa559d9923d7dacb4b72e47b22688a4225=
c4708<br>---<br>M contrib/vcpkg-ports/pkcs11-helper/portfile.cmake<br>1 fil=
e changed, 8 insertions(+), 5 deletions(-)<br><br></pre><pre class=3D"block=
s" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git p=
ull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/40/1640/1</pre><pre=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>d=
iff --git a/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake b/contrib/vcpk=
g-ports/pkcs11-helper/portfile.cmake</span><br><span>index f5742a4..8186719=
 100644</span><br><span>--- a/contrib/vcpkg-ports/pkcs11-helper/portfile.cm=
ake</span><br><span>+++ b/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake<=
/span><br><span>@@ -23,11 +23,14 @@</span><br><span>         OPENSSL_HOME=
=3D${CURRENT_PACKAGES_DIR}/../openssl_${TARGET_TRIPLET}</span><br><span>   =
)</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/lib/pkcs11-hel=
per.dll.lib DESTINATION ${CURRENT_PACKAGES_DIR}/lib RENAME pkcs11-helper.li=
b)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  file(INSTALL ${CU=
RRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/lib/pkcs11-helper.dll.lib DESTI=
NATION ${CURRENT_PACKAGES_DIR}/debug/lib RENAME pkcs11-helper.lib)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-  file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_T=
RIPLET}-rel/lib/libpkcs11-helper-1.dll DESTINATION ${CURRENT_PACKAGES_DIR}/=
bin)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  file(INSTALL ${=
CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/lib/libpkcs11-helper-1.dll DE=
STINATION ${CURRENT_PACKAGES_DIR}/debug/bin)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+  if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_T=
YPE STREQUAL &quot;release&quot;)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-=
rel/lib/pkcs11-helper.dll.lib DESTINATION ${CURRENT_PACKAGES_DIR}/lib RENAM=
E pkcs11-helper.lib)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/lib/libpk=
cs11-helper-1.dll DESTINATION ${CURRENT_PACKAGES_DIR}/bin)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  endif()</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUI=
LD_TYPE STREQUAL &quot;debug&quot;)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET=
}-dbg/lib/pkcs11-helper.dll.lib DESTINATION ${CURRENT_PACKAGES_DIR}/debug/l=
ib RENAME pkcs11-helper.lib)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/l=
ib/libpkcs11-helper-1.dll DESTINATION ${CURRENT_PACKAGES_DIR}/debug/bin)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+  endif()</span><br><s=
pan> </span><br><span>   set(PACKAGE_VERSION &quot;${VERSION}&quot;)</span>=
<br><span>   set(libdir [[${prefix}/lib]])</span><br><span></span><br></pre=
><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1640?us=
p=3Demail">change 1640</a>. To unsubscribe, or for help writing mail filter=
s, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">setting=
s</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><lin=
k itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1640?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Icfa559d9923d7dacb4b72e47b22=
688a4225c4708 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1640 </div>
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

--dWCwUjJKNMc=--

