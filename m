From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 2 Sep 2025 16:11:53 +0000
In-Reply-To: <gerrit.1753449319000.Ic0035d52e0ea123398318870d2f4d21af927a602@...2715...>
References: <gerrit.1753449319000.Ic0035d52e0ea123398318870d2f4d21af927a602@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, ralf@...2726..., frank@...2641...,
 lstipakov@...277...
Message-ID: <9176195c7878be8b3b541806cb6dbf535bb9a974-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="pnI0gPsoIgw="; charset=UTF-8
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
To: ralf_lici <ralf@...2726...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, stipa <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--pnI0gPsoIgw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#6) to the change originally created by=
 ralf_lici. ( http://gerrit.openvpn.net/c/openvpn/+/1113?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


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
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250902160050.18640-1-gert@...1296...>
URL: https://sourceforge.net/p/openvpn/mailman/message/59228306/
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/manage.c
1 file changed, 22 insertions(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/13/1113/6

diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 52b0e5e..422aa0b 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -514,6 +514,28 @@
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
Gerrit-PatchSet: 6
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--pnI0gPsoIgw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #6</strong> to the change originally cr=
eated by ralf_lici.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
1113?usp=3Demail">View Change</a></p><p>The following approvals got outdate=
d and were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">management: resync timer on bytecount interval chang=
e<br><br>coarse_timer_wakeup tracks when the next timer-driven task will oc=
cur.<br>If a user issues `bytecount n` via the management interface, but th=
e<br>next scheduled wakeup is more than n seconds away, bandwidth logging<b=
r>will be delayed until that timer fires.<br><br>To ensure timely logging, =
reset the timer whenever a new `bytecount`<br>command is received. This gua=
rantees that logging begins exactly n<br>seconds after the command, matchin=
g the user-defined interval.<br><br>Change-Id: Ic0035d52e0ea123398318870d2f=
4d21af927a602<br>Signed-off-by: Ralf Lici &lt;ralf@...2726...&gt;<br>Acked-=
by: Gert Doering &lt;gert@...1296...&gt;<br>Message-Id: &lt;20250902160050.=
18640-1-gert@...1296...&gt;<br>URL: https://sourceforge.net/p/openvpn/mailm=
an/message/59228306/<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;=
<br>---<br>M src/openvpn/manage.c<br>1 file changed, 22 insertions(+), 0 de=
letions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/c=
hanges/13/1113/6</pre><pre style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;"><span>diff --git a/src/openvpn/manage.c b/src/openvpn/ma=
nage.c</span><br><span>index 52b0e5e..422aa0b 100644</span><br><span>--- a/=
src/openvpn/manage.c</span><br><span>+++ b/src/openvpn/manage.c</span><br><=
span>@@ -514,6 +514,28 @@</span><br><span>         man-&gt;connection.bytec=
ount_update_seconds =3D 0;</span><br><span>         event_timeout_clear(&am=
p;man-&gt;connection.bytecount_update_interval);</span><br><span>     }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* The newly received bytecount inter=
val may be sooner than the existing</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+     * coarse timer wakeup. Reset the timer to ensure it fi=
res at the correct,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
     * earlier time.</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+     */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (man=
-&gt;persist.callback.arg)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 struct context *c;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (man-&gt=
;settings.flags &amp; MF_SERVER)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            struct multi_context *m =3D man-&gt;persist.callback.arg;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            c =3D &amp=
;m-&gt;top;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            c =3D man-&gt;persist.c=
allback.arg;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        reset_coarse_timers(c);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     msg(M_CLIENT, &q=
uot;SUCCESS: bytecount interval changed&quot;);</span><br><span> }</span><b=
r><span> </span><br><span></span><br></pre><p>To view, visit <a href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/1113?usp=3Demail">change 1113</a>. To un=
subscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://s=
chema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/1113?usp=3Demail"/><meta itemprop=3D"name" content=3D"V=
iew Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic0035d52e0ea123398318870d2f=
4d21af927a602 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1113 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@...2726...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--pnI0gPsoIgw=--

