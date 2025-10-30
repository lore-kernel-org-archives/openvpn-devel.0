From: "stipa (Code Review)" <gerrit@...515...>
Date: Thu, 30 Oct 2025 10:09:31 +0000
References: <gerrit.1761818969000.I5ea90594493ab5cb858f7495f773e080b379e8e8@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <aea20ebdcc328fab02a7c050cefe8bda7d935b75-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ESAPX2VYH+c="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: win32: ensure plugin
 dir has the trailing slash
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

--ESAPX2VYH+c=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1332?usp=3Demail

to review the following change.


Change subject: win32: ensure plugin dir has the trailing slash
......................................................................

win32: ensure plugin dir has the trailing slash

This prevents loading plugins from the directories
which share initial characters with the trusted path.

Reported-by: Joshua Rogers <contact@...2949...>
Found-by: ZeroPath (https://zeropath.com/)

Change-Id: I5ea90594493ab5cb858f7495f773e080b379e8e8
Signed-off-by: Lev Stipakov <lev@...515...>
---
M CMakeLists.txt
M src/openvpn/win32.c
2 files changed, 29 insertions(+), 11 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/32/1332/1

diff --git a/CMakeLists.txt b/CMakeLists.txt
index c9301e6..6888de3 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -245,6 +245,9 @@
 check_symbol_exists(chsize io.h HAVE_CHSIZE)
 check_symbol_exists(getrlimit sys/resource.h HAVE_GETRLIMIT)

+# Some old versions of mingw does not have PATHCCH_OPTIONS enums -- add a =
check
+check_symbol_exists(PATHCCH_ENSURE_TRAILING_SLASH pathcch.h HAVE_PATHCCH_E=
NSURE_TRAILING_SLASH)
+
 # Some OS (e.g. FreeBSD) need some basic headers to allow
 # including network headers
 set(NETEXTRA sys/types.h)
@@ -338,7 +341,7 @@
         if (WIN32)
             target_link_libraries(${target} PUBLIC
                 ws2_32.lib crypt32.lib fwpuclnt.lib iphlpapi.lib
-                wininet.lib setupapi.lib rpcrt4.lib wtsapi32.lib ncrypt.li=
b bcrypt.lib)
+                wininet.lib setupapi.lib rpcrt4.lib wtsapi32.lib ncrypt.li=
b bcrypt.lib pathcch.lib)
         endif ()

     endif ()
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index 3c11ec3..6aa9463 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -51,6 +51,12 @@

 #include "wfp_block.h"

+#include <pathcch.h>
+
+#ifndef HAVE_PATHCCH_ENSURE_TRAILING_SLASH
+#define PATHCCH_ENSURE_TRAILING_SLASH 0x20
+#endif
+
 /*
  * WFP handle
  */
@@ -1552,12 +1558,12 @@
         return false;
     }

-    WCHAR plugin_dir[MAX_PATH] =3D { 0 };
+    WCHAR plugin_dir_reg[MAX_PATH] =3D { 0 };

     /* Attempt to retrieve the trusted plugin directory path from the regi=
stry,
      * using installation path as a fallback */
-    if (!get_openvpn_reg_value(L"plugin_dir", plugin_dir, _countof(plugin_=
dir))
-        && !get_openvpn_reg_value(NULL, plugin_dir, _countof(plugin_dir)))
+    if (!get_openvpn_reg_value(L"plugin_dir", plugin_dir_reg, _countof(plu=
gin_dir_reg))
+        && !get_openvpn_reg_value(NULL, plugin_dir_reg, _countof(plugin_di=
r_reg)))
     {
         msg(M_WARN, "Installation path could not be determined.");
     }
@@ -1569,26 +1575,35 @@
         msg(M_NONFATAL | M_ERRNO, "Failed to get system directory.");
     }

-    if ((wcslen(plugin_dir) =3D=3D 0) && (wcslen(system_dir) =3D=3D 0))
+    if ((wcslen(plugin_dir_reg) =3D=3D 0) && (wcslen(system_dir) =3D=3D 0))
     {
         return false;
     }

-    WCHAR normalized_plugin_dir[MAX_PATH] =3D { 0 };
+    WCHAR plugin_dir[MAX_PATH] =3D { 0 };

-    /* Normalize the plugin dir */
-    if (wcslen(plugin_dir) > 0)
+    /* normalize and canonicalize the plugin dir and add trailing slash */
+    if (wcslen(plugin_dir_reg) > 0)
     {
-        if (!GetFullPathNameW(plugin_dir, MAX_PATH, normalized_plugin_dir,=
 NULL))
+        WCHAR normalized_plugin_dir[MAX_PATH] =3D { 0 };
+        if (!GetFullPathNameW(plugin_dir_reg, MAX_PATH, normalized_plugin_=
dir, NULL))
         {
             msg(M_NONFATAL | M_ERRNO, "Failed to normalize plugin dir.");
+        }
+
+        HRESULT res =3D PathCchCanonicalizeEx(plugin_dir, _countof(plugin_=
dir), normalized_plugin_dir,
+                                            PATHCCH_ENSURE_TRAILING_SLASH);
+        if (res !=3D S_OK)
+        {
+            /* doc says we cannot rely on GetLastError() */
+            msg(M_NONFATAL, "Failed to canonicalize plugin dir.");
             return false;
         }
     }

     /* Check if the plugin path resides within the plugin/install director=
y */
-    if ((wcslen(normalized_plugin_dir) > 0)
-        && (wcsnicmp(normalized_plugin_dir, plugin_path, wcslen(normalized=
_plugin_dir)) =3D=3D 0))
+    if ((wcslen(plugin_dir) > 0)
+        && (wcsnicmp(plugin_dir, plugin_path, wcslen(plugin_dir)) =3D=3D 0=
))
     {
         return true;
     }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1332?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5ea90594493ab5cb858f7495f773e080b379e8e8
Gerrit-Change-Number: 1332
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--ESAPX2VYH+c=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>stipa would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1332?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">win32: ensure plugin dir has the trailing s=
lash<br><br>This prevents loading plugins from the directories<br>which sha=
re initial characters with the trusted path.<br><br>Reported-by: Joshua Rog=
ers &lt;contact@...2949...&gt;<br>Found-by: ZeroPath (https://zeropath.com/=
)<br><br>Change-Id: I5ea90594493ab5cb858f7495f773e080b379e8e8<br>Signed-off=
-by: Lev Stipakov &lt;lev@...515...&gt;<br>---<br>M CMakeLists.txt<br>M src=
/openvpn/win32.c<br>2 files changed, 29 insertions(+), 11 deletions(-)<br><=
br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs=
/changes/32/1332/1</pre><pre style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;"><span>diff --git a/CMakeLists.txt b/CMakeLists.txt</sp=
an><br><span>index c9301e6..6888de3 100644</span><br><span>--- a/CMakeLists=
.txt</span><br><span>+++ b/CMakeLists.txt</span><br><span>@@ -245,6 +245,9 =
@@</span><br><span> check_symbol_exists(chsize io.h HAVE_CHSIZE)</span><br>=
<span> check_symbol_exists(getrlimit sys/resource.h HAVE_GETRLIMIT)</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Some ol=
d versions of mingw does not have PATHCCH_OPTIONS enums -- add a check</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+check_symbol_exists(PATH=
CCH_ENSURE_TRAILING_SLASH pathcch.h HAVE_PATHCCH_ENSURE_TRAILING_SLASH)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> # Som=
e OS (e.g. FreeBSD) need some basic headers to allow</span><br><span> # inc=
luding network headers</span><br><span> set(NETEXTRA sys/types.h)</span><br=
><span>@@ -338,7 +341,7 @@</span><br><span>         if (WIN32)</span><br><s=
pan>             target_link_libraries(${target} PUBLIC</span><br><span>   =
              ws2_32.lib crypt32.lib fwpuclnt.lib iphlpapi.lib</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                wininet.lib setupa=
pi.lib rpcrt4.lib wtsapi32.lib ncrypt.lib bcrypt.lib)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                wininet.lib setupapi.lib =
rpcrt4.lib wtsapi32.lib ncrypt.lib bcrypt.lib pathcch.lib)</span><br><span>=
         endif ()</span><br><span> </span><br><span>     endif ()</span><br=
><span>diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c</span><br><sp=
an>index 3c11ec3..6aa9463 100644</span><br><span>--- a/src/openvpn/win32.c<=
/span><br><span>+++ b/src/openvpn/win32.c</span><br><span>@@ -51,6 +51,12 @=
@</span><br><span> </span><br><span> #include &quot;wfp_block.h&quot;</span=
><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#includ=
e &lt;pathcch.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef HAVE_PATHCC=
H_ENSURE_TRAILING_SLASH</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#define PATHCCH_ENSURE_TRAILING_SLASH 0x20</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span> /*</span><br><span>  * WFP handle</span><br=
><span>  */</span><br><span>@@ -1552,12 +1558,12 @@</span><br><span>       =
  return false;</span><br><span>     }</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    WCHAR plugin_dir[MAX_PATH] =3D { 0 }=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    WCHAR plugin_d=
ir_reg[MAX_PATH] =3D { 0 };</span><br><span> </span><br><span>     /* Attem=
pt to retrieve the trusted plugin directory path from the registry,</span><=
br><span>      * using installation path as a fallback */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    if (!get_openvpn_reg_value(L&quot;p=
lugin_dir&quot;, plugin_dir, _countof(plugin_dir))</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        &amp;&amp; !get_openvpn_reg_value(NULL=
, plugin_dir, _countof(plugin_dir)))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (!get_openvpn_reg_value(L&quot;plugin_dir&quot;, pl=
ugin_dir_reg, _countof(plugin_dir_reg))</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        &amp;&amp; !get_openvpn_reg_value(NULL, plugin_=
dir_reg, _countof(plugin_dir_reg)))</span><br><span>     {</span><br><span>=
         msg(M_WARN, &quot;Installation path could not be determined.&quot;=
);</span><br><span>     }</span><br><span>@@ -1569,26 +1575,35 @@</span><br=
><span>         msg(M_NONFATAL | M_ERRNO, &quot;Failed to get system direct=
ory.&quot;);</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if ((wcslen(plugin_dir) =3D=3D 0) &amp;=
&amp; (wcslen(system_dir) =3D=3D 0))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if ((wcslen(plugin_dir_reg) =3D=3D 0) &amp;&amp; (wcsl=
en(system_dir) =3D=3D 0))</span><br><span>     {</span><br><span>         r=
eturn false;</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    WCHAR normalized_plugin_dir[MAX_PATH] =
=3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    WCHAR=
 plugin_dir[MAX_PATH] =3D { 0 };</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    /* Normalize the plugin dir */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    if (wcslen(plugin_dir) &gt; 0=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* normalize a=
nd canonicalize the plugin dir and add trailing slash */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (wcslen(plugin_dir_reg) &gt; 0)=
</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        if (!GetFullPathNameW(plugin_dir, MAX_PATH, normalized_plugin_dir=
, NULL))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        WCH=
AR normalized_plugin_dir[MAX_PATH] =3D { 0 };</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        if (!GetFullPathNameW(plugin_dir_reg, MAX=
_PATH, normalized_plugin_dir, NULL))</span><br><span>         {</span><br><=
span>             msg(M_NONFATAL | M_ERRNO, &quot;Failed to normalize plugi=
n dir.&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        HRESULT res =3D PathCchCan=
onicalizeEx(plugin_dir, _countof(plugin_dir), normalized_plugin_dir,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                          =
                  PATHCCH_ENSURE_TRAILING_SLASH);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        if (res !=3D S_OK)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            /* doc says we cannot rely on GetLas=
tError() */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    msg(M_NONFATAL, &quot;Failed to canonicalize plugin dir.&quot;);</span>=
<br><span>             return false;</span><br><span>         }</span><br><=
span>     }</span><br><span> </span><br><span>     /* Check if the plugin p=
ath resides within the plugin/install directory */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if ((wcslen(normalized_plugin_dir) &gt; 0)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        &amp;&amp; (w=
csnicmp(normalized_plugin_dir, plugin_path, wcslen(normalized_plugin_dir)) =
=3D=3D 0))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if ((=
wcslen(plugin_dir) &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        &amp;&amp; (wcsnicmp(plugin_dir, plugin_path, wcslen(plugin_=
dir)) =3D=3D 0))</span><br><span>     {</span><br><span>         return tru=
e;</span><br><span>     }</span><br><span></span><br></pre><p>To view, visi=
t <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1332?usp=3Demail">change=
 1332</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div i=
temscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"ur=
l" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1332?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5ea90594493ab5cb858f7495f77=
3e080b379e8e8 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1332 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
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

--ESAPX2VYH+c=--

