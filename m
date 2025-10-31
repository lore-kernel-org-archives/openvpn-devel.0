From: "stipa (Code Review)" <gerrit@...515...>
Date: Fri, 31 Oct 2025 11:33:26 +0000
In-Reply-To: <gerrit.1761818969000.I5ea90594493ab5cb858f7495f773e080b379e8e8@...2715...>
References: <gerrit.1761818969000.I5ea90594493ab5cb858f7495f773e080b379e8e8@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <5ec8380da1a7082d3cbadb602c0701248746efd2-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="O2BOPlzUIfQ="; charset=UTF-8
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

--O2BOPlzUIfQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, stipa.

Hello cron2, flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1332?usp=3Demail

to look at the new patch set (#2).


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
M src/openvpn/Makefile.am
M src/openvpn/win32.c
3 files changed, 30 insertions(+), 12 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/32/1332/2

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
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index db87dfc..a2b5e92 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -166,5 +166,5 @@
 	$(OPTIONAL_INOTIFY_LIBS)
 if WIN32
 openvpn_SOURCES +=3D openvpn_win32_resources.rc wfp_block.c wfp_block.h
-openvpn_LDADD +=3D -lgdi32 -lws2_32 -lwininet -lcrypt32 -liphlpapi -lwinmm=
 -lfwpuclnt -lrpcrt4 -lncrypt -lsetupapi -lbcrypt
+openvpn_LDADD +=3D -lgdi32 -lws2_32 -lwininet -lcrypt32 -liphlpapi -lwinmm=
 -lfwpuclnt -lrpcrt4 -lncrypt -lsetupapi -lbcrypt -lpathcch
 endif
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index df29dd7..3ed28f6 100644
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
@@ -1553,12 +1559,12 @@
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
@@ -1570,26 +1576,35 @@
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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5ea90594493ab5cb858f7495f773e080b379e8e8
Gerrit-Change-Number: 1332
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: stipa <lstipakov@...277...>

--O2BOPlzUIfQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, stipa. </p>
<p>stipa <strong>uploaded patch set #2</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1332?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">win32: ensure plugin dir has the trailing slash<br><br>=
This prevents loading plugins from the directories<br>which share initial c=
haracters with the trusted path.<br><br>Reported-by: Joshua Rogers &lt;cont=
act@...2949...&gt;<br>Found-by: ZeroPath (https://zeropath.com/)<br><br>Cha=
nge-Id: I5ea90594493ab5cb858f7495f773e080b379e8e8<br>Signed-off-by: Lev Sti=
pakov &lt;lev@...515...&gt;<br>---<br>M CMakeLists.txt<br>M src/openvpn/Mak=
efile.am<br>M src/openvpn/win32.c<br>3 files changed, 30 insertions(+), 12 =
deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:2=
9418/openvpn refs/changes/32/1332/2</pre><pre style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;"><span>diff --git a/CMakeLists.txt b/C=
MakeLists.txt</span><br><span>index c9301e6..6888de3 100644</span><br><span=
>--- a/CMakeLists.txt</span><br><span>+++ b/CMakeLists.txt</span><br><span>=
@@ -245,6 +245,9 @@</span><br><span> check_symbol_exists(chsize io.h HAVE_C=
HSIZE)</span><br><span> check_symbol_exists(getrlimit sys/resource.h HAVE_G=
ETRLIMIT)</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, =
40%);">+# Some old versions of mingw does not have PATHCCH_OPTIONS enums --=
 add a check</span><br><span style=3D"color: hsl(120, 100%, 40%);">+check_s=
ymbol_exists(PATHCCH_ENSURE_TRAILING_SLASH pathcch.h HAVE_PATHCCH_ENSURE_TR=
AILING_SLASH)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span> # Some OS (e.g. FreeBSD) need some basic headers to allow</span=
><br><span> # including network headers</span><br><span> set(NETEXTRA sys/t=
ypes.h)</span><br><span>@@ -338,7 +341,7 @@</span><br><span>         if (WI=
N32)</span><br><span>             target_link_libraries(${target} PUBLIC</s=
pan><br><span>                 ws2_32.lib crypt32.lib fwpuclnt.lib iphlpapi=
.lib</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                w=
ininet.lib setupapi.lib rpcrt4.lib wtsapi32.lib ncrypt.lib bcrypt.lib)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                wininet.=
lib setupapi.lib rpcrt4.lib wtsapi32.lib ncrypt.lib bcrypt.lib pathcch.lib)=
</span><br><span>         endif ()</span><br><span> </span><br><span>     e=
ndif ()</span><br><span>diff --git a/src/openvpn/Makefile.am b/src/openvpn/=
Makefile.am</span><br><span>index db87dfc..a2b5e92 100644</span><br><span>-=
-- a/src/openvpn/Makefile.am</span><br><span>+++ b/src/openvpn/Makefile.am<=
/span><br><span>@@ -166,5 +166,5 @@</span><br><span> 	$(OPTIONAL_INOTIFY_LI=
BS)</span><br><span> if WIN32</span><br><span> openvpn_SOURCES +=3D openvpn=
_win32_resources.rc wfp_block.c wfp_block.h</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-openvpn_LDADD +=3D -lgdi32 -lws2_32 -lwininet -lcrypt=
32 -liphlpapi -lwinmm -lfwpuclnt -lrpcrt4 -lncrypt -lsetupapi -lbcrypt</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+openvpn_LDADD +=3D -lgdi=
32 -lws2_32 -lwininet -lcrypt32 -liphlpapi -lwinmm -lfwpuclnt -lrpcrt4 -lnc=
rypt -lsetupapi -lbcrypt -lpathcch</span><br><span> endif</span><br><span>d=
iff --git a/src/openvpn/win32.c b/src/openvpn/win32.c</span><br><span>index=
 df29dd7..3ed28f6 100644</span><br><span>--- a/src/openvpn/win32.c</span><b=
r><span>+++ b/src/openvpn/win32.c</span><br><span>@@ -51,6 +51,12 @@</span>=
<br><span> </span><br><span> #include &quot;wfp_block.h&quot;</span><br><sp=
an> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;pa=
thcch.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef HAVE_PATHCCH_ENSURE=
_TRAILING_SLASH</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#def=
ine PATHCCH_ENSURE_TRAILING_SLASH 0x20</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span> /*</span><br><span>  * WFP handle</span><br><span> =
 */</span><br><span>@@ -1553,12 +1559,12 @@</span><br><span>         return=
 false;</span><br><span>     }</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    WCHAR plugin_dir[MAX_PATH] =3D { 0 };</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    WCHAR plugin_dir_reg[M=
AX_PATH] =3D { 0 };</span><br><span> </span><br><span>     /* Attempt to re=
trieve the trusted plugin directory path from the registry,</span><br><span=
>      * using installation path as a fallback */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    if (!get_openvpn_reg_value(L&quot;plugin_di=
r&quot;, plugin_dir, _countof(plugin_dir))</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        &amp;&amp; !get_openvpn_reg_value(NULL, plugin=
_dir, _countof(plugin_dir)))</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (!get_openvpn_reg_value(L&quot;plugin_dir&quot;, plugin_dir=
_reg, _countof(plugin_dir_reg))</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        &amp;&amp; !get_openvpn_reg_value(NULL, plugin_dir_reg,=
 _countof(plugin_dir_reg)))</span><br><span>     {</span><br><span>        =
 msg(M_WARN, &quot;Installation path could not be determined.&quot;);</span=
><br><span>     }</span><br><span>@@ -1570,26 +1576,35 @@</span><br><span> =
        msg(M_NONFATAL | M_ERRNO, &quot;Failed to get system directory.&quo=
t;);</span><br><span>     }</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    if ((wcslen(plugin_dir) =3D=3D 0) &amp;&amp; (w=
cslen(system_dir) =3D=3D 0))</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if ((wcslen(plugin_dir_reg) =3D=3D 0) &amp;&amp; (wcslen(syste=
m_dir) =3D=3D 0))</span><br><span>     {</span><br><span>         return fa=
lse;</span><br><span>     }</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    WCHAR normalized_plugin_dir[MAX_PATH] =3D { 0 }=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    WCHAR plugin_d=
ir[MAX_PATH] =3D { 0 };</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    /* Normalize the plugin dir */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    if (wcslen(plugin_dir) &gt; 0)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    /* normalize and canoni=
calize the plugin dir and add trailing slash */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (wcslen(plugin_dir_reg) &gt; 0)</span><b=
r><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 if (!GetFullPathNameW(plugin_dir, MAX_PATH, normalized_plugin_dir, NULL))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        WCHAR normal=
ized_plugin_dir[MAX_PATH] =3D { 0 };</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        if (!GetFullPathNameW(plugin_dir_reg, MAX_PATH, no=
rmalized_plugin_dir, NULL))</span><br><span>         {</span><br><span>    =
         msg(M_NONFATAL | M_ERRNO, &quot;Failed to normalize plugin dir.&qu=
ot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        HRESULT res =3D PathCchCanonicali=
zeEx(plugin_dir, _countof(plugin_dir), normalized_plugin_dir,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                                 =
           PATHCCH_ENSURE_TRAILING_SLASH);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        if (res !=3D S_OK)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            /* doc says we cannot rely on GetLastError(=
) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg=
(M_NONFATAL, &quot;Failed to canonicalize plugin dir.&quot;);</span><br><sp=
an>             return false;</span><br><span>         }</span><br><span>  =
   }</span><br><span> </span><br><span>     /* Check if the plugin path res=
ides within the plugin/install directory */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    if ((wcslen(normalized_plugin_dir) &gt; 0)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        &amp;&amp; (wcsnicmp=
(normalized_plugin_dir, plugin_path, wcslen(normalized_plugin_dir)) =3D=3D =
0))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if ((wcslen(=
plugin_dir) &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        &amp;&amp; (wcsnicmp(plugin_dir, plugin_path, wcslen(plugin_dir)) =
=3D=3D 0))</span><br><span>     {</span><br><span>         return true;</sp=
an><br><span>     }</span><br><span></span><br></pre><p>To view, visit <a h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/1332?usp=3Demail">change 1332<=
/a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
p://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscop=
e itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"ac=
tion" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1332?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5ea90594493ab5cb858f7495f77=
3e080b379e8e8 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1332 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
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
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>

</body></html>=

--O2BOPlzUIfQ=--

