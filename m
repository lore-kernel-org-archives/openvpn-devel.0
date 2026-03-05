From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 5 Mar 2026 08:45:10 +0000
In-Reply-To: <gerrit.1769789455000.I7be033bc88e9a6ba474916c8be039c126e8bc574@...2715...>
References: <gerrit.1769789455000.I7be033bc88e9a6ba474916c8be039c126e8bc574@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <736cfec630465f1c80e0c01f498f0b4726fb0bd1-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="jaMVol2ON4w="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--jaMVol2ON4w=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/15=
02?usp=3Demail )

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

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7be033bc88e9a6ba474916c8be039c126e8bc574
Gerrit-Change-Number: 1502
Gerrit-PatchSet: 6
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--jaMVol2ON4w=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1502?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">push: Improve check of vsnprintf return value<br=
><br>Avoid sign-compare warning and do not ignore error<br>return values.<b=
r><br>Change-Id: I7be033bc88e9a6ba474916c8be039c126e8bc574<br>Signed-off-by=
: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Arne Schwabe &lt;=
arne-openvpn@...1227...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/ope=
nvpn/+/1502<br>Message-Id: &lt;20260304164904.15743-1-gert@...1296...&gt;<b=
r>URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg=
35905.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br=
>M src/openvpn/push.c<br>1 file changed, 1 insertion(+), 10 deletions(-)<br=
><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/push.c b/src/openvpn/push.c</span><br><span>ind=
ex 8541467..93c5558 100644</span><br><span>--- a/src/openvpn/push.c</span><=
br><span>+++ b/src/openvpn/push.c</span><br><span>@@ -800,11 +800,6 @@</spa=
n><br><span>     gc_free(&amp;gc);</span><br><span> }</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || =
defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pr=
agma GCC diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#pragma GCC diagnostic ignored &quot;-Wsign-compare&quot;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span> bool</span><br><span> send_push_r=
eply(struct context *c, struct push_list *per_client_push_list)</span><br><=
span> {</span><br><span>@@ -936,7 +931,7 @@</span><br><span>     va_start(a=
rglist, format);</span><br><span>     len =3D vsnprintf(tmp, sizeof(tmp), f=
ormat, arglist);</span><br><span>     va_end(arglist);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    if (len &gt; sizeof(tmp) - 1)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (len &lt; 0 || len &g=
t;=3D (int)sizeof(tmp))</span><br><span>     {</span><br><span>         ret=
urn false;</span><br><span>     }</span><br><span>@@ -944,10 +939,6 @@</spa=
n><br><span>     return true;</span><br><span> }</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defin=
ed(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma =
GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#en=
dif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> =
void</span><br><span> push_reset(struct options *o)</span><br><span> {</spa=
n><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/1502?usp=3Demail">change 1502</a>. To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/s=
ettings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://sch=
ema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:/=
/schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/1502?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vie=
w Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
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

--jaMVol2ON4w=--

