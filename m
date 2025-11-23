From: "d12fk (Code Review)" <gerrit@...515...>
Date: Sun, 23 Nov 2025 06:47:35 +0000
References: <gerrit.1763880426000.I3ebf30f6d9edc66eb54fb3f1b5634c96d156b1ca@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <decf2ee031c68a17797080a9141e72b1ac91b304-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4l98NjOwxHc="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: iservice: fix off
 by one error
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

--4l98NjOwxHc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1395?usp=3Demail

to review the following change.


Change subject: iservice: fix off by one error
......................................................................

iservice: fix off by one error

In case there is more than one non-ignored interface domain, the start
of the next domain was off by one glyph. That meant that all but the
first domain was ignored when converting to MULTI_SZ.

Reported-by: Marc Heuse <marc@...2953...>
Reported-by: stephan@...2953...
Change-Id: I3ebf30f6d9edc66eb54fb3f1b5634c96d156b1ca
Signed-off-by: Heiko Hund <heiko@...2662...>
---
M src/openvpnserv/interactive.c
1 file changed, 2 insertions(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/95/1395/1

diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 8916bea..6818122 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -2234,7 +2234,8 @@
                     return NO_ERROR;
                 }

-                pos =3D comma + 1;
+                /* Comma pos is now +1 after adding leading dot */
+                pos =3D comma + 2;
             }
         }
     }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1395?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3ebf30f6d9edc66eb54fb3f1b5634c96d156b1ca
Gerrit-Change-Number: 1395
Gerrit-PatchSet: 1
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--4l98NjOwxHc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>d12fk would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1395?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">iservice: fix off by one error<br><br>In ca=
se there is more than one non-ignored interface domain, the start<br>of the=
 next domain was off by one glyph. That meant that all but the<br>first dom=
ain was ignored when converting to MULTI_SZ.<br><br>Reported-by: Marc Heuse=
 &lt;marc@...2953...&gt;<br>Reported-by: stephan@...2953...<br>Change-Id: I=
3ebf30f6d9edc66eb54fb3f1b5634c96d156b1ca<br>Signed-off-by: Heiko Hund &lt;h=
eiko@...2662...&gt;<br>---<br>M src/openvpnserv/interactive.c<br>1 file cha=
nged, 2 insertions(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ss=
h://gerrit.openvpn.net:29418/openvpn refs/changes/95/1395/1</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c</span><=
br><span>index 8916bea..6818122 100644</span><br><span>--- a/src/openvpnser=
v/interactive.c</span><br><span>+++ b/src/openvpnserv/interactive.c</span><=
br><span>@@ -2234,7 +2234,8 @@</span><br><span>                     return =
NO_ERROR;</span><br><span>                 }</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                pos =3D comma + 1;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                /* =
Comma pos is now +1 after adding leading dot */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                pos =3D comma + 2;</span><br><s=
pan>             }</span><br><span>         }</span><br><span>     }</span>=
<br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/1395?usp=3Demail">change 1395</a>. To unsubscribe, or fo=
r help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/set=
tings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schem=
a.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://s=
chema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/1395?usp=3Demail"/><meta itemprop=3D"name" content=3D"View =
Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3ebf30f6d9edc66eb54fb3f1b56=
34c96d156b1ca </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1395 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--4l98NjOwxHc=--

