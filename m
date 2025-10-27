From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 27 Oct 2025 13:08:20 +0000
References: <gerrit.1761570487000.I62b8263f18c4e2e7f5ecacb4616737f5ba836303@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <f7b30ba7ffbfb0cbb255d068f00fd7c3c07ce86f-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/zxTqYSDNy8="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--/zxTqYSDNy8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1311?usp=3Demail

to review the following change.


Change subject: multi: Fix wrong sigma value in multi_push_restart_schedule=
_exit
......................................................................

multi: Fix wrong sigma value in multi_push_restart_schedule_exit

Sigma was computed based on the absolute time and
not the delta.

Change-Id: I62b8263f18c4e2e7f5ecacb4616737f5ba836303
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/multi.c
1 file changed, 2 insertions(+), 4 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/11/1311/1

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index ad5004e..74cc866 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3843,7 +3843,6 @@
 {
     struct hash_iterator hi;
     struct hash_element *he;
-    struct timeval tv;

     /* tell all clients to restart */
     hash_iterator_init(m->iter, &hi);
@@ -3861,15 +3860,14 @@

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
=20
     signal_reset(m->top.sig, 0);
 }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1311?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I62b8263f18c4e2e7f5ecacb4616737f5ba836303
Gerrit-Change-Number: 1311
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--/zxTqYSDNy8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1311?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">multi: Fix wrong sigma value in multi_push_=
restart_schedule_exit<br><br>Sigma was computed based on the absolute time =
and<br>not the delta.<br><br>Change-Id: I62b8263f18c4e2e7f5ecacb4616737f5ba=
836303<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<=
br>M src/openvpn/multi.c<br>1 file changed, 2 insertions(+), 4 deletions(-)=
<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn=
 refs/changes/11/1311/1</pre><pre style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;"><span>diff --git a/src/openvpn/multi.c b/src/open=
vpn/multi.c</span><br><span>index ad5004e..74cc866 100644</span><br><span>-=
-- a/src/openvpn/multi.c</span><br><span>+++ b/src/openvpn/multi.c</span><b=
r><span>@@ -3843,7 +3843,6 @@</span><br><span> {</span><br><span>     struc=
t hash_iterator hi;</span><br><span>     struct hash_element *he;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    struct timeval tv;</span><b=
r><span> </span><br><span>     /* tell all clients to restart */</span><br>=
<span>     hash_iterator_init(m-&gt;iter, &amp;hi);</span><br><span>@@ -386=
1,15 +3860,14 @@</span><br><span> </span><br><span>     /* reschedule signa=
l */</span><br><span>     ASSERT(!openvpn_gettimeofday(&amp;m-&gt;deferred_=
shutdown_signal.wakeup, NULL));</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    tv.tv_sec =3D 2;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    tv.tv_usec =3D 0;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    struct timeval tv =3D { .tv_sec =3D 2, .tv_usec =3D 0 };</sp=
an><br><span>     tv_add(&amp;m-&gt;deferred_shutdown_signal.wakeup, &amp;t=
v);</span><br><span> </span><br><span>     m-&gt;deferred_shutdown_signal.s=
ignal_received =3D m-&gt;top.sig-&gt;signal_received;</span><br><span> </sp=
an><br><span>     schedule_add_entry(m-&gt;schedule, (struct schedule_entry=
 *)&amp;m-&gt;deferred_shutdown_signal,</span><br><span>                   =
     &amp;m-&gt;deferred_shutdown_signal.wakeup,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                       compute_wakeup_sigma(&amp=
;m-&gt;deferred_shutdown_signal.wakeup));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                       compute_wakeup_sigma(&amp;tv))=
;</span><br><span> </span><br><span>     signal_reset(m-&gt;top.sig, 0);</s=
pan><br><span> }</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1311?usp=3Demail">change 1311</a>=
. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:/=
/gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope i=
temtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"actio=
n" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/1311?usp=3Demail"/><meta itemprop=3D=
"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I62b8263f18c4e2e7f5ecacb4616=
737f5ba836303 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1311 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--/zxTqYSDNy8=--

