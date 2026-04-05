From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 5 Apr 2026 14:32:57 +0000
In-Reply-To: <gerrit.1775320419000.Iff5be978817bfc0cd4d78818e7be7b90bad71f3c@...2715...>
References: <gerrit.1775320419000.Iff5be978817bfc0cd4d78818e7be7b90bad71f3c@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <278d3a45368528a89764b7ac6692ba9d838268bc-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="j/Fiu8sBYhE="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: win: Fix
 nrpt_dnssec flag handling
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: d12fk <heiko@...515...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--j/Fiu8sBYhE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/16=
06?usp=3Demail )

Change subject: win: Fix nrpt_dnssec flag handling
......................................................................

win: Fix nrpt_dnssec flag handling

By default the first enum value is 0.
But we check whether we set the flag by doing
BOOL dnssec =3D (msg->flags & nrpt_dnssec) !=3D 0;
This can't ever be true.

Found by cppcheck.

Change-Id: Iff5be978817bfc0cd4d78818e7be7b90bad71f3c
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1606
Message-Id: <20260405102209.31528-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36=
487.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M include/openvpn-msg.h
1 file changed, 1 insertion(+), 1 deletion(-)




diff --git a/include/openvpn-msg.h b/include/openvpn-msg.h
index bef20cf..ca3267e 100644
--- a/include/openvpn-msg.h
+++ b/include/openvpn-msg.h
@@ -110,7 +110,7 @@
=20
 typedef enum
 {
-    nrpt_dnssec
+    nrpt_dnssec =3D 1 << 0,
 } nrpt_flags_t;

 #define NRPT_ADDR_NUM  8  /* Max. number of addresses */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1606?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iff5be978817bfc0cd4d78818e7be7b90bad71f3c
Gerrit-Change-Number: 1606
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: d12fk <heiko@...515...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--j/Fiu8sBYhE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1606?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">win: Fix nrpt_dnssec flag handling<br><br>By def=
ault the first enum value is 0.<br>But we check whether we set the flag by =
doing<br>BOOL dnssec =3D (msg-&gt;flags &amp; nrpt_dnssec) !=3D 0;<br>This =
can&#39;t ever be true.<br><br>Found by cppcheck.<br><br>Change-Id: Iff5be9=
78817bfc0cd4d78818e7be7b90bad71f3c<br>Signed-off-by: Frank Lichtenheld &lt;=
frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>G=
errit URL: https://gerrit.openvpn.net/c/openvpn/+/1606<br>Message-Id: &lt;2=
0260405102209.31528-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.=
com/openvpn-devel@lists.sourceforge.net/msg36487.html<br>Signed-off-by: Ger=
t Doering &lt;gert@...1296...&gt;<br>---<br>M include/openvpn-msg.h<br>1 fi=
le changed, 1 insertion(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/include/openvpn-msg.h b/include/openvpn-msg.h</span><br><sp=
an>index bef20cf..ca3267e 100644</span><br><span>--- a/include/openvpn-msg.=
h</span><br><span>+++ b/include/openvpn-msg.h</span><br><span>@@ -110,7 +11=
0,7 @@</span><br><span> </span><br><span> typedef enum</span><br><span> {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    nrpt_dnssec</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    nrpt_dnssec =3D 1 &lt;&=
lt; 0,</span><br><span> } nrpt_flags_t;</span><br><span> </span><br><span> =
#define NRPT_ADDR_NUM  8  /* Max. number of addresses */</span><br><span></=
span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/1606?usp=3Demail">change 1606</a>. To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3D=
email">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailM=
essage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vi=
ewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/1606?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></d=
iv></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iff5be978817bfc0cd4d78818e7b=
e7b90bad71f3c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1606 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: d12fk &lt;heiko@...515...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--j/Fiu8sBYhE=--

