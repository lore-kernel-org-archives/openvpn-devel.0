From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 21 Jan 2026 17:15:58 +0000
In-Reply-To: <gerrit.1761063820000.Icc31b7fa0da86220df45552aecc15dc6c769cd54@...2715...>
References: <gerrit.1761063820000.Icc31b7fa0da86220df45552aecc15dc6c769cd54@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, gert@...1296...
Message-ID: <6c7d060bfdef00cea726bb8bef10ab815567b925-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Kuel6SRM3bA="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: push: Fix conversion
 issues related to timeout in send_auth_pending_m...
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

--Kuel6SRM3bA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld.

Hello cron2, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1293?usp=3Demail

to look at the new patch set (#10).

The following approvals got outdated and were removed:
Code-Review-1 by cron2


Change subject: push: Fix conversion issues related to timeout in send_auth=
_pending_messages
......................................................................

push: Fix conversion issues related to timeout in send_auth_pending_messages

Add additional checking to make sure that the required
casts are safe.

Change-Id: Icc31b7fa0da86220df45552aecc15dc6c769cd54
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/push.c
M src/openvpn/ssl_verify.c
2 files changed, 13 insertions(+), 7 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/93/1293/10

diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 25df48d..551a5c7 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -429,11 +429,6 @@
     gc_free(&gc);
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 bool
 send_auth_pending_messages(struct tls_multi *tls_multi, struct tls_session=
 *session,
                            const char *extra, unsigned int timeout)
@@ -449,7 +444,12 @@
     /* Calculate the maximum timeout and subtract the time we already wait=
ed */
     unsigned int max_timeout =3D
         max_uint(tls_multi->opt.renegotiate_seconds / 2, tls_multi->opt.ha=
ndshake_window);
-    max_timeout =3D max_timeout - (now - ks->initial);
+    time_t time_elapsed =3D now - ks->initial;
+    if (time_elapsed < 0 || time_elapsed >=3D (time_t)max_timeout)
+    {
+        return false;
+    }
+    max_timeout -=3D (unsigned int)time_elapsed;
     timeout =3D min_uint(max_timeout, timeout);

     struct gc_arena gc =3D gc_new();
@@ -738,6 +738,11 @@
     return true;
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 static bool
 send_push_options(struct context *c, struct buffer *buf, struct push_list =
*push_list, int safe_cap,
                   bool *push_sent, bool *multi_push)
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 0b02a2f..c74d555 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -911,8 +911,9 @@
             buf_chomp(iv_buf);
             buf_chomp(extra_buf);

+            errno =3D 0;
             long timeout =3D strtol(BSTR(timeout_buf), NULL, 10);
-            if (timeout <=3D 0)
+            if (timeout <=3D 0 || timeout > UINT_MAX || errno)
             {
                 msg(M_WARN, "could not parse auth pending file timeout");
                 buffer_list_free(lines);

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1293?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Icc31b7fa0da86220df45552aecc15dc6c769cd54
Gerrit-Change-Number: 1293
Gerrit-PatchSet: 10
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--Kuel6SRM3bA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, flichtenheld. </p>
<p>flichtenheld <strong>uploaded patch set #10</strong> to this change.</p>=
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1293?usp=3Demail">View =
Change</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">push: Fix conversion issues related=
 to timeout in send_auth_pending_messages<br><br>Add additional checking to=
 make sure that the required<br>casts are safe.<br><br>Change-Id: Icc31b7fa=
0da86220df45552aecc15dc6c769cd54<br>Signed-off-by: Frank Lichtenheld &lt;fr=
ank@...2641...&gt;<br>---<br>M src/openvpn/push.c<br>M src/openvpn/ssl_veri=
fy.c<br>2 files changed, 13 insertions(+), 7 deletions(-)<br><br></pre><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/93/1=
293/10</pre><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;"><span>diff --git a/src/openvpn/push.c b/src/openvpn/push.c</span><=
br><span>index 25df48d..551a5c7 100644</span><br><span>--- a/src/openvpn/pu=
sh.c</span><br><span>+++ b/src/openvpn/push.c</span><br><span>@@ -429,11 +4=
29,6 @@</span><br><span>     gc_free(&amp;gc);</span><br><span> }</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(_=
_GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span> bool</span><br><span> s=
end_auth_pending_messages(struct tls_multi *tls_multi, struct tls_session *=
session,</span><br><span>                            const char *extra, uns=
igned int timeout)</span><br><span>@@ -449,7 +444,12 @@</span><br><span>   =
  /* Calculate the maximum timeout and subtract the time we already waited =
*/</span><br><span>     unsigned int max_timeout =3D</span><br><span>      =
   max_uint(tls_multi-&gt;opt.renegotiate_seconds / 2, tls_multi-&gt;opt.ha=
ndshake_window);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    m=
ax_timeout =3D max_timeout - (now - ks-&gt;initial);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    time_t time_elapsed =3D now - ks-&gt;=
initial;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (tim=
e_elapsed &lt; 0 || time_elapsed &gt;=3D (time_t)max_timeout)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        return false;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    max_timeout -=3D (unsigned int)time_elapsed;</span><br>=
<span>     timeout =3D min_uint(max_timeout, timeout);</span><br><span> </s=
pan><br><span>     struct gc_arena gc =3D gc_new();</span><br><span>@@ -738=
,6 +738,11 @@</span><br><span>     return true;</span><br><span> }</span><b=
r><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if define=
d(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wconversion&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static bool<=
/span><br><span> send_push_options(struct context *c, struct buffer *buf, s=
truct push_list *push_list, int safe_cap,</span><br><span>                 =
  bool *push_sent, bool *multi_push)</span><br><span>diff --git a/src/openv=
pn/ssl_verify.c b/src/openvpn/ssl_verify.c</span><br><span>index 0b02a2f..c=
74d555 100644</span><br><span>--- a/src/openvpn/ssl_verify.c</span><br><spa=
n>+++ b/src/openvpn/ssl_verify.c</span><br><span>@@ -911,8 +911,9 @@</span>=
<br><span>             buf_chomp(iv_buf);</span><br><span>             buf_=
chomp(extra_buf);</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            errno =3D 0;</span><br><span>             long =
timeout =3D strtol(BSTR(timeout_buf), NULL, 10);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            if (timeout &lt;=3D 0)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            if (timeout &lt;=3D 0=
 || timeout &gt; UINT_MAX || errno)</span><br><span>             {</span><b=
r><span>                 msg(M_WARN, &quot;could not parse auth pending fil=
e timeout&quot;);</span><br><span>                 buffer_list_free(lines);=
</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerri=
t.openvpn.net/c/openvpn/+/1293?usp=3Demail">change 1293</a>. To unsubscribe=
, or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.=
net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http:=
//schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"h=
ttp://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/1293?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Icc31b7fa0da86220df45552aecc=
15dc6c769cd54 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1293 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 10 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--Kuel6SRM3bA=--

