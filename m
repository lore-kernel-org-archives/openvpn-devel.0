From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 21 Oct 2025 11:24:21 +0000
References: <gerrit.1761045859000.I445b2e2cd14e55cc1ae3efdf1650b28e18992aa5@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <ad3245cdeabc90881b0cffd342808d256c0ce718-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mB1deYXgwXg="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: interval: Fix
 conversion warning
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

--mB1deYXgwXg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1291?usp=3Demail

to review the following change.


Change subject: interval: Fix conversion warning
......................................................................

interval: Fix conversion warning

Use correct return type of the function.

Change-Id: I445b2e2cd14e55cc1ae3efdf1650b28e18992aa5
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/interval.c
1 file changed, 1 insertion(+), 10 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/91/1291/1

diff --git a/src/openvpn/interval.c b/src/openvpn/interval.c
index fbefcd9..f9953a6 100644
--- a/src/openvpn/interval.c
+++ b/src/openvpn/interval.c
@@ -38,11 +38,6 @@
     top->horizon =3D horizon;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 bool
 event_timeout_trigger(struct event_timeout *et, struct timeval *tv, const =
int et_const_retry)
 {
@@ -52,7 +47,7 @@
     }

     bool ret =3D false;
-    time_t wakeup =3D event_timeout_remaining(et);
+    interval_t wakeup =3D event_timeout_remaining(et);

     if (wakeup <=3D 0)
     {
@@ -82,7 +77,3 @@
     }
     return ret;
 }
-
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1291?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I445b2e2cd14e55cc1ae3efdf1650b28e18992aa5
Gerrit-Change-Number: 1291
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--mB1deYXgwXg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1291?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">interval: Fix conversion warning<br><br>Use=
 correct return type of the function.<br><br>Change-Id: I445b2e2cd14e55cc1a=
e3efdf1650b28e18992aa5<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2716...=
1...&gt;<br>---<br>M src/openvpn/interval.c<br>1 file changed, 1 insertion(=
+), 10 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvp=
n.net:29418/openvpn refs/changes/91/1291/1</pre><pre style=3D"font-family: =
monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn=
/interval.c b/src/openvpn/interval.c</span><br><span>index fbefcd9..f9953a6=
 100644</span><br><span>--- a/src/openvpn/interval.c</span><br><span>+++ b/=
src/openvpn/interval.c</span><br><span>@@ -38,11 +38,6 @@</span><br><span> =
    top-&gt;horizon =3D horizon;</span><br><span> }</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || de=
fined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#prag=
ma GCC diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span> bool</span><br><span> event_timeout_t=
rigger(struct event_timeout *et, struct timeval *tv, const int et_const_ret=
ry)</span><br><span> {</span><br><span>@@ -52,7 +47,7 @@</span><br><span>  =
   }</span><br><span> </span><br><span>     bool ret =3D false;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    time_t wakeup =3D event_timeo=
ut_remaining(et);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  interval_t wakeup =3D event_timeout_remaining(et);</span><br><span> </spa=
n><br><span>     if (wakeup &lt;=3D 0)</span><br><span>     {</span><br><sp=
an>@@ -82,7 +77,3 @@</span><br><span>     }</span><br><span>     return ret=
;</span><br><span> }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) =
|| defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#endif</span><br><span></span><br></pre><p>To view, visit <a href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/1291?usp=3Demail">change 1291</a>. To =
unsubscribe, or for help writing mail filters, visit <a href=3D"http://gerr=
it.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemty=
pe=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/1291?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I445b2e2cd14e55cc1ae3efdf165=
0b28e18992aa5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1291 </div>
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

--mB1deYXgwXg=--

