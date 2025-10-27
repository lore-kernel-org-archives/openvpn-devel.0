From: "selvanair (Code Review)" <gerrit@...515...>
Date: Mon, 27 Oct 2025 20:27:04 +0000
References: <gerrit.1761596820000.I8e884c00cb94f97a612056e8dca74d821a6d6386@...2715...>
Reply-To: selva.nair@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <fee6bd23cc285c884845e2beb9c95a85beba947e-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="TTx2tUyiomU="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Canonicalize
 config_dir before comparing with the config file location
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--TTx2tUyiomU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1318?usp=3Demail

to review the following change.


Change subject: Canonicalize config_dir before comparing with the config fi=
le location
......................................................................

Canonicalize config_dir before comparing with the config file location

Found by ZeroPath

Change-Id: I8e884c00cb94f97a612056e8dca74d821a6d6386
Signed-off-by: Selva Nair <selva.nair@...277...>
---
M src/openvpnserv/CMakeLists.txt
M src/openvpnserv/validate.c
2 files changed, 17 insertions(+), 4 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/18/1318/1

diff --git a/src/openvpnserv/CMakeLists.txt b/src/openvpnserv/CMakeLists.txt
index 340b904..a92ee08 100644
--- a/src/openvpnserv/CMakeLists.txt
+++ b/src/openvpnserv/CMakeLists.txt
@@ -6,6 +6,11 @@

 add_executable(openvpnserv)

+include(CheckSymbolExists)
+
+# Some old versions of mingw does not have PATHCCH_OPTIONS enums -- add a =
check
+check_symbol_exists(PATHCCH_ENSURE_TRAILING_SLASH pathcch.h HAVE_PATHCCH_E=
NSURE_TRAILING_SLASH)
+
 set(MC_GEN_DIR ${CMAKE_CURRENT_BINARY_DIR}/mc)

 target_include_directories(openvpnserv PRIVATE
@@ -31,7 +36,7 @@
     )
 target_link_libraries(openvpnserv
     advapi32.lib userenv.lib iphlpapi.lib fwpuclnt.lib rpcrt4.lib
-    shlwapi.lib netapi32.lib ws2_32.lib ntdll.lib ole32.lib)
+    shlwapi.lib netapi32.lib ws2_32.lib ntdll.lib ole32.lib pathcch.lib)
 if (MINGW)
     target_compile_options(openvpnserv PRIVATE -municode)
     target_link_options(openvpnserv PRIVATE -municode)
diff --git a/src/openvpnserv/validate.c b/src/openvpnserv/validate.c
index 59d5b86..2187fb5 100644
--- a/src/openvpnserv/validate.c
+++ b/src/openvpnserv/validate.c
@@ -25,6 +25,11 @@
 #include <lmaccess.h>
 #include <shlwapi.h>
 #include <lm.h>
+#include <pathcch.h>
+
+#ifndef HAVE_PATHCCH_ENSURE_TRAILING_SLASH
+#define PATHCCH_ENSURE_TRAILING_SLASH 0x20
+#endif

 static const WCHAR *white_list[] =3D {
     L"auth-retry",
@@ -61,7 +66,7 @@
 {
     WCHAR tmp[MAX_PATH];
     const WCHAR *config_file =3D NULL;
-    const WCHAR *config_dir =3D NULL;
+    WCHAR config_dir[MAX_PATH];

     /* convert fname to full path */
     if (PathIsRelativeW(fname))
@@ -74,9 +79,12 @@
         config_file =3D fname;
     }

-    config_dir =3D s->config_dir;
+    /* canonicalize config_dir and add trailing slash before comparison */
+    HRESULT res =3D PathCchCanonicalizeEx(config_dir, _countof(config_dir)=
, s->config_dir,
+                                        PATHCCH_ENSURE_TRAILING_SLASH);

-    if (wcsncmp(config_dir, config_file, wcslen(config_dir)) =3D=3D 0
+    if (res =3D=3D S_OK
+        && wcsncmp(config_dir, config_file, wcslen(config_dir)) =3D=3D 0
         && wcsstr(config_file + wcslen(config_dir), L"..") =3D=3D NULL)
     {
         return TRUE;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1318?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8e884c00cb94f97a612056e8dca74d821a6d6386
Gerrit-Change-Number: 1318
Gerrit-PatchSet: 1
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--TTx2tUyiomU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>selvanair would like plaisthos and flichtenheld to <strong>review</stron=
g> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1318?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">Canonicalize config_dir before comparing wi=
th the config file location<br><br>Found by ZeroPath<br><br>Change-Id: I8e8=
84c00cb94f97a612056e8dca74d821a6d6386<br>Signed-off-by: Selva Nair &lt;selv=
a.nair@...277...&gt;<br>---<br>M src/openvpnserv/CMakeLists.txt<br>M src/op=
envpnserv/validate.c<br>2 files changed, 17 insertions(+), 4 deletions(-)<b=
r><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn r=
efs/changes/18/1318/1</pre><pre style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;"><span>diff --git a/src/openvpnserv/CMakeLists.txt b=
/src/openvpnserv/CMakeLists.txt</span><br><span>index 340b904..a92ee08 1006=
44</span><br><span>--- a/src/openvpnserv/CMakeLists.txt</span><br><span>+++=
 b/src/openvpnserv/CMakeLists.txt</span><br><span>@@ -6,6 +6,11 @@</span><b=
r><span> </span><br><span> add_executable(openvpnserv)</span><br><span> </s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+include(CheckSymbolExi=
sts)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+# Some old versions of mingw does =
not have PATHCCH_OPTIONS enums -- add a check</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+check_symbol_exists(PATHCCH_ENSURE_TRAILING_SLASH=
 pathcch.h HAVE_PATHCCH_ENSURE_TRAILING_SLASH)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span> set(MC_GEN_DIR ${CMAKE_CURRENT=
_BINARY_DIR}/mc)</span><br><span> </span><br><span> target_include_director=
ies(openvpnserv PRIVATE</span><br><span>@@ -31,7 +36,7 @@</span><br><span> =
    )</span><br><span> target_link_libraries(openvpnserv</span><br><span>  =
   advapi32.lib userenv.lib iphlpapi.lib fwpuclnt.lib rpcrt4.lib</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    shlwapi.lib netapi32.lib ws2=
_32.lib ntdll.lib ole32.lib)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    shlwapi.lib netapi32.lib ws2_32.lib ntdll.lib ole32.lib pathcc=
h.lib)</span><br><span> if (MINGW)</span><br><span>     target_compile_opti=
ons(openvpnserv PRIVATE -municode)</span><br><span>     target_link_options=
(openvpnserv PRIVATE -municode)</span><br><span>diff --git a/src/openvpnser=
v/validate.c b/src/openvpnserv/validate.c</span><br><span>index 59d5b86..21=
87fb5 100644</span><br><span>--- a/src/openvpnserv/validate.c</span><br><sp=
an>+++ b/src/openvpnserv/validate.c</span><br><span>@@ -25,6 +25,11 @@</spa=
n><br><span> #include &lt;lmaccess.h&gt;</span><br><span> #include &lt;shlw=
api.h&gt;</span><br><span> #include &lt;lm.h&gt;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#include &lt;pathcch.h&gt;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#ifndef HAVE_PATHCCH_ENSURE_TRAILING_SLASH</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#define PATHCCH_ENSURE_TRAILING_SLA=
SH 0x20</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span=
><br><span> </span><br><span> static const WCHAR *white_list[] =3D {</span>=
<br><span>     L&quot;auth-retry&quot;,</span><br><span>@@ -61,7 +66,7 @@</=
span><br><span> {</span><br><span>     WCHAR tmp[MAX_PATH];</span><br><span=
>     const WCHAR *config_file =3D NULL;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    const WCHAR *config_dir =3D NULL;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    WCHAR config_dir[MAX_PATH];</span>=
<br><span> </span><br><span>     /* convert fname to full path */</span><br=
><span>     if (PathIsRelativeW(fname))</span><br><span>@@ -74,9 +79,12 @@<=
/span><br><span>         config_file =3D fname;</span><br><span>     }</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    conf=
ig_dir =3D s-&gt;config_dir;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /* canonicalize config_dir and add trailing slash before compa=
rison */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    HRESULT=
 res =3D PathCchCanonicalizeEx(config_dir, _countof(config_dir), s-&gt;conf=
ig_dir,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
                            PATHCCH_ENSURE_TRAILING_SLASH);</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (wcsncmp(con=
fig_dir, config_file, wcslen(config_dir)) =3D=3D 0</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (res =3D=3D S_OK</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; wcsncmp(config_dir, c=
onfig_file, wcslen(config_dir)) =3D=3D 0</span><br><span>         &amp;&amp=
; wcsstr(config_file + wcslen(config_dir), L&quot;..&quot;) =3D=3D NULL)</s=
pan><br><span>     {</span><br><span>         return TRUE;</span><br><span>=
</span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1318?usp=3Demail">change 1318</a>. To unsubscribe, or for help wri=
ting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=
=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org=
/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/1318?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8e884c00cb94f97a612056e8dca=
74d821a6d6386 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1318 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: selvanair &lt;selva.nair@...1354...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--TTx2tUyiomU=--

