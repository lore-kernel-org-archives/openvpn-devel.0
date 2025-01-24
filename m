From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 24 Jan 2025 14:00:58 +0000
In-Reply-To: <gerrit.1737722584000.I0542df021ae0ba9c982335fed7bbd10ed326dd0f@...2715...>
References: <gerrit.1737722584000.I0542df021ae0ba9c982335fed7bbd10ed326dd0f@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <8a12d4f6290ca8d76ca3a358d952e195c781c31a-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="IHKzgfYKZCs="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Fix PASS_BY_VALUE
 issue in options_postprocess_mutate_le()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: its_Giaan <gianmarco@...2726...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--IHKzgfYKZCs=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 its_Giaan. ( http://gerrit.openvpn.net/c/openvpn/+/875?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: Fix PASS_BY_VALUE issue in options_postprocess_mutate_le()
......................................................................

Fix PASS_BY_VALUE issue in options_postprocess_mutate_le()

Fix issue reported by Coverity:
CID 1641424: Performance inefficiencies (PASS_BY_VALUE)
    Passing parameter ce of type "struct connection_entry"
    (size 208 bytes) by value, which exceeds the low
    threshold of 128 bytes.

Commit 8466c2ca unintentionally introduced a performance
penalty due to passing struct connection_entry 'ce'
by value to options_postprocess_mutate_le().
fix this by passing 'ce' by address.

Change-Id: I0542df021ae0ba9c982335fed7bbd10ed326dd0f
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250124130000.20067-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30=
566.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/options.c
1 file changed, 3 insertions(+), 3 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/75/875/2

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index c938999..bd5c056 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3323,12 +3323,12 @@
 }

 static void
-options_postprocess_mutate_le(struct connection_entry ce, struct local_ent=
ry *le)
+options_postprocess_mutate_le(struct connection_entry *ce, struct local_en=
try *le)
 {
     /* use the global port if none is specified */
     if (!le->port)
     {
-        le->port =3D ce.local_port;
+        le->port =3D ce->local_port;
     }
 }

@@ -3777,7 +3777,7 @@
     {
         for (i =3D 0; i < o->ce.local_list->len; i++)
         {
-            options_postprocess_mutate_le(o->ce, o->ce.local_list->array[i=
]);
+            options_postprocess_mutate_le(&o->ce, o->ce.local_list->array[=
i]);
         }
     }
     else

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/875?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0542df021ae0ba9c982335fed7bbd10ed326dd0f
Gerrit-Change-Number: 875
Gerrit-PatchSet: 2
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--IHKzgfYKZCs=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by its_Giaan.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
875?usp=3Demail">View Change</a></p><p>The following approvals got outdated=
 and were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">Fix PASS_BY_VALUE issue in options_postprocess_mutat=
e_le()<br><br>Fix issue reported by Coverity:<br>CID 1641424: Performance i=
nefficiencies (PASS_BY_VALUE)<br>    Passing parameter ce of type &quot;str=
uct connection_entry&quot;<br>    (size 208 bytes) by value, which exceeds =
the low<br>    threshold of 128 bytes.<br><br>Commit 8466c2ca unintentional=
ly introduced a performance<br>penalty due to passing struct connection_ent=
ry &#39;ce&#39;<br>by value to options_postprocess_mutate_le().<br>fix this=
 by passing &#39;ce&#39; by address.<br><br>Change-Id: I0542df021ae0ba9c982=
335fed7bbd10ed326dd0f<br>Signed-off-by: Gianmarco De Gregori &lt;gianmarco@=
...2726...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Message=
-Id: &lt;20250124130000.20067-1-gert@...1296...&gt;<br>URL: https://www.mai=
l-archive.com/openvpn-devel@lists.sourceforge.net/msg30566.html<br>Signed-o=
ff-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/options=
.c<br>1 file changed, 3 insertions(+), 3 deletions(-)<br><br></pre><pre sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ss=
h://gerrit.openvpn.net:29418/openvpn refs/changes/75/875/2</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/options.c b/src/openvpn/options.c</span><br><span>index c=
938999..bd5c056 100644</span><br><span>--- a/src/openvpn/options.c</span><b=
r><span>+++ b/src/openvpn/options.c</span><br><span>@@ -3323,12 +3323,12 @@=
</span><br><span> }</span><br><span> </span><br><span> static void</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-options_postprocess_mutate_le(=
struct connection_entry ce, struct local_entry *le)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+options_postprocess_mutate_le(struct conn=
ection_entry *ce, struct local_entry *le)</span><br><span> {</span><br><spa=
n>     /* use the global port if none is specified */</span><br><span>     =
if (!le-&gt;port)</span><br><span>     {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        le-&gt;port =3D ce.local_port;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        le-&gt;port =3D ce-&gt;local_=
port;</span><br><span>     }</span><br><span> }</span><br><span> </span><br=
><span>@@ -3777,7 +3777,7 @@</span><br><span>     {</span><br><span>       =
  for (i =3D 0; i &lt; o-&gt;ce.local_list-&gt;len; i++)</span><br><span>  =
       {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            o=
ptions_postprocess_mutate_le(o-&gt;ce, o-&gt;ce.local_list-&gt;array[i]);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            options_p=
ostprocess_mutate_le(&amp;o-&gt;ce, o-&gt;ce.local_list-&gt;array[i]);</spa=
n><br><span>         }</span><br><span>     }</span><br><span>     else</sp=
an><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/875?usp=3Demail">change 875</a>. To unsubscribe, or f=
or help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/se=
ttings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Email=
Message"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/V=
iewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/875?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></d=
iv></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0542df021ae0ba9c982335fed7b=
bd10ed326dd0f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 875 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--IHKzgfYKZCs=--

