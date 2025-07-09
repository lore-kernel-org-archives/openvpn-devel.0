From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 9 Jul 2025 07:46:40 +0000
In-Reply-To: <gerrit.1751571694000.I7e9a0c668e0950257632452cfd9eeb236f0120f2@...2715...>
References: <gerrit.1751571694000.I7e9a0c668e0950257632452cfd9eeb236f0120f2@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <c718ea059e79e57d81d3835d4db1f9a9edb207e4-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="l0+AsYF8teo="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: dns: do not run
 updown scripts with lwipovpn
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: d12fk <heiko@...515...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--l0+AsYF8teo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/10=
77?usp=3Demail )

Change subject: dns: do not run updown scripts with lwipovpn
......................................................................

dns: do not run updown scripts with lwipovpn

Running the script doesn't make sense with the AFUNIX dev node, so we
simply clear any scripts that have been set before.

Change-Id: I7e9a0c668e0950257632452cfd9eeb236f0120f2
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Message-Id: <20250708185210.30421-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
069.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/options.c
1 file changed, 8 insertions(+), 0 deletions(-)




diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index af097f8..0662b49 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -61,6 +61,7 @@
 #include "xkey_common.h"
 #include "dco.h"
 #include "options_util.h"
+#include "tun_afunix.h"

 #include <ctype.h>

@@ -3593,6 +3594,13 @@
     struct gc_arena gc =3D gc_new();
     struct dns_options *dns =3D &o->dns_options;

+    if (is_tun_afunix(o->dev_node))
+    {
+        /* Disable running  dns-updown script with lwipovpn */
+        dns->updown_flags =3D DNS_UPDOWN_NO_FLAGS;
+        dns->updown =3D NULL;
+    }
+
     if (dns->servers || dns_updown_user_set(dns) || dns_updown_forced(dns))
     {
         /* Clean up env from --dhcp-option DNS config */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1077?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7e9a0c668e0950257632452cfd9eeb236f0120f2
Gerrit-Change-Number: 1077
Gerrit-PatchSet: 3
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--l0+AsYF8teo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1077?usp=3Demail">View Change</a></p><div styl=
e=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">dns: do not run updown scripts with lwipovpn<=
br><br>Running the script doesn&#39;t make sense with the AFUNIX dev node, =
so we<br>simply clear any scripts that have been set before.<br><br>Change-=
Id: I7e9a0c668e0950257632452cfd9eeb236f0120f2<br>Signed-off-by: Heiko Hund =
&lt;heiko@...2662...&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@...1830...=
...&gt;<br>Message-Id: &lt;20250708185210.30421-1-gert@...1296...&gt;<br>UR=
L: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg3206=
9.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M s=
rc/openvpn/options.c<br>1 file changed, 8 insertions(+), 0 deletions(-)<br>=
<br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</span><br><sp=
an>index af097f8..0662b49 100644</span><br><span>--- a/src/openvpn/options.=
c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -61,6 +61,=
7 @@</span><br><span> #include &quot;xkey_common.h&quot;</span><br><span> #=
include &quot;dco.h&quot;</span><br><span> #include &quot;options_util.h&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;t=
un_afunix.h&quot;</span><br><span> </span><br><span> #include &lt;ctype.h&g=
t;</span><br><span> </span><br><span>@@ -3593,6 +3594,13 @@</span><br><span=
>     struct gc_arena gc =3D gc_new();</span><br><span>     struct dns_opti=
ons *dns =3D &amp;o-&gt;dns_options;</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (is_tun_afunix(o-&gt;dev_node))</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        /* Disable running  dns-upd=
own script with lwipovpn */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        dns-&gt;updown_flags =3D DNS_UPDOWN_NO_FLAGS;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        dns-&gt;updown =3D NULL;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if (dns-&gt;=
servers || dns_updown_user_set(dns) || dns_updown_forced(dns))</span><br><s=
pan>     {</span><br><span>         /* Clean up env from --dhcp-option DNS =
config */</span><br><span></span><br></pre><p>To view, visit <a href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/1077?usp=3Demail">change 1077</a>. To un=
subscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://s=
chema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/1077?usp=3Demail"/><meta itemprop=3D"name" content=3D"V=
iew Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7e9a0c668e0950257632452cfd9=
eeb236f0120f2 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1077 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--l0+AsYF8teo=--

