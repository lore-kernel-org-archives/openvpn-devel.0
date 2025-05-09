From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 9 May 2025 10:19:19 +0000
In-Reply-To: <gerrit.1743171486000.I28af9eac2e9fb615903a82c8f4087602b72c134d@...2715...>
References: <gerrit.1743171486000.I28af9eac2e9fb615903a82c8f4087602b72c134d@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <858ce927810623092225a56aa6369e5b6965221e-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+CA2pn3B9yI="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--+CA2pn3B9yI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/92=
3?usp=3Demail )

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
Gerrit-MessageType: merged

--+CA2pn3B9yI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/923?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">CMake: Sync list of compiler flags with config=
ure.ac<br><br>Also fix one issue reported by the build.<br><br>Change-Id: I=
28af9eac2e9fb615903a82c8f4087602b72c134d<br>Signed-off-by: Frank Lichtenhel=
d &lt;frank@...2641...&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@...1711...=
27...&gt;<br>Message-Id: &lt;20250509090936.18818-1-gert@...1296...&gt;<br>=
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31=
604.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M=
 CMakeLists.txt<br>M tests/unit_tests/openvpn/test_cryptoapi.c<br>2 files c=
hanged, 11 insertions(+), 6 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/CMakeLists.txt b/CMakeLists.txt</span><br><span>index 6687b=
56..c19d29a 100644</span><br><span>--- a/CMakeLists.txt</span><br><span>+++=
 b/CMakeLists.txt</span><br><span>@@ -66,6 +66,13 @@</span><br><span>     C=
ACHE STRING &quot;Flags used by the C++ compiler during AddressSanitizer bu=
ilds.&quot;</span><br><span>     FORCE)</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+function(check_and_add_compiler_flag =
flag variable)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=
heck_c_compiler_flag(${flag} ${variable})</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (${variable})</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        add_compile_options(${flag})</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    endif()</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+endfunction()</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span> if (MSVC)</span><br><span>   =
  add_definitions(-D_CRT_SECURE_NO_WARNINGS -D_CRT_NONSTDC_NO_DEPRECATE -D_=
WINSOCK_DEPRECATED_NO_WARNINGS)</span><br><span>     if (USE_WERROR)</span>=
<br><span>@@ -96,11 +103,9 @@</span><br><span>     endif()</span><br><span>=
 else ()</span><br><span>     add_compile_options(-Wall -Wuninitialized)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    check_c_compiler_fla=
g(-Wno-stringop-truncation NoStringOpTruncation)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    if (${NoStringOpTruncation})</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        add_compile_options(-Wno-stringop-truncation)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    endif()</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    check_and_add_compiler_flag(-W=
no-stringop-truncation NoStringOpTruncation)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    check_and_add_compiler_flag(-Wstrict-prototype=
s StrictPrototypes)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    check_and_add_compiler_flag(-Wold-style-definition OldStyleDefinition)<=
/span><br><span>     # We are not ready for this</span><br><span>     #add_=
compile_options(-Wconversion -Wno-sign-conversion -Wsign-compare)</span><br=
><span>     if (USE_WERROR)</span><br><span>diff --git a/tests/unit_tests/o=
penvpn/test_cryptoapi.c b/tests/unit_tests/openvpn/test_cryptoapi.c</span><=
br><span>index 98102ef..478995f 100644</span><br><span>--- a/tests/unit_tes=
ts/openvpn/test_cryptoapi.c</span><br><span>+++ b/tests/unit_tests/openvpn/=
test_cryptoapi.c</span><br><span>@@ -116,7 +116,7 @@</span><br><span> </spa=
n><br><span> /* Fill-in certs[] array */</span><br><span> void</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-init_cert_data()</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+init_cert_data(void)</span><br><span>=
 {</span><br><span>     struct test_cert certs_local[] =3D {</span><br><spa=
n>         {cert1,  key1,  cname1,  &quot;OVPN TEST CA1&quot;,  &quot;OVPN =
Test Cert 1&quot;,  hash1,  1},</span><br><span></span><br></pre><p>To view=
, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/923?usp=3Demail">c=
hange 923</a>. To unsubscribe, or for help writing mail filters, visit <a h=
ref=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope =
itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/923?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--+CA2pn3B9yI=--

