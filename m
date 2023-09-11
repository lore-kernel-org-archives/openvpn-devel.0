From: "stipa (Code Review)" <gerrit@...515...>
Date: Mon, 11 Sep 2023 12:42:23 +0000
References: <gerrit.1694436141000.If3c27a2a2ba24f2af0e3e3c95eea57ed420b2542@...2715...>
Reply-To: lstipakov@...277..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <37df9e97b8e8ea8db6f576e861e934f4252899a2-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="zpLV6Cfvmtc="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--zpLV6Cfvmtc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/329?usp=3Demail

to review the following change.


Change subject: Warn user if INFO control command is too long
......................................................................

Warn user if INFO control command is too long

"INFO_PRE,..." command length is limited to 256 bytes. If the server
implementation pushes command which is too long, warn the user and
don't send the truncated command to a management client.

Change-Id: If3c27a2a2ba24f2af0e3e3c95eea57ed420b2542
Signed-off-by: Lev Stipakov <lev@...515...>
---
M src/openvpn/push.c
1 file changed, 8 insertions(+), 2 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/29/329/1

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

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/329?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: If3c27a2a2ba24f2af0e3e3c95eea57ed420b2542
Gerrit-Change-Number: 329
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--zpLV6Cfvmtc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>stipa would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/329?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Warn user if INFO control command is too long<br><br>&quot;IN=
FO_PRE,...&quot; command length is limited to 256 bytes. If the server<br>i=
mplementation pushes command which is too long, warn the user and<br>don&#3=
9;t send the truncated command to a management client.<br><br>Change-Id: If=
3c27a2a2ba24f2af0e3e3c95eea57ed420b2542<br>Signed-off-by: Lev Stipakov &lt;=
lev@...515...&gt;<br>---<br>M src/openvpn/push.c<br>1 file changed, 8 inser=
tions(+), 2 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/=
openvpn refs/changes/29/329/1</pre><pre style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/push.c b/src=
/openvpn/push.c</span><br><span>index d468211..19849c5 100644</span><br><sp=
an>--- a/src/openvpn/push.c</span><br><span>+++ b/src/openvpn/push.c</span>=
<br><span>@@ -244,8 +244,14 @@</span><br><span>          * for management g=
reeting and we don&#39;t want to confuse the client</span><br><span>       =
   */</span><br><span>         struct buffer out =3D alloc_buf_gc(256, &amp=
;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        buf_prin=
tf(&amp;out, &quot;&gt;%s:%s&quot;, &quot;INFOMSG&quot;, m);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        management_notify_generic(ma=
nagement, BSTR(&amp;out));</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        if (buf_printf(&amp;out, &quot;&gt;%s:%s&quot;, &quot;INFOMS=
G&quot;, m))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            manag=
ement_notify_generic(management, BSTR(&amp;out));</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        else</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            msg(D_PUSH_ERRORS, &quot;WARNING: Received INFO command is t=
oo long, won&#39;t notify management client.&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span> </span><br><sp=
an>         gc_free(&amp;gc);</span><br><span>     }</span><br><span></span=
><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/329?usp=3Demail">change 329</a>. To unsubscribe, or for help writing mai=
l filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a=
>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link it=
emprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/329?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: If3c27a2a2ba24f2af0e3e3c95ee=
a57ed420b2542 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 329 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--zpLV6Cfvmtc=--

