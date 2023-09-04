From: "stipa (Code Review)" <gerrit@...515...>
Date: Mon, 4 Sep 2023 15:43:23 +0000
In-Reply-To: <gerrit.1693837331000.I2139b62117ba69d643b585d2610e8aef15f71d3e@...2715...>
References: <gerrit.1693837331000.I2139b62117ba69d643b585d2610e8aef15f71d3e@...2715...>
Reply-To: lstipakov@...277..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <89726e852cdbbc4b924435a8a04b95db5d2c720c-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9rC5WSIvsmA="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[release/2.6]: Support for
 long INFO/INFO_PRE messages
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

--9rC5WSIvsmA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, stipa.

Hello flichtenheld,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/327?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review+1 by flichtenheld


Change subject: Support for long INFO/INFO_PRE messages
......................................................................

Support for long INFO/INFO_PRE messages

Current hardcoded limit is not defined anywhere and
the server (CloudConnexa) sends the longer string in some cases.

Change-Id: I2139b62117ba69d643b585d2610e8aef15f71d3e
Signed-off-by: Lev Stipakov <lev@...515...>
---
M src/openvpn/push.c
1 file changed, 4 insertions(+), 2 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/27/327/2

diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index d468211..722bfce 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -42,6 +42,8 @@

 static char push_reply_cmd[] =3D "PUSH_REPLY";

+#define INFOMSG_MAN ">INFOMSG:"
+
 /*
  * Auth username/password
  *
@@ -243,8 +245,8 @@
          * We use >INFOMSG here instead of plain >INFO since INFO is used =
to
          * for management greeting and we don't want to confuse the client
          */
-        struct buffer out =3D alloc_buf_gc(256, &gc);
-        buf_printf(&out, ">%s:%s", "INFOMSG", m);
+        struct buffer out =3D alloc_buf_gc(strlen(INFOMSG_MAN) + BLEN(&buf=
), &gc);
+        buf_printf(&out, "%s%s", INFOMSG_MAN, m);
         management_notify_generic(management, BSTR(&out));

         gc_free(&gc);

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/327?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: I2139b62117ba69d643b585d2610e8aef15f71d3e
Gerrit-Change-Number: 327
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-MessageType: newpatchset

--9rC5WSIvsmA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, stipa. </p>
<p>stipa <strong>uploaded patch set #2</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/327?usp=3Demail">View Change</a=
></p><p>The following approvals got outdated and were removed:
Code-Review+1 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Support for long INFO/INFO_PRE messages<br><b=
r>Current hardcoded limit is not defined anywhere and<br>the server (CloudC=
onnexa) sends the longer string in some cases.<br><br>Change-Id: I2139b6211=
7ba69d643b585d2610e8aef15f71d3e<br>Signed-off-by: Lev Stipakov &lt;lev@...1696...=
15...&gt;<br>---<br>M src/openvpn/push.c<br>1 file changed, 4 insertions(+)=
, 2 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn =
refs/changes/27/327/2</pre><pre style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;"><span>diff --git a/src/openvpn/push.c b/src/openvpn=
/push.c</span><br><span>index d468211..722bfce 100644</span><br><span>--- a=
/src/openvpn/push.c</span><br><span>+++ b/src/openvpn/push.c</span><br><spa=
n>@@ -42,6 +42,8 @@</span><br><span> </span><br><span> static char push_rep=
ly_cmd[] =3D &quot;PUSH_REPLY&quot;;</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#define INFOMSG_MAN &quot;&gt;INFOMSG:&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n> /*</span><br><span>  * Auth username/password</span><br><span>  *</span>=
<br><span>@@ -243,8 +245,8 @@</span><br><span>          * We use &gt;INFOMS=
G here instead of plain &gt;INFO since INFO is used to</span><br><span>    =
      * for management greeting and we don&#39;t want to confuse the client=
</span><br><span>          */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        struct buffer out =3D alloc_buf_gc(256, &amp;gc);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        buf_printf(&amp;out, &q=
uot;&gt;%s:%s&quot;, &quot;INFOMSG&quot;, m);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        struct buffer out =3D alloc_buf_gc(strlen=
(INFOMSG_MAN) + BLEN(&amp;buf), &amp;gc);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        buf_printf(&amp;out, &quot;%s%s&quot;, INFOMS=
G_MAN, m);</span><br><span>         management_notify_generic(management, B=
STR(&amp;out));</span><br><span> </span><br><span>         gc_free(&amp;gc)=
;</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/327?usp=3Demail">change 327</a>. To unsubscribe,=
 or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.n=
et/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/=
EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.=
org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/327?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"=
/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2139b62117ba69d643b585d2610=
e8aef15f71d3e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 327 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--9rC5WSIvsmA=--

