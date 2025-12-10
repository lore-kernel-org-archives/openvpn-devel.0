From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 10 Dec 2025 11:02:59 +0000
In-Reply-To: <gerrit.1762271909000.Id0bb4c45d373437ab8dbaff7a311745f9b538cbf@...2715...>
References: <gerrit.1762271909000.Id0bb4c45d373437ab8dbaff7a311745f9b538cbf@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <18fcb95cc0c724ba287fd94a11a9da3fb00ee88f-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="SsXVfwmDK8I="; charset=UTF-8
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
To: its_Giaan <gianmarco@...2726...>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--SsXVfwmDK8I=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/13=
48?usp=3Demail )

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

Gerrit-MessageType: merged
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

--SsXVfwmDK8I=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1348?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">mudp: fix unaligned 32-bit read when parsing pee=
r ID<br><br>The code previously read a 32-bit value from a uint8_t<br>buffe=
r using a direct cast and dereference.<br>This can cause unaligned memory a=
ccess and undefined<br>behavior on architectures that do not support unalig=
ned<br>reads, potentially leading to a one-packet crash.<br><br>Fix this by=
 reading the bytes individually and<br>combining them manually.<br><br>Repo=
rted-By: Joshua Rogers &lt;contact@...2949...&gt;<br>Found-By: ZeroPath (ht=
tps://zeropath.com)<br><br>Change-Id: Id0bb4c45d373437ab8dbaff7a311745f9b53=
8cbf<br>Signed-off-by: Gianmarco De Gregori &lt;gianmarco@...2726...&gt;<br=
>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerr=
it.openvpn.net/c/openvpn/+/1348<br>Message-Id: &lt;20251210104839.8270-1-ge=
rt@...1296...&gt;<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br=
>---<br>M src/openvpn/mudp.c<br>1 file changed, 1 insertion(+), 1 deletion(=
-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c</span><br><span>ind=
ex b03e165..5de3af6 100644</span><br><span>--- a/src/openvpn/mudp.c</span><=
br><span>+++ b/src/openvpn/mudp.c</span><br><span>@@ -209,7 +209,7 @@</span=
><br><span>         /* make sure buffer has enough length to read opcode (1=
 byte) and peer-id (3 bytes) */</span><br><span>         if (v2)</span><br>=
<span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       uint32_t peer_id =3D ntohl(*(uint32_t *)ptr) &amp; 0xFFFFFF;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            uint32_t peer_i=
d =3D ((uint32_t)ptr[1] &lt;&lt; 16) | ((uint32_t)ptr[2] &lt;&lt; 8) | ((ui=
nt32_t)ptr[3]);</span><br><span>             peer_id_disabled =3D (peer_id =
=3D=3D MAX_PEER_ID);</span><br><span> </span><br><span>             if (!pe=
er_id_disabled &amp;&amp; (peer_id &lt; m-&gt;max_clients) &amp;&amp; (m-&g=
t;instances[peer_id]))</span><br><span></span><br></pre><p>To view, visit <=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1348?usp=3Demail">change 13=
48</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div items=
cope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/1348?usp=3Demail"/><meta itemp=
rop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
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

--SsXVfwmDK8I=--

