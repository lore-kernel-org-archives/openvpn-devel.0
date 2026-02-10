From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 10 Feb 2026 14:09:09 +0000
References: <gerrit.1770732547000.Ie35099b114c510e55292090c34b9d950b1f03947@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <99f18df4122f970a7dda126db3372b80af0ef32b-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="MnzMLIZ2p58="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: crypto: Do not
 claim we will remove support for BF-CBC in 2.7
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

--MnzMLIZ2p58=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1511?usp=3Demail

to review the following change.


Change subject: crypto: Do not claim we will remove support for BF-CBC in 2=
.7
......................................................................

crypto: Do not claim we will remove support for BF-CBC in 2.7

Change-Id: Ie35099b114c510e55292090c34b9d950b1f03947
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/crypto.c
1 file changed, 1 insertion(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/11/1511/1

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index e3d1fa5..9a4269c 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -863,7 +863,7 @@
             " bit (%d bit).  This allows attacks like SWEET32.  Mitigate b=
y "
             "using a --cipher with a larger block size (e.g. AES-256-CBC).=
 "
             "Support for these insecure ciphers will be removed in "
-            "OpenVPN 2.7.",
+            "OpenVPN 2.8.",
             ciphername, cipher_kt_block_size(ciphername) * 8);
     }
 }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1511?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie35099b114c510e55292090c34b9d950b1f03947
Gerrit-Change-Number: 1511
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--MnzMLIZ2p58=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1511?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">crypto: Do not claim we will remove support=
 for BF-CBC in 2.7<br><br>Change-Id: Ie35099b114c510e55292090c34b9d950b1f03=
947<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>=
M src/openvpn/crypto.c<br>1 file changed, 1 insertion(+), 1 deletion(-)<br>=
<br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn ref=
s/changes/11/1511/1</pre><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;"><span>diff --git a/src/openvpn/crypto.c b/src/openvpn=
/crypto.c</span><br><span>index e3d1fa5..9a4269c 100644</span><br><span>---=
 a/src/openvpn/crypto.c</span><br><span>+++ b/src/openvpn/crypto.c</span><b=
r><span>@@ -863,7 +863,7 @@</span><br><span>             &quot; bit (%d bit=
).  This allows attacks like SWEET32.  Mitigate by &quot;</span><br><span> =
            &quot;using a --cipher with a larger block size (e.g. AES-256-C=
BC). &quot;</span><br><span>             &quot;Support for these insecure c=
iphers will be removed in &quot;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            &quot;OpenVPN 2.7.&quot;,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            &quot;OpenVPN 2.8.&quot;,</span><b=
r><span>             ciphername, cipher_kt_block_size(ciphername) * 8);</sp=
an><br><span>     }</span><br><span> }</span><br><span></span><br></pre><p>=
To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1511?usp=3D=
email">change 1511</a>. To unsubscribe, or for help writing mail filters, v=
isit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a=
>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link it=
emprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1511?usp=3Dema=
il"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie35099b114c510e55292090c34b=
9d950b1f03947 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1511 </div>
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

--MnzMLIZ2p58=--

