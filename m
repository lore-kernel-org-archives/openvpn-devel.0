From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 13 Oct 2025 16:29:15 +0000
In-Reply-To: <gerrit.1760359115000.I5e6cb3a287a2e8e1584036307b4c21bb68050c6a@...2715...>
References: <gerrit.1760359115000.I5e6cb3a287a2e8e1584036307b4c21bb68050c6a@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <2d12ebac29fa7546ea0983fe6709942b04a4c3f0-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4SXjKygzmj4="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: schedule: Fix
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

--4SXjKygzmj4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1270?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: schedule: Fix conversion warning
......................................................................

schedule: Fix conversion warning

Return value of random() is safe to cast.

Change-Id: I5e6cb3a287a2e8e1584036307b4c21bb68050c6a
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1270
Message-Id: <20251013162313.2276-1-gert@...1296...>
URL: https://sourceforge.net/p/openvpn/mailman/message/59246224/
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/schedule.c
1 file changed, 1 insertion(+), 10 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/70/1270/2

diff --git a/src/openvpn/schedule.c b/src/openvpn/schedule.c
index 1389889..bf6693f 100644
--- a/src/openvpn/schedule.c
+++ b/src/openvpn/schedule.c
@@ -65,25 +65,16 @@
 }
 #endif

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 static inline void
 schedule_set_pri(struct schedule_entry *e)
 {
-    e->pri =3D random();
+    e->pri =3D (unsigned int)random();
     if (e->pri < 1)
     {
         e->pri =3D 1;
     }
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 /* This is the master key comparison routine.  A key is
  * simply a struct timeval containing the absolute time for
  * an event.  The unique treap priority (pri) is used to ensure

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1270?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5e6cb3a287a2e8e1584036307b4c21bb68050c6a
Gerrit-Change-Number: 1270
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--4SXjKygzmj4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1270?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">schedule: Fix conversion warning<br=
><br>Return value of random() is safe to cast.<br><br>Change-Id: I5e6cb3a28=
7a2e8e1584036307b4c21bb68050c6a<br>Signed-off-by: Frank Lichtenheld &lt;fra=
nk@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerr=
it URL: https://gerrit.openvpn.net/c/openvpn/+/1270<br>Message-Id: &lt;2025=
1013162313.2276-1-gert@...1296...&gt;<br>URL: https://sourceforge.net/p/ope=
nvpn/mailman/message/59246224/<br>Signed-off-by: Gert Doering &lt;gert@...1386...=
296...&gt;<br>---<br>M src/openvpn/schedule.c<br>1 file changed, 1 insertio=
n(+), 10 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.open=
vpn.net:29418/openvpn refs/changes/70/1270/2</pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openv=
pn/schedule.c b/src/openvpn/schedule.c</span><br><span>index 1389889..bf669=
3f 100644</span><br><span>--- a/src/openvpn/schedule.c</span><br><span>+++ =
b/src/openvpn/schedule.c</span><br><span>@@ -65,25 +65,16 @@</span><br><spa=
n> }</span><br><span> #endif</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic=
 ignored &quot;-Wconversion&quot;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span> static inline void</span><br><span> schedule_set_pri(struct =
schedule_entry *e)</span><br><span> {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    e-&gt;pri =3D random();</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    e-&gt;pri =3D (unsigned int)random();</span><br=
><span>     if (e-&gt;pri &lt; 1)</span><br><span>     {</span><br><span>  =
       e-&gt;pri =3D 1;</span><br><span>     }</span><br><span> }</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(_=
_GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span> /* This is the master key comparison routine.  A key is</s=
pan><br><span>  * simply a struct timeval containing the absolute time for<=
/span><br><span>  * an event.  The unique treap priority (pri) is used to e=
nsure</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://=
gerrit.openvpn.net/c/openvpn/+/1270?usp=3Demail">change 1270</a>. To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit.ope=
nvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"=
http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1270?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5e6cb3a287a2e8e1584036307b4=
c21bb68050c6a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1270 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--4SXjKygzmj4=--

