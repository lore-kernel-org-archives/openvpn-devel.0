From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Tue, 9 Sep 2025 08:21:07 +0000
References: <gerrit.1757406065000.I74e2b6aed3c7454e897db57f777e6a191be3d87f@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <85a451702057aa482c4338e809f6d48864c98a8c-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4Vq27eyBgAw="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Fix multi-socket
 and dco-win interaction
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

--4Vq27eyBgAw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1173?usp=3Demail

to review the following change.


Change subject: Fix multi-socket and dco-win interaction
......................................................................

Fix multi-socket and dco-win interaction

The dco_check_option_ce(), for dco_win, checked only
the global protocol of the current connection entry,
but now it should be extended to the local_list
and since dco_win does not support more than 1
socket, checking the first entry of the local_list
will be enough.

Change-Id: I74e2b6aed3c7454e897db57f777e6a191be3d87f
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
---
M src/openvpn/dco.c
1 file changed, 1 insertion(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/73/1173/1

diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 1abebbb..70a8c0a 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -268,7 +268,7 @@
 #endif

 #if defined(_WIN32)
-    if (!proto_is_udp(ce->proto) && mode =3D=3D MODE_SERVER)
+    if (!proto_is_udp(ce->local_list->array[0]->proto) && mode =3D=3D MODE=
_SERVER)
     {
         msg(msglevel,
             "NOTE: TCP transport disables data channel offload on Windows =
in server mode.");

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1173?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I74e2b6aed3c7454e897db57f777e6a191be3d87f
Gerrit-Change-Number: 1173
Gerrit-PatchSet: 1
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--4Vq27eyBgAw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>its_Giaan would like plaisthos and flichtenheld to <strong>review</stron=
g> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1173?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">Fix multi-socket and dco-win interaction<br><br>The dco_chec=
k_option_ce(), for dco_win, checked only<br>the global protocol of the curr=
ent connection entry,<br>but now it should be extended to the local_list<br=
>and since dco_win does not support more than 1<br>socket, checking the fir=
st entry of the local_list<br>will be enough.<br><br>Change-Id: I74e2b6aed3=
c7454e897db57f777e6a191be3d87f<br>Signed-off-by: Gianmarco De Gregori &lt;g=
ianmarco@...2726...&gt;<br>---<br>M src/openvpn/dco.c<br>1 file changed, 1 =
insertion(+), 1 deletion(-)<br><br></pre><pre style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:294=
18/openvpn refs/changes/73/1173/1</pre><pre style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/dco.c b/=
src/openvpn/dco.c</span><br><span>index 1abebbb..70a8c0a 100644</span><br><=
span>--- a/src/openvpn/dco.c</span><br><span>+++ b/src/openvpn/dco.c</span>=
<br><span>@@ -268,7 +268,7 @@</span><br><span> #endif</span><br><span> </sp=
an><br><span> #if defined(_WIN32)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    if (!proto_is_udp(ce-&gt;proto) &amp;&amp; mode =3D=3D MODE=
_SERVER)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!pr=
oto_is_udp(ce-&gt;local_list-&gt;array[0]-&gt;proto) &amp;&amp; mode =3D=3D=
 MODE_SERVER)</span><br><span>     {</span><br><span>         msg(msglevel,=
</span><br><span>             &quot;NOTE: TCP transport disables data chann=
el offload on Windows in server mode.&quot;);</span><br><span></span><br></=
pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1173=
?usp=3Demail">change 1173</a>. To unsubscribe, or for help writing mail fil=
ters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p=
><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope =
itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempro=
p=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1173?usp=3Demail"/>=
<meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I74e2b6aed3c7454e897db57f777=
e6a191be3d87f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1173 </div>
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


--4Vq27eyBgAw=--

