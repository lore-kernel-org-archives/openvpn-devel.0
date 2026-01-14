From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 14 Jan 2026 18:35:29 +0000
In-Reply-To: <gerrit.1765959951000.I5d5fca3f5f7a724b4f9ec98832d3a785459f36a5@...2715...>
References: <gerrit.1765959951000.I5d5fca3f5f7a724b4f9ec98832d3a785459f36a5@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, antonio@...2726...
Message-ID: <8bcb08de70f0a413d1937e195d166afab11a60d7-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/m0m3l4ODXw="; charset=UTF-8
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
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--/m0m3l4ODXw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/14=
47?usp=3Demail )

Change subject: Add check for bind-dev in DCO options
......................................................................

Add check for bind-dev in DCO options

Github: OpenVPN/openvpn#683

Change-Id: I5d5fca3f5f7a724b4f9ec98832d3a785459f36a5
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Antonio Quartulli <antonio@...2726...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1447
Message-Id: <20260114160238.31321-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
260.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/dco.c
1 file changed, 6 insertions(+), 0 deletions(-)




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

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: I5d5fca3f5f7a724b4f9ec98832d3a785459f36a5
Gerrit-Change-Number: 1447
Gerrit-PatchSet: 3
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: ordex <antonio@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--/m0m3l4ODXw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1447?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">Add check for bind-dev in DCO options<br><br>Git=
hub: OpenVPN/openvpn#683<br><br>Change-Id: I5d5fca3f5f7a724b4f9ec98832d3a78=
5459f36a5<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>Acked-b=
y: Antonio Quartulli &lt;antonio@...2726...&gt;<br>Gerrit URL: https://gerr=
it.openvpn.net/c/openvpn/+/1447<br>Message-Id: &lt;20260114160238.31321-1-g=
ert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1697...=
.sourceforge.net/msg35260.html<br>Signed-off-by: Gert Doering &lt;gert@...1386...=
296...&gt;<br>---<br>M src/openvpn/dco.c<br>1 file changed, 6 insertions(+)=
, 0 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c</span><br><span>index=
 e41d59f..06d5920 100644</span><br><span>--- a/src/openvpn/dco.c</span><br>=
<span>+++ b/src/openvpn/dco.c</span><br><span>@@ -317,6 +317,12 @@</span><b=
r><span>         }</span><br><span>     }</span><br><span> </span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (o-&gt;bind_dev)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        msg(msglevel, &quot;Note: bind-dev no=
t supported with DCO, disabling data channel offload&quot;);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span> #if defined(_WIN32)</span><b=
r><span>     if (o-&gt;mode =3D=3D MODE_SERVER)</span><br><span>     {</spa=
n><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/1447?usp=3Demail">change 1447</a>. To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/s=
ettings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://sch=
ema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:/=
/schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/1447?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vie=
w Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5d5fca3f5f7a724b4f9ec98832d=
3a785459f36a5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1447 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@...1296...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;antonio@...2726...&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--/m0m3l4ODXw=--

