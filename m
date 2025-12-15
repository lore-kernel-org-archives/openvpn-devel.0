From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 15 Dec 2025 15:36:01 +0000
In-Reply-To: <gerrit.1761570487000.I62b8263f18c4e2e7f5ecacb4616737f5ba836303@...2715...>
References: <gerrit.1761570487000.I62b8263f18c4e2e7f5ecacb4616737f5ba836303@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <23e294be96a2580d97c4c870bb651a7de4daef32-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ylyRJg2TSfo="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: multi: Fix wrong
 sigma value in multi_push_restart_schedule_exit
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ylyRJg2TSfo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#10) to the change originally created b=
y flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1311?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: multi: Fix wrong sigma value in multi_push_restart_schedule=
_exit
......................................................................

multi: Fix wrong sigma value in multi_push_restart_schedule_exit

Sigma was computed based on the absolute time and
not the delta.

Note that this probably makes no actual difference in
practice. The sigma value is irrelevant on first call
and multi_push_restart_schedule_exit should not be
called multiple times since it is only called
if deferred_shutdown_signal.signal_received is not set,
yet.

Change-Id: I62b8263f18c4e2e7f5ecacb4616737f5ba836303
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1311
Message-Id: <20251215150500.18898-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
075.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/multi.c
1 file changed, 2 insertions(+), 4 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/11/1311/10

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index d2d9ba8e..d9cb3a9 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3820,7 +3820,6 @@
 {
     struct hash_iterator hi;
     struct hash_element *he;
-    struct timeval tv;

     /* tell all clients to restart */
     hash_iterator_init(m->iter, &hi);
@@ -3838,15 +3837,14 @@

     /* reschedule signal */
     ASSERT(!openvpn_gettimeofday(&m->deferred_shutdown_signal.wakeup, NULL=
));
-    tv.tv_sec =3D 2;
-    tv.tv_usec =3D 0;
+    struct timeval tv =3D { .tv_sec =3D 2, .tv_usec =3D 0 };
     tv_add(&m->deferred_shutdown_signal.wakeup, &tv);

     m->deferred_shutdown_signal.signal_received =3D m->top.sig->signal_rec=
eived;

     schedule_add_entry(m->schedule, (struct schedule_entry *)&m->deferred_=
shutdown_signal,
                        &m->deferred_shutdown_signal.wakeup,
-                       compute_wakeup_sigma(&m->deferred_shutdown_signal.w=
akeup));
+                       compute_wakeup_sigma(&tv));

     signal_reset(m->top.sig, 0);
 }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1311?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I62b8263f18c4e2e7f5ecacb4616737f5ba836303
Gerrit-Change-Number: 1311
Gerrit-PatchSet: 10
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ylyRJg2TSfo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #10</strong> to the change originally created by flichtenhe=
ld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1311?usp=3Demail=
">View Change</a></p><p>The following approvals got outdated and were remov=
ed:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">multi: Fix wrong sigma value in mul=
ti_push_restart_schedule_exit<br><br>Sigma was computed based on the absolu=
te time and<br>not the delta.<br><br>Note that this probably makes no actua=
l difference in<br>practice. The sigma value is irrelevant on first call<br=
>and multi_push_restart_schedule_exit should not be<br>called multiple time=
s since it is only called<br>if deferred_shutdown_signal.signal_received is=
 not set,<br>yet.<br><br>Change-Id: I62b8263f18c4e2e7f5ecacb4616737f5ba8363=
03<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by=
: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.openvp=
n.net/c/openvpn/+/1311<br>Message-Id: &lt;20251215150500.18898-1-gert@...1711...=
96...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1357...=
rge.net/msg35075.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt=
;<br>---<br>M src/openvpn/multi.c<br>1 file changed, 2 insertions(+), 4 del=
etions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:2941=
8/openvpn refs/changes/11/1311/10</pre><pre style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/multi.c =
b/src/openvpn/multi.c</span><br><span>index d2d9ba8e..d9cb3a9 100644</span>=
<br><span>--- a/src/openvpn/multi.c</span><br><span>+++ b/src/openvpn/multi=
.c</span><br><span>@@ -3820,7 +3820,6 @@</span><br><span> {</span><br><span=
>     struct hash_iterator hi;</span><br><span>     struct hash_element *he=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct timeval t=
v;</span><br><span> </span><br><span>     /* tell all clients to restart */=
</span><br><span>     hash_iterator_init(m-&gt;iter, &amp;hi);</span><br><s=
pan>@@ -3838,15 +3837,14 @@</span><br><span> </span><br><span>     /* resch=
edule signal */</span><br><span>     ASSERT(!openvpn_gettimeofday(&amp;m-&g=
t;deferred_shutdown_signal.wakeup, NULL));</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    tv.tv_sec =3D 2;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    tv.tv_usec =3D 0;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct timeval tv =3D { .tv_sec =3D 2, .tv_usec =
=3D 0 };</span><br><span>     tv_add(&amp;m-&gt;deferred_shutdown_signal.wa=
keup, &amp;tv);</span><br><span> </span><br><span>     m-&gt;deferred_shutd=
own_signal.signal_received =3D m-&gt;top.sig-&gt;signal_received;</span><br=
><span> </span><br><span>     schedule_add_entry(m-&gt;schedule, (struct sc=
hedule_entry *)&amp;m-&gt;deferred_shutdown_signal,</span><br><span>       =
                 &amp;m-&gt;deferred_shutdown_signal.wakeup,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                       compute_wakeu=
p_sigma(&amp;m-&gt;deferred_shutdown_signal.wakeup));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                       compute_wakeup_sig=
ma(&amp;tv));</span><br><span> </span><br><span>     signal_reset(m-&gt;top=
.sig, 0);</span><br><span> }</span><br><span></span><br></pre><p>To view, v=
isit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1311?usp=3Demail">cha=
nge 1311</a>. To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div=
 itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1311?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I62b8263f18c4e2e7f5ecacb4616=
737f5ba836303 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1311 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 10 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--ylyRJg2TSfo=--

