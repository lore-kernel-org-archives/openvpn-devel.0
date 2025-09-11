From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Thu, 11 Sep 2025 16:20:23 +0000
References: <gerrit.1757607620000.I73c46ac630834a8cf8894aaa2dcc429fbedd3db7@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <0c69c8ce91e2945b288f30251c0ecb101c2cbd0f-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ydsUsewUz4Y="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: vlan: Limit
 -Wconversion override to GCC 10 and older
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

--ydsUsewUz4Y=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1179?usp=3Demail

to review the following change.


Change subject: vlan: Limit -Wconversion override to GCC 10 and older
......................................................................

vlan: Limit -Wconversion override to GCC 10 and older

Only Debian 11 complains about this. This way we know
we can remove this at some point.

Change-Id: I73c46ac630834a8cf8894aaa2dcc429fbedd3db7
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/vlan.c
1 file changed, 3 insertions(+), 2 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/79/1179/1

diff --git a/src/openvpn/vlan.c b/src/openvpn/vlan.c
index 3da470a..f6e2251 100644
--- a/src/openvpn/vlan.c
+++ b/src/openvpn/vlan.c
@@ -43,7 +43,8 @@
     return ntohs(hdr->pcp_cfi_vid & OPENVPN_8021Q_MASK_VID);
 }

-#if defined(__GNUC__) || defined(__clang__)
+/* ~OPENVPN_8021Q_MASK_VID is "int" on old GCC */
+#if defined(__GNUC__) && __GNUC__ < 11
 #pragma GCC diagnostic push
 #pragma GCC diagnostic ignored "-Wconversion"
 #endif
@@ -61,7 +62,7 @@
         (hdr->pcp_cfi_vid & ~OPENVPN_8021Q_MASK_VID) | (htons(vid) & OPENV=
PN_8021Q_MASK_VID);
 }

-#if defined(__GNUC__) || defined(__clang__)
+#if defined(__GNUC__) && __GNUC__ < 11
 #pragma GCC diagnostic pop
 #endif


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1179?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I73c46ac630834a8cf8894aaa2dcc429fbedd3db7
Gerrit-Change-Number: 1179
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--ydsUsewUz4Y=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1179?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">vlan: Limit -Wconversion override to GCC 10 and older<br><br=
>Only Debian 11 complains about this. This way we know<br>we can remove thi=
s at some point.<br><br>Change-Id: I73c46ac630834a8cf8894aaa2dcc429fbedd3db=
7<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M =
src/openvpn/vlan.c<br>1 file changed, 3 insertions(+), 2 deletions(-)<br><b=
r></pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/79/1179/1=
</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;"><span>diff --git a/src/openvpn/vlan.c b/src/openvpn/vlan.c</span><br><sp=
an>index 3da470a..f6e2251 100644</span><br><span>--- a/src/openvpn/vlan.c</=
span><br><span>+++ b/src/openvpn/vlan.c</span><br><span>@@ -43,7 +43,8 @@</=
span><br><span>     return ntohs(hdr-&gt;pcp_cfi_vid &amp; OPENVPN_8021Q_MA=
SK_VID);</span><br><span> }</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/* ~OPENVPN_8021Q_MASK_VID =
is &quot;int&quot; on old GCC */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#if defined(__GNUC__) &amp;&amp; __GNUC__ &lt; 11</span><br><s=
pan> #pragma GCC diagnostic push</span><br><span> #pragma GCC diagnostic ig=
nored &quot;-Wconversion&quot;</span><br><span> #endif</span><br><span>@@ -=
61,7 +62,7 @@</span><br><span>         (hdr-&gt;pcp_cfi_vid &amp; ~OPENVPN_=
8021Q_MASK_VID) | (htons(vid) &amp; OPENVPN_8021Q_MASK_VID);</span><br><spa=
n> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#if defined(__GNUC__) &amp;&amp; __GNUC__ &lt; 11<=
/span><br><span> #pragma GCC diagnostic pop</span><br><span> #endif</span><=
br><span> </span><br><span></span><br></pre><p>To view, visit <a href=3D"ht=
tp://gerrit.openvpn.net/c/openvpn/+/1179?usp=3Demail">change 1179</a>. To u=
nsubscribe, or for help writing mail filters, visit <a href=3D"http://gerri=
t.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://=
schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/1179?usp=3Demail"/><meta itemprop=3D"name" content=3D"=
View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I73c46ac630834a8cf8894aaa2dc=
c429fbedd3db7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1179 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--ydsUsewUz4Y=--

