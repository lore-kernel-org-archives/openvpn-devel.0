From: "reynir (Code Review)" <gerrit@...515...>
Date: Mon, 22 Apr 2024 11:05:22 +0000
References: <gerrit.1713783920000.I9457f005f4ba970502e6b667d9dc4299a588d661@...2715...>
Reply-To: reynir@...2756..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <d8405445a87eb086b0adeaaa12cb3235f47efffa-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="b790fOSZAlA="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Only
 schedule_exit() once
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

--b790fOSZAlA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/555?usp=3Demail

to review the following change.


Change subject: Only schedule_exit() once
......................................................................

Only schedule_exit() once

If an exit has already been scheduled we should not schedule it again.
Otherwise, the exit signal is never emitted if the peer reschedules the
exit before the timeout occurs.

Change-Id: I9457f005f4ba970502e6b667d9dc4299a588d661
Signed-off-by: Reynir Bj=C3=B6rnsson <reynir@...2756...>
---
M src/openvpn/forward.c
1 file changed, 5 insertions(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/55/555/1

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 8d10f25..70f8e9d 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -519,6 +519,11 @@
 void
 schedule_exit(struct context *c, const int n_seconds, const int signal)
 {
+    /* don't reschedule if already scheduled; we drop the new signal, but =
it
+     * only ever seems to be SIGTERM anyway. */
+    if (event_timeout_defined(&c->c2.scheduled_exit)) {
+        return;
+    }
     tls_set_single_session(c->c2.tls_multi);
     update_time();
     reset_coarse_timers(c);

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/555?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I9457f005f4ba970502e6b667d9dc4299a588d661
Gerrit-Change-Number: 555
Gerrit-PatchSet: 1
Gerrit-Owner: reynir <reynir@...2756...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--b790fOSZAlA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>reynir would like plaisthos and flichtenheld to <strong>review</strong> =
this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/555?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Only schedule_exit() once<br><br>If an exit has already been =
scheduled we should not schedule it again.<br>Otherwise, the exit signal is=
 never emitted if the peer reschedules the<br>exit before the timeout occur=
s.<br><br>Change-Id: I9457f005f4ba970502e6b667d9dc4299a588d661<br>Signed-of=
f-by: Reynir Bj=C3=B6rnsson &lt;reynir@...2756...&gt;<br>---<br>M src/openv=
pn/forward.c<br>1 file changed, 5 insertions(+), 0 deletions(-)<br><br></pr=
e><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">g=
it pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/55/555/1</pre><=
pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><spa=
n>diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c</span><br><spa=
n>index 8d10f25..70f8e9d 100644</span><br><span>--- a/src/openvpn/forward.c=
</span><br><span>+++ b/src/openvpn/forward.c</span><br><span>@@ -519,6 +519=
,11 @@</span><br><span> void</span><br><span> schedule_exit(struct context =
*c, const int n_seconds, const int signal)</span><br><span> {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    /* don&#39;t reschedule if al=
ready scheduled; we drop the new signal, but it</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+     * only ever seems to be SIGTERM anyway. */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (event_timeo=
ut_defined(&amp;c-&gt;c2.scheduled_exit)) {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        return;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    }</span><br><span>     tls_set_single_session(c-&gt=
;c2.tls_multi);</span><br><span>     update_time();</span><br><span>     re=
set_coarse_timers(c);</span><br><span></span><br></pre><p>To view, visit <a=
 href=3D"http://gerrit.openvpn.net/c/openvpn/+/555?usp=3Demail">change 555<=
/a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
p://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/555?usp=3Demail"/><meta itemprop=3D"name" c=
ontent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9457f005f4ba970502e6b667d9d=
c4299a588d661 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 555 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: reynir &lt;reynir@...2756...&gt;=
 </div>
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


--b790fOSZAlA=--

