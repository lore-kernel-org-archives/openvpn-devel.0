From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 2 Jun 2025 14:58:32 +0000
References: <gerrit.1748876308000.I0e13595c1057c680e1065eae84ca94b273ed9ca1@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <7cf6d6faae2f41fd8ab4de7bd235e5eea91c6fc4-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="tZJz+F2hQLo="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Do not segfault on
 missing --dh in server config
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

--tZJz+F2hQLo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1037?usp=3Demail

to review the following change.


Change subject: Do not segfault on missing --dh in server config
......................................................................

Do not segfault on missing --dh in server config

Change-Id: I0e13595c1057c680e1065eae84ca94b273ed9ca1
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/options.c
1 file changed, 1 insertion(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/37/1037/1

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 0d648ba..b9708343 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3698,7 +3698,7 @@

     if (o->tls_server)
     {
-        if (streq(o->dh_file, "none"))
+        if (o->dh_file && streq(o->dh_file, "none"))
         {
             o->dh_file =3D NULL;
         }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1037?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0e13595c1057c680e1065eae84ca94b273ed9ca1
Gerrit-Change-Number: 1037
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--tZJz+F2hQLo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1037?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">Do not segfault on missing --dh in server config<br><br>Chan=
ge-Id: I0e13595c1057c680e1065eae84ca94b273ed9ca1<br>Signed-off-by: Frank Li=
chtenheld &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/options.c<br>1 f=
ile changed, 1 insertion(+), 1 deletion(-)<br><br></pre><pre style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.=
openvpn.net:29418/openvpn refs/changes/37/1037/1</pre><pre style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/o=
penvpn/options.c b/src/openvpn/options.c</span><br><span>index 0d648ba..b97=
08343 100644</span><br><span>--- a/src/openvpn/options.c</span><br><span>++=
+ b/src/openvpn/options.c</span><br><span>@@ -3698,7 +3698,7 @@</span><br><=
span> </span><br><span>     if (o-&gt;tls_server)</span><br><span>     {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (streq(o-&gt;=
dh_file, &quot;none&quot;))</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        if (o-&gt;dh_file &amp;&amp; streq(o-&gt;dh_file, &quot;non=
e&quot;))</span><br><span>         {</span><br><span>             o-&gt;dh_=
file =3D NULL;</span><br><span>         }</span><br><span></span><br></pre>=
<p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1037?usp=
=3Demail">change 1037</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><di=
v itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1037?usp=3Demail"/><met=
a itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0e13595c1057c680e1065eae84c=
a94b273ed9ca1 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1037 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--tZJz+F2hQLo=--

