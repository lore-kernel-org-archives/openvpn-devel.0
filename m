From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 30 Jan 2026 16:11:06 +0000
References: <gerrit.1769789455000.I7be033bc88e9a6ba474916c8be039c126e8bc574@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <af9497ea55206e298cb814b12227cbd94b4e47a4-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="07+/HGkEfPA="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--07+/HGkEfPA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1502?usp=3Demail

to review the following change.


Change subject: push: Improve check of vsnprintf return value
......................................................................

push: Improve check of vsnprintf return value

Avoid sign-compare warning and do not ignore error
return values.

Change-Id: I7be033bc88e9a6ba474916c8be039c126e8bc574
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/push.c
1 file changed, 1 insertion(+), 10 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/02/1502/1

diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index d13b24a..a948973 100644
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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7be033bc88e9a6ba474916c8be039c126e8bc574
Gerrit-Change-Number: 1502
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--07+/HGkEfPA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1502?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">push: Improve check of vsnprintf return val=
ue<br><br>Avoid sign-compare warning and do not ignore error<br>return valu=
es.<br><br>Change-Id: I7be033bc88e9a6ba474916c8be039c126e8bc574<br>Signed-o=
ff-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/p=
ush.c<br>1 file changed, 1 insertion(+), 10 deletions(-)<br><br></pre><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/02/15=
02/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;"><span>diff --git a/src/openvpn/push.c b/src/openvpn/push.c</span><br=
><span>index d13b24a..a948973 100644</span><br><span>--- a/src/openvpn/push=
.c</span><br><span>+++ b/src/openvpn/push.c</span><br><span>@@ -800,11 +800=
,6 @@</span><br><span>     gc_free(&amp;gc);</span><br><span> }</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__G=
NUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wsign-compare&quot;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span> bool</span><br><span> s=
end_push_reply(struct context *c, struct push_list *per_client_push_list)</=
span><br><span> {</span><br><span>@@ -936,7 +931,7 @@</span><br><span>     =
va_start(arglist, format);</span><br><span>     len =3D vsnprintf(tmp, size=
of(tmp), format, arglist);</span><br><span>     va_end(arglist);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    if (len &gt; sizeof(tmp) - 1=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (len &lt; 0=
 || len &gt;=3D (int)sizeof(tmp))</span><br><span>     {</span><br><span>  =
       return false;</span><br><span>     }</span><br><span>@@ -944,10 +939=
,6 @@</span><br><span>     return true;</span><br><span> }</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__=
) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span> void</span><br><span> push_reset(struct options *o)</span><br><sp=
an> {</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://=
gerrit.openvpn.net/c/openvpn/+/1502?usp=3Demail">change 1502</a>. To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit.ope=
nvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"=
http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1502?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7be033bc88e9a6ba474916c8be0=
39c126e8bc574 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1502 </div>
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

--07+/HGkEfPA=--

