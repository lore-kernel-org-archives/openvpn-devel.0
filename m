From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Sat, 4 Apr 2026 16:33:41 +0000
References: <gerrit.1775320419000.Iff5be978817bfc0cd4d78818e7be7b90bad71f3c@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <0e174109857f11d8c12aeb8cc621261370ecc17b-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9mWNHmT7BGg="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--9mWNHmT7BGg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1606?usp=3Demail

to review the following change.


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
---
M include/openvpn-msg.h
1 file changed, 1 insertion(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/06/1606/1

diff --git a/include/openvpn-msg.h b/include/openvpn-msg.h
index bef20cf..ca3267e 100644
--- a/include/openvpn-msg.h
+++ b/include/openvpn-msg.h
@@ -110,7 +110,7 @@

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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iff5be978817bfc0cd4d78818e7be7b90bad71f3c
Gerrit-Change-Number: 1606
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--9mWNHmT7BGg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1606?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">win: Fix nrpt_dnssec flag handling<br><br>B=
y default the first enum value is 0.<br>But we check whether we set the fla=
g by doing<br>BOOL dnssec =3D (msg-&gt;flags &amp; nrpt_dnssec) !=3D 0;<br>=
This can&#39;t ever be true.<br><br>Found by cppcheck.<br><br>Change-Id: If=
f5be978817bfc0cd4d78818e7be7b90bad71f3c<br>Signed-off-by: Frank Lichtenheld=
 &lt;frank@...2641...&gt;<br>---<br>M include/openvpn-msg.h<br>1 file chang=
ed, 1 insertion(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit.openvpn.net:29418/openvpn refs/changes/06/1606/1</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/include/openvpn-msg.h b/include/openvpn-msg.h</span><br><span>index b=
ef20cf..ca3267e 100644</span><br><span>--- a/include/openvpn-msg.h</span><b=
r><span>+++ b/include/openvpn-msg.h</span><br><span>@@ -110,7 +110,7 @@</sp=
an><br><span> </span><br><span> typedef enum</span><br><span> {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    nrpt_dnssec</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    nrpt_dnssec =3D 1 &lt;&lt; 0,</sp=
an><br><span> } nrpt_flags_t;</span><br><span> </span><br><span> #define NR=
PT_ADDR_NUM  8  /* Max. number of addresses */</span><br><span></span><br><=
/pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/160=
6?usp=3Demail">change 1606</a>. To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">set=
tings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><d=
iv itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction">=
<link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1606?u=
sp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iff5be978817bfc0cd4d78818e7b=
e7b90bad71f3c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1606 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--9mWNHmT7BGg=--

