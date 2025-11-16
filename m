From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 16 Nov 2025 17:47:45 +0000
In-Reply-To: <gerrit.1761045859000.I445b2e2cd14e55cc1ae3efdf1650b28e18992aa5@...2715...>
References: <gerrit.1761045859000.I445b2e2cd14e55cc1ae3efdf1650b28e18992aa5@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <48d6f6223861d42de5ca557a8d1fd8cf2e05bd68-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="PBJKJsD12TY="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--PBJKJsD12TY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#6) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1291?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: interval: Fix conversion warning
......................................................................

interval: Fix conversion warning

Use correct return type of the function.

Change-Id: I445b2e2cd14e55cc1ae3efdf1650b28e18992aa5
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1291
Message-Id: <20251116135909.15964-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
464.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/interval.c
1 file changed, 1 insertion(+), 10 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/91/1291/6

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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I445b2e2cd14e55cc1ae3efdf1650b28e18992aa5
Gerrit-Change-Number: 1291
Gerrit-PatchSet: 6
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--PBJKJsD12TY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #6</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1291?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">interval: Fix conversion warning<br=
><br>Use correct return type of the function.<br><br>Change-Id: I445b2e2cd1=
4e55cc1ae3efdf1650b28e18992aa5<br>Signed-off-by: Frank Lichtenheld &lt;fran=
k@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerri=
t URL: https://gerrit.openvpn.net/c/openvpn/+/1291<br>Message-Id: &lt;20251=
116135909.15964-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/=
openvpn-devel@lists.sourceforge.net/msg34464.html<br>Signed-off-by: Gert Do=
ering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/interval.c<br>1 file =
changed, 1 insertion(+), 10 deletions(-)<br><br></pre><pre class=3D"blocks"=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pul=
l ssh://gerrit.openvpn.net:29418/openvpn refs/changes/91/1291/6</pre><pre s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>dif=
f --git a/src/openvpn/interval.c b/src/openvpn/interval.c</span><br><span>i=
ndex fbefcd9..f9953a6 100644</span><br><span>--- a/src/openvpn/interval.c</=
span><br><span>+++ b/src/openvpn/interval.c</span><br><span>@@ -38,11 +38,6=
 @@</span><br><span>     top-&gt;horizon =3D horizon;</span><br><span> }</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if de=
fined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wconversion&quo=
t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> bool</span><br><=
span> event_timeout_trigger(struct event_timeout *et, struct timeval *tv, c=
onst int et_const_retry)</span><br><span> {</span><br><span>@@ -52,7 +47,7 =
@@</span><br><span>     }</span><br><span> </span><br><span>     bool ret =
=3D false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    time_t =
wakeup =3D event_timeout_remaining(et);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    interval_t wakeup =3D event_timeout_remaining(et);<=
/span><br><span> </span><br><span>     if (wakeup &lt;=3D 0)</span><br><spa=
n>     {</span><br><span>@@ -82,7 +77,3 @@</span><br><span>     }</span><br=
><span>     return ret;</span><br><span> }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#endif</span><br><span></span><br></pre><p>To vi=
ew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1291?usp=3Demail=
">change 1291</a>. To unsubscribe, or for help writing mail filters, visit =
<a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p=
><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope =
itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempro=
p=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1291?usp=3Demail"/>=
<meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I445b2e2cd14e55cc1ae3efdf165=
0b28e18992aa5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1291 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--PBJKJsD12TY=--

