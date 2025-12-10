From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 10 Dec 2025 11:02:56 +0000
In-Reply-To: <gerrit.1762271909000.Id0bb4c45d373437ab8dbaff7a311745f9b538cbf@...2715...>
References: <gerrit.1762271909000.Id0bb4c45d373437ab8dbaff7a311745f9b538cbf@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <18fcb95cc0c724ba287fd94a11a9da3fb00ee88f-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ozZRIMocKTk="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: mudp: fix unaligned
 32-bit read when parsing peer ID
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

--ozZRIMocKTk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 its_Giaan. ( http://gerrit.openvpn.net/c/openvpn/+/1348?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: mudp: fix unaligned 32-bit read when parsing peer ID
......................................................................

mudp: fix unaligned 32-bit read when parsing peer ID

The code previously read a 32-bit value from a uint8_t
buffer using a direct cast and dereference.
This can cause unaligned memory access and undefined
behavior on architectures that do not support unaligned
reads, potentially leading to a one-packet crash.

Fix this by reading the bytes individually and
combining them manually.

Reported-By: Joshua Rogers <contact@...2949...>
Found-By: ZeroPath (https://zeropath.com)

Change-Id: Id0bb4c45d373437ab8dbaff7a311745f9b538cbf
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1348
Message-Id: <20251210104839.8270-1-gert@...1296...>
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/mudp.c
1 file changed, 1 insertion(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/48/1348/4

diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index b03e165..5de3af6 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -209,7 +209,7 @@
         /* make sure buffer has enough length to read opcode (1 byte) and =
peer-id (3 bytes) */
         if (v2)
         {
-            uint32_t peer_id =3D ntohl(*(uint32_t *)ptr) & 0xFFFFFF;
+            uint32_t peer_id =3D ((uint32_t)ptr[1] << 16) | ((uint32_t)ptr=
[2] << 8) | ((uint32_t)ptr[3]);
             peer_id_disabled =3D (peer_id =3D=3D MAX_PEER_ID);

             if (!peer_id_disabled && (peer_id < m->max_clients) && (m->ins=
tances[peer_id]))

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1348?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id0bb4c45d373437ab8dbaff7a311745f9b538cbf
Gerrit-Change-Number: 1348
Gerrit-PatchSet: 4
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ozZRIMocKTk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #4</strong> to the change originally created by its_Giaan.<=
/p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1348?usp=3Demail">Vi=
ew Change</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">mudp: fix unaligned 32-bit read whe=
n parsing peer ID<br><br>The code previously read a 32-bit value from a uin=
t8_t<br>buffer using a direct cast and dereference.<br>This can cause unali=
gned memory access and undefined<br>behavior on architectures that do not s=
upport unaligned<br>reads, potentially leading to a one-packet crash.<br><b=
r>Fix this by reading the bytes individually and<br>combining them manually=
.<br><br>Reported-By: Joshua Rogers &lt;contact@...2949...&gt;<br>Found-By:=
 ZeroPath (https://zeropath.com)<br><br>Change-Id: Id0bb4c45d373437ab8dbaff=
7a311745f9b538cbf<br>Signed-off-by: Gianmarco De Gregori &lt;gianmarco@...1665...=
726...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL:=
 https://gerrit.openvpn.net/c/openvpn/+/1348<br>Message-Id: &lt;20251210104=
839.8270-1-gert@...1296...&gt;<br>Signed-off-by: Gert Doering &lt;gert@...1386...=
296...&gt;<br>---<br>M src/openvpn/mudp.c<br>1 file changed, 1 insertion(+)=
, 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.ne=
t:29418/openvpn refs/changes/48/1348/4</pre><pre style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/mud=
p.c b/src/openvpn/mudp.c</span><br><span>index b03e165..5de3af6 100644</spa=
n><br><span>--- a/src/openvpn/mudp.c</span><br><span>+++ b/src/openvpn/mudp=
.c</span><br><span>@@ -209,7 +209,7 @@</span><br><span>         /* make sur=
e buffer has enough length to read opcode (1 byte) and peer-id (3 bytes) */=
</span><br><span>         if (v2)</span><br><span>         {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            uint32_t peer_id =3D nto=
hl(*(uint32_t *)ptr) &amp; 0xFFFFFF;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            uint32_t peer_id =3D ((uint32_t)ptr[1] &lt;&lt=
; 16) | ((uint32_t)ptr[2] &lt;&lt; 8) | ((uint32_t)ptr[3]);</span><br><span=
>             peer_id_disabled =3D (peer_id =3D=3D MAX_PEER_ID);</span><br>=
<span> </span><br><span>             if (!peer_id_disabled &amp;&amp; (peer=
_id &lt; m-&gt;max_clients) &amp;&amp; (m-&gt;instances[peer_id]))</span><b=
r><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/1348?usp=3Demail">change 1348</a>. To unsubscribe, or for =
help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/setti=
ngs?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.=
org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sch=
ema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/1348?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id0bb4c45d373437ab8dbaff7a31=
1745f9b538cbf </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1348 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
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

</body></html>=

--ozZRIMocKTk=--

