From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 15 Sep 2025 20:28:06 +0000
In-Reply-To: <gerrit.1757941198000.Ibb126e9ca4548aeb8b60df226e37c9b414698247@...2715...>
References: <gerrit.1757941198000.Ibb126e9ca4548aeb8b60df226e37c9b414698247@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <a28dbcdc5746a78e2777367e7f72d025df93a93e-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="shODO1h7Ks8="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: win: replace wmic
 invocation with powershell
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

--shODO1h7Ks8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 stipa. ( http://gerrit.openvpn.net/c/openvpn/+/1187?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: win: replace wmic invocation with powershell
......................................................................

win: replace wmic invocation with powershell

Since wmic has been recently deprecated and is absent on new
systems, replace setting DNS domain "old-style" with powershell.

This is based on 2.6 patch which replaces wmic with powershell

    d383d6e "win: replace wmic invocation with powershell"

except that here we only touch openvpn process code. There is no
wmic calls in 2.7 service.

Github: fixes OpenVPN/openvpn#642

Change-Id: Ibb126e9ca4548aeb8b60df226e37c9b414698247
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1187
Message-Id: <20250915130344.2906-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
951.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/tun.c
M src/openvpn/win32.h
2 files changed, 12 insertions(+), 9 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/87/1187/2

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 29f74a2..ee0733a 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -405,7 +405,7 @@
 }

 static void
-do_dns_domain_wmic(bool add, const struct tuntap *tt)
+do_dns_domain_pwsh(bool add, const struct tuntap *tt)
 {
     if (!tt->options.domain)
     {
@@ -413,10 +413,13 @@
     }

     struct argv argv =3D argv_new();
-    argv_printf(&argv, "%s%s nicconfig where (InterfaceIndex=3D%ld) call S=
etDNSDomain '%s'",
-                get_win_sys_path(), WMIC_PATH_SUFFIX, tt->adapter_index,
+    argv_printf(&argv,
+                "%s%s -NoProfile -NonInteractive -Command Set-DnsClient -I=
nterfaceIndex %lu -ConnectionSpecificSuffix '%s'",
+                get_win_sys_path(),
+                POWERSHELL_PATH_SUFFIX,
+                tt->adapter_index,
                 add ? tt->options.domain : "");
-    exec_command("WMIC", &argv, 1, M_WARN);
+    exec_command("PowerShell", &argv, 1, M_WARN);

     argv_free(&argv);
 }
@@ -1208,7 +1211,7 @@

         if (!tt->did_ifconfig_setup)
         {
-            do_dns_domain_wmic(true, tt);
+            do_dns_domain_pwsh(true, tt);
         }
     }
 #else  /* platforms we have no IPv6 code for */
@@ -1527,7 +1530,7 @@
                            NI_IP_NETMASK | NI_OPTIONS);
         }

-        do_dns_domain_wmic(true, tt);
+        do_dns_domain_pwsh(true, tt);
     }


@@ -6547,7 +6550,7 @@
         {
             if (!tt->did_ifconfig_setup)
             {
-                do_dns_domain_wmic(false, tt);
+                do_dns_domain_pwsh(false, tt);
             }

             netsh_delete_address_dns(tt, true, &gc);
@@ -6574,7 +6577,7 @@
         }
         else
         {
-            do_dns_domain_wmic(false, tt);
+            do_dns_domain_pwsh(false, tt);

             if (tt->options.ip_win32_type =3D=3D IPW32_SET_NETSH)
             {
diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h
index dbfa5bc..ff3145a 100644
--- a/src/openvpn/win32.h
+++ b/src/openvpn/win32.h
@@ -40,7 +40,7 @@
 #define WIN_ROUTE_PATH_SUFFIX    "\\system32\\route.exe"
 #define WIN_IPCONFIG_PATH_SUFFIX "\\system32\\ipconfig.exe"
 #define WIN_NET_PATH_SUFFIX      "\\system32\\net.exe"
-#define WMIC_PATH_SUFFIX         "\\system32\\wbem\\wmic.exe"
+#define POWERSHELL_PATH_SUFFIX   "\\system32\\WindowsPowerShell\\v1.0\\pow=
ershell.exe"

 /*
  * Win32-specific OpenVPN code, targeted at the mingw

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1187?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ibb126e9ca4548aeb8b60df226e37c9b414698247
Gerrit-Change-Number: 1187
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--shODO1h7Ks8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by stipa.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1187=
?usp=3Demail">View Change</a></p><p>The following approvals got outdated an=
d were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">win: replace wmic invocation with powershell<br><br>=
Since wmic has been recently deprecated and is absent on new<br>systems, re=
place setting DNS domain &quot;old-style&quot; with powershell.<br><br>This=
 is based on 2.6 patch which replaces wmic with powershell<br><br>    d383d=
6e &quot;win: replace wmic invocation with powershell&quot;<br><br>except t=
hat here we only touch openvpn process code. There is no<br>wmic calls in 2=
.7 service.<br><br>Github: fixes OpenVPN/openvpn#642<br><br>Change-Id: Ibb1=
26e9ca4548aeb8b60df226e37c9b414698247<br>Signed-off-by: Lev Stipakov &lt;le=
v@...515...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit=
 URL: https://gerrit.openvpn.net/c/openvpn/+/1187<br>Message-Id: &lt;202509=
15130344.2906-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/op=
envpn-devel@lists.sourceforge.net/msg32951.html<br>Signed-off-by: Gert Doer=
ing &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/tun.c<br>M src/openvpn/=
win32.h<br>2 files changed, 12 insertions(+), 9 deletions(-)<br><br></pre><=
pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git =
pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/87/1187/2</pre><pr=
e style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>=
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c</span><br><span>index 29=
f74a2..ee0733a 100644</span><br><span>--- a/src/openvpn/tun.c</span><br><sp=
an>+++ b/src/openvpn/tun.c</span><br><span>@@ -405,7 +405,7 @@</span><br><s=
pan> }</span><br><span> </span><br><span> static void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-do_dns_domain_wmic(bool add, const struct t=
untap *tt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+do_dns_do=
main_pwsh(bool add, const struct tuntap *tt)</span><br><span> {</span><br><=
span>     if (!tt-&gt;options.domain)</span><br><span>     {</span><br><spa=
n>@@ -413,10 +413,13 @@</span><br><span>     }</span><br><span> </span><br>=
<span>     struct argv argv =3D argv_new();</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    argv_printf(&amp;argv, &quot;%s%s nicconfig where=
 (InterfaceIndex=3D%ld) call SetDNSDomain &#39;%s&#39;&quot;,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                get_win_sys_path(),=
 WMIC_PATH_SUFFIX, tt-&gt;adapter_index,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    argv_printf(&amp;argv,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                &quot;%s%s -NoProfile -NonInter=
active -Command Set-DnsClient -InterfaceIndex %lu -ConnectionSpecificSuffix=
 &#39;%s&#39;&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                get_win_sys_path(),</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                POWERSHELL_PATH_SUFFIX,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                tt-&gt;adapter_index,<=
/span><br><span>                 add ? tt-&gt;options.domain : &quot;&quot;=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    exec_command(&q=
uot;WMIC&quot;, &amp;argv, 1, M_WARN);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    exec_command(&quot;PowerShell&quot;, &amp;argv, 1, M=
_WARN);</span><br><span> </span><br><span>     argv_free(&amp;argv);</span>=
<br><span> }</span><br><span>@@ -1208,7 +1211,7 @@</span><br><span> </span>=
<br><span>         if (!tt-&gt;did_ifconfig_setup)</span><br><span>        =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            do_dns_=
domain_wmic(true, tt);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            do_dns_domain_pwsh(true, tt);</span><br><span>         }</sp=
an><br><span>     }</span><br><span> #else  /* platforms we have no IPv6 co=
de for */</span><br><span>@@ -1527,7 +1530,7 @@</span><br><span>           =
                 NI_IP_NETMASK | NI_OPTIONS);</span><br><span>         }</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  do_dns_domain_wmic(true, tt);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        do_dns_domain_pwsh(true, tt);</span><br><span>     }</s=
pan><br><span> </span><br><span> </span><br><span>@@ -6547,7 +6550,7 @@</sp=
an><br><span>         {</span><br><span>             if (!tt-&gt;did_ifconf=
ig_setup)</span><br><span>             {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                do_dns_domain_wmic(false, tt);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                do_dns_domain=
_pwsh(false, tt);</span><br><span>             }</span><br><span> </span><b=
r><span>             netsh_delete_address_dns(tt, true, &amp;gc);</span><br=
><span>@@ -6574,7 +6577,7 @@</span><br><span>         }</span><br><span>   =
      else</span><br><span>         {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            do_dns_domain_wmic(false, tt);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            do_dns_domain_pwsh(false=
, tt);</span><br><span> </span><br><span>             if (tt-&gt;options.ip=
_win32_type =3D=3D IPW32_SET_NETSH)</span><br><span>             {</span><b=
r><span>diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h</span><br><s=
pan>index dbfa5bc..ff3145a 100644</span><br><span>--- a/src/openvpn/win32.h=
</span><br><span>+++ b/src/openvpn/win32.h</span><br><span>@@ -40,7 +40,7 @=
@</span><br><span> #define WIN_ROUTE_PATH_SUFFIX    &quot;\\system32\\route=
.exe&quot;</span><br><span> #define WIN_IPCONFIG_PATH_SUFFIX &quot;\\system=
32\\ipconfig.exe&quot;</span><br><span> #define WIN_NET_PATH_SUFFIX      &q=
uot;\\system32\\net.exe&quot;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#define WMIC_PATH_SUFFIX         &quot;\\system32\\wbem\\wmic.exe&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define POWERSH=
ELL_PATH_SUFFIX   &quot;\\system32\\WindowsPowerShell\\v1.0\\powershell.exe=
&quot;</span><br><span> </span><br><span> /*</span><br><span>  * Win32-spec=
ific OpenVPN code, targeted at the mingw</span><br><span></span><br></pre><=
p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1187?usp=
=3Demail">change 1187</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><di=
v itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1187?usp=3Demail"/><met=
a itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ibb126e9ca4548aeb8b60df226e3=
7c9b414698247 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1187 </div>
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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--shODO1h7Ks8=--

