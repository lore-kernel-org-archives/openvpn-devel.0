From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 22 Aug 2025 13:45:24 +0000
References: <gerrit.1755870317000.Ibec7ffb9085503f72e79514776042bc310384f13@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <759fba310e838c1154578e1d9d945d531ea5be5a-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="koCdxtI6XJA="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: options: Fix
 --hash-size virtual argument
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

--koCdxtI6XJA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1149?usp=3Demail

to review the following change.


Change subject: options: Fix --hash-size virtual argument
......................................................................

options: Fix --hash-size virtual argument

Previously we ignored the second argument to --hash-size.
This bug is older than the openvpn git repository, but
clearly this is not an option often used (or at all).

Change-Id: Ibec7ffb9085503f72e79514776042bc310384f13
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/options.c
1 file changed, 1 insertion(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/49/1149/1

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 5f9971c..e9584a8 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -7951,7 +7951,7 @@
             goto err;
         }
         options->real_hash_size =3D real;
-        options->virtual_hash_size =3D real;
+        options->virtual_hash_size =3D virtual;
     }
     else if (streq(p[0], "connect-freq") && p[1] && p[2] && !p[3])
     {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1149?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ibec7ffb9085503f72e79514776042bc310384f13
Gerrit-Change-Number: 1149
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--koCdxtI6XJA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1149?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">options: Fix --hash-size virtual argument<br><br>Previously =
we ignored the second argument to --hash-size.<br>This bug is older than th=
e openvpn git repository, but<br>clearly this is not an option often used (=
or at all).<br><br>Change-Id: Ibec7ffb9085503f72e79514776042bc310384f13<br>=
Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/o=
penvpn/options.c<br>1 file changed, 1 insertion(+), 1 deletion(-)<br><br></=
pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
>git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/49/1149/1</pr=
e><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><=
span>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</span><br><=
span>index 5f9971c..e9584a8 100644</span><br><span>--- a/src/openvpn/option=
s.c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -7951,7 =
+7951,7 @@</span><br><span>             goto err;</span><br><span>         =
}</span><br><span>         options-&gt;real_hash_size =3D real;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        options-&gt;virtual_hash_=
size =3D real;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   options-&gt;virtual_hash_size =3D virtual;</span><br><span>     }</span>=
<br><span>     else if (streq(p[0], &quot;connect-freq&quot;) &amp;&amp; p[=
1] &amp;&amp; p[2] &amp;&amp; !p[3])</span><br><span>     {</span><br><span=
></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/1149?usp=3Demail">change 1149</a>. To unsubscribe, or for help wr=
iting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">se=
ttings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><=
div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"=
><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1149?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ibec7ffb9085503f72e795147760=
42bc310384f13 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1149 </div>
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


--koCdxtI6XJA=--

