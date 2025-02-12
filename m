From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 12 Feb 2025 11:53:30 +0000
References: <gerrit.1739361204000.I3f05318fb6f8d9e32d07532a4f0c6ccf8fb757ce@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <194884c16c654e1076b95b1f4b3e1e7f3ca5cc7c-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="vZI8u5XU4/Q="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--vZI8u5XU4/Q=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/889?usp=3Demail

to review the following change.


Change subject: Fix typo in positive_atoi
......................................................................

Fix typo in positive_atoi

This is a code path that only affects Android

Change-Id: I3f05318fb6f8d9e32d07532a4f0c6ccf8fb757ce
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/options.c
1 file changed, 1 insertion(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/89/889/1

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
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--vZI8u5XU4/Q=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/889?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Fix typo in positive_atoi<br><br>This is a code path that onl=
y affects Android<br><br>Change-Id: I3f05318fb6f8d9e32d07532a4f0c6ccf8fb757=
ce<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>---<br>M src/o=
penvpn/options.c<br>1 file changed, 1 insertion(+), 1 deletion(-)<br><br></=
pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
>git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/89/889/1</pre=
><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><s=
pan>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</span><br><s=
pan>index 218d8a6..3ae44db 100644</span><br><span>--- a/src/openvpn/options=
.c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -8316,7 +=
8316,7 @@</span><br><span> #if defined(TARGET_ANDROID)</span><br><span>    =
     else if (streq(p[1], &quot;PROXY_HTTP&quot;) &amp;&amp; p[3] &amp;&amp=
; !p[4])</span><br><span>         {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            o-&gt;http_proxy_port =3D positiove_atoi(p[3], ms=
glevel);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 o-&gt;http_proxy_port =3D positive_atoi(p[3], msglevel);</span><br><span> =
            o-&gt;http_proxy =3D p[2];</span><br><span>         }</span><br=
><span> #endif</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/889?usp=3Demail">change 889</a>. =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/889?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3f05318fb6f8d9e32d07532a4f0=
c6ccf8fb757ce </div>
<div style=3D"display:none"> Gerrit-Change-Number: 889 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--vZI8u5XU4/Q=--

