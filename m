From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 30 Sep 2025 11:03:19 +0000
In-Reply-To: <gerrit.1757607620000.I73c46ac630834a8cf8894aaa2dcc429fbedd3db7@...2715...>
References: <gerrit.1757607620000.I73c46ac630834a8cf8894aaa2dcc429fbedd3db7@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, max@...2606...
Message-ID: <627679047423a4293a660f34c0e27d2f2127709c-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0/AcDaRb81E="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, MaxF <max@...2606...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0/AcDaRb81E=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello MaxF, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1179?usp=3Demail

to look at the new patch set (#9).

The change is no longer submittable: checks~ChecksSubmitRule is unsatisfied=
 now.


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/79/1179/9

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
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I73c46ac630834a8cf8894aaa2dcc429fbedd3db7
Gerrit-Change-Number: 1179
Gerrit-PatchSet: 9
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: MaxF <max@...2606...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--0/AcDaRb81E=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #9</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1179?usp=3Demail">View C=
hange</a></p><p>The change is no longer submittable: checks~ChecksSubmitRul=
e is unsatisfied now.</p><pre class=3D"blocks" style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;">vlan: Limit -Wconversion override to=
 GCC 10 and older<br><br>Only Debian 11 complains about this. This way we k=
now<br>we can remove this at some point.<br><br>Change-Id: I73c46ac630834a8=
cf8894aaa2dcc429fbedd3db7<br>Signed-off-by: Frank Lichtenheld &lt;frank@...493...=
2641...&gt;<br>---<br>M src/openvpn/vlan.c<br>1 file changed, 3 insertions(=
+), 2 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn=
.net:29418/openvpn refs/changes/79/1179/9</pre><pre style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/=
vlan.c b/src/openvpn/vlan.c</span><br><span>index 3da470a..7a9fdaa 100644</=
span><br><span>--- a/src/openvpn/vlan.c</span><br><span>+++ b/src/openvpn/v=
lan.c</span><br><span>@@ -43,7 +43,8 @@</span><br><span>     return ntohs(h=
dr-&gt;pcp_cfi_vid &amp; OPENVPN_8021Q_MASK_VID);</span><br><span> }</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if define=
d(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+/* old GCC complains about ~OPENVPN_8021Q_MASK_VID being &quo=
t;int&quot; */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if d=
efined(__GNUC__) &amp;&amp; __GNUC__ &lt; 11</span><br><span> #pragma GCC d=
iagnostic push</span><br><span> #pragma GCC diagnostic ignored &quot;-Wconv=
ersion&quot;</span><br><span> #endif</span><br><span>@@ -61,7 +62,7 @@</spa=
n><br><span>         (hdr-&gt;pcp_cfi_vid &amp; ~OPENVPN_8021Q_MASK_VID) | =
(htons(vid) &amp; OPENVPN_8021Q_MASK_VID);</span><br><span> }</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNU=
C__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#if defined(__GNUC__) &amp;&amp; __GNUC__ &lt; 11</span><br><span> #=
pragma GCC diagnostic pop</span><br><span> #endif</span><br><span> </span><=
br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/1179?usp=3Demail">change 1179</a>. To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/sett=
ings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema=
.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sc=
hema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/1179?usp=3Demail"/><meta itemprop=3D"name" content=3D"View C=
hange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I73c46ac630834a8cf8894aaa2dc=
c429fbedd3db7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1179 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 9 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: MaxF &lt;max@...2606...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--0/AcDaRb81E=--

