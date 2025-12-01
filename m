From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Mon, 1 Dec 2025 16:03:05 +0000
In-Reply-To: <gerrit.1762271909000.Id0bb4c45d373437ab8dbaff7a311745f9b538cbf@...2715...>
References: <gerrit.1762271909000.Id0bb4c45d373437ab8dbaff7a311745f9b538cbf@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <fe67b6747b7ba9d6a2bc5b122988492e7d026f34-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="nPGiq8AoJmE="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--nPGiq8AoJmE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, its_Giaan, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1348?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld

The change is no longer submittable: Code-Review and checks~ChecksSubmitRul=
e are unsatisfied now.


Change subject: mudp: fix unaligned 32-bit read when parsing peer ID
......................................................................

mudp: fix unaligned 32-bit read when parsing peer ID

The code previously read a 32-bit value from a uint8_t
buffer using a direct cast and dereference.
This can cause unaligned memory access and undefined
behavior on architectures that do not support unaligned
reads, potentially leading to a one-packet crash.

Fix this by read the bytes individually and combine
them manually.

Reported-By: Joshua Rogers <contact@...2949...>
Found-By: ZeroPath (https://zeropath.com)

Change-Id: Id0bb4c45d373437ab8dbaff7a311745f9b538cbf
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
---
M src/openvpn/mudp.c
1 file changed, 1 insertion(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/48/1348/2

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
Gerrit-PatchSet: 2
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--nPGiq8AoJmE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, its_Giaan, plaisthos. </p>
<p>its_Giaan <strong>uploaded patch set #2</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1348?usp=3Demail">View Chan=
ge</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld</p><p>The change is no longer submittable: Co=
de-Review and checks~ChecksSubmitRule are unsatisfied now.</p><pre class=3D=
"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
>mudp: fix unaligned 32-bit read when parsing peer ID<br><br>The code previ=
ously read a 32-bit value from a uint8_t<br>buffer using a direct cast and =
dereference.<br>This can cause unaligned memory access and undefined<br>beh=
avior on architectures that do not support unaligned<br>reads, potentially =
leading to a one-packet crash.<br><br>Fix this by read the bytes individual=
ly and combine<br>them manually.<br><br>Reported-By: Joshua Rogers &lt;cont=
act@...2949...&gt;<br>Found-By: ZeroPath (https://zeropath.com)<br><br>Chan=
ge-Id: Id0bb4c45d373437ab8dbaff7a311745f9b538cbf<br>Signed-off-by: Gianmarc=
o De Gregori &lt;gianmarco@...2726...&gt;<br>---<br>M src/openvpn/mudp.c<br=
>1 file changed, 1 insertion(+), 1 deletion(-)<br><br></pre><pre class=3D"b=
locks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">g=
it pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/48/1348/2</pre>=
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

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id0bb4c45d373437ab8dbaff7a31=
1745f9b538cbf </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1348 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@...1296...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@...1665...=
726...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--nPGiq8AoJmE=--

