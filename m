From: "stipa (Code Review)" <gerrit@...515...>
Date: Wed, 10 Sep 2025 11:35:21 +0000
References: <gerrit.1757504119000.Ie135e070b481b88033c43b76f872060fb237243c@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <8f437ed33753e39fc3c8a1311f629371d195cc2c-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="MmfiFOP+j/I="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[release/2.6]: win: replace
 wmic invocation with powershell
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

--MmfiFOP+j/I=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1175?usp=3Demail

to review the following change.


Change subject: win: replace wmic invocation with powershell
......................................................................

win: replace wmic invocation with powershell

Since wmic has been recently deprecated and is absent on new
systems, replace setting DNS domain "old-style" with powershell.

GitHub: https://github.com/OpenVPN/openvpn/issues/642

Change-Id: Ie135e070b481b88033c43b76f872060fb237243c
Signed-off-by: Lev Stipakov <lev@...515...>
---
M src/openvpn/tun.c
M src/openvpn/win32.h
2 files changed, 14 insertions(+), 9 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/75/1175/1

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

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1175?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: Ie135e070b481b88033c43b76f872060fb237243c
Gerrit-Change-Number: 1175
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--MmfiFOP+j/I=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>stipa would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1175?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">win: replace wmic invocation with powershell<br><br>Since wm=
ic has been recently deprecated and is absent on new<br>systems, replace se=
tting DNS domain &quot;old-style&quot; with powershell.<br><br>GitHub: http=
s://github.com/OpenVPN/openvpn/issues/642<br><br>Change-Id: Ie135e070b481b8=
8033c43b76f872060fb237243c<br>Signed-off-by: Lev Stipakov &lt;lev@...515...=
&gt;<br>---<br>M src/openvpn/tun.c<br>M src/openvpn/win32.h<br>2 files chan=
ged, 14 insertions(+), 9 deletions(-)<br><br></pre><pre style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openv=
pn.net:29418/openvpn refs/changes/75/1175/1</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvp=
n/tun.c b/src/openvpn/tun.c</span><br><span>index 92e71a3..1ece1e1 100644</=
span><br><span>--- a/src/openvpn/tun.c</span><br><span>+++ b/src/openvpn/tu=
n.c</span><br><span>@@ -383,7 +383,7 @@</span><br><span> }</span><br><span>=
 </span><br><span> static void</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-do_dns_domain_wmic(bool add, const struct tuntap *tt)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+do_dns_domain_pwsh(bool add, con=
st struct tuntap *tt)</span><br><span> {</span><br><span>     if (!tt-&gt;o=
ptions.domain)</span><br><span>     {</span><br><span>@@ -391,9 +391,14 @@<=
/span><br><span>     }</span><br><span> </span><br><span>     struct argv a=
rgv =3D argv_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  argv_printf(&amp;argv, &quot;%s%s nicconfig where (InterfaceIndex=3D%ld) =
call SetDNSDomain &#39;%s&#39;&quot;,</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                get_win_sys_path(), WMIC_PATH_SUFFIX, tt-&g=
t;adapter_index, add ? tt-&gt;options.domain : &quot;&quot;);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    exec_command(&quot;WMIC&quot;, =
&amp;argv, 1, M_WARN);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    argv_printf(&amp;argv,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                &quot;%s%s -NoProfile -NonInteractive -Command Se=
t-DnsClient -InterfaceIndex %ld -ConnectionSpecificSuffix &#39;%s&#39;&quot=
;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                g=
et_win_sys_path(),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               POWERSHELL_PATH_SUFFIX,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                tt-&gt;adapter_index,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                add ? tt-&gt;options.d=
omain : &quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                );</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    exec_command(&quot;PowerShell&quot;, &amp;argv, 1, M_WARN);</span><br><=
span> </span><br><span>     argv_free(&amp;argv);</span><br><span> }</span>=
<br><span>@@ -1269,7 +1274,7 @@</span><br><span> </span><br><span>         =
if (!tt-&gt;did_ifconfig_setup)</span><br><span>         {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            do_dns_domain_wmic(true, t=
t);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            do_d=
ns_domain_pwsh(true, tt);</span><br><span>         }</span><br><span>     }=
</span><br><span> #else /* platforms we have no IPv6 code for */</span><br>=
<span>@@ -1625,7 +1630,7 @@</span><br><span>                            tt-=
&gt;adapter_netmask, NI_IP_NETMASK | NI_OPTIONS);</span><br><span>         =
}</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      do_dns_domain_wmic(true, tt);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        do_dns_domain_pwsh(true, tt);</span><br><span>     =
}</span><br><span> </span><br><span> </span><br><span>@@ -7024,7 +7029,7 @@=
</span><br><span>         {</span><br><span>             if (!tt-&gt;did_if=
config_setup)</span><br><span>             {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                do_dns_domain_wmic(false, tt);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                do_dns_do=
main_pwsh(false, tt);</span><br><span>             }</span><br><span> </spa=
n><br><span>             netsh_delete_address_dns(tt, true, &amp;gc);</span=
><br><span>@@ -7050,7 +7055,7 @@</span><br><span>         }</span><br><span=
>         else</span><br><span>         {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            do_dns_domain_wmic(false, tt);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            do_dns_domain_pwsh(f=
alse, tt);</span><br><span> </span><br><span>             if (tt-&gt;option=
s.ip_win32_type =3D=3D IPW32_SET_NETSH)</span><br><span>             {</spa=
n><br><span>diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h</span><b=
r><span>index 1b87fa3..67e6169 100644</span><br><span>--- a/src/openvpn/win=
32.h</span><br><span>+++ b/src/openvpn/win32.h</span><br><span>@@ -38,7 +38=
,7 @@</span><br><span> #define WIN_ROUTE_PATH_SUFFIX &quot;\\system32\\rout=
e.exe&quot;</span><br><span> #define WIN_IPCONFIG_PATH_SUFFIX &quot;\\syste=
m32\\ipconfig.exe&quot;</span><br><span> #define WIN_NET_PATH_SUFFIX &quot;=
\\system32\\net.exe&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#define WMIC_PATH_SUFFIX &quot;\\system32\\wbem\\wmic.exe&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#define POWERSHELL_PATH_SUF=
FIX &quot;\\system32\\WindowsPowerShell\\v1.0\\powershell.exe&quot;</span><=
br><span> </span><br><span> /*</span><br><span>  * Win32-specific OpenVPN c=
ode, targeted at the mingw</span><br><span></span><br></pre><p>To view, vis=
it <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1175?usp=3Demail">chang=
e 1175</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/1175?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie135e070b481b88033c43b76f87=
2060fb237243c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1175 </div>
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


--MmfiFOP+j/I=--

