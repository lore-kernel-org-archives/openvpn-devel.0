From: "stipa (Code Review)" <gerrit@...515...>
Date: Fri, 12 Sep 2025 13:27:34 +0000
References: <gerrit.1757683652000.Ie135e070b481b88033c43b76f872060fb237243c@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <b8cc414b251470a246a54ffb1a551200242b1c4d-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6D9Wfr8Jmqo="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: win: replace wmic
 invocation with powershell
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

--6D9Wfr8Jmqo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1182?usp=3Demail

to review the following change.


Change subject: win: replace wmic invocation with powershell
......................................................................

win: replace wmic invocation with powershell

Since wmic has been recently deprecated and is absent on new
systems, replace setting DNS domain "old-style" with powershell.

Some changes to the service implementation:

 - remove action parameter and hardcode Set-DnsClient since this is
 the only used action

 - remove support of multiple domains, since we only pass a single domain
 (tuntap_options.domain)

GitHub: https://github.com/OpenVPN/openvpn/issues/642

Change-Id: Ie135e070b481b88033c43b76f872060fb237243c
Signed-off-by: Lev Stipakov <lev@...515...>
---
M src/openvpn/tun.c
M src/openvpn/win32.h
M src/openvpnserv/interactive.c
3 files changed, 21 insertions(+), 30 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/82/1182/1

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 92e71a3..1ece1e1 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -383,7 +383,7 @@
 }

 static void
-do_dns_domain_wmic(bool add, const struct tuntap *tt)
+do_dns_domain_pwsh(bool add, const struct tuntap *tt)
 {
     if (!tt->options.domain)
     {
@@ -391,9 +391,14 @@
     }

     struct argv argv =3D argv_new();
-    argv_printf(&argv, "%s%s nicconfig where (InterfaceIndex=3D%ld) call S=
etDNSDomain '%s'",
-                get_win_sys_path(), WMIC_PATH_SUFFIX, tt->adapter_index, a=
dd ? tt->options.domain : "");
-    exec_command("WMIC", &argv, 1, M_WARN);
+    argv_printf(&argv,
+                "%s%s -NoProfile -NonInteractive -Command Set-DnsClient -I=
nterfaceIndex %ld -ConnectionSpecificSuffix '%s'",
+                get_win_sys_path(),
+                POWERSHELL_PATH_SUFFIX,
+                tt->adapter_index,
+                add ? tt->options.domain : ""
+                );
+    exec_command("PowerShell", &argv, 1, M_WARN);

     argv_free(&argv);
 }
@@ -1269,7 +1274,7 @@

         if (!tt->did_ifconfig_setup)
         {
-            do_dns_domain_wmic(true, tt);
+            do_dns_domain_pwsh(true, tt);
         }
     }
 #else /* platforms we have no IPv6 code for */
@@ -1625,7 +1630,7 @@
                            tt->adapter_netmask, NI_IP_NETMASK | NI_OPTIONS=
);
         }

-        do_dns_domain_wmic(true, tt);
+        do_dns_domain_pwsh(true, tt);
     }


@@ -7024,7 +7029,7 @@
         {
             if (!tt->did_ifconfig_setup)
             {
-                do_dns_domain_wmic(false, tt);
+                do_dns_domain_pwsh(false, tt);
             }

             netsh_delete_address_dns(tt, true, &gc);
@@ -7050,7 +7055,7 @@
         }
         else
         {
-            do_dns_domain_wmic(false, tt);
+            do_dns_domain_pwsh(false, tt);

             if (tt->options.ip_win32_type =3D=3D IPW32_SET_NETSH)
             {
diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h
index 1b87fa3..67e6169 100644
--- a/src/openvpn/win32.h
+++ b/src/openvpn/win32.h
@@ -38,7 +38,7 @@
 #define WIN_ROUTE_PATH_SUFFIX "\\system32\\route.exe"
 #define WIN_IPCONFIG_PATH_SUFFIX "\\system32\\ipconfig.exe"
 #define WIN_NET_PATH_SUFFIX "\\system32\\net.exe"
-#define WMIC_PATH_SUFFIX "\\system32\\wbem\\wmic.exe"
+#define POWERSHELL_PATH_SUFFIX "\\system32\\WindowsPowerShell\\v1.0\\power=
shell.exe"

 /*
  * Win32-specific OpenVPN code, targeted at the mingw
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index a25d26f..d38373a 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -1150,45 +1150,31 @@
 }

 /**
- * Run command: wmic nicconfig (InterfaceIndex=3D$if_index) call $action (=
$data)
+ * Run command: powershell -NoProfile -NonInteractive -Command Set-DnsClie=
nt -InterfaceIndex %ld -ConnectionSpecificSuffix '%s'
  * @param  if_index    "index of interface"
- * @param  action      e.g., "SetDNSDomain"
  * @param  data        data if required for action
  *                     - a single word for SetDNSDomain, empty or NULL to =
delete
- *                     - comma separated values for a list
  */
 static DWORD
-wmic_nicconfig_cmd(const wchar_t *action, const NET_IFINDEX if_index,
-                   const wchar_t *data)
+pwsh_setdns_cmd(const NET_IFINDEX if_index, const wchar_t *data)
 {
     DWORD err =3D 0;
     wchar_t argv0[MAX_PATH];
     wchar_t *cmdline =3D NULL;
     int timeout =3D 10000; /* in msec */

-    openvpn_swprintf(argv0, _countof(argv0), L"%ls\\%ls", get_win_sys_path=
(), L"wbem\\wmic.exe");
+    openvpn_swprintf(argv0, _countof(argv0), L"%ls\\%ls", get_win_sys_path=
(), L"WindowsPowerShell\\v1.0\\powershell.exe");

-    const wchar_t *fmt;
-    /* comma separated list must be enclosed in parenthesis */
-    if (data && wcschr(data, L','))
-    {
-        fmt =3D L"wmic nicconfig where (InterfaceIndex=3D%ld) call %ls (%l=
s)";
-    }
-    else
-    {
-        fmt =3D L"wmic nicconfig where (InterfaceIndex=3D%ld) call %ls \"%=
ls\"";
-    }
+    const wchar_t *fmt =3D L"-NoProfile -NonInteractive -Command Set-DnsCl=
ient -InterfaceIndex %ld -ConnectionSpecificSuffix '%s'";

-    size_t ncmdline =3D wcslen(fmt) + 20 + wcslen(action) /* max 20 for if=
index */
-                      + (data ? wcslen(data) + 1 : 1);
+    size_t ncmdline =3D wcslen(fmt) + 20 + /* max 20 for ifindex */ (data =
? wcslen(data) + 1 : 1);
     cmdline =3D malloc(ncmdline*sizeof(wchar_t));
     if (!cmdline)
     {
         return ERROR_OUTOFMEMORY;
     }

-    openvpn_swprintf(cmdline, ncmdline, fmt, if_index, action,
-                     data ? data : L"");
+    openvpn_swprintf(cmdline, ncmdline, fmt, if_index, data ? data : L"");
     err =3D ExecCommand(argv0, cmdline, timeout);

     free(cmdline);
@@ -1248,7 +1234,7 @@
         free(RemoveListItem(&(*lists)[undo_domain], CmpWString, (void *)if=
_name));
     }

-    err =3D wmic_nicconfig_cmd(L"SetDNSDomain", if_index, wdomain);
+    err =3D pwsh_setdns_cmd(if_index, wdomain);

     /* Add to undo list if domain is non-empty */
     if (err =3D=3D 0 && wdomain[0] && lists)

--=20
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1182?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie135e070b481b88033c43b76f872060fb237243c
Gerrit-Change-Number: 1182
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--6D9Wfr8Jmqo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>stipa would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1182?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">win: replace wmic invocation with powershell<br><br>Since wm=
ic has been recently deprecated and is absent on new<br>systems, replace se=
tting DNS domain &quot;old-style&quot; with powershell.<br><br>Some changes=
 to the service implementation:<br><br> - remove action parameter and hardc=
ode Set-DnsClient since this is<br> the only used action<br><br> - remove s=
upport of multiple domains, since we only pass a single domain<br> (tuntap_=
options.domain)<br><br>GitHub: https://github.com/OpenVPN/openvpn/issues/64=
2<br><br>Change-Id: Ie135e070b481b88033c43b76f872060fb237243c<br>Signed-off=
-by: Lev Stipakov &lt;lev@...515...&gt;<br>---<br>M src/openvpn/tun.c<br>M =
src/openvpn/win32.h<br>M src/openvpnserv/interactive.c<br>3 files changed, =
21 insertions(+), 30 deletions(-)<br><br></pre><pre style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.n=
et:29418/openvpn refs/changes/82/1182/1</pre><pre style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/tu=
n.c b/src/openvpn/tun.c</span><br><span>index 92e71a3..1ece1e1 100644</span=
><br><span>--- a/src/openvpn/tun.c</span><br><span>+++ b/src/openvpn/tun.c<=
/span><br><span>@@ -383,7 +383,7 @@</span><br><span> }</span><br><span> </s=
pan><br><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-do_dns_domain_wmic(bool add, const struct tuntap *tt)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+do_dns_domain_pwsh(bool add, const s=
truct tuntap *tt)</span><br><span> {</span><br><span>     if (!tt-&gt;optio=
ns.domain)</span><br><span>     {</span><br><span>@@ -391,9 +391,14 @@</spa=
n><br><span>     }</span><br><span> </span><br><span>     struct argv argv =
=3D argv_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ar=
gv_printf(&amp;argv, &quot;%s%s nicconfig where (InterfaceIndex=3D%ld) call=
 SetDNSDomain &#39;%s&#39;&quot;,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                get_win_sys_path(), WMIC_PATH_SUFFIX, tt-&gt;ad=
apter_index, add ? tt-&gt;options.domain : &quot;&quot;);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    exec_command(&quot;WMIC&quot;, &amp=
;argv, 1, M_WARN);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   argv_printf(&amp;argv,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                &quot;%s%s -NoProfile -NonInteractive -Command Set-Dn=
sClient -InterfaceIndex %ld -ConnectionSpecificSuffix &#39;%s&#39;&quot;,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                get_w=
in_sys_path(),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
           POWERSHELL_PATH_SUFFIX,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                tt-&gt;adapter_index,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                add ? tt-&gt;options.doma=
in : &quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              );</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 exec_command(&quot;PowerShell&quot;, &amp;argv, 1, M_WARN);</span><br><spa=
n> </span><br><span>     argv_free(&amp;argv);</span><br><span> }</span><br=
><span>@@ -1269,7 +1274,7 @@</span><br><span> </span><br><span>         if =
(!tt-&gt;did_ifconfig_setup)</span><br><span>         {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            do_dns_domain_wmic(true, tt);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            do_dns_=
domain_pwsh(true, tt);</span><br><span>         }</span><br><span>     }</s=
pan><br><span> #else /* platforms we have no IPv6 code for */</span><br><sp=
an>@@ -1625,7 +1630,7 @@</span><br><span>                            tt-&gt=
;adapter_netmask, NI_IP_NETMASK | NI_OPTIONS);</span><br><span>         }</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   do_dns_domain_wmic(true, tt);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        do_dns_domain_pwsh(true, tt);</span><br><span>     }</=
span><br><span> </span><br><span> </span><br><span>@@ -7024,7 +7029,7 @@</s=
pan><br><span>         {</span><br><span>             if (!tt-&gt;did_ifcon=
fig_setup)</span><br><span>             {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                do_dns_domain_wmic(false, tt);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                do_dns_domai=
n_pwsh(false, tt);</span><br><span>             }</span><br><span> </span><=
br><span>             netsh_delete_address_dns(tt, true, &amp;gc);</span><b=
r><span>@@ -7050,7 +7055,7 @@</span><br><span>         }</span><br><span>  =
       else</span><br><span>         {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            do_dns_domain_wmic(false, tt);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            do_dns_domain_pwsh(fals=
e, tt);</span><br><span> </span><br><span>             if (tt-&gt;options.i=
p_win32_type =3D=3D IPW32_SET_NETSH)</span><br><span>             {</span><=
br><span>diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h</span><br><=
span>index 1b87fa3..67e6169 100644</span><br><span>--- a/src/openvpn/win32.=
h</span><br><span>+++ b/src/openvpn/win32.h</span><br><span>@@ -38,7 +38,7 =
@@</span><br><span> #define WIN_ROUTE_PATH_SUFFIX &quot;\\system32\\route.e=
xe&quot;</span><br><span> #define WIN_IPCONFIG_PATH_SUFFIX &quot;\\system32=
\\ipconfig.exe&quot;</span><br><span> #define WIN_NET_PATH_SUFFIX &quot;\\s=
ystem32\\net.exe&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#define WMIC_PATH_SUFFIX &quot;\\system32\\wbem\\wmic.exe&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#define POWERSHELL_PATH_SUFFIX=
 &quot;\\system32\\WindowsPowerShell\\v1.0\\powershell.exe&quot;</span><br>=
<span> </span><br><span> /*</span><br><span>  * Win32-specific OpenVPN code=
, targeted at the mingw</span><br><span>diff --git a/src/openvpnserv/intera=
ctive.c b/src/openvpnserv/interactive.c</span><br><span>index a25d26f..d383=
73a 100644</span><br><span>--- a/src/openvpnserv/interactive.c</span><br><s=
pan>+++ b/src/openvpnserv/interactive.c</span><br><span>@@ -1150,45 +1150,3=
1 @@</span><br><span> }</span><br><span> </span><br><span> /**</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- * Run command: wmic nicconfig (In=
terfaceIndex=3D$if_index) call $action ($data)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * Run command: powershell -NoProfile -NonIntera=
ctive -Command Set-DnsClient -InterfaceIndex %ld -ConnectionSpecificSuffix =
&#39;%s&#39;</span><br><span>  * @param  if_index    &quot;index of interfa=
ce&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param  ac=
tion      e.g., &quot;SetDNSDomain&quot;</span><br><span>  * @param  data  =
      data if required for action</span><br><span>  *                     -=
 a single word for SetDNSDomain, empty or NULL to delete</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- *                     - comma separated=
 values for a list</span><br><span>  */</span><br><span> static DWORD</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-wmic_nicconfig_cmd(const wc=
har_t *action, const NET_IFINDEX if_index,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                   const wchar_t *data)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+pwsh_setdns_cmd(const NET_IFINDEX =
if_index, const wchar_t *data)</span><br><span> {</span><br><span>     DWOR=
D err =3D 0;</span><br><span>     wchar_t argv0[MAX_PATH];</span><br><span>=
     wchar_t *cmdline =3D NULL;</span><br><span>     int timeout =3D 10000;=
 /* in msec */</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    openvpn_swprintf(argv0, _countof(argv0), L&quot;%ls\\%ls&quo=
t;, get_win_sys_path(), L&quot;wbem\\wmic.exe&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    openvpn_swprintf(argv0, _countof(argv=
0), L&quot;%ls\\%ls&quot;, get_win_sys_path(), L&quot;WindowsPowerShell\\v1=
.0\\powershell.exe&quot;);</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    const wchar_t *fmt;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    /* comma separated list must be enclosed in pa=
renthesis */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (d=
ata &amp;&amp; wcschr(data, L&#39;,&#39;))</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        fmt =3D L&quot;wmic nicconfig where (InterfaceIndex=3D%ld) cal=
l %ls (%ls)&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        fmt =3D L&quot;wmic nicconfig where (Int=
erfaceIndex=3D%ld) call %ls \&quot;%ls\&quot;&quot;;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    const wchar_t *fmt =3D L&quot;-NoProfile -NonInteract=
ive -Command Set-DnsClient -InterfaceIndex %ld -ConnectionSpecificSuffix &#=
39;%s&#39;&quot;;</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    size_t ncmdline =3D wcslen(fmt) + 20 + wcslen(action) /* =
max 20 for ifindex */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                      + (data ? wcslen(data) + 1 : 1);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    size_t ncmdline =3D wcslen(fmt) + 20=
 + /* max 20 for ifindex */ (data ? wcslen(data) + 1 : 1);</span><br><span>=
     cmdline =3D malloc(ncmdline*sizeof(wchar_t));</span><br><span>     if =
(!cmdline)</span><br><span>     {</span><br><span>         return ERROR_OUT=
OFMEMORY;</span><br><span>     }</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    openvpn_swprintf(cmdline, ncmdline, fmt, i=
f_index, action,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
                data ? data : L&quot;&quot;);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    openvpn_swprintf(cmdline, ncmdline, fmt, if_i=
ndex, data ? data : L&quot;&quot;);</span><br><span>     err =3D ExecComman=
d(argv0, cmdline, timeout);</span><br><span> </span><br><span>     free(cmd=
line);</span><br><span>@@ -1248,7 +1234,7 @@</span><br><span>         free(=
RemoveListItem(&amp;(*lists)[undo_domain], CmpWString, (void *)if_name));</=
span><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    err =3D wmic_nicconfig_cmd(L&quot;SetDNSDomain&quot;,=
 if_index, wdomain);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    err =3D pwsh_setdns_cmd(if_index, wdomain);</span><br><span> </span><b=
r><span>     /* Add to undo list if domain is non-empty */</span><br><span>=
     if (err =3D=3D 0 &amp;&amp; wdomain[0] &amp;&amp; lists)</span><br><sp=
an></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/1182?usp=3Demail">change 1182</a>. To unsubscribe, or for help =
writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">=
settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"=
><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewActio=
n"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/118=
2?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie135e070b481b88033c43b76f87=
2060fb237243c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1182 </div>
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


--6D9Wfr8Jmqo=--

