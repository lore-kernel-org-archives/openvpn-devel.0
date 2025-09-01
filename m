From: "ralf_lici (Code Review)" <gerrit@...515...>
Date: Mon, 1 Sep 2025 19:21:53 +0000
In-Reply-To: <gerrit.1753449319000.Ic0035d52e0ea123398318870d2f4d21af927a602@...2715...>
References: <gerrit.1753449319000.Ic0035d52e0ea123398318870d2f4d21af927a602@...2715...>
Reply-To: ralf@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <dd1b2e7035ff175b82cdc9432bf2759708ab8819-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9CxX8BUzgjg="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: management: resync
 timer on bytecount interval change
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, stipa <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--9CxX8BUzgjg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici, stipa.

Hello flichtenheld, plaisthos, stipa,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1113?usp=3Demail

to look at the new patch set (#3).

The following approvals got outdated and were removed:
Code-Review+2 by stipa

The change is no longer submittable: Code-Review and checks~ChecksSubmitRul=
e are unsatisfied now.


Change subject: management: resync timer on bytecount interval change
......................................................................

management: resync timer on bytecount interval change

coarse_timer_wakeup tracks when the next timer-driven task will occur.
If a user issues `bytecount n` via the management interface, but the
next scheduled wakeup is more than n seconds away, bandwidth logging
will be delayed until that timer fires.

To ensure timely logging, reset the timer whenever a new `bytecount`
command is received. This guarantees that logging begins exactly n
seconds after the command, matching the user-defined interval.

Change-Id: Ic0035d52e0ea123398318870d2f4d21af927a602
Signed-off-by: Ralf Lici <ralf@...2726...>
---
M src/openvpn/manage.c
1 file changed, 23 insertions(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/13/1113/3

diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index aed04f5..53a3e4e 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -41,6 +41,7 @@
 #include "manage.h"
 #include "openvpn.h"
 #include "dco.h"
+#include "multi.h"

 #include "memdbg.h"

@@ -513,6 +514,28 @@
         man->connection.bytecount_update_seconds =3D 0;
         event_timeout_clear(&man->connection.bytecount_update_interval);
     }
+
+    /* The newly received bytecount interval may be sooner than the existi=
ng
+     * coarse timer wakeup. Reset the timer to ensure it fires at the corr=
ect,
+     * earlier time.
+     */
+    if (man->persist.callback.arg)
+    {
+        struct context *c;
+
+        if (man->settings.flags & MF_SERVER)
+        {
+            struct multi_context *m =3D man->persist.callback.arg;
+            c =3D &m->top;
+        }
+        else
+        {
+            c =3D man->persist.callback.arg;
+        }
+
+        reset_coarse_timers(c);
+    }
+
     msg(M_CLIENT, "SUCCESS: bytecount interval changed");
 }


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1113?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic0035d52e0ea123398318870d2f4d21af927a602
Gerrit-Change-Number: 1113
Gerrit-PatchSet: 3
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: ralf_lici <ralf@...2726...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-MessageType: newpatchset

--9CxX8BUzgjg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos, ralf_lici, stipa. </p>
<p>ralf_lici <strong>uploaded patch set #3</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1113?usp=3Demail">View Chan=
ge</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by stipa</p><p>The change is no longer submittable: Code-Revi=
ew and checks~ChecksSubmitRule are unsatisfied now.</p><pre style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;">management: resync time=
r on bytecount interval change<br><br>coarse_timer_wakeup tracks when the n=
ext timer-driven task will occur.<br>If a user issues `bytecount n` via the=
 management interface, but the<br>next scheduled wakeup is more than n seco=
nds away, bandwidth logging<br>will be delayed until that timer fires.<br><=
br>To ensure timely logging, reset the timer whenever a new `bytecount`<br>=
command is received. This guarantees that logging begins exactly n<br>secon=
ds after the command, matching the user-defined interval.<br><br>Change-Id:=
 Ic0035d52e0ea123398318870d2f4d21af927a602<br>Signed-off-by: Ralf Lici &lt;=
ralf@...2726...&gt;<br>---<br>M src/openvpn/manage.c<br>1 file changed, 23 =
insertions(+), 0 deletions(-)<br><br></pre><pre style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:2=
9418/openvpn refs/changes/13/1113/3</pre><pre style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/manage=
.c b/src/openvpn/manage.c</span><br><span>index aed04f5..53a3e4e 100644</sp=
an><br><span>--- a/src/openvpn/manage.c</span><br><span>+++ b/src/openvpn/m=
anage.c</span><br><span>@@ -41,6 +41,7 @@</span><br><span> #include &quot;m=
anage.h&quot;</span><br><span> #include &quot;openvpn.h&quot;</span><br><sp=
an> #include &quot;dco.h&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#include &quot;multi.h&quot;</span><br><span> </span><br><span> =
#include &quot;memdbg.h&quot;</span><br><span> </span><br><span>@@ -513,6 +=
514,28 @@</span><br><span>         man-&gt;connection.bytecount_update_seco=
nds =3D 0;</span><br><span>         event_timeout_clear(&amp;man-&gt;connec=
tion.bytecount_update_interval);</span><br><span>     }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    /* The newly received bytecount interval may be sooner=
 than the existing</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
    * coarse timer wakeup. Reset the timer to ensure it fires at the correc=
t,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * earlier ti=
me.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (man-&gt;persist.call=
back.arg)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct context *=
c;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        if (man-&gt;settings.flags &=
amp; MF_SERVER)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            st=
ruct multi_context *m =3D man-&gt;persist.callback.arg;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            c =3D &amp;m-&gt;top;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            c =3D man-&gt;persist.callback.arg;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        reset_coarse_timers(c);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span>     msg(M_CLIENT, &quot;SUCCESS: byt=
ecount interval changed&quot;);</span><br><span> }</span><br><span> </span>=
<br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/1113?usp=3Demail">change 1113</a>. To unsubscribe, or fo=
r help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/set=
tings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailM=
essage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vi=
ewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/1113?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></d=
iv></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic0035d52e0ea123398318870d2f=
4d21af927a602 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1113 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@...2726...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ralf@...2804...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--9CxX8BUzgjg=--

