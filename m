From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Wed, 26 Nov 2025 13:59:00 +0000
References: <gerrit.1764165538000.I80aed8a91259374d4b2b2155a8f47e286f2def75@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <ee50e36154e07bc6e2f1cd5e231f6ebe6a48b2d8-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Y+w2cjq8dqk="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Properly log
 peer-id in P2P mode
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

--Y+w2cjq8dqk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1406?usp=3Demail

to review the following change.


Change subject: Properly log peer-id in P2P mode
......................................................................

Properly log peer-id in P2P mode

As of now OpenVPN prints o->peer_id in the deferred
options log message, however in P2P mode that field
is currently always 0 as it gets populated only when
a peer-id is pushed by a server (which doesn't happen in P2P).

Fix this by populate o->peer_id before loggin it.

Change-Id: I80aed8a91259374d4b2b2155a8f47e286f2def75
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
---
M src/openvpn/init.c
1 file changed, 1 insertion(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/06/1406/1

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index fc079e1..b7795c7 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2541,6 +2541,7 @@
     }

     c->options.use_peer_id =3D c->c2.tls_multi->use_peer_id;
+    c->options.peer_id =3D c->c2.tls_multi->peer_id;

     struct tls_session *session =3D &c->c2.tls_multi->session[TM_ACTIVE];


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1406?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I80aed8a91259374d4b2b2155a8f47e286f2def75
Gerrit-Change-Number: 1406
Gerrit-PatchSet: 1
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--Y+w2cjq8dqk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>its_Giaan would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1406?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">Properly log peer-id in P2P mode<br><br>As =
of now OpenVPN prints o-&gt;peer_id in the deferred<br>options log message,=
 however in P2P mode that field<br>is currently always 0 as it gets populat=
ed only when<br>a peer-id is pushed by a server (which doesn&#39;t happen i=
n P2P).<br><br>Fix this by populate o-&gt;peer_id before loggin it.<br><br>=
Change-Id: I80aed8a91259374d4b2b2155a8f47e286f2def75<br>Signed-off-by: Gian=
marco De Gregori &lt;gianmarco@...2726...&gt;<br>---<br>M src/openvpn/init.=
c<br>1 file changed, 1 insertion(+), 0 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/06/1406/1<=
/pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
"><span>diff --git a/src/openvpn/init.c b/src/openvpn/init.c</span><br><spa=
n>index fc079e1..b7795c7 100644</span><br><span>--- a/src/openvpn/init.c</s=
pan><br><span>+++ b/src/openvpn/init.c</span><br><span>@@ -2541,6 +2541,7 @=
@</span><br><span>     }</span><br><span> </span><br><span>     c-&gt;optio=
ns.use_peer_id =3D c-&gt;c2.tls_multi-&gt;use_peer_id;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    c-&gt;options.peer_id =3D c-&gt;c2.t=
ls_multi-&gt;peer_id;</span><br><span> </span><br><span>     struct tls_ses=
sion *session =3D &amp;c-&gt;c2.tls_multi-&gt;session[TM_ACTIVE];</span><br=
><span> </span><br><span></span><br></pre><p>To view, visit <a href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/1406?usp=3Demail">change 1406</a>. To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit.=
openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1406?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I80aed8a91259374d4b2b2155a8f=
47e286f2def75 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1406 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--Y+w2cjq8dqk=--

