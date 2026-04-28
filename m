From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 28 Apr 2026 13:56:33 +0000
In-Reply-To: <gerrit.1777376956000.Icfa559d9923d7dacb4b72e47b22688a4225c4708@...2715...>
References: <gerrit.1777376956000.Icfa559d9923d7dacb4b72e47b22688a4225c4708@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <5269e14c63335228f0ce296d0091b14285bc37d8-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Q84hIyZ3n88="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Q84hIyZ3n88=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1640?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/40/1640/2

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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Icfa559d9923d7dacb4b72e47b22688a4225c4708
Gerrit-Change-Number: 1640
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Q84hIyZ3n88=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1640?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by flichtenheld</p><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">Fix pkgcs11 vcpkg port insta=
lling debug files on release builds<br><br>Change-Id: Icfa559d9923d7dacb4b7=
2e47b22688a4225c4708<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2724...=
..&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Gerrit UR=
L: https://gerrit.openvpn.net/c/openvpn/+/1640<br>Message-Id: &lt;202604281=
24810.29709-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/open=
vpn-devel@lists.sourceforge.net/msg36762.html<br>Signed-off-by: Gert Doerin=
g &lt;gert@...1296...&gt;<br>---<br>M contrib/vcpkg-ports/pkcs11-helper/por=
tfile.cmake<br>1 file changed, 8 insertions(+), 5 deletions(-)<br><br></pre=
><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes=
/40/1640/2</pre><pre style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;"><span>diff --git a/contrib/vcpkg-ports/pkcs11-helper/portfile.=
cmake b/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake</span><br><span>in=
dex f5742a4..8186719 100644</span><br><span>--- a/contrib/vcpkg-ports/pkcs1=
1-helper/portfile.cmake</span><br><span>+++ b/contrib/vcpkg-ports/pkcs11-he=
lper/portfile.cmake</span><br><span>@@ -23,11 +23,14 @@</span><br><span>   =
      OPENSSL_HOME=3D${CURRENT_PACKAGES_DIR}/../openssl_${TARGET_TRIPLET}</=
span><br><span>   )</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-  file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-=
rel/lib/pkcs11-helper.dll.lib DESTINATION ${CURRENT_PACKAGES_DIR}/lib RENAM=
E pkcs11-helper.lib)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
 file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/lib/pkcs11-he=
lper.dll.lib DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib RENAME pkcs11-he=
lper.lib)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-  file(INSTALL ${CURRENT_BUILDTRE=
ES_DIR}/${TARGET_TRIPLET}-rel/lib/libpkcs11-helper-1.dll DESTINATION ${CURR=
ENT_PACKAGES_DIR}/bin)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-  file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/lib/libpkcs=
11-helper-1.dll DESTINATION ${CURRENT_PACKAGES_DIR}/debug/bin)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  if(NOT DEFINED VCPKG_BUILD_TYP=
E OR VCPKG_BUILD_TYPE STREQUAL &quot;release&quot;)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    file(INSTALL ${CURRENT_BUILDTREES_DIR=
}/${TARGET_TRIPLET}-rel/lib/pkcs11-helper.dll.lib DESTINATION ${CURRENT_PAC=
KAGES_DIR}/lib RENAME pkcs11-helper.lib)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TR=
IPLET}-rel/lib/libpkcs11-helper-1.dll DESTINATION ${CURRENT_PACKAGES_DIR}/b=
in)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  endif()</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  if(NOT DEFINED VCPKG_BUI=
LD_TYPE OR VCPKG_BUILD_TYPE STREQUAL &quot;debug&quot;)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    file(INSTALL ${CURRENT_BUILDTREES_D=
IR}/${TARGET_TRIPLET}-dbg/lib/pkcs11-helper.dll.lib DESTINATION ${CURRENT_P=
ACKAGES_DIR}/debug/lib RENAME pkcs11-helper.lib)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    file(INSTALL ${CURRENT_BUILDTREES_DIR}/${T=
ARGET_TRIPLET}-dbg/lib/libpkcs11-helper-1.dll DESTINATION ${CURRENT_PACKAGE=
S_DIR}/debug/bin)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
endif()</span><br><span> </span><br><span>   set(PACKAGE_VERSION &quot;${VE=
RSION}&quot;)</span><br><span>   set(libdir [[${prefix}/lib]])</span><br><s=
pan></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/1640?usp=3Demail">change 1640</a>. To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?=
usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/=
EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.=
org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/1640?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
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

--Q84hIyZ3n88=--

