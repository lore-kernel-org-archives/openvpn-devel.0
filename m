From: "stipa (Code Review)" <gerrit@...515...>
Date: Fri, 18 Apr 2025 13:06:41 +0000
References: <gerrit.1744981598000.I39d660ebeec76280e4d4357192b74bf2c0980615@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <a71edc302e7e6355b4349baaee7a3ddfb7f4fdf0-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="awA6vww8by0="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--awA6vww8by0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/944?usp=3Demail

to review the following change.


Change subject: win: refactor get_windows_version()
......................................................................

win: refactor get_windows_version()

It's 2025, and almost all clients now run on Windows 10 or newer.
Instead of displaying:

  "Windows version 10.0 (Windows 10 or greater)"

we now show the exact build number, e.g.:

  "Windows version: 10.0.22631"

Remove "pre-Win7" checks in a few places.

For IV_PLAT_VER, we now provide only the version number without
binary architecture info. Previously:

  IV_PLAT_VER=3D10.0,_amd64_executable

Now:

  IV_PLAT_VER=3D10.0.22631

Change-Id: I39d660ebeec76280e4d4357192b74bf2c0980615
Signed-off-by: Lev Stipakov <lev@...515...>
---
M src/openvpn/tun.c
M src/openvpn/win32.c
M src/openvpn/win32.h
3 files changed, 49 insertions(+), 93 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/44/944/1

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
index edac71e..8d4c4a3 100644
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
@@ -1420,57 +1384,50 @@
     }
 }

+typedef LONG (WINAPI *RtlGetVersionPtr)(PRTL_OSVERSIONINFOW);
+
 const char *
-win32_version_string(struct gc_arena *gc, bool add_name)
+win32_version_string(struct gc_arena *gc, bool add_exec_info)
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
-
-    arch_t process_arch, host_arch;
-    win32_get_arch(&process_arch, &host_arch);
-    win32_print_arch(process_arch, &out);
-
-    buf_printf(&out, " executable");
-
-    if (host_arch !=3D ARCH_NATIVE)
+    RtlGetVersionPtr fn =3D (RtlGetVersionPtr)GetProcAddress(hMod, "RtlGet=
Version");
+    if (!fn)
     {
-        buf_printf(&out, " running on ");
-        win32_print_arch(host_arch, &out);
-        buf_printf(&out, " host");
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
+    if (add_exec_info)
+    {
+        buf_printf(&out, ", ");
+
+        arch_t process_arch, host_arch;
+        win32_get_arch(&process_arch, &host_arch);
+        win32_print_arch(process_arch, &out);
+
+        buf_printf(&out, " executable");
+
+        if (host_arch !=3D ARCH_NATIVE)
+        {
+            buf_printf(&out, " running on ");
+            win32_print_arch(host_arch, &out);
+            buf_printf(&out, " host");
+        }
     }

     return (const char *)out.data;
diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h
index 081beeb..d663586 100644
--- a/src/openvpn/win32.h
+++ b/src/openvpn/win32.h
@@ -301,11 +301,14 @@

 int win32_version_info(void);

-/*
- * String representation of Windows version number and name, see
- * https://msdn.microsoft.com/en-us/library/windows/desktop/ms724832(v=3Dv=
s.85).aspx
+/**
+ * @brief Get Windows version string, optionally with architecture info.
+ *
+ * @param gc gc arena to allocate string.
+ * @param add_exec_info Whether to include architecture details.
+ * @return Version string, or "N/A" on failure.
  */
-const char *win32_version_string(struct gc_arena *gc, bool add_name);
+const char *win32_version_string(struct gc_arena *gc, bool add_exec_info);

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
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--awA6vww8by0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>stipa would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/944?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">win: refactor get_windows_version()<br><br>It&#39;s 2025, and=
 almost all clients now run on Windows 10 or newer.<br>Instead of displayin=
g:<br><br>  &quot;Windows version 10.0 (Windows 10 or greater)&quot;<br><br=
>we now show the exact build number, e.g.:<br><br>  &quot;Windows version: =
10.0.22631&quot;<br><br>Remove &quot;pre-Win7&quot; checks in a few places.=
<br><br>For IV_PLAT_VER, we now provide only the version number without<br>=
binary architecture info. Previously:<br><br>  IV_PLAT_VER=3D10.0,_amd64_ex=
ecutable<br><br>Now:<br><br>  IV_PLAT_VER=3D10.0.22631<br><br>Change-Id: I3=
9d660ebeec76280e4d4357192b74bf2c0980615<br>Signed-off-by: Lev Stipakov &lt;=
lev@...515...&gt;<br>---<br>M src/openvpn/tun.c<br>M src/openvpn/win32.c<br=
>M src/openvpn/win32.h<br>3 files changed, 49 insertions(+), 93 deletions(-=
)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/44=
/944/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;"><span>diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c</span><br=
><span>index 4f7de6c..5186afa 100644</span><br><span>--- a/src/openvpn/tun.=
c</span><br><span>+++ b/src/openvpn/tun.c</span><br><span>@@ -5428,11 +5428=
,8 @@</span><br><span>                     NETSH_PATH_SUFFIX, adapter_index=
,</span><br><span>                     print_in6_addr(addr_list[i], 0, &amp=
;gc));</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        /* disable slow address validation on Windows 7 and higher */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (win32_versio=
n_info() &gt;=3D WIN_7)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  argv_printf_cat(&amp;argv, &quot;%s&quot;, &quot;validate=3Dno&quot;);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        /* disable slow address va=
lidation */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
argv_printf_cat(&amp;argv, &quot;%s&quot;, &quot;validate=3Dno&quot;);</spa=
n><br><span> </span><br><span>         /* Treat errors while adding as non-=
fatal as we do not check for duplicates */</span><br><span>         netsh_c=
ommand(&amp;argv, 1, (i=3D=3D0) ? M_FATAL : M_NONFATAL);</span><br><span>@@=
 -5498,9 +5495,8 @@</span><br><span>                             adapter_in=
dex,</span><br><span>                             print_in_addr_t(addr_list=
[i], 0, &amp;gc));</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                /* disable slow address validation on Window=
s 7 and higher */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
            /* only for DNS */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                if (is_dns &amp;&amp; win32_version_info() &gt;=3D=
 WIN_7)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    /* disable slow address validation for DNS */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                if (is_dns)</span><br><span> =
                {</span><br><span>                     argv_printf_cat(&amp=
;argv, &quot;%s&quot;, &quot;validate=3Dno&quot;);</span><br><span>        =
         }</span><br><span>diff --git a/src/openvpn/win32.c b/src/openvpn/w=
in32.c</span><br><span>index edac71e..8d4c4a3 100644</span><br><span>--- a/=
src/openvpn/win32.c</span><br><span>+++ b/src/openvpn/win32.c</span><br><sp=
an>@@ -1283,42 +1283,6 @@</span><br><span>     return true;</span><br><span=
> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-win32_version_info=
(void)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    if (!IsWindowsXPOrGreater())</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        msg(M_FATAL, &quot;Error: Window=
s version must be XP or greater.&quot;);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!IsWindows=
VistaOrGreater())</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return WIN_X=
P;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    if (!IsWindows7OrGreater())</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        return WIN_VISTA;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!IsWindows8O=
rGreater())</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        return WIN_7;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    if (!IsWindows8Point1OrGreater())</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        return WIN_8;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!IsWindows10OrGre=
ater())</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        return WIN_8_1;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    return WIN_10;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span> typedef enum {</span><br><span>     ARCH_X86,</span><br><span>     AR=
CH_AMD64,</span><br><span>@@ -1420,57 +1384,50 @@</span><br><span>     }</s=
pan><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+typedef LONG (WINAPI *RtlGetVersionPtr)(PRTL_OSVERSIONINFOW)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> =
const char *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-win32_ver=
sion_string(struct gc_arena *gc, bool add_name)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+win32_version_string(struct gc_arena *gc, bool =
add_exec_info)</span><br><span> {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    int version =3D win32_version_info();</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    struct buffer out =3D alloc_buf_gc(256,=
 gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    switch (version)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    HMODULE hMod =3D GetModuleHandle=
W(L&quot;ntdll.dll&quot;);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (!hMod)</span><br><span>     {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        case WIN_XP:</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            buf_printf(&amp;out, &quot;5.1%s&quot;, a=
dd_name ? &quot; (Windows XP)&quot; : &quot;&quot;);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            break;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        case WIN_VISTA:</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            buf_printf(&amp;out, &quot;6.0%s&quot;, add_name ? &q=
uot; (Windows Vista)&quot; : &quot;&quot;);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            break;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      case WIN_7:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        buf_printf(&amp;out, &quot;6.1%s&quot;, add_name ? &quot; (Windows =
7)&quot; : &quot;&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            break;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        case WIN_8:<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            buf_printf=
(&amp;out, &quot;6.2%s&quot;, add_name ? &quot; (Windows 8)&quot; : &quot;&=
quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            br=
eak;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        case WIN_8_1:</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            buf_printf(&amp;out, &quot=
;6.3%s&quot;, add_name ? &quot; (Windows 8.1)&quot; : &quot;&quot;);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            break;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        case WIN_10:</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            buf_printf(&amp;out, &quot;10.0%s&quot;, =
add_name ? &quot; (Windows 10 or greater)&quot; : &quot;&quot;);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            break;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        default:</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            msg(M_NONFATAL, &quot;Unknown Windows version: %d=
&quot;, version);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        buf_printf(&amp;out, &quot;0.0%s&quot;, add_name ? &quot; (unknown)=
&quot; : &quot;&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        return &quot;N/A&quot;;</span><br><span>     }</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    buf_printf(&amp;out=
, &quot;, &quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    arch_t process_arch,=
 host_arch;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    win32_=
get_arch(&amp;process_arch, &amp;host_arch);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    win32_print_arch(process_arch, &amp;out);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    buf_printf(&amp;out, &quot; executable&quot;)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    if (host_arch !=3D ARCH_NATIVE)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    RtlGetVersionPtr fn =
=3D (RtlGetVersionPtr)GetProcAddress(hMod, &quot;RtlGetVersion&quot;);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!fn)</span><br><=
span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        bu=
f_printf(&amp;out, &quot; running on &quot;);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        win32_print_arch(host_arch, &amp;out);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        buf_printf(&amp;ou=
t, &quot; host&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        return &quot;N/A&quot;;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    RTL_OSVERSIONI=
NFOW rovi =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    rovi.dwOSVersionInfoSize =3D sizeof(rovi);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (fn(&amp;rovi) !=3D 0)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        return &quot;N/A&quot;;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct buffer out =3D alloc_buf_gc(256, gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    buf_printf(&amp;out, &quot;%lu.%lu.%lu&quot;, rovi.dwMaj=
orVersion, rovi.dwMinorVersion, rovi.dwBuildNumber);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (add_exec_info)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        buf_printf(&amp;out, &quot;, &quot;);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        arch_t process_arch, host_arch;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        win32_get_arch(&amp;process_arch, &a=
mp;host_arch);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   win32_print_arch(process_arch, &amp;out);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        buf_printf(&amp;out, &quot; executable&quot;);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        if (host_arch !=3D ARCH_NATIVE)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            buf_printf(&amp;out, &quot; r=
unning on &quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           win32_print_arch(host_arch, &amp;out);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            buf_printf(&amp;out, &quot; host&=
quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</s=
pan><br><span>     }</span><br><span> </span><br><span>     return (const c=
har *)out.data;</span><br><span>diff --git a/src/openvpn/win32.h b/src/open=
vpn/win32.h</span><br><span>index 081beeb..d663586 100644</span><br><span>-=
-- a/src/openvpn/win32.h</span><br><span>+++ b/src/openvpn/win32.h</span><b=
r><span>@@ -301,11 +301,14 @@</span><br><span> </span><br><span> int win32_=
version_info(void);</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * =
String representation of Windows version number and name, see</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- * https://msdn.microsoft.com/en-us=
/library/windows/desktop/ms724832(v=3Dvs.85).aspx</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * @brief Get Windows version string, optionally with archite=
cture info.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param gc gc arena to =
allocate string.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
@param add_exec_info Whether to include architecture details.</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @return Version string, or &qu=
ot;N/A&quot; on failure.</span><br><span>  */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-const char *win32_version_string(struct gc_arena *g=
c, bool add_name);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+c=
onst char *win32_version_string(struct gc_arena *gc, bool add_exec_info);</=
span><br><span> </span><br><span> /*</span><br><span>  * Send the |size| by=
tes in buffer |data| to the interactive service |pipe|</span><br><span></sp=
an><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/944?usp=3Demail">change 944</a>. To unsubscribe, or for help writing m=
ail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings<=
/a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div ite=
mscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link =
itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/944?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I39d660ebeec76280e4d4357192b=
74bf2c0980615 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 944 </div>
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
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--awA6vww8by0=--

