From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 22 Sep 2023 12:06:15 +0000
In-Reply-To: <gerrit.1694436141000.If3c27a2a2ba24f2af0e3e3c95eea57ed420b2542@...2715...>
References: <gerrit.1694436141000.If3c27a2a2ba24f2af0e3e3c95eea57ed420b2542@...2715...>
Reply-To: gert@...1296..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., lstipakov@...277...
Message-ID: <d793a2a3f4cb2abac5604b83f1c97cc4f30247e7-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="NGbmq68HySE="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[release/2.6]: Warn user if
 INFO control command is too long
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: stipa <lstipakov@...277...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--NGbmq68HySE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 stipa. ( http://gerrit.openvpn.net/c/openvpn/+/329?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


Change subject: Warn user if INFO control command is too long
......................................................................

Warn user if INFO control command is too long

"INFO_PRE,..." command length is limited to 256 bytes. If the server
implementation pushes command which is too long, warn the user and
don't send the truncated command to a management client.

Change-Id: If3c27a2a2ba24f2af0e3e3c95eea57ed420b2542
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20230922105055.37969-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27=
062.html
Signed-off-by: Gert Doering <gert@...1296...>
(cherry picked from commit df624fb6d63db6b2a3b0c40597cee74c61b8ab2c)
---
M src/openvpn/push.c
1 file changed, 8 insertions(+), 2 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/29/329/2

diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index d468211..19849c5 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -244,8 +244,14 @@
          * for management greeting and we don't want to confuse the client
          */
         struct buffer out =3D alloc_buf_gc(256, &gc);
-        buf_printf(&out, ">%s:%s", "INFOMSG", m);
-        management_notify_generic(management, BSTR(&out));
+        if (buf_printf(&out, ">%s:%s", "INFOMSG", m))
+        {
+            management_notify_generic(management, BSTR(&out));
+        }
+        else
+        {
+            msg(D_PUSH_ERRORS, "WARNING: Received INFO command is too long=
, won't notify management client.");
+        }

         gc_free(&gc);
     }

--=20
To view, visit http://gerrit.openvpn.net/c/openvpn/+/329?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: If3c27a2a2ba24f2af0e3e3c95eea57ed420b2542
Gerrit-Change-Number: 329
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--NGbmq68HySE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by stipa.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/329?=
usp=3Demail">View Change</a></p><p>The following approvals got outdated and=
 were removed:
Code-Review+2 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Warn user if INFO control command is too long=
<br><br>&quot;INFO_PRE,...&quot; command length is limited to 256 bytes. If=
 the server<br>implementation pushes command which is too long, warn the us=
er and<br>don&#39;t send the truncated command to a management client.<br><=
br>Change-Id: If3c27a2a2ba24f2af0e3e3c95eea57ed420b2542<br>Signed-off-by: L=
ev Stipakov &lt;lev@...515...&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@=
...2641...&gt;<br>Message-Id: &lt;20230922105055.37969-1-frank@...2641...&g=
t;<br>URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net=
/msg27062.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>(c=
herry picked from commit df624fb6d63db6b2a3b0c40597cee74c61b8ab2c)<br>---<b=
r>M src/openvpn/push.c<br>1 file changed, 8 insertions(+), 2 deletions(-)<b=
r><br></pre><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/29/32=
9/2</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/src/openvpn/push.c b/src/openvpn/push.c</span><br>=
<span>index d468211..19849c5 100644</span><br><span>--- a/src/openvpn/push.=
c</span><br><span>+++ b/src/openvpn/push.c</span><br><span>@@ -244,8 +244,1=
4 @@</span><br><span>          * for management greeting and we don&#39;t w=
ant to confuse the client</span><br><span>          */</span><br><span>    =
     struct buffer out =3D alloc_buf_gc(256, &amp;gc);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        buf_printf(&amp;out, &quot;&gt;%s:=
%s&quot;, &quot;INFOMSG&quot;, m);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        management_notify_generic(management, BSTR(&amp;out));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (buf_pri=
ntf(&amp;out, &quot;&gt;%s:%s&quot;, &quot;INFOMSG&quot;, m))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            management_notify_generic(man=
agement, BSTR(&amp;out));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(D_PUS=
H_ERRORS, &quot;WARNING: Received INFO command is too long, won&#39;t notif=
y management client.&quot;);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        }</span><br><span> </span><br><span>         gc_free(&amp;=
gc);</span><br><span>     }</span><br><span></span><br></pre><p>To view, vi=
sit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/329?usp=3Demail">chang=
e 329</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/329?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: If3c27a2a2ba24f2af0e3e3c95ee=
a57ed420b2542 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 329 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--NGbmq68HySE=--

