From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 10 Feb 2026 15:28:45 +0000
In-Reply-To: <gerrit.1770732547000.Ie35099b114c510e55292090c34b9d950b1f03947@...2715...>
References: <gerrit.1770732547000.Ie35099b114c510e55292090c34b9d950b1f03947@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <158787acf2cc325a0cc22a97ff78e489880785e6-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="YDoam7eERpE="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--YDoam7eERpE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/15=
11?usp=3Demail )

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

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie35099b114c510e55292090c34b9d950b1f03947
Gerrit-Change-Number: 1511
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--YDoam7eERpE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1511?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">crypto: Do not claim we will remove support for =
BF-CBC in 2.7<br><br>Change-Id: Ie35099b114c510e55292090c34b9d950b1f03947<b=
r>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Ge=
rt Doering &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.ne=
t/c/openvpn/+/1511<br>Message-Id: &lt;20260210152035.1273-1-gert@...1296...=
&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1223...=
et/msg35565.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>=
---<br>M src/openvpn/crypto.c<br>1 file changed, 1 insertion(+), 1 deletion=
(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c</span><br><span=
>index e3d1fa5..9a4269c 100644</span><br><span>--- a/src/openvpn/crypto.c</=
span><br><span>+++ b/src/openvpn/crypto.c</span><br><span>@@ -863,7 +863,7 =
@@</span><br><span>             &quot; bit (%d bit).  This allows attacks l=
ike SWEET32.  Mitigate by &quot;</span><br><span>             &quot;using a=
 --cipher with a larger block size (e.g. AES-256-CBC). &quot;</span><br><sp=
an>             &quot;Support for these insecure ciphers will be removed in=
 &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            &q=
uot;OpenVPN 2.7.&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            &quot;OpenVPN 2.8.&quot;,</span><br><span>             ciph=
ername, cipher_kt_block_size(ciphername) * 8);</span><br><span>     }</span=
><br><span> }</span><br><span></span><br></pre><p>To view, visit <a href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/1511?usp=3Demail">change 1511</a>. T=
o unsubscribe, or for help writing mail filters, visit <a href=3D"http://ge=
rrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope item=
type=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"ht=
tp://gerrit.openvpn.net/c/openvpn/+/1511?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
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

--YDoam7eERpE=--

