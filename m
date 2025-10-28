From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 28 Oct 2025 14:05:51 +0000
In-Reply-To: <gerrit.1761596820000.I8e884c00cb94f97a612056e8dca74d821a6d6386@...2715...>
References: <gerrit.1761596820000.I8e884c00cb94f97a612056e8dca74d821a6d6386@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., selva.nair@...277...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <5387c2c1077d1f5281b98614892e246771ef0f14-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="BLLxJB4HX3s="; charset=UTF-8
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
To: selvanair <selva.nair@...277...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, stipa <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--BLLxJB4HX3s=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 selvanair. ( http://gerrit.openvpn.net/c/openvpn/+/1318?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos, Code-Review+2 by stipa


Change subject: Canonicalize config_dir before comparing with the config fi=
le location
......................................................................

Canonicalize config_dir before comparing with the config file location

Found by ZeroPath

Change-Id: I8e884c00cb94f97a612056e8dca74d821a6d6386
Signed-off-by: Selva Nair <selva.nair@...277...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1318
Message-Id: <20251028101642.11874-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33=
923.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpnserv/CMakeLists.txt
M src/openvpnserv/validate.c
2 files changed, 17 insertions(+), 4 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/18/1318/2

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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8e884c00cb94f97a612056e8dca74d821a6d6386
Gerrit-Change-Number: 1318
Gerrit-PatchSet: 2
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--BLLxJB4HX3s=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by selvanair.<=
/p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1318?usp=3Demail">Vi=
ew Change</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by plaisthos, Code-Review+2 by stipa</p><pre class=3D"blocks"=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Canonic=
alize config_dir before comparing with the config file location<br><br>Foun=
d by ZeroPath<br><br>Change-Id: I8e884c00cb94f97a612056e8dca74d821a6d6386<b=
r>Signed-off-by: Selva Nair &lt;selva.nair@...277...&gt;<br>Acked-by: Arne =
Schwabe &lt;arne-openvpn@...1227...&gt;<br>Gerrit URL: https://gerrit.openv=
pn.net/c/openvpn/+/1318<br>Message-Id: &lt;20251028101642.11874-1-gert@...1386...=
296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1535...=
orge.net/msg33923.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&g=
t;<br>---<br>M src/openvpnserv/CMakeLists.txt<br>M src/openvpnserv/validate=
.c<br>2 files changed, 17 insertions(+), 4 deletions(-)<br><br></pre><pre c=
lass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/18/131=
8/2</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/src/openvpnserv/CMakeLists.txt b/src/openvpnserv/C=
MakeLists.txt</span><br><span>index 340b904..a92ee08 100644</span><br><span=
>--- a/src/openvpnserv/CMakeLists.txt</span><br><span>+++ b/src/openvpnserv=
/CMakeLists.txt</span><br><span>@@ -6,6 +6,11 @@</span><br><span> </span><b=
r><span> add_executable(openvpnserv)</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+include(CheckSymbolExists)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+# Some old versions of mingw does not have PATHCCH_O=
PTIONS enums -- add a check</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+check_symbol_exists(PATHCCH_ENSURE_TRAILING_SLASH pathcch.h HAVE_PA=
THCCH_ENSURE_TRAILING_SLASH)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span> set(MC_GEN_DIR ${CMAKE_CURRENT_BINARY_DIR}/mc)</=
span><br><span> </span><br><span> target_include_directories(openvpnserv PR=
IVATE</span><br><span>@@ -31,7 +36,7 @@</span><br><span>     )</span><br><s=
pan> target_link_libraries(openvpnserv</span><br><span>     advapi32.lib us=
erenv.lib iphlpapi.lib fwpuclnt.lib rpcrt4.lib</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    shlwapi.lib netapi32.lib ws2_32.lib ntdll.lib =
ole32.lib)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    shlwa=
pi.lib netapi32.lib ws2_32.lib ntdll.lib ole32.lib pathcch.lib)</span><br><=
span> if (MINGW)</span><br><span>     target_compile_options(openvpnserv PR=
IVATE -municode)</span><br><span>     target_link_options(openvpnserv PRIVA=
TE -municode)</span><br><span>diff --git a/src/openvpnserv/validate.c b/src=
/openvpnserv/validate.c</span><br><span>index 59d5b86..2187fb5 100644</span=
><br><span>--- a/src/openvpnserv/validate.c</span><br><span>+++ b/src/openv=
pnserv/validate.c</span><br><span>@@ -25,6 +25,11 @@</span><br><span> #incl=
ude &lt;lmaccess.h&gt;</span><br><span> #include &lt;shlwapi.h&gt;</span><b=
r><span> #include &lt;lm.h&gt;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#include &lt;pathcch.h&gt;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
ifndef HAVE_PATHCCH_ENSURE_TRAILING_SLASH</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#define PATHCCH_ENSURE_TRAILING_SLASH 0x20</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> </span=
><br><span> static const WCHAR *white_list[] =3D {</span><br><span>     L&q=
uot;auth-retry&quot;,</span><br><span>@@ -61,7 +66,7 @@</span><br><span> {<=
/span><br><span>     WCHAR tmp[MAX_PATH];</span><br><span>     const WCHAR =
*config_file =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    const WCHAR *config_dir =3D NULL;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    WCHAR config_dir[MAX_PATH];</span><br><span> </span>=
<br><span>     /* convert fname to full path */</span><br><span>     if (Pa=
thIsRelativeW(fname))</span><br><span>@@ -74,9 +79,12 @@</span><br><span>  =
       config_file =3D fname;</span><br><span>     }</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    config_dir =3D s-&gt;c=
onfig_dir;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* ca=
nonicalize config_dir and add trailing slash before comparison */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    HRESULT res =3D PathCchCa=
nonicalizeEx(config_dir, _countof(config_dir), s-&gt;config_dir,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                              =
          PATHCCH_ENSURE_TRAILING_SLASH);</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    if (wcsncmp(config_dir, config_fi=
le, wcslen(config_dir)) =3D=3D 0</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (res =3D=3D S_OK</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        &amp;&amp; wcsncmp(config_dir, config_file, wcslen=
(config_dir)) =3D=3D 0</span><br><span>         &amp;&amp; wcsstr(config_fi=
le + wcslen(config_dir), L&quot;..&quot;) =3D=3D NULL)</span><br><span>    =
 {</span><br><span>         return TRUE;</span><br><span></span><br></pre><=
p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1318?usp=
=3Demail">change 1318</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings=
</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link=
 itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1318?usp=3D=
email"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8e884c00cb94f97a612056e8dca=
74d821a6d6386 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1318 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: selvanair &lt;selva.nair@...1354...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--BLLxJB4HX3s=--

