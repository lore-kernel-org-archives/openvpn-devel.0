From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 8 Oct 2025 11:27:15 +0000
In-Reply-To: <gerrit.1757607620000.I73c46ac630834a8cf8894aaa2dcc429fbedd3db7@...2715...>
References: <gerrit.1757607620000.I73c46ac630834a8cf8894aaa2dcc429fbedd3db7@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 max@...2606...
Message-ID: <ea81a1b431ab862b73c4c5719ee5fa01f2ad7df6-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="MpGYv6hIL88="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: vlan: Remove
 -Wconversion override
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, MaxF <max@...2606...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--MpGYv6hIL88=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#12) to the change originally created b=
y flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1179?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: vlan: Remove -Wconversion override
......................................................................

vlan: Remove -Wconversion override

Only Debian 11 (GCC 10) complains about this.
We decided not to add work-arounds for GCC 10
and older and instead accept that they do not
build -Werror clean.

Change-Id: I73c46ac630834a8cf8894aaa2dcc429fbedd3db7
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1179
Message-Id: <20251008105507.9997-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33=
285.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/vlan.c
1 file changed, 0 insertions(+), 9 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/79/1179/12

diff --git a/src/openvpn/vlan.c b/src/openvpn/vlan.c
index 3da470a..a6a6e93 100644
--- a/src/openvpn/vlan.c
+++ b/src/openvpn/vlan.c
@@ -43,11 +43,6 @@
     return ntohs(hdr->pcp_cfi_vid & OPENVPN_8021Q_MASK_VID);
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 /*
  * Set the VLAN Identifier (VID) in an IEEE 802.1Q header.
  *
@@ -61,10 +56,6 @@
         (hdr->pcp_cfi_vid & ~OPENVPN_8021Q_MASK_VID) | (htons(vid) & OPENV=
PN_8021Q_MASK_VID);
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 /*
  * vlan_decapsulate - remove 802.1q header and return VID
  *

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1179?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I73c46ac630834a8cf8894aaa2dcc429fbedd3db7
Gerrit-Change-Number: 1179
Gerrit-PatchSet: 12
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: MaxF <max@...2606...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--MpGYv6hIL88=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #12</strong> to the change originally created by flichtenhe=
ld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1179?usp=3Demail=
">View Change</a></p><p>The following approvals got outdated and were remov=
ed:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">vlan: Remove -Wconversion override<=
br><br>Only Debian 11 (GCC 10) complains about this.<br>We decided not to a=
dd work-arounds for GCC 10<br>and older and instead accept that they do not=
<br>build -Werror clean.<br><br>Change-Id: I73c46ac630834a8cf8894aaa2dcc429=
fbedd3db7<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>A=
cked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit=
.openvpn.net/c/openvpn/+/1179<br>Message-Id: &lt;20251008105507.9997-1-gert=
@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1466...=
urceforge.net/msg33285.html<br>Signed-off-by: Gert Doering &lt;gert@...1726...=
...&gt;<br>---<br>M src/openvpn/vlan.c<br>1 file changed, 0 insertions(+), =
9 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net=
:29418/openvpn refs/changes/79/1179/12</pre><pre style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/vla=
n.c b/src/openvpn/vlan.c</span><br><span>index 3da470a..a6a6e93 100644</spa=
n><br><span>--- a/src/openvpn/vlan.c</span><br><span>+++ b/src/openvpn/vlan=
.c</span><br><span>@@ -43,11 +43,6 @@</span><br><span>     return ntohs(hdr=
-&gt;pcp_cfi_vid &amp; OPENVPN_8021Q_MASK_VID);</span><br><span> }</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(=
__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /*</span><br><span>  *=
 Set the VLAN Identifier (VID) in an IEEE 802.1Q header.</span><br><span>  =
*</span><br><span>@@ -61,10 +56,6 @@</span><br><span>         (hdr-&gt;pcp_=
cfi_vid &amp; ~OPENVPN_8021Q_MASK_VID) | (htons(vid) &amp; OPENVPN_8021Q_MA=
SK_VID);</span><br><span> }</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /*</span><br><span>  =
* vlan_decapsulate - remove 802.1q header and return VID</span><br><span>  =
*</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/1179?usp=3Demail">change 1179</a>. To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn=
.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http=
://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"=
http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/1179?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I73c46ac630834a8cf8894aaa2dc=
c429fbedd3db7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1179 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 12 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: MaxF &lt;max@...2606...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--MpGYv6hIL88=--

