From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 12 Feb 2025 13:02:07 +0000
In-Reply-To: <gerrit.1739361204000.I3f05318fb6f8d9e32d07532a4f0c6ccf8fb757ce@...2715...>
References: <gerrit.1739361204000.I3f05318fb6f8d9e32d07532a4f0c6ccf8fb757ce@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <920d645a5cb1d5a66ca8212bd24dc1faf5f53a46-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="qQOHL3cQFeE="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--qQOHL3cQFeE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/88=
9?usp=3Demail )

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
Gerrit-MessageType: merged

--qQOHL3cQFeE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/889?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Fix typo in positive_atoi<br><br>This is a cod=
e path that only affects Android<br><br>Change-Id: I3f05318fb6f8d9e32d07532=
a4f0c6ccf8fb757ce<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br=
>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Message-Id: &lt;20250212=
123652.18183-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/ope=
nvpn-devel@lists.sourceforge.net/msg30832.html<br>Signed-off-by: Gert Doeri=
ng &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/options.c<br>1 file chan=
ged, 1 insertion(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</span><br><sp=
an>index 218d8a6..3ae44db 100644</span><br><span>--- a/src/openvpn/options.=
c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -8316,7 +8=
316,7 @@</span><br><span> #if defined(TARGET_ANDROID)</span><br><span>     =
    else if (streq(p[1], &quot;PROXY_HTTP&quot;) &amp;&amp; p[3] &amp;&amp;=
 !p[4])</span><br><span>         {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            o-&gt;http_proxy_port =3D positiove_atoi(p[3], msg=
level);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
o-&gt;http_proxy_port =3D positive_atoi(p[3], msglevel);</span><br><span>  =
           o-&gt;http_proxy =3D p[2];</span><br><span>         }</span><br>=
<span> #endif</span><br><span></span><br></pre><p>To view, visit <a href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/889?usp=3Demail">change 889</a>. To =
unsubscribe, or for help writing mail filters, visit <a href=3D"http://gerr=
it.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http:/=
/schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"ht=
tp://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/889?usp=3Demail"/><meta itemprop=3D"name" content=3D"=
View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--qQOHL3cQFeE=--

