From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 4 Mar 2024 14:54:35 +0000
References: <gerrit.1709564073000.Icfc179490d6821e22d14817941fb0bad667c713f@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <1af6c91fafd75497cc417e91903d7eb164c00bbe-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="rsWE+5BJKxQ="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Avoid SIGUR1 to
 SIGHUP when the configuration is read from stdin
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--rsWE+5BJKxQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/533?usp=3Demail

to review the following change.


Change subject: Avoid SIGUR1 to SIGHUP when the configuration is read from =
stdin
......................................................................

Avoid SIGUR1 to SIGHUP when the configuration is read from stdin

If the configuration is read from stdin, we cannot reread the configuration
as stdin provides the configuration only once. So whenever we hit the
"close_context usr1 to hup" logic, the OpenVPN process will fail as tries
to restart with an empty configuration.

Change-Id: Icfc179490d6821e22d14817941fb0bad667c713f
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/openvpn.c
1 file changed, 5 insertions(+), 3 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/33/533/1

diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
index 874facf..4d1437d 100644
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
+     * reading the config from stdin will not work */
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
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--rsWE+5BJKxQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/533?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Avoid SIGUR1 to SIGHUP when the configuration is read from st=
din<br><br>If the configuration is read from stdin, we cannot reread the co=
nfiguration<br>as stdin provides the configuration only once. So whenever w=
e hit the<br>&quot;close_context usr1 to hup&quot; logic, the OpenVPN proce=
ss will fail as tries<br>to restart with an empty configuration.<br><br>Cha=
nge-Id: Icfc179490d6821e22d14817941fb0bad667c713f<br>Signed-off-by: Arne Sc=
hwabe &lt;arne@...1227...&gt;<br>---<br>M src/openvpn/openvpn.c<br>1 file c=
hanged, 5 insertions(+), 3 deletions(-)<br><br></pre><pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.ope=
nvpn.net:29418/openvpn refs/changes/33/533/1</pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openv=
pn/openvpn.c b/src/openvpn/openvpn.c</span><br><span>index 874facf..4d1437d=
 100644</span><br><span>--- a/src/openvpn/openvpn.c</span><br><span>+++ b/s=
rc/openvpn/openvpn.c</span><br><span>@@ -32,6 +32,7 @@</span><br><span> #in=
clude &quot;multi.h&quot;</span><br><span> #include &quot;win32.h&quot;</sp=
an><br><span> #include &quot;platform.h&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#include &quot;string.h&quot;</span><br><span> </=
span><br><span> #include &quot;memdbg.h&quot;</span><br><span> </span><br><=
span>@@ -60,9 +61,10 @@</span><br><span> </span><br><span>     /* set point=
-to-point mode */</span><br><span>     c-&gt;mode =3D CM_P2P;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    /* initialize tunnel instance */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    init_instance_handle_signals(c, c-&gt=
;es, CC_HARD_USR1_TO_HUP);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    /* initialize tunnel instance, avoid SIGHUP when config is stdin=
 since</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * readin=
g the config from stdin will not work */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    bool stdin_config =3D c-&gt;options.config &amp;&a=
mp; (strcmp(c-&gt;options.config, &quot;stdin&quot;) =3D=3D 0);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    init_instance_handle_signal=
s(c, c-&gt;es, stdin_config ? 0 : CC_HARD_USR1_TO_HUP);</span><br><span>   =
  if (IS_SIG(c))</span><br><span>     {</span><br><span>         return;</s=
pan><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/533?usp=3Demail">change 533</a>. To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/s=
ettings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Emai=
lMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/=
ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/533?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Icfc179490d6821e22d14817941f=
b0bad667c713f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 533 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--rsWE+5BJKxQ=--

