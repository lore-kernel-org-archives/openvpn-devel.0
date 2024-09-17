From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 17 Sep 2024 11:00:41 +0000
In-Reply-To: <gerrit.1709564073000.Icfc179490d6821e22d14817941fb0bad667c713f@...2715...>
References: <gerrit.1709564073000.Icfc179490d6821e22d14817941fb0bad667c713f@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <1f6f7177756d3cf388eedc3ccf0c524d5ae7a88a-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LwzQZy9aU1o="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--LwzQZy9aU1o=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/533?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/33/533/4

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
Gerrit-MessageType: newpatchset

--LwzQZy9aU1o=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #4</strong> to the change originally cr=
eated by plaisthos.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
533?usp=3Demail">View Change</a></p><p>The following approvals got outdated=
 and were removed:
Code-Review+2 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Avoid SIGUSR1 to SIGHUP remapping when the co=
nfiguration is read from stdin<br><br>If the configuration is read from std=
in, we cannot reread the configuration<br>as stdin provides the configurati=
on only once. So whenever we hit the<br>&quot;close_context usr1 to hup&quo=
t; logic, the OpenVPN process will fail as tries<br>to restart with an empt=
y configuration.<br><br>While OpenVPN tries to block  USR1 from normal unix=
 signal, I have observed<br>cases in my app which sends USR1 from managemen=
t interface where the<br>CC_HARD_USR1_TO_HUP logic is trigger and breaking =
the OpenVPN process.<br><br>Change-Id: Icfc179490d6821e22d14817941fb0bad667=
c713f<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>Acked-by: F=
rank Lichtenheld &lt;frank@...2641...&gt;<br>Message-Id: &lt;20240719131016=
.75042-1-frank@...2641...&gt;<br>URL: https://www.mail-archive.com/openvpn-=
devel@lists.sourceforge.net/msg28941.html<br>Signed-off-by: Gert Doering &l=
t;gert@...1296...&gt;<br>---<br>M src/openvpn/openvpn.c<br>1 file changed, =
5 insertions(+), 3 deletions(-)<br><br></pre><pre style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net=
:29418/openvpn refs/changes/33/533/4</pre><pre style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/openv=
pn.c b/src/openvpn/openvpn.c</span><br><span>index 0e85ebc..16147b7 100644<=
/span><br><span>--- a/src/openvpn/openvpn.c</span><br><span>+++ b/src/openv=
pn/openvpn.c</span><br><span>@@ -32,6 +32,7 @@</span><br><span> #include &q=
uot;multi.h&quot;</span><br><span> #include &quot;win32.h&quot;</span><br><=
span> #include &quot;platform.h&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#include &quot;string.h&quot;</span><br><span> </span><br=
><span> #include &quot;memdbg.h&quot;</span><br><span> </span><br><span>@@ =
-60,9 +61,10 @@</span><br><span> </span><br><span>     /* set point-to-poin=
t mode */</span><br><span>     c-&gt;mode =3D CM_P2P;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    /* initialize tunnel instance */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    init_instance_handle_signals(c, c-&gt;es, CC_=
HARD_USR1_TO_HUP);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   /* initialize tunnel instance, avoid SIGHUP when config is stdin since</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * re-reading the=
 config from stdin will not work */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    bool stdin_config =3D c-&gt;options.config &amp;&amp; (=
strcmp(c-&gt;options.config, &quot;stdin&quot;) =3D=3D 0);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    init_instance_handle_signals(c, =
c-&gt;es, stdin_config ? 0 : CC_HARD_USR1_TO_HUP);</span><br><span>     if =
(IS_SIG(c))</span><br><span>     {</span><br><span>         return;</span><=
br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/533?usp=3Demail">change 533</a>. To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settin=
gs">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/533?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div><=
/div>

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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--LwzQZy9aU1o=--

