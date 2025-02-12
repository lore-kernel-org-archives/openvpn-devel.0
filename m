From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 12 Feb 2025 13:02:03 +0000
In-Reply-To: <gerrit.1739361204000.I3f05318fb6f8d9e32d07532a4f0c6ccf8fb757ce@...2715...>
References: <gerrit.1739361204000.I3f05318fb6f8d9e32d07532a4f0c6ccf8fb757ce@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <920d645a5cb1d5a66ca8212bd24dc1faf5f53a46-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="abtOf0bkYww="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Fix typo in
 positive_atoi
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

--abtOf0bkYww=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/889?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: Fix typo in positive_atoi
......................................................................

Fix typo in positive_atoi

This is a code path that only affects Android

Change-Id: I3f05318fb6f8d9e32d07532a4f0c6ccf8fb757ce
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250212123652.18183-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30=
832.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/options.c
1 file changed, 1 insertion(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/89/889/2

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 218d8a6..3ae44db 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -8316,7 +8316,7 @@
 #if defined(TARGET_ANDROID)
         else if (streq(p[1], "PROXY_HTTP") && p[3] && !p[4])
         {
-            o->http_proxy_port =3D positiove_atoi(p[3], msglevel);
+            o->http_proxy_port =3D positive_atoi(p[3], msglevel);
             o->http_proxy =3D p[2];
         }
 #endif

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/889?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3f05318fb6f8d9e32d07532a4f0c6ccf8fb757ce
Gerrit-Change-Number: 889
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--abtOf0bkYww=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by plaisthos.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
889?usp=3Demail">View Change</a></p><p>The following approvals got outdated=
 and were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">Fix typo in positive_atoi<br><br>This is a code path=
 that only affects Android<br><br>Change-Id: I3f05318fb6f8d9e32d07532a4f0c6=
ccf8fb757ce<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>Acked=
-by: Gert Doering &lt;gert@...1296...&gt;<br>Message-Id: &lt;20250212123652=
.18183-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-d=
evel@lists.sourceforge.net/msg30832.html<br>Signed-off-by: Gert Doering &lt=
;gert@...1296...&gt;<br>---<br>M src/openvpn/options.c<br>1 file changed, 1=
 insertion(+), 1 deletion(-)<br><br></pre><pre style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29=
418/openvpn refs/changes/89/889/2</pre><pre style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/options.=
c b/src/openvpn/options.c</span><br><span>index 218d8a6..3ae44db 100644</sp=
an><br><span>--- a/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/=
options.c</span><br><span>@@ -8316,7 +8316,7 @@</span><br><span> #if define=
d(TARGET_ANDROID)</span><br><span>         else if (streq(p[1], &quot;PROXY=
_HTTP&quot;) &amp;&amp; p[3] &amp;&amp; !p[4])</span><br><span>         {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            o-&gt;http_=
proxy_port =3D positiove_atoi(p[3], msglevel);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            o-&gt;http_proxy_port =3D positive_a=
toi(p[3], msglevel);</span><br><span>             o-&gt;http_proxy =3D p[2]=
;</span><br><span>         }</span><br><span> #endif</span><br><span></span=
><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/889?usp=3Demail">change 889</a>. To unsubscribe, or for help writing mai=
l filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a=
>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link it=
emprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/889?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3f05318fb6f8d9e32d07532a4f0=
c6ccf8fb757ce </div>
<div style=3D"display:none"> Gerrit-Change-Number: 889 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--abtOf0bkYww=--

