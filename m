From: "stipa (Code Review)" <gerrit@...515...>
Date: Thu, 18 Sep 2025 09:55:50 +0000
References: <gerrit.1758189345000.I7a57d7b4e84aa2b9c9e71e30520ed468b0e3c278@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <a0958c2ee10420508df8891f687b385c483009f8-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7zYjDjYuv1U="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--7zYjDjYuv1U=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1198?usp=3Demail

to review the following change.


Change subject: Validate DNS domain name before powershell invocation
......................................................................

Validate DNS domain name before powershell invocation

Starting from commit

  d383d6e ("win: replace wmic invocation with powershell")

we pass --dhcp-option DOMAIN value to a powershell command
to set DNS domain. Without validation this opens the door
to a command injection atack.

This only allows domain names with chartacters:

  [A-Za-z0-9.-_\x80-\0xff]

Change-Id: I7a57d7b4e84aa2b9c9e71e30520ed468b0e3c278
Signed-off-by: Lev Stipakov <lev@...515...>
---
A src/openvpn/domain_helper.h
M src/openvpn/tun.c
M src/openvpnserv/interactive.c
3 files changed, 59 insertions(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/98/1198/1

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
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--7zYjDjYuv1U=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>stipa would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1198?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">Validate DNS domain name before powershell invocation<br><br=
>Starting from commit<br><br>  d383d6e (&quot;win: replace wmic invocation =
with powershell&quot;)<br><br>we pass --dhcp-option DOMAIN value to a power=
shell command<br>to set DNS domain. Without validation this opens the door<=
br>to a command injection atack.<br><br>This only allows domain names with =
chartacters:<br><br>  [A-Za-z0-9.-_\x80-\0xff]<br><br>Change-Id: I7a57d7b4e=
84aa2b9c9e71e30520ed468b0e3c278<br>Signed-off-by: Lev Stipakov &lt;lev@...1696...=
15...&gt;<br>---<br>A src/openvpn/domain_helper.h<br>M src/openvpn/tun.c<br=
>M src/openvpnserv/interactive.c<br>3 files changed, 59 insertions(+), 0 de=
letions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/c=
hanges/98/1198/1</pre><pre style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;"><span>diff --git a/src/openvpn/domain_helper.h b/src/ope=
nvpn/domain_helper.h</span><br><span>new file mode 100644</span><br><span>i=
ndex 0000000..f1ecf86</span><br><span>--- /dev/null</span><br><span>+++ b/s=
rc/openvpn/domain_helper.h</span><br><span>@@ -0,0 +1,45 @@</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to securely tunnel IP =
networks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *         =
    over a single UDP port, with support for SSL/TLS-based</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *             session authenticatio=
n and key exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *             packet encryption, packet authentication, and</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *             packet compression.=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2025 Lev Stipakov =
&lt;lev@...515...&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This progra=
m is free software; you can redistribute it and/or modify</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU Gen=
eral Public License version 2</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *  as published by the Free Software Foundation.</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  This program is distributed in the hope that it =
will be useful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
but WITHOUT ANY WARRANTY; without even the implied warranty of</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS F=
OR A PARTICULAR PURPOSE.  See the</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *  GNU General Public License for more details.</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *  You should have received a copy of the GNU Ge=
neral Public License along</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  with this program; if not, write to the Free Software Foundation=
, Inc.,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  51 Frank=
lin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
tatic inline bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+is=
_allowed_domain_ascii(unsigned char c)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    return (c &gt;=3D &#39;A&#39; &amp;&amp; c &lt;=3D &#39;Z&#39;)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+           || (c &gt;=3D &=
#39;a&#39; &amp;&amp; c &lt;=3D &#39;z&#39;)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+           || (c &gt;=3D &#39;0&#39; &amp;&amp; c =
&lt;=3D &#39;9&#39;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+           || c =3D=3D &#39;.&#39; || c =3D=3D &#39;-&#39; || c =3D=3D &#3=
9;_&#39; || c &gt;=3D 0x80;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+static inline bool</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+validate_domain(const char *do=
main)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    for (const char *ch =3D doma=
in; *ch; ++ch)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!is_all=
owed_domain_ascii((unsigned char)*ch))</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            return false;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff --git a/=
src/openvpn/tun.c b/src/openvpn/tun.c</span><br><span>index 99dc490..278494=
1 100644</span><br><span>--- a/src/openvpn/tun.c</span><br><span>+++ b/src/=
openvpn/tun.c</span><br><span>@@ -46,6 +46,7 @@</span><br><span> #include &=
quot;win32.h&quot;</span><br><span> #include &quot;block_dns.h&quot;</span>=
<br><span> #include &quot;networking.h&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#include &quot;domain_helper.h&quot;</span><br><sp=
an> </span><br><span> #include &quot;memdbg.h&quot;</span><br><span> </span=
><br><span>@@ -390,6 +391,12 @@</span><br><span>         return;</span><br>=
<span>     }</span><br><span> </span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (add &amp;&amp; !validate_domain(tt-&gt;options.domain))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;Failed t=
o set DNS domain &#39;%s&#39; because it contains invalid characters&quot;,=
 tt-&gt;options.domain);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan>     struct argv argv =3D argv_new();</span><br><span>     argv_printf(=
&amp;argv,</span><br><span>                 &quot;%s%s -NoProfile -NonInter=
active -Command Set-DnsClient -InterfaceIndex %lu -ConnectionSpecificSuffix=
 &#39;%s&#39;&quot;,</span><br><span>diff --git a/src/openvpnserv/interacti=
ve.c b/src/openvpnserv/interactive.c</span><br><span>index ca58596..c12d34f=
 100644</span><br><span>--- a/src/openvpnserv/interactive.c</span><br><span=
>+++ b/src/openvpnserv/interactive.c</span><br><span>@@ -40,6 +40,7 @@</spa=
n><br><span> #include &quot;validate.h&quot;</span><br><span> #include &quo=
t;block_dns.h&quot;</span><br><span> #include &quot;ring_buffer.h&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;domain_h=
elper.h&quot;</span><br><span> </span><br><span> #define IO_TIMEOUT  2000 /=
*ms*/</span><br><span> </span><br><span>@@ -1216,6 +1217,12 @@</span><br><s=
pan> {</span><br><span>     NET_IFINDEX if_index;</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!validate_domain(do=
main))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        MsgToEventLog(MSG_F=
LAGS_ERROR, TEXT(&quot;Failed to set DNS domain &#39;%hs&#39; because it co=
ntains invalid characters&quot;), domain);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        return ERROR_INVALID_DATA;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span>     DWORD err  =3D ConvertInterfa=
ceNameToIndex(if_name, &amp;if_index);</span><br><span>     if (err !=3D ER=
ROR_SUCCESS)</span><br><span>     {</span><br><span></span><br></pre><p>To =
view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1198?usp=3Dema=
il">change 1198</a>. To unsubscribe, or for help writing mail filters, visi=
t <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div item=
scope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url=
" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1198?usp=3Demail"/><meta it=
emprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7a57d7b4e84aa2b9c9e71e30520=
ed468b0e3c278 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1198 </div>
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


--7zYjDjYuv1U=--

