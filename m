From: "d12fk (Code Review)" <gerrit@...515...>
Date: Sun, 23 Nov 2025 06:47:25 +0000
References: <gerrit.1763880426000.Iabad046c930dd0f38ec50d1c43d8b3288816df7d@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <d01bdf417529b666cb361cfc872119214cbaf859-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="PxeTJM+fvBw="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: iservice: return
 correct size when domains are truncated
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

--PxeTJM+fvBw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1391?usp=3Demail

to review the following change.


Change subject: iservice: return correct size when domains are truncated
......................................................................

iservice: return correct size when domains are truncated

In case not all domains can be converted in the available buffer, return
the size of the already converted domains size plus the second terminating
zero for the MULTI_SZ.

Reported-by: Marc Heuse <marc@...2953...>
Reported-by: stephan@...2953...
Change-Id: Iabad046c930dd0f38ec50d1c43d8b3288816df7d
Signed-off-by: Heiko Hund <heiko@...2662...>
---
M src/openvpnserv/interactive.c
1 file changed, 1 insertion(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/91/1391/1

diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 37752b2..f31a8a9 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -2214,7 +2214,7 @@
                 {
                     /* Domain doesn't fit, bad luck if it's the first one =
*/
                     *pos =3D '\0';
-                    *size =3D converted_size =3D=3D 0 ? 0 : *size + 1;
+                    *size =3D converted_size =3D=3D 0 ? 0 : converted_size=
 + 1;
                     return ERROR_MORE_DATA;
                 }


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1391?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iabad046c930dd0f38ec50d1c43d8b3288816df7d
Gerrit-Change-Number: 1391
Gerrit-PatchSet: 1
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--PxeTJM+fvBw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>d12fk would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1391?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">iservice: return correct size when domains =
are truncated<br><br>In case not all domains can be converted in the availa=
ble buffer, return<br>the size of the already converted domains size plus t=
he second terminating<br>zero for the MULTI_SZ.<br><br>Reported-by: Marc He=
use &lt;marc@...2953...&gt;<br>Reported-by: stephan@...2953...<br>Change-Id=
: Iabad046c930dd0f38ec50d1c43d8b3288816df7d<br>Signed-off-by: Heiko Hund &l=
t;heiko@...2662...&gt;<br>---<br>M src/openvpnserv/interactive.c<br>1 file =
changed, 1 insertion(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull =
ssh://gerrit.openvpn.net:29418/openvpn refs/changes/91/1391/1</pre><pre sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff =
--git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c</span=
><br><span>index 37752b2..f31a8a9 100644</span><br><span>--- a/src/openvpns=
erv/interactive.c</span><br><span>+++ b/src/openvpnserv/interactive.c</span=
><br><span>@@ -2214,7 +2214,7 @@</span><br><span>                 {</span><=
br><span>                     /* Domain doesn&#39;t fit, bad luck if it&#39=
;s the first one */</span><br><span>                     *pos =3D &#39;\0&#=
39;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
   *size =3D converted_size =3D=3D 0 ? 0 : *size + 1;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    *size =3D converted_s=
ize =3D=3D 0 ? 0 : converted_size + 1;</span><br><span>                    =
 return ERROR_MORE_DATA;</span><br><span>                 }</span><br><span=
> </span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1391?usp=3Demail">change 1391</a>. To unsubscri=
be, or for help writing mail filters, visit <a href=3D"http://gerrit.openvp=
n.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/1391?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iabad046c930dd0f38ec50d1c43d=
8b3288816df7d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1391 </div>
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

--PxeTJM+fvBw=--

