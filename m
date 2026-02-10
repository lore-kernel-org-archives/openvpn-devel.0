From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 10 Feb 2026 15:28:43 +0000
In-Reply-To: <gerrit.1770732547000.Ie35099b114c510e55292090c34b9d950b1f03947@...2715...>
References: <gerrit.1770732547000.Ie35099b114c510e55292090c34b9d950b1f03947@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <158787acf2cc325a0cc22a97ff78e489880785e6-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="rEZOr4LGong="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--rEZOr4LGong=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1511?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: crypto: Do not claim we will remove support for BF-CBC in 2=
.7
......................................................................

crypto: Do not claim we will remove support for BF-CBC in 2.7

Change-Id: Ie35099b114c510e55292090c34b9d950b1f03947
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1511
Message-Id: <20260210152035.1273-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
565.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/crypto.c
1 file changed, 1 insertion(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/11/1511/2

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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie35099b114c510e55292090c34b9d950b1f03947
Gerrit-Change-Number: 1511
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--rEZOr4LGong=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1511?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">crypto: Do not claim we will remove=
 support for BF-CBC in 2.7<br><br>Change-Id: Ie35099b114c510e55292090c34b9d=
950b1f03947<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br=
>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerr=
it.openvpn.net/c/openvpn/+/1511<br>Message-Id: &lt;20260210152035.1273-1-ge=
rt@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1199...=
sourceforge.net/msg35565.html<br>Signed-off-by: Gert Doering &lt;gert@...1711...=
96...&gt;<br>---<br>M src/openvpn/crypto.c<br>1 file changed, 1 insertion(+=
), 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.n=
et:29418/openvpn refs/changes/11/1511/2</pre><pre style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/cr=
ypto.c b/src/openvpn/crypto.c</span><br><span>index e3d1fa5..9a4269c 100644=
</span><br><span>--- a/src/openvpn/crypto.c</span><br><span>+++ b/src/openv=
pn/crypto.c</span><br><span>@@ -863,7 +863,7 @@</span><br><span>           =
  &quot; bit (%d bit).  This allows attacks like SWEET32.  Mitigate by &quo=
t;</span><br><span>             &quot;using a --cipher with a larger block =
size (e.g. AES-256-CBC). &quot;</span><br><span>             &quot;Support =
for these insecure ciphers will be removed in &quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            &quot;OpenVPN 2.7.&quot;,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;OpenVPN=
 2.8.&quot;,</span><br><span>             ciphername, cipher_kt_block_size(=
ciphername) * 8);</span><br><span>     }</span><br><span> }</span><br><span=
></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/1511?usp=3Demail">change 1511</a>. To unsubscribe, or for help wr=
iting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=
=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org=
/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/1511?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie35099b114c510e55292090c34b=
9d950b1f03947 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1511 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--rEZOr4LGong=--

