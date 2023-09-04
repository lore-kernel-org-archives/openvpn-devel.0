From: "stipa (Code Review)" <gerrit@...515...>
Date: Mon, 4 Sep 2023 14:22:14 +0000
References: <gerrit.1693837331000.I2139b62117ba69d643b585d2610e8aef15f71d3e@...2715...>
Reply-To: lstipakov@...277..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <a8e62f9022afe4ed26441e86b08bcc06289ca828-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="q+EXQ+pfGCA="; charset=UTF-8
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

--q+EXQ+pfGCA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/327?usp=3Demail

to review the following change.


Change subject: Support for long INFO/INFO_PRE messages
......................................................................

Support for long INFO/INFO_PRE messages

Current hardcoded limit is not defined anywhere and
the server (CloudConnexa) sends the longer string in some cases.

Change-Id: I2139b62117ba69d643b585d2610e8aef15f71d3e
Signed-off-by: Lev Stipakov <lev@...515...>
---
M src/openvpn/push.c
1 file changed, 1 insertion(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/27/327/1

diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index d468211..663cfbd 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -243,7 +243,7 @@
          * We use >INFOMSG here instead of plain >INFO since INFO is used =
to
          * for management greeting and we don't want to confuse the client
          */
-        struct buffer out =3D alloc_buf_gc(256, &gc);
+        struct buffer out =3D alloc_buf_gc(1 + 7 + 1 + BLEN(&buf) + 1, &gc=
);
         buf_printf(&out, ">%s:%s", "INFOMSG", m);
         management_notify_generic(management, BSTR(&out));


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/327?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: I2139b62117ba69d643b585d2610e8aef15f71d3e
Gerrit-Change-Number: 327
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--q+EXQ+pfGCA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>stipa would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/327?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Support for long INFO/INFO_PRE messages<br><br>Current hardco=
ded limit is not defined anywhere and<br>the server (CloudConnexa) sends th=
e longer string in some cases.<br><br>Change-Id: I2139b62117ba69d643b585d26=
10e8aef15f71d3e<br>Signed-off-by: Lev Stipakov &lt;lev@...515...&gt;<br>---=
<br>M src/openvpn/push.c<br>1 file changed, 1 insertion(+), 1 deletion(-)<b=
r><br></pre><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/27/32=
7/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/src/openvpn/push.c b/src/openvpn/push.c</span><br>=
<span>index d468211..663cfbd 100644</span><br><span>--- a/src/openvpn/push.=
c</span><br><span>+++ b/src/openvpn/push.c</span><br><span>@@ -243,7 +243,7=
 @@</span><br><span>          * We use &gt;INFOMSG here instead of plain &g=
t;INFO since INFO is used to</span><br><span>          * for management gre=
eting and we don&#39;t want to confuse the client</span><br><span>         =
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct buf=
fer out =3D alloc_buf_gc(256, &amp;gc);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        struct buffer out =3D alloc_buf_gc(1 + 7 + 1 + =
BLEN(&amp;buf) + 1, &amp;gc);</span><br><span>         buf_printf(&amp;out,=
 &quot;&gt;%s:%s&quot;, &quot;INFOMSG&quot;, m);</span><br><span>         m=
anagement_notify_generic(management, BSTR(&amp;out));</span><br><span> </sp=
an><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/327?usp=3Demail">change 327</a>. To unsubscribe, or f=
or help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/se=
ttings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Email=
Message"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/V=
iewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/327?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></d=
iv></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2139b62117ba69d643b585d2610=
e8aef15f71d3e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 327 </div>
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


--q+EXQ+pfGCA=--

