From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 19 Sep 2025 07:41:07 +0000
In-Reply-To: <gerrit.1758189345000.I7a57d7b4e84aa2b9c9e71e30520ed468b0e3c278@...2715...>
References: <gerrit.1758189345000.I7a57d7b4e84aa2b9c9e71e30520ed468b0e3c278@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <83f420ab3546517261831259128728ceef93e737-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="axykxMej5nA="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[release/2.6]: Validate DNS
 domain name before powershell invocation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: stipa <lstipakov@...277...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--axykxMej5nA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/11=
98?usp=3Demail )

Change subject: Validate DNS domain name before powershell invocation
......................................................................

Validate DNS domain name before powershell invocation

Starting from commit

  d383d6e ("win: replace wmic invocation with powershell")

we pass --dhcp-option DOMAIN value to a powershell command
to set DNS domain. Without validation this opens the door
to a command injection atack.

This only allows domain names with characters:

  [A-Za-z0-9.-_\x80-\0xff]

Change-Id: I7a57d7b4e84aa2b9c9e71e30520ed468b0e3c278
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1198
Message-Id: <20250918173447.32466-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33=
071.html
Signed-off-by: Gert Doering <gert@...1296...>
---
A src/openvpn/domain_helper.h
M src/openvpn/tun.c
M src/openvpnserv/interactive.c
3 files changed, 59 insertions(+), 0 deletions(-)




diff --git a/src/openvpn/domain_helper.h b/src/openvpn/domain_helper.h
new file mode 100644
index 0000000..f1ecf86
--- /dev/null
+++ b/src/openvpn/domain_helper.h
@@ -0,0 +1,45 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2025 Lev Stipakov <lev@...515...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+static inline bool
+is_allowed_domain_ascii(unsigned char c)
+{
+    return (c >=3D 'A' && c <=3D 'Z')
+           || (c >=3D 'a' && c <=3D 'z')
+           || (c >=3D '0' && c <=3D '9')
+           || c =3D=3D '.' || c =3D=3D '-' || c =3D=3D '_' || c >=3D 0x80;
+}
+
+static inline bool
+validate_domain(const char *domain)
+{
+    for (const char *ch =3D domain; *ch; ++ch)
+    {
+        if (!is_allowed_domain_ascii((unsigned char)*ch))
+        {
+            return false;
+        }
+    }
+
+    return true;
+}
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 99dc490..2784941 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -46,6 +46,7 @@
 #include "win32.h"
 #include "block_dns.h"
 #include "networking.h"
+#include "domain_helper.h"

 #include "memdbg.h"

@@ -390,6 +391,12 @@
         return;
     }

+    if (add && !validate_domain(tt->options.domain))
+    {
+        msg(M_WARN, "Failed to set DNS domain '%s' because it contains inv=
alid characters", tt->options.domain);
+        return;
+    }
+
     struct argv argv =3D argv_new();
     argv_printf(&argv,
                 "%s%s -NoProfile -NonInteractive -Command Set-DnsClient -I=
nterfaceIndex %lu -ConnectionSpecificSuffix '%s'",
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index ca58596..c12d34f 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -40,6 +40,7 @@
 #include "validate.h"
 #include "block_dns.h"
 #include "ring_buffer.h"
+#include "domain_helper.h"

 #define IO_TIMEOUT  2000 /*ms*/

@@ -1216,6 +1217,12 @@
 {
     NET_IFINDEX if_index;

+    if (!validate_domain(domain))
+    {
+        MsgToEventLog(MSG_FLAGS_ERROR, TEXT("Failed to set DNS domain '%hs=
' because it contains invalid characters"), domain);
+        return ERROR_INVALID_DATA;
+    }
+
     DWORD err  =3D ConvertInterfaceNameToIndex(if_name, &if_index);
     if (err !=3D ERROR_SUCCESS)
     {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1198?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: I7a57d7b4e84aa2b9c9e71e30520ed468b0e3c278
Gerrit-Change-Number: 1198
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--axykxMej5nA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1198?usp=3Demail">View Change</a></p><div styl=
e=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Validate DNS domain name before powershell in=
vocation<br><br>Starting from commit<br><br>  d383d6e (&quot;win: replace w=
mic invocation with powershell&quot;)<br><br>we pass --dhcp-option DOMAIN v=
alue to a powershell command<br>to set DNS domain. Without validation this =
opens the door<br>to a command injection atack.<br><br>This only allows dom=
ain names with characters:<br><br>  [A-Za-z0-9.-_\x80-\0xff]<br><br>Change-=
Id: I7a57d7b4e84aa2b9c9e71e30520ed468b0e3c278<br>Signed-off-by: Lev Stipako=
v &lt;lev@...515...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<b=
r>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1198<br>Message-Id: &l=
t;20250918173447.32466-1-gert@...1296...&gt;<br>URL: https://www.mail-archi=
ve.com/openvpn-devel@lists.sourceforge.net/msg33071.html<br>Signed-off-by: =
Gert Doering &lt;gert@...1296...&gt;<br>---<br>A src/openvpn/domain_helper.=
h<br>M src/openvpn/tun.c<br>M src/openvpnserv/interactive.c<br>3 files chan=
ged, 59 insertions(+), 0 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/domain_helper.h b/src/openvpn/domain_helper.h</=
span><br><span>new file mode 100644</span><br><span>index 0000000..f1ecf86<=
/span><br><span>--- /dev/null</span><br><span>+++ b/src/openvpn/domain_help=
er.h</span><br><span>@@ -0,0 +1,45 @@</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *  OpenVPN -- An application to securely tunnel IP networks</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *             over a single UDP =
port, with support for SSL/TLS-based</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *             session authentication and key exchange,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet =
encryption, packet authentication, and</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *             packet compression.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  Copyright (C) 2025 Lev Stipakov &lt;lev@...515...&gt;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *  This program is free software; yo=
u can redistribute it and/or modify</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *  it under the terms of the GNU General Public License ve=
rsion 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as publi=
shed by the Free Software Foundation.</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *  This program is distributed in the hope that it will be useful,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRAN=
TY; without even the implied warranty of</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOS=
E.  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU =
General Public License for more details.</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *  You should have received a copy of the GNU General Public License a=
long</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this p=
rogram; if not, write to the Free Software Foundation, Inc.,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *  51 Franklin Street, Fifth Floo=
r, Boston, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+static inline bool</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+is_allowed_domain_ascii(un=
signed char c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    return (c &gt;=3D &=
#39;A&#39; &amp;&amp; c &lt;=3D &#39;Z&#39;)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+           || (c &gt;=3D &#39;a&#39; &amp;&amp; c =
&lt;=3D &#39;z&#39;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+           || (c &gt;=3D &#39;0&#39; &amp;&amp; c &lt;=3D &#39;9&#39;)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+           || c =3D=3D =
&#39;.&#39; || c =3D=3D &#39;-&#39; || c =3D=3D &#39;_&#39; || c &gt;=3D 0x=
80;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+static inline bool</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+validate_domain(const char *domain)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    for (const char *ch =3D domain; *ch; ++ch)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (!is_allowed_domain_ascii((uns=
igned char)*ch))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            r=
eturn false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    return true;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+}</span><br><span>diff --git a/src/openvpn/tun.c b/sr=
c/openvpn/tun.c</span><br><span>index 99dc490..2784941 100644</span><br><sp=
an>--- a/src/openvpn/tun.c</span><br><span>+++ b/src/openvpn/tun.c</span><b=
r><span>@@ -46,6 +46,7 @@</span><br><span> #include &quot;win32.h&quot;</sp=
an><br><span> #include &quot;block_dns.h&quot;</span><br><span> #include &q=
uot;networking.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#include &quot;domain_helper.h&quot;</span><br><span> </span><br><span> =
#include &quot;memdbg.h&quot;</span><br><span> </span><br><span>@@ -390,6 +=
391,12 @@</span><br><span>         return;</span><br><span>     }</span><br=
><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (add=
 &amp;&amp; !validate_domain(tt-&gt;options.domain))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        msg(M_WARN, &quot;Failed to set DNS domain &#39=
;%s&#39; because it contains invalid characters&quot;, tt-&gt;options.domai=
n);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     struct argv =
argv =3D argv_new();</span><br><span>     argv_printf(&amp;argv,</span><br>=
<span>                 &quot;%s%s -NoProfile -NonInteractive -Command Set-D=
nsClient -InterfaceIndex %lu -ConnectionSpecificSuffix &#39;%s&#39;&quot;,<=
/span><br><span>diff --git a/src/openvpnserv/interactive.c b/src/openvpnser=
v/interactive.c</span><br><span>index ca58596..c12d34f 100644</span><br><sp=
an>--- a/src/openvpnserv/interactive.c</span><br><span>+++ b/src/openvpnser=
v/interactive.c</span><br><span>@@ -40,6 +40,7 @@</span><br><span> #include=
 &quot;validate.h&quot;</span><br><span> #include &quot;block_dns.h&quot;</=
span><br><span> #include &quot;ring_buffer.h&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#include &quot;domain_helper.h&quot;</span><=
br><span> </span><br><span> #define IO_TIMEOUT  2000 /*ms*/</span><br><span=
> </span><br><span>@@ -1216,6 +1217,12 @@</span><br><span> {</span><br><spa=
n>     NET_IFINDEX if_index;</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (!validate_domain(domain))</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        MsgToEventLog(MSG_FLAGS_ERROR, TEXT(&quo=
t;Failed to set DNS domain &#39;%hs&#39; because it contains invalid charac=
ters&quot;), domain);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        return ERROR_INVALID_DATA;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span>     DWORD err  =3D ConvertInterfaceNameToIndex(if_name=
, &amp;if_index);</span><br><span>     if (err !=3D ERROR_SUCCESS)</span><b=
r><span>     {</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1198?usp=3Demail">change 1198</a>=
. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:/=
/gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"h=
ttp://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1198?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7a57d7b4e84aa2b9c9e71e30520=
ed468b0e3c278 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1198 </div>
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
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--axykxMej5nA=--

