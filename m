From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 28 Mar 2025 14:18:11 +0000
References: <gerrit.1743171486000.I28af9eac2e9fb615903a82c8f4087602b72c134d@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <5caccc1f9db32ffeba9640cd2f082e7a8a9aad7a-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="nwfeAZfDAyI="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--nwfeAZfDAyI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/923?usp=3Demail

to review the following change.


Change subject: CMake: Sync list of compiler flags with configure.ac
......................................................................

CMake: Sync list of compiler flags with configure.ac

Also fix one issue reported by the build.

Change-Id: I28af9eac2e9fb615903a82c8f4087602b72c134d
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M CMakeLists.txt
M tests/unit_tests/openvpn/test_cryptoapi.c
2 files changed, 11 insertions(+), 6 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/23/923/1

diff --git a/CMakeLists.txt b/CMakeLists.txt
index b04adce..ba11056 100644
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
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--nwfeAZfDAyI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/923?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">CMake: Sync list of compiler flags with configure.ac<br><br>A=
lso fix one issue reported by the build.<br><br>Change-Id: I28af9eac2e9fb61=
5903a82c8f4087602b72c134d<br>Signed-off-by: Frank Lichtenheld &lt;frank@...493...=
2641...&gt;<br>---<br>M CMakeLists.txt<br>M tests/unit_tests/openvpn/test_c=
ryptoapi.c<br>2 files changed, 11 insertions(+), 6 deletions(-)<br><br></pr=
e><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">g=
it pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/23/923/1</pre><=
pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><spa=
n>diff --git a/CMakeLists.txt b/CMakeLists.txt</span><br><span>index b04adc=
e..ba11056 100644</span><br><span>--- a/CMakeLists.txt</span><br><span>+++ =
b/CMakeLists.txt</span><br><span>@@ -66,6 +66,13 @@</span><br><span>     CA=
CHE STRING &quot;Flags used by the C++ compiler during AddressSanitizer bui=
lds.&quot;</span><br><span>     FORCE)</span><br><span> </span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+function(check_and_add_compiler_flag f=
lag variable)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ch=
eck_c_compiler_flag(${flag} ${variable})</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (${variable})</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        add_compile_options(${flag})</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    endif()</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+endfunction()</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span> if (MSVC)</span><br><span>     a=
dd_definitions(-D_CRT_SECURE_NO_WARNINGS -D_CRT_NONSTDC_NO_DEPRECATE -D_WIN=
SOCK_DEPRECATED_NO_WARNINGS)</span><br><span>     if (USE_WERROR)</span><br=
><span>@@ -96,11 +103,9 @@</span><br><span>     endif()</span><br><span> el=
se ()</span><br><span>     add_compile_options(-Wall -Wuninitialized)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    check_c_compiler_flag(-=
Wno-stringop-truncation NoStringOpTruncation)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    if (${NoStringOpTruncation})</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        add_compile_options(-Wno-stringop-truncation)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    endif()</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    check_and_add_compiler_flag(-Wno-=
stringop-truncation NoStringOpTruncation)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    check_and_add_compiler_flag(-Wstrict-prototypes S=
trictPrototypes)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 check_and_add_compiler_flag(-Wold-style-definition OldStyleDefinition)</sp=
an><br><span>     # We are not ready for this</span><br><span>     #add_com=
pile_options(-Wconversion -Wno-sign-conversion -Wsign-compare)</span><br><s=
pan>     if (USE_WERROR)</span><br><span>diff --git a/tests/unit_tests/open=
vpn/test_cryptoapi.c b/tests/unit_tests/openvpn/test_cryptoapi.c</span><br>=
<span>index 98102ef..478995f 100644</span><br><span>--- a/tests/unit_tests/=
openvpn/test_cryptoapi.c</span><br><span>+++ b/tests/unit_tests/openvpn/tes=
t_cryptoapi.c</span><br><span>@@ -116,7 +116,7 @@</span><br><span> </span><=
br><span> /* Fill-in certs[] array */</span><br><span> void</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-init_cert_data()</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+init_cert_data(void)</span><br><span> {<=
/span><br><span>     struct test_cert certs_local[] =3D {</span><br><span> =
        {cert1,  key1,  cname1,  &quot;OVPN TEST CA1&quot;,  &quot;OVPN Tes=
t Cert 1&quot;,  hash1,  1},</span><br><span></span><br></pre><p>To view, v=
isit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/923?usp=3Demail">chan=
ge 923</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/923?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I28af9eac2e9fb615903a82c8f40=
87602b72c134d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 923 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--nwfeAZfDAyI=--

