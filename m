From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Fri, 24 Jan 2025 12:43:06 +0000
References: <gerrit.1737722584000.I0542df021ae0ba9c982335fed7bbd10ed326dd0f@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <11aa8b9c09fc615599857e7019fed07294bf914a-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dwe3qv+v7k4="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--dwe3qv+v7k4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/875?usp=3Demail

to review the following change.


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
---
M src/openvpn/options.c
1 file changed, 3 insertions(+), 3 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/75/875/1

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
Gerrit-PatchSet: 1
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--dwe3qv+v7k4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>its_Giaan would like plaisthos and flichtenheld to <strong>review</stron=
g> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/875?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Fix PASS_BY_VALUE issue in options_postprocess_mutate_le()<br=
><br>Fix issue reported by Coverity:<br>CID 1641424: Performance inefficien=
cies (PASS_BY_VALUE)<br>    Passing parameter ce of type &quot;struct conne=
ction_entry&quot;<br>    (size 208 bytes) by value, which exceeds the low<b=
r>    threshold of 128 bytes.<br><br>Commit 8466c2ca unintentionally introd=
uced a performance<br>penalty due to passing struct connection_entry &#39;c=
e&#39;<br>by value to options_postprocess_mutate_le().<br>fix this by passi=
ng &#39;ce&#39; by address.<br><br>Change-Id: I0542df021ae0ba9c982335fed7bb=
d10ed326dd0f<br>Signed-off-by: Gianmarco De Gregori &lt;gianmarco@...2804...=
.&gt;<br>---<br>M src/openvpn/options.c<br>1 file changed, 3 insertions(+),=
 3 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn r=
efs/changes/75/875/1</pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;"><span>diff --git a/src/openvpn/options.c b/src/openv=
pn/options.c</span><br><span>index c938999..bd5c056 100644</span><br><span>=
--- a/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/options.c</sp=
an><br><span>@@ -3323,12 +3323,12 @@</span><br><span> }</span><br><span> </=
span><br><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-options_postprocess_mutate_le(struct connection_entry ce, struct loca=
l_entry *le)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+options=
_postprocess_mutate_le(struct connection_entry *ce, struct local_entry *le)=
</span><br><span> {</span><br><span>     /* use the global port if none is =
specified */</span><br><span>     if (!le-&gt;port)</span><br><span>     {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        le-&gt;port =
=3D ce.local_port;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       le-&gt;port =3D ce-&gt;local_port;</span><br><span>     }</span><br>=
<span> }</span><br><span> </span><br><span>@@ -3777,7 +3777,7 @@</span><br>=
<span>     {</span><br><span>         for (i =3D 0; i &lt; o-&gt;ce.local_l=
ist-&gt;len; i++)</span><br><span>         {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            options_postprocess_mutate_le(o-&gt;ce, =
o-&gt;ce.local_list-&gt;array[i]);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            options_postprocess_mutate_le(&amp;o-&gt;ce, o-&=
gt;ce.local_list-&gt;array[i]);</span><br><span>         }</span><br><span>=
     }</span><br><span>     else</span><br><span></span><br></pre><p>To vie=
w, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/875?usp=3Demail">=
change 875</a>. To unsubscribe, or for help writing mail filters, visit <a =
href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope=
 itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/875?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0542df021ae0ba9c982335fed7b=
bd10ed326dd0f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 875 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--dwe3qv+v7k4=--

