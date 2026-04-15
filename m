From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Wed, 15 Apr 2026 15:35:02 +0000
References: <gerrit.1776267299000.I33e55d88d561393ebfbc73a995f700056e19a436@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <984ef4842b35f3b6be0d360aae39e10b1276157e-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="TusSvCkhrFs="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: sitnl: use
 RTM_SETLINK for updating existing interfaces
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

--TusSvCkhrFs=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1628?usp=3Demail

to review the following change.


Change subject: sitnl: use RTM_SETLINK for updating existing interfaces
......................................................................

sitnl: use RTM_SETLINK for updating existing interfaces

RTM_NEWLINK is primarily intended for link creation and initialization,
while RTM_SETLINK is the canonical interface for modifying attributes of
an already existing link.

Even though the kernel may accept RTM_NEWLINK for updates, using
RTM_SETLINK better reflects the intended netlink semantics and follows
the dedicated update path in the kernel.

This makes the behavior more explicit and consistent with how link
configuration changes are expected to be performed.

Change-Id: I33e55d88d561393ebfbc73a995f700056e19a436
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
---
M src/openvpn/networking_sitnl.c
1 file changed, 3 insertions(+), 3 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/28/1628/1

diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
index b3f8e2b..3aea076 100644
--- a/src/openvpn/networking_sitnl.c
+++ b/src/openvpn/networking_sitnl.c
@@ -671,7 +671,7 @@

     req.n.nlmsg_len =3D NLMSG_LENGTH(sizeof(req.i));
     req.n.nlmsg_flags =3D NLM_F_REQUEST;
-    req.n.nlmsg_type =3D RTM_NEWLINK;
+    req.n.nlmsg_type =3D RTM_SETLINK;

     req.i.ifi_family =3D AF_PACKET;
     req.i.ifi_index =3D ifindex;
@@ -707,7 +707,7 @@

     req.n.nlmsg_len =3D NLMSG_LENGTH(sizeof(req.i));
     req.n.nlmsg_flags =3D NLM_F_REQUEST;
-    req.n.nlmsg_type =3D RTM_NEWLINK;
+    req.n.nlmsg_type =3D RTM_SETLINK;

     req.i.ifi_family =3D AF_PACKET;
     req.i.ifi_index =3D ifindex;
@@ -738,7 +738,7 @@

     req.n.nlmsg_len =3D NLMSG_LENGTH(sizeof(req.i));
     req.n.nlmsg_flags =3D NLM_F_REQUEST;
-    req.n.nlmsg_type =3D RTM_NEWLINK;
+    req.n.nlmsg_type =3D RTM_SETLINK;
=20
     req.i.ifi_family =3D AF_PACKET;
     req.i.ifi_index =3D ifindex;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1628?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I33e55d88d561393ebfbc73a995f700056e19a436
Gerrit-Change-Number: 1628
Gerrit-PatchSet: 1
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--TusSvCkhrFs=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>its_Giaan would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1628?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">sitnl: use RTM_SETLINK for updating existin=
g interfaces<br><br>RTM_NEWLINK is primarily intended for link creation and=
 initialization,<br>while RTM_SETLINK is the canonical interface for modify=
ing attributes of<br>an already existing link.<br><br>Even though the kerne=
l may accept RTM_NEWLINK for updates, using<br>RTM_SETLINK better reflects =
the intended netlink semantics and follows<br>the dedicated update path in =
the kernel.<br><br>This makes the behavior more explicit and consistent wit=
h how link<br>configuration changes are expected to be performed.<br><br>Ch=
ange-Id: I33e55d88d561393ebfbc73a995f700056e19a436<br>Signed-off-by: Gianma=
rco De Gregori &lt;gianmarco@...2726...&gt;<br>---<br>M src/openvpn/network=
ing_sitnl.c<br>1 file changed, 3 insertions(+), 3 deletions(-)<br><br></pre=
><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes=
/28/1628/1</pre><pre style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;"><span>diff --git a/src/openvpn/networking_sitnl.c b/src/openvp=
n/networking_sitnl.c</span><br><span>index b3f8e2b..3aea076 100644</span><b=
r><span>--- a/src/openvpn/networking_sitnl.c</span><br><span>+++ b/src/open=
vpn/networking_sitnl.c</span><br><span>@@ -671,7 +671,7 @@</span><br><span>=
 </span><br><span>     req.n.nlmsg_len =3D NLMSG_LENGTH(sizeof(req.i));</sp=
an><br><span>     req.n.nlmsg_flags =3D NLM_F_REQUEST;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    req.n.nlmsg_type =3D RTM_NEWLINK;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    req.n.nlmsg_type =3D=
 RTM_SETLINK;</span><br><span> </span><br><span>     req.i.ifi_family =3D A=
F_PACKET;</span><br><span>     req.i.ifi_index =3D ifindex;</span><br><span=
>@@ -707,7 +707,7 @@</span><br><span> </span><br><span>     req.n.nlmsg_len=
 =3D NLMSG_LENGTH(sizeof(req.i));</span><br><span>     req.n.nlmsg_flags =
=3D NLM_F_REQUEST;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 req.n.nlmsg_type =3D RTM_NEWLINK;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    req.n.nlmsg_type =3D RTM_SETLINK;</span><br><span> </spa=
n><br><span>     req.i.ifi_family =3D AF_PACKET;</span><br><span>     req.i=
.ifi_index =3D ifindex;</span><br><span>@@ -738,7 +738,7 @@</span><br><span=
> </span><br><span>     req.n.nlmsg_len =3D NLMSG_LENGTH(sizeof(req.i));</s=
pan><br><span>     req.n.nlmsg_flags =3D NLM_F_REQUEST;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    req.n.nlmsg_type =3D RTM_NEWLINK;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    req.n.nlmsg_type =
=3D RTM_SETLINK;</span><br><span> </span><br><span>     req.i.ifi_family =
=3D AF_PACKET;</span><br><span>     req.i.ifi_index =3D ifindex;</span><br>=
<span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/1628?usp=3Demail">change 1628</a>. To unsubscribe, or for he=
lp writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/setting=
s?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.or=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/1628?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chan=
ge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I33e55d88d561393ebfbc73a995f=
700056e19a436 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1628 </div>
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

--TusSvCkhrFs=--

