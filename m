From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 9 May 2025 10:19:16 +0000
In-Reply-To: <gerrit.1743171486000.I28af9eac2e9fb615903a82c8f4087602b72c134d@...2715...>
References: <gerrit.1743171486000.I28af9eac2e9fb615903a82c8f4087602b72c134d@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <858ce927810623092225a56aa6369e5b6965221e-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="bIicCEQUz+Y="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: CMake: Sync list of
 compiler flags with configure.ac
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

--bIicCEQUz+Y=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/923?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos


Change subject: CMake: Sync list of compiler flags with configure.ac
......................................................................

CMake: Sync list of compiler flags with configure.ac

Also fix one issue reported by the build.

Change-Id: I28af9eac2e9fb615903a82c8f4087602b72c134d
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Message-Id: <20250509090936.18818-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31=
604.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M CMakeLists.txt
M tests/unit_tests/openvpn/test_cryptoapi.c
2 files changed, 11 insertions(+), 6 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/23/923/3

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 6687b56..c19d29a 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -66,6 +66,13 @@
     CACHE STRING "Flags used by the C++ compiler during AddressSanitizer b=
uilds."
     FORCE)

+function(check_and_add_compiler_flag flag variable)
+    check_c_compiler_flag(${flag} ${variable})
+    if (${variable})
+        add_compile_options(${flag})
+    endif()
+endfunction()
+
 if (MSVC)
     add_definitions(-D_CRT_SECURE_NO_WARNINGS -D_CRT_NONSTDC_NO_DEPRECATE =
-D_WINSOCK_DEPRECATED_NO_WARNINGS)
     if (USE_WERROR)
@@ -96,11 +103,9 @@
     endif()
 else ()
     add_compile_options(-Wall -Wuninitialized)
-    check_c_compiler_flag(-Wno-stringop-truncation NoStringOpTruncation)
-
-    if (${NoStringOpTruncation})
-        add_compile_options(-Wno-stringop-truncation)
-    endif()
+    check_and_add_compiler_flag(-Wno-stringop-truncation NoStringOpTruncat=
ion)
+    check_and_add_compiler_flag(-Wstrict-prototypes StrictPrototypes)
+    check_and_add_compiler_flag(-Wold-style-definition OldStyleDefinition)
     # We are not ready for this
     #add_compile_options(-Wconversion -Wno-sign-conversion -Wsign-compare)
     if (USE_WERROR)
diff --git a/tests/unit_tests/openvpn/test_cryptoapi.c b/tests/unit_tests/o=
penvpn/test_cryptoapi.c
index 98102ef..478995f 100644
--- a/tests/unit_tests/openvpn/test_cryptoapi.c
+++ b/tests/unit_tests/openvpn/test_cryptoapi.c
@@ -116,7 +116,7 @@

 /* Fill-in certs[] array */
 void
-init_cert_data()
+init_cert_data(void)
 {
     struct test_cert certs_local[] =3D {
         {cert1,  key1,  cname1,  "OVPN TEST CA1",  "OVPN Test Cert 1",  ha=
sh1,  1},

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/923?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I28af9eac2e9fb615903a82c8f4087602b72c134d
Gerrit-Change-Number: 923
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--bIicCEQUz+Y=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #3</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/923?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by plaisthos</p><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">CMake: Sync list of compiler flags with configur=
e.ac<br><br>Also fix one issue reported by the build.<br><br>Change-Id: I28=
af9eac2e9fb615903a82c8f4087602b72c134d<br>Signed-off-by: Frank Lichtenheld =
&lt;frank@...2641...&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@...1830...=
...&gt;<br>Message-Id: &lt;20250509090936.18818-1-gert@...1296...&gt;<br>UR=
L: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg3160=
4.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M C=
MakeLists.txt<br>M tests/unit_tests/openvpn/test_cryptoapi.c<br>2 files cha=
nged, 11 insertions(+), 6 deletions(-)<br><br></pre><pre style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.open=
vpn.net:29418/openvpn refs/changes/23/923/3</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/CMakeLists=
.txt b/CMakeLists.txt</span><br><span>index 6687b56..c19d29a 100644</span><=
br><span>--- a/CMakeLists.txt</span><br><span>+++ b/CMakeLists.txt</span><b=
r><span>@@ -66,6 +66,13 @@</span><br><span>     CACHE STRING &quot;Flags us=
ed by the C++ compiler during AddressSanitizer builds.&quot;</span><br><spa=
n>     FORCE)</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+function(check_and_add_compiler_flag flag variable)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    check_c_compiler_flag(${fla=
g} ${variable})</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (${variable})</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     add_compile_options(${flag})</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    endif()</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+endfunction()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span> if (MSVC)</span><br><span>     add_definitions(-D_CRT_SEC=
URE_NO_WARNINGS -D_CRT_NONSTDC_NO_DEPRECATE -D_WINSOCK_DEPRECATED_NO_WARNIN=
GS)</span><br><span>     if (USE_WERROR)</span><br><span>@@ -96,11 +103,9 @=
@</span><br><span>     endif()</span><br><span> else ()</span><br><span>   =
  add_compile_options(-Wall -Wuninitialized)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    check_c_compiler_flag(-Wno-stringop-truncation N=
oStringOpTruncation)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (${NoStringOpTr=
uncation})</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        add=
_compile_options(-Wno-stringop-truncation)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    endif()</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    check_and_add_compiler_flag(-Wno-stringop-truncation NoStr=
ingOpTruncation)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 check_and_add_compiler_flag(-Wstrict-prototypes StrictPrototypes)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    check_and_add_compiler_f=
lag(-Wold-style-definition OldStyleDefinition)</span><br><span>     # We ar=
e not ready for this</span><br><span>     #add_compile_options(-Wconversion=
 -Wno-sign-conversion -Wsign-compare)</span><br><span>     if (USE_WERROR)<=
/span><br><span>diff --git a/tests/unit_tests/openvpn/test_cryptoapi.c b/te=
sts/unit_tests/openvpn/test_cryptoapi.c</span><br><span>index 98102ef..4789=
95f 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_cryptoapi.c<=
/span><br><span>+++ b/tests/unit_tests/openvpn/test_cryptoapi.c</span><br><=
span>@@ -116,7 +116,7 @@</span><br><span> </span><br><span> /* Fill-in cert=
s[] array */</span><br><span> void</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-init_cert_data()</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+init_cert_data(void)</span><br><span> {</span><br><span>     stru=
ct test_cert certs_local[] =3D {</span><br><span>         {cert1,  key1,  c=
name1,  &quot;OVPN TEST CA1&quot;,  &quot;OVPN Test Cert 1&quot;,  hash1,  =
1},</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/923?usp=3Demail">change 923</a>. To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn=
.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.or=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/923?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I28af9eac2e9fb615903a82c8f40=
87602b72c134d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 923 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--bIicCEQUz+Y=--

