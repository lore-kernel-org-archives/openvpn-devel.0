From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 17 Sep 2024 11:00:43 +0000
In-Reply-To: <gerrit.1709564073000.Icfc179490d6821e22d14817941fb0bad667c713f@...2715...>
References: <gerrit.1709564073000.Icfc179490d6821e22d14817941fb0bad667c713f@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <1f6f7177756d3cf388eedc3ccf0c524d5ae7a88a-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6huD4XhXMe0="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Avoid SIGUSR1 to
 SIGHUP remapping when the configuration is read from...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--6huD4XhXMe0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/53=
3?usp=3Demail )

Change subject: Avoid SIGUSR1 to SIGHUP remapping when the configuration is=
 read from stdin
......................................................................

Avoid SIGUSR1 to SIGHUP remapping when the configuration is read from stdin

If the configuration is read from stdin, we cannot reread the configuration
as stdin provides the configuration only once. So whenever we hit the
"close_context usr1 to hup" logic, the OpenVPN process will fail as tries
to restart with an empty configuration.

While OpenVPN tries to block  USR1 from normal unix signal, I have observed
cases in my app which sends USR1 from management interface where the
CC_HARD_USR1_TO_HUP logic is trigger and breaking the OpenVPN process.

Change-Id: Icfc179490d6821e22d14817941fb0bad667c713f
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20240719131016.75042-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28=
941.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/openvpn.c
1 file changed, 5 insertions(+), 3 deletions(-)




diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
index 0e85ebc..16147b7 100644
--- a/src/openvpn/openvpn.c
+++ b/src/openvpn/openvpn.c
@@ -32,6 +32,7 @@
 #include "multi.h"
 #include "win32.h"
 #include "platform.h"
+#include "string.h"

 #include "memdbg.h"

@@ -60,9 +61,10 @@

     /* set point-to-point mode */
     c->mode =3D CM_P2P;
-
-    /* initialize tunnel instance */
-    init_instance_handle_signals(c, c->es, CC_HARD_USR1_TO_HUP);
+    /* initialize tunnel instance, avoid SIGHUP when config is stdin since
+     * re-reading the config from stdin will not work */
+    bool stdin_config =3D c->options.config && (strcmp(c->options.config, =
"stdin") =3D=3D 0);
+    init_instance_handle_signals(c, c->es, stdin_config ? 0 : CC_HARD_USR1=
_TO_HUP);
     if (IS_SIG(c))
     {
         return;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/533?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Icfc179490d6821e22d14817941fb0bad667c713f
Gerrit-Change-Number: 533
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--6huD4XhXMe0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/533?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Avoid SIGUSR1 to SIGHUP remapping when the con=
figuration is read from stdin<br><br>If the configuration is read from stdi=
n, we cannot reread the configuration<br>as stdin provides the configuratio=
n only once. So whenever we hit the<br>&quot;close_context usr1 to hup&quot=
; logic, the OpenVPN process will fail as tries<br>to restart with an empty=
 configuration.<br><br>While OpenVPN tries to block  USR1 from normal unix =
signal, I have observed<br>cases in my app which sends USR1 from management=
 interface where the<br>CC_HARD_USR1_TO_HUP logic is trigger and breaking t=
he OpenVPN process.<br><br>Change-Id: Icfc179490d6821e22d14817941fb0bad667c=
713f<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>Acked-by: Fr=
ank Lichtenheld &lt;frank@...2641...&gt;<br>Message-Id: &lt;20240719131016.=
75042-1-frank@...2641...&gt;<br>URL: https://www.mail-archive.com/openvpn-d=
evel@lists.sourceforge.net/msg28941.html<br>Signed-off-by: Gert Doering &lt=
;gert@...1296...&gt;<br>---<br>M src/openvpn/openvpn.c<br>1 file changed, 5=
 insertions(+), 3 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c</span><br><sp=
an>index 0e85ebc..16147b7 100644</span><br><span>--- a/src/openvpn/openvpn.=
c</span><br><span>+++ b/src/openvpn/openvpn.c</span><br><span>@@ -32,6 +32,=
7 @@</span><br><span> #include &quot;multi.h&quot;</span><br><span> #includ=
e &quot;win32.h&quot;</span><br><span> #include &quot;platform.h&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;string.h&=
quot;</span><br><span> </span><br><span> #include &quot;memdbg.h&quot;</spa=
n><br><span> </span><br><span>@@ -60,9 +61,10 @@</span><br><span> </span><b=
r><span>     /* set point-to-point mode */</span><br><span>     c-&gt;mode =
=3D CM_P2P;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    /* initialize tunnel instan=
ce */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    init_instanc=
e_handle_signals(c, c-&gt;es, CC_HARD_USR1_TO_HUP);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* initialize tunnel instance, avoid =
SIGHUP when config is stdin since</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+     * re-reading the config from stdin will not work */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool stdin_config =
=3D c-&gt;options.config &amp;&amp; (strcmp(c-&gt;options.config, &quot;std=
in&quot;) =3D=3D 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    init_instance_handle_signals(c, c-&gt;es, stdin_config ? 0 : CC_HARD_U=
SR1_TO_HUP);</span><br><span>     if (IS_SIG(c))</span><br><span>     {</sp=
an><br><span>         return;</span><br><span></span><br></pre><p>To view, =
visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/533?usp=3Demail">cha=
nge 533</a>. To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope it=
emtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action=
" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/533?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Icfc179490d6821e22d14817941f=
b0bad667c713f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 533 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--6huD4XhXMe0=--

