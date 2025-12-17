From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 17 Dec 2025 08:25:55 +0000
References: <gerrit.1765959951000.I5d5fca3f5f7a724b4f9ec98832d3a785459f36a5@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <3a06bff0c2c0a8c5f15cd9e9c866a4088ceb69c3-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ggqWAAzUods="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[release/2.6]: Add check for
 bind-dev in DCO options
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

--ggqWAAzUods=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1447?usp=3Demail

to review the following change.


Change subject: Add check for bind-dev in DCO options
......................................................................

Add check for bind-dev in DCO options

Change-Id: I5d5fca3f5f7a724b4f9ec98832d3a785459f36a5
---
M src/openvpn/dco.c
1 file changed, 6 insertions(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/47/1447/1

diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index e41d59f..06d5920 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -317,6 +317,12 @@
         }
     }

+    if (o->bind_dev)
+    {
+        msg(msglevel, "Note: bind-dev not supported with DCO, disabling da=
ta channel offload");
+        return false;
+    }
+
 #if defined(_WIN32)
     if (o->mode =3D=3D MODE_SERVER)
     {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1447?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: I5d5fca3f5f7a724b4f9ec98832d3a785459f36a5
Gerrit-Change-Number: 1447
Gerrit-PatchSet: 1
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--ggqWAAzUods=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>cron2 would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1447?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">Add check for bind-dev in DCO options<br><b=
r>Change-Id: I5d5fca3f5f7a724b4f9ec98832d3a785459f36a5<br>---<br>M src/open=
vpn/dco.c<br>1 file changed, 6 insertions(+), 0 deletions(-)<br><br></pre><=
pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/4=
7/1447/1</pre><pre style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;"><span>diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c</span><=
br><span>index e41d59f..06d5920 100644</span><br><span>--- a/src/openvpn/dc=
o.c</span><br><span>+++ b/src/openvpn/dco.c</span><br><span>@@ -317,6 +317,=
12 @@</span><br><span>         }</span><br><span>     }</span><br><span> </=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (o-&gt;bind_de=
v)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        msg(msglevel, &quot;Not=
e: bind-dev not supported with DCO, disabling data channel offload&quot;);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return false=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #if defined(_W=
IN32)</span><br><span>     if (o-&gt;mode =3D=3D MODE_SERVER)</span><br><sp=
an>     {</span><br><span></span><br></pre><p>To view, visit <a href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/1447?usp=3Demail">change 1447</a>. To un=
subscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1447?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5d5fca3f5f7a724b4f9ec98832d=
3a785459f36a5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1447 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@...1296...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--ggqWAAzUods=--

