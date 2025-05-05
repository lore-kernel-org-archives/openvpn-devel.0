From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 5 May 2025 16:27:08 +0000
In-Reply-To: <gerrit.1744981598000.I39d660ebeec76280e4d4357192b74bf2c0980615@...2715...>
References: <gerrit.1744981598000.I39d660ebeec76280e4d4357192b74bf2c0980615@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <4d8507e3f3cc3295093216757d80228f3eddea00-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="jTYQEibJips="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: win: refactor
 get_windows_version()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: stipa <lstipakov@...277...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--jTYQEibJips=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 stipa. ( http://gerrit.openvpn.net/c/openvpn/+/944?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: win: refactor get_windows_version()
......................................................................

win: refactor get_windows_version()

It's 2025, and almost all clients now run on Windows 10 or newer.
Instead of displaying:

  "Windows version 10.0 (Windows 10 or greater), amd64 executable"

we now show the exact build number, e.g.:

  "Windows version: 10.0.22631,amd64"

Remove "pre-Win7" checks in a few places.

Change-Id: I39d660ebeec76280e4d4357192b74bf2c0980615
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250505122712.5214-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31=
566.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/options.c
M src/openvpn/ssl.c
M src/openvpn/tun.c
M src/openvpn/win32.c
M src/openvpn/win32.h
5 files changed, 36 insertions(+), 95 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/44/944/4

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 8c41dec..02970a7 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -4847,7 +4847,7 @@
 show_windows_version(const unsigned int flags)
 {
     struct gc_arena gc =3D gc_new();
-    msg(flags, "Windows version %s", win32_version_string(&gc, true));
+    msg(flags, "Windows version: %s", win32_version_string(&gc));
     gc_free(&gc);
 }
 #endif
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 23f6423..fd299ef 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2060,7 +2060,7 @@
             }
             buf_printf(&out, "IV_SSL=3D%s\n", get_ssl_library_version() );
 #if defined(_WIN32)
-            buf_printf(&out, "IV_PLAT_VER=3D%s\n", win32_version_string(&g=
c, false));
+            buf_printf(&out, "IV_PLAT_VER=3D%s\n", win32_version_string(&g=
c));
 #else
             struct utsname u;
             uname(&u);
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 4f7de6c..5186afa 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -5428,11 +5428,8 @@
                     NETSH_PATH_SUFFIX, adapter_index,
                     print_in6_addr(addr_list[i], 0, &gc));

-        /* disable slow address validation on Windows 7 and higher */
-        if (win32_version_info() >=3D WIN_7)
-        {
-            argv_printf_cat(&argv, "%s", "validate=3Dno");
-        }
+        /* disable slow address validation */
+        argv_printf_cat(&argv, "%s", "validate=3Dno");

         /* Treat errors while adding as non-fatal as we do not check for d=
uplicates */
         netsh_command(&argv, 1, (i=3D=3D0) ? M_FATAL : M_NONFATAL);
@@ -5498,9 +5495,8 @@
                             adapter_index,
                             print_in_addr_t(addr_list[i], 0, &gc));

-                /* disable slow address validation on Windows 7 and higher=
 */
-                /* only for DNS */
-                if (is_dns && win32_version_info() >=3D WIN_7)
+                /* disable slow address validation for DNS */
+                if (is_dns)
                 {
                     argv_printf_cat(&argv, "%s", "validate=3Dno");
                 }
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index edac71e..caa14d6 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -1283,42 +1283,6 @@
     return true;
 }

-int
-win32_version_info(void)
-{
-    if (!IsWindowsXPOrGreater())
-    {
-        msg(M_FATAL, "Error: Windows version must be XP or greater.");
-    }
-
-    if (!IsWindowsVistaOrGreater())
-    {
-        return WIN_XP;
-    }
-
-    if (!IsWindows7OrGreater())
-    {
-        return WIN_VISTA;
-    }
-
-    if (!IsWindows8OrGreater())
-    {
-        return WIN_7;
-    }
-
-    if (!IsWindows8Point1OrGreater())
-    {
-        return WIN_8;
-    }
-
-    if (!IsWindows10OrGreater())
-    {
-        return WIN_8_1;
-    }
-
-    return WIN_10;
-}
-
 typedef enum {
     ARCH_X86,
     ARCH_AMD64,
@@ -1420,52 +1384,40 @@
     }
 }

+typedef LONG (WINAPI *RtlGetVersionPtr)(PRTL_OSVERSIONINFOW);
+
 const char *
-win32_version_string(struct gc_arena *gc, bool add_name)
+win32_version_string(struct gc_arena *gc)
 {
-    int version =3D win32_version_info();
-    struct buffer out =3D alloc_buf_gc(256, gc);
-
-    switch (version)
+    HMODULE hMod =3D GetModuleHandleW(L"ntdll.dll");
+    if (!hMod)
     {
-        case WIN_XP:
-            buf_printf(&out, "5.1%s", add_name ? " (Windows XP)" : "");
-            break;
-
-        case WIN_VISTA:
-            buf_printf(&out, "6.0%s", add_name ? " (Windows Vista)" : "");
-            break;
-
-        case WIN_7:
-            buf_printf(&out, "6.1%s", add_name ? " (Windows 7)" : "");
-            break;
-
-        case WIN_8:
-            buf_printf(&out, "6.2%s", add_name ? " (Windows 8)" : "");
-            break;
-
-        case WIN_8_1:
-            buf_printf(&out, "6.3%s", add_name ? " (Windows 8.1)" : "");
-            break;
-
-        case WIN_10:
-            buf_printf(&out, "10.0%s", add_name ? " (Windows 10 or greater=
)" : "");
-            break;
-
-        default:
-            msg(M_NONFATAL, "Unknown Windows version: %d", version);
-            buf_printf(&out, "0.0%s", add_name ? " (unknown)" : "");
-            break;
+        return "N/A";
     }

-    buf_printf(&out, ", ");
+    RtlGetVersionPtr fn =3D (RtlGetVersionPtr)GetProcAddress(hMod, "RtlGet=
Version");
+    if (!fn)
+    {
+        return "N/A";
+    }
+
+    RTL_OSVERSIONINFOW rovi =3D { 0 };
+    rovi.dwOSVersionInfoSize =3D sizeof(rovi);
+    if (fn(&rovi) !=3D 0)
+    {
+        return "N/A";
+    }
+
+    struct buffer out =3D alloc_buf_gc(256, gc);
+
+    buf_printf(&out, "%lu.%lu.%lu", rovi.dwMajorVersion, rovi.dwMinorVersi=
on, rovi.dwBuildNumber);
+
+    buf_printf(&out, ",");

     arch_t process_arch, host_arch;
     win32_get_arch(&process_arch, &host_arch);
     win32_print_arch(process_arch, &out);

-    buf_printf(&out, " executable");
-
     if (host_arch !=3D ARCH_NATIVE)
     {
         buf_printf(&out, " running on ");
diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h
index 081beeb..685898c 100644
--- a/src/openvpn/win32.h
+++ b/src/openvpn/win32.h
@@ -292,20 +292,13 @@

 bool win_wfp_uninit(const NET_IFINDEX index, const HANDLE msg_channel);

-#define WIN_XP    0
-#define WIN_VISTA 1
-#define WIN_7     2
-#define WIN_8     3
-#define WIN_8_1   4
-#define WIN_10    5
-
-int win32_version_info(void);
-
-/*
- * String representation of Windows version number and name, see
- * https://msdn.microsoft.com/en-us/library/windows/desktop/ms724832(v=3Dv=
s.85).aspx
+/**
+ * @brief Get Windows version string with architecture info.
+ *
+ * @param gc gc arena to allocate string.
+ * @return Version string, or "N/A" on failure.
  */
-const char *win32_version_string(struct gc_arena *gc, bool add_name);
+const char *win32_version_string(struct gc_arena *gc);

 /*
  * Send the |size| bytes in buffer |data| to the interactive service |pipe|

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/944?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I39d660ebeec76280e4d4357192b74bf2c0980615
Gerrit-Change-Number: 944
Gerrit-PatchSet: 4
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--jTYQEibJips=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #4</strong> to the change originally cr=
eated by stipa.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/944?=
usp=3Demail">View Change</a></p><p>The following approvals got outdated and=
 were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">win: refactor get_windows_version()<br><br>It&#39;s =
2025, and almost all clients now run on Windows 10 or newer.<br>Instead of =
displaying:<br><br>  &quot;Windows version 10.0 (Windows 10 or greater), am=
d64 executable&quot;<br><br>we now show the exact build number, e.g.:<br><b=
r>  &quot;Windows version: 10.0.22631,amd64&quot;<br><br>Remove &quot;pre-W=
in7&quot; checks in a few places.<br><br>Change-Id: I39d660ebeec76280e4d435=
7192b74bf2c0980615<br>Signed-off-by: Lev Stipakov &lt;lev@...515...&gt;<br>=
Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Message-Id: &lt;202505051=
22712.5214-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openv=
pn-devel@lists.sourceforge.net/msg31566.html<br>Signed-off-by: Gert Doering=
 &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/options.c<br>M src/openvpn=
/ssl.c<br>M src/openvpn/tun.c<br>M src/openvpn/win32.c<br>M src/openvpn/win=
32.h<br>5 files changed, 36 insertions(+), 95 deletions(-)<br><br></pre><pr=
e style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pu=
ll ssh://gerrit.openvpn.net:29418/openvpn refs/changes/44/944/4</pre><pre s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>dif=
f --git a/src/openvpn/options.c b/src/openvpn/options.c</span><br><span>ind=
ex 8c41dec..02970a7 100644</span><br><span>--- a/src/openvpn/options.c</spa=
n><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -4847,7 +4847,7 =
@@</span><br><span> show_windows_version(const unsigned int flags)</span><b=
r><span> {</span><br><span>     struct gc_arena gc =3D gc_new();</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    msg(flags, &quot;Windows ver=
sion %s&quot;, win32_version_string(&amp;gc, true));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    msg(flags, &quot;Windows version: %s&=
quot;, win32_version_string(&amp;gc));</span><br><span>     gc_free(&amp;gc=
);</span><br><span> }</span><br><span> #endif</span><br><span>diff --git a/=
src/openvpn/ssl.c b/src/openvpn/ssl.c</span><br><span>index 23f6423..fd299e=
f 100644</span><br><span>--- a/src/openvpn/ssl.c</span><br><span>+++ b/src/=
openvpn/ssl.c</span><br><span>@@ -2060,7 +2060,7 @@</span><br><span>       =
      }</span><br><span>             buf_printf(&amp;out, &quot;IV_SSL=3D%s=
\n&quot;, get_ssl_library_version() );</span><br><span> #if defined(_WIN32)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            buf_print=
f(&amp;out, &quot;IV_PLAT_VER=3D%s\n&quot;, win32_version_string(&amp;gc, f=
alse));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
buf_printf(&amp;out, &quot;IV_PLAT_VER=3D%s\n&quot;, win32_version_string(&=
amp;gc));</span><br><span> #else</span><br><span>             struct utsnam=
e u;</span><br><span>             uname(&amp;u);</span><br><span>diff --git=
 a/src/openvpn/tun.c b/src/openvpn/tun.c</span><br><span>index 4f7de6c..518=
6afa 100644</span><br><span>--- a/src/openvpn/tun.c</span><br><span>+++ b/s=
rc/openvpn/tun.c</span><br><span>@@ -5428,11 +5428,8 @@</span><br><span>   =
                  NETSH_PATH_SUFFIX, adapter_index,</span><br><span>       =
              print_in6_addr(addr_list[i], 0, &amp;gc));</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* disable slo=
w address validation on Windows 7 and higher */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        if (win32_version_info() &gt;=3D WIN_7)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            argv_printf_cat(&amp;ar=
gv, &quot;%s&quot;, &quot;validate=3Dno&quot;);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        /* disable slow address validation */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        argv_printf_cat(&amp;argv=
, &quot;%s&quot;, &quot;validate=3Dno&quot;);</span><br><span> </span><br><=
span>         /* Treat errors while adding as non-fatal as we do not check =
for duplicates */</span><br><span>         netsh_command(&amp;argv, 1, (i=
=3D=3D0) ? M_FATAL : M_NONFATAL);</span><br><span>@@ -5498,9 +5495,8 @@</sp=
an><br><span>                             adapter_index,</span><br><span>  =
                           print_in_addr_t(addr_list[i], 0, &amp;gc));</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
        /* disable slow address validation on Windows 7 and higher */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                /* only for=
 DNS */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
  if (is_dns &amp;&amp; win32_version_info() &gt;=3D WIN_7)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                /* disable slow add=
ress validation for DNS */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                if (is_dns)</span><br><span>                 {</span=
><br><span>                     argv_printf_cat(&amp;argv, &quot;%s&quot;, =
&quot;validate=3Dno&quot;);</span><br><span>                 }</span><br><s=
pan>diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c</span><br><span>=
index edac71e..caa14d6 100644</span><br><span>--- a/src/openvpn/win32.c</sp=
an><br><span>+++ b/src/openvpn/win32.c</span><br><span>@@ -1283,42 +1283,6 =
@@</span><br><span>     return true;</span><br><span> }</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-int</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-win32_version_info(void)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    if (!IsWindowsXPOrGreater())</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        msg(M_FATAL, &quot;Error: Windows version must be XP or=
 greater.&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    if (!IsWindowsVistaOrGreater())</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        return WIN_XP;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
if (!IsWindows7OrGreater())</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        re=
turn WIN_VISTA;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (!IsWindows8OrGreater())</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        return WIN_7;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!Is=
Windows8Point1OrGreater())</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ret=
urn WIN_8;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    if (!IsWindows10OrGreater())</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        return WIN_8_1;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return WI=
N_10;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> typedef enum {</sp=
an><br><span>     ARCH_X86,</span><br><span>     ARCH_AMD64,</span><br><spa=
n>@@ -1420,52 +1384,40 @@</span><br><span>     }</span><br><span> }</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+typedef L=
ONG (WINAPI *RtlGetVersionPtr)(PRTL_OSVERSIONINFOW);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> const char *</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-win32_version_string(struct gc_a=
rena *gc, bool add_name)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+win32_version_string(struct gc_arena *gc)</span><br><span> {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    int version =3D win32_versi=
on_info();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct =
buffer out =3D alloc_buf_gc(256, gc);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    s=
witch (version)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
HMODULE hMod =3D GetModuleHandleW(L&quot;ntdll.dll&quot;);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (!hMod)</span><br><span>     =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        case WIN_XP:=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            buf_print=
f(&amp;out, &quot;5.1%s&quot;, add_name ? &quot; (Windows XP)&quot; : &quot=
;&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
break;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        case WIN_VISTA:</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            buf_printf(&amp;out, &=
quot;6.0%s&quot;, add_name ? &quot; (Windows Vista)&quot; : &quot;&quot;);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            break;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        case WIN_7:</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            buf_printf(&amp;out, &quot;6.1%s&quo=
t;, add_name ? &quot; (Windows 7)&quot; : &quot;&quot;);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            break;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        case WIN_8:</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            buf_printf(&amp;out, &quot;6.2%s&quot;, add_name ? &qu=
ot; (Windows 8)&quot; : &quot;&quot;);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            break;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 case WIN_8_1:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     buf_printf(&amp;out, &quot;6.3%s&quot;, add_name ? &quot; (Windows 8.1=
)&quot; : &quot;&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            break;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        case WIN_10:<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            buf_printf=
(&amp;out, &quot;10.0%s&quot;, add_name ? &quot; (Windows 10 or greater)&qu=
ot; : &quot;&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           break;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        default:</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_NONFATAL, &q=
uot;Unknown Windows version: %d&quot;, version);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            buf_printf(&amp;out, &quot;0.0%s&quo=
t;, add_name ? &quot; (unknown)&quot; : &quot;&quot;);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            break;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return &quot;N/A&quot;;</span><br=
><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    buf_printf(&amp;out, &quot;, &quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    RtlGetVersionPtr fn =3D (RtlGetVersio=
nPtr)GetProcAddress(hMod, &quot;RtlGetVersion&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!fn)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        return &quot;N/A&quot;;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    RTL_=
OSVERSIONINFOW rovi =3D { 0 };</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    rovi.dwOSVersionInfoSize =3D sizeof(rovi);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (fn(&amp;rovi) !=3D 0)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return &quot;N/A&quot;;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    struct buffer out =3D alloc_buf_gc(256, gc);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    buf_printf(&amp;out, &quot;%lu.%lu.%lu&quot;, =
rovi.dwMajorVersion, rovi.dwMinorVersion, rovi.dwBuildNumber);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    buf_printf(&amp;out, &quot;,&quot;);</span><br>=
<span> </span><br><span>     arch_t process_arch, host_arch;</span><br><spa=
n>     win32_get_arch(&amp;process_arch, &amp;host_arch);</span><br><span> =
    win32_print_arch(process_arch, &amp;out);</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    buf_printf(&amp;out, &quot; e=
xecutable&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span>     if (host_arch !=3D ARCH_NATIVE)</span><br><span>     {</s=
pan><br><span>         buf_printf(&amp;out, &quot; running on &quot;);</spa=
n><br><span>diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h</span><b=
r><span>index 081beeb..685898c 100644</span><br><span>--- a/src/openvpn/win=
32.h</span><br><span>+++ b/src/openvpn/win32.h</span><br><span>@@ -292,20 +=
292,13 @@</span><br><span> </span><br><span> bool win_wfp_uninit(const NET_=
IFINDEX index, const HANDLE msg_channel);</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#define WIN_XP    0</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#define WIN_VISTA 1</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#define WIN_7     2</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define WIN_8     3</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define WIN_8_1   4</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define WIN_10    5</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-int win32_version_info(void);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * String representat=
ion of Windows version number and name, see</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- * https://msdn.microsoft.com/en-us/library/windows/d=
esktop/ms724832(v=3Dvs.85).aspx</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @=
brief Get Windows version string with architecture info.</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * @param gc gc arena to allocate string.</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @return Version string, or &qu=
ot;N/A&quot; on failure.</span><br><span>  */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-const char *win32_version_string(struct gc_arena *g=
c, bool add_name);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+c=
onst char *win32_version_string(struct gc_arena *gc);</span><br><span> </sp=
an><br><span> /*</span><br><span>  * Send the |size| bytes in buffer |data|=
 to the interactive service |pipe|</span><br><span></span><br></pre><p>To v=
iew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/944?usp=3Demail=
">change 944</a>. To unsubscribe, or for help writing mail filters, visit <=
a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemsco=
pe itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/944?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I39d660ebeec76280e4d4357192b=
74bf2c0980615 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 944 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--jTYQEibJips=--

