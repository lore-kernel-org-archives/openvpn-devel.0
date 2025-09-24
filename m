From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 24 Sep 2025 14:34:50 +0000
In-Reply-To: <gerrit.1757607620000.I73c46ac630834a8cf8894aaa2dcc429fbedd3db7@...2715...>
References: <gerrit.1757607620000.I73c46ac630834a8cf8894aaa2dcc429fbedd3db7@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <6b08ea42d39479ebbffada068b6abf0f4c552c9a-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="qddSXFQzCdY="; charset=UTF-8
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

--qddSXFQzCdY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1179?usp=3Demail

to look at the new patch set (#8).


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/79/1179/8

diff --git a/src/openvpn/vlan.c b/src/openvpn/vlan.c
index 3da470a..7a9fdaa 100644
--- a/src/openvpn/vlan.c
+++ b/src/openvpn/vlan.c
@@ -43,7 +43,8 @@
     return ntohs(hdr->pcp_cfi_vid & OPENVPN_8021Q_MASK_VID);
 }

-#if defined(__GNUC__) || defined(__clang__)
+/* old GCC complains about ~OPENVPN_8021Q_MASK_VID being "int" */
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
Gerrit-PatchSet: 8
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newpatchset

--qddSXFQzCdY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #8</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1179?usp=3Demail">View C=
hange</a></p><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">vlan: Limit -Wconversion override to GCC 10 and older<br><br>Only=
 Debian 11 complains about this. This way we know<br>we can remove this at =
some point.<br><br>Change-Id: I73c46ac630834a8cf8894aaa2dcc429fbedd3db7<br>=
Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/o=
penvpn/vlan.c<br>1 file changed, 3 insertions(+), 2 deletions(-)<br><br></p=
re><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/79/1179/8</pre=
><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><s=
pan>diff --git a/src/openvpn/vlan.c b/src/openvpn/vlan.c</span><br><span>in=
dex 3da470a..7a9fdaa 100644</span><br><span>--- a/src/openvpn/vlan.c</span>=
<br><span>+++ b/src/openvpn/vlan.c</span><br><span>@@ -43,7 +43,8 @@</span>=
<br><span>     return ntohs(hdr-&gt;pcp_cfi_vid &amp; OPENVPN_8021Q_MASK_VI=
D);</span><br><span> }</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+/* old GCC complains about ~OPEN=
VPN_8021Q_MASK_VID being &quot;int&quot; */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#if defined(__GNUC__) &amp;&amp; __GNUC__ &lt; 11</=
span><br><span> #pragma GCC diagnostic push</span><br><span> #pragma GCC di=
agnostic ignored &quot;-Wconversion&quot;</span><br><span> #endif</span><br=
><span>@@ -61,7 +62,7 @@</span><br><span>         (hdr-&gt;pcp_cfi_vid &amp=
; ~OPENVPN_8021Q_MASK_VID) | (htons(vid) &amp; OPENVPN_8021Q_MASK_VID);</sp=
an><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) &amp;&amp; __GNUC=
__ &lt; 11</span><br><span> #pragma GCC diagnostic pop</span><br><span> #en=
dif</span><br><span> </span><br><span></span><br></pre><p>To view, visit <a=
 href=3D"http://gerrit.openvpn.net/c/openvpn/+/1179?usp=3Demail">change 117=
9</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"h=
ttp://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1179?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I73c46ac630834a8cf8894aaa2dc=
c429fbedd3db7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1179 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 8 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--qddSXFQzCdY=--

