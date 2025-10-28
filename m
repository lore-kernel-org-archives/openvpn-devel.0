From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 28 Oct 2025 14:05:54 +0000
In-Reply-To: <gerrit.1761596820000.I8e884c00cb94f97a612056e8dca74d821a6d6386@...2715...>
References: <gerrit.1761596820000.I8e884c00cb94f97a612056e8dca74d821a6d6386@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., selva.nair@...277...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <5387c2c1077d1f5281b98614892e246771ef0f14-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="oOS2dsnO9F8="; charset=UTF-8
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
To: selvanair <selva.nair@...277...>
Cc: stipa <lstipakov@...277...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--oOS2dsnO9F8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/13=
18?usp=3Demail )

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

Gerrit-MessageType: merged
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

--oOS2dsnO9F8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1318?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">Canonicalize config_dir before comparing with th=
e config file location<br><br>Found by ZeroPath<br><br>Change-Id: I8e884c00=
cb94f97a612056e8dca74d821a6d6386<br>Signed-off-by: Selva Nair &lt;selva.nai=
r@...277...&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@...1227...&gt;<b=
r>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1318<br>Message-Id: &l=
t;20251028101642.11874-1-gert@...1296...&gt;<br>URL: https://www.mail-archi=
ve.com/openvpn-devel@lists.sourceforge.net/msg33923.html<br>Signed-off-by: =
Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpnserv/CMakeLists=
.txt<br>M src/openvpnserv/validate.c<br>2 files changed, 17 insertions(+), =
4 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpnserv/CMakeLists.txt b/src/openvpnserv/CMakeLists=
.txt</span><br><span>index 340b904..a92ee08 100644</span><br><span>--- a/sr=
c/openvpnserv/CMakeLists.txt</span><br><span>+++ b/src/openvpnserv/CMakeLis=
ts.txt</span><br><span>@@ -6,6 +6,11 @@</span><br><span> </span><br><span> =
add_executable(openvpnserv)</span><br><span> </span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+include(CheckSymbolExists)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+# Some old versions of mingw does not have PATHCCH_OPTIONS e=
nums -- add a check</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
check_symbol_exists(PATHCCH_ENSURE_TRAILING_SLASH pathcch.h HAVE_PATHCCH_EN=
SURE_TRAILING_SLASH)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span> set(MC_GEN_DIR ${CMAKE_CURRENT_BINARY_DIR}/mc)</span><br=
><span> </span><br><span> target_include_directories(openvpnserv PRIVATE</s=
pan><br><span>@@ -31,7 +36,7 @@</span><br><span>     )</span><br><span> tar=
get_link_libraries(openvpnserv</span><br><span>     advapi32.lib userenv.li=
b iphlpapi.lib fwpuclnt.lib rpcrt4.lib</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    shlwapi.lib netapi32.lib ws2_32.lib ntdll.lib ole32.li=
b)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    shlwapi.lib n=
etapi32.lib ws2_32.lib ntdll.lib ole32.lib pathcch.lib)</span><br><span> if=
 (MINGW)</span><br><span>     target_compile_options(openvpnserv PRIVATE -m=
unicode)</span><br><span>     target_link_options(openvpnserv PRIVATE -muni=
code)</span><br><span>diff --git a/src/openvpnserv/validate.c b/src/openvpn=
serv/validate.c</span><br><span>index 59d5b86..2187fb5 100644</span><br><sp=
an>--- a/src/openvpnserv/validate.c</span><br><span>+++ b/src/openvpnserv/v=
alidate.c</span><br><span>@@ -25,6 +25,11 @@</span><br><span> #include &lt;=
lmaccess.h&gt;</span><br><span> #include &lt;shlwapi.h&gt;</span><br><span>=
 #include &lt;lm.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#include &lt;pathcch.h&gt;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef H=
AVE_PATHCCH_ENSURE_TRAILING_SLASH</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#define PATHCCH_ENSURE_TRAILING_SLASH 0x20</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> </span><br><sp=
an> static const WCHAR *white_list[] =3D {</span><br><span>     L&quot;auth=
-retry&quot;,</span><br><span>@@ -61,7 +66,7 @@</span><br><span> {</span><b=
r><span>     WCHAR tmp[MAX_PATH];</span><br><span>     const WCHAR *config_=
file =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    con=
st WCHAR *config_dir =3D NULL;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    WCHAR config_dir[MAX_PATH];</span><br><span> </span><br><spa=
n>     /* convert fname to full path */</span><br><span>     if (PathIsRela=
tiveW(fname))</span><br><span>@@ -74,9 +79,12 @@</span><br><span>         c=
onfig_file =3D fname;</span><br><span>     }</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    config_dir =3D s-&gt;config_di=
r;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* canonicali=
ze config_dir and add trailing slash before comparison */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    HRESULT res =3D PathCchCanonicali=
zeEx(config_dir, _countof(config_dir), s-&gt;config_dir,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                                      =
  PATHCCH_ENSURE_TRAILING_SLASH);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (wcsncmp(config_dir, config_file, wc=
slen(config_dir)) =3D=3D 0</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (res =3D=3D S_OK</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        &amp;&amp; wcsncmp(config_dir, config_file, wcslen(confi=
g_dir)) =3D=3D 0</span><br><span>         &amp;&amp; wcsstr(config_file + w=
cslen(config_dir), L&quot;..&quot;) =3D=3D NULL)</span><br><span>     {</sp=
an><br><span>         return TRUE;</span><br><span></span><br></pre><p>To v=
iew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1318?usp=3Demai=
l">change 1318</a>. To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</=
p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempr=
op=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1318?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
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

--oOS2dsnO9F8=--

