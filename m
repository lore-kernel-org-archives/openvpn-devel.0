From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 5 Mar 2026 08:45:06 +0000
In-Reply-To: <gerrit.1769789455000.I7be033bc88e9a6ba474916c8be039c126e8bc574@...2715...>
References: <gerrit.1769789455000.I7be033bc88e9a6ba474916c8be039c126e8bc574@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <736cfec630465f1c80e0c01f498f0b4726fb0bd1-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="zxdTSoMjbUk="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: push: Improve check
 of vsnprintf return value
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

--zxdTSoMjbUk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#6) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1502?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos


Change subject: push: Improve check of vsnprintf return value
......................................................................

push: Improve check of vsnprintf return value

Avoid sign-compare warning and do not ignore error
return values.

Change-Id: I7be033bc88e9a6ba474916c8be039c126e8bc574
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1502
Message-Id: <20260304164904.15743-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
905.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/push.c
1 file changed, 1 insertion(+), 10 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/02/1502/6

diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 8541467..93c5558 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -800,11 +800,6 @@
     gc_free(&gc);
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
 bool
 send_push_reply(struct context *c, struct push_list *per_client_push_list)
 {
@@ -936,7 +931,7 @@
     va_start(arglist, format);
     len =3D vsnprintf(tmp, sizeof(tmp), format, arglist);
     va_end(arglist);
-    if (len > sizeof(tmp) - 1)
+    if (len < 0 || len >=3D (int)sizeof(tmp))
     {
         return false;
     }
@@ -944,10 +939,6 @@
     return true;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 void
 push_reset(struct options *o)
 {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1502?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7be033bc88e9a6ba474916c8be039c126e8bc574
Gerrit-Change-Number: 1502
Gerrit-PatchSet: 6
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--zxdTSoMjbUk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #6</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1502?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by plaisthos</p><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">push: Improve check of vsnprint=
f return value<br><br>Avoid sign-compare warning and do not ignore error<br=
>return values.<br><br>Change-Id: I7be033bc88e9a6ba474916c8be039c126e8bc574=
<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: =
Arne Schwabe &lt;arne-openvpn@...1227...&gt;<br>Gerrit URL: https://gerrit.=
openvpn.net/c/openvpn/+/1502<br>Message-Id: &lt;20260304164904.15743-1-gert=
@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1466...=
urceforge.net/msg35905.html<br>Signed-off-by: Gert Doering &lt;gert@...1726...=
...&gt;<br>---<br>M src/openvpn/push.c<br>1 file changed, 1 insertion(+), 1=
0 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net=
:29418/openvpn refs/changes/02/1502/6</pre><pre style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/push=
.c b/src/openvpn/push.c</span><br><span>index 8541467..93c5558 100644</span=
><br><span>--- a/src/openvpn/push.c</span><br><span>+++ b/src/openvpn/push.=
c</span><br><span>@@ -800,11 +800,6 @@</span><br><span>     gc_free(&amp;gc=
);</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignore=
d &quot;-Wsign-compare&quot;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span> bool</span><br><span> send_push_reply(struct context *c, struct p=
ush_list *per_client_push_list)</span><br><span> {</span><br><span>@@ -936,=
7 +931,7 @@</span><br><span>     va_start(arglist, format);</span><br><span=
>     len =3D vsnprintf(tmp, sizeof(tmp), format, arglist);</span><br><span=
>     va_end(arglist);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    if (len &gt; sizeof(tmp) - 1)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (len &lt; 0 || len &gt;=3D (int)sizeof(tmp))</span><b=
r><span>     {</span><br><span>         return false;</span><br><span>     =
}</span><br><span>@@ -944,10 +939,6 @@</span><br><span>     return true;</s=
pan><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span> void</span><br><span> push_reset=
(struct options *o)</span><br><span> {</span><br><span></span><br></pre><p>=
To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1502?usp=3D=
email">change 1502</a>. To unsubscribe, or for help writing mail filters, v=
isit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a=
>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link it=
emprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1502?usp=3Dema=
il"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7be033bc88e9a6ba474916c8be0=
39c126e8bc574 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1502 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--zxdTSoMjbUk=--

