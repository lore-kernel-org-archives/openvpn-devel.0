From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 9 Jan 2024 11:09:03 +0000
References: <gerrit.1704798536000.Iaef904ee2448dc0b9ad396d3ad9ae21b9dd6281e@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <4f6be5e2fc56379333283583d98e6ceb7fce3d3b-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="MJvaDEJM6tw="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]:
 adjust_payload_max_cbc: Fix Coverity issue "Division or modulo by zero"
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

--MJvaDEJM6tw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/492?usp=3Demail

to review the following change.


Change subject: adjust_payload_max_cbc: Fix Coverity issue "Division or mod=
ulo by zero"
......................................................................

adjust_payload_max_cbc: Fix Coverity issue "Division or modulo by zero"

In error cases cipher_kt_block_size can return 0.
This would lead to a divison by zero in round_down_uint.
By reordering the conditional we can make sure we only
take this path if we have a valid cipher to begin with.

Change-Id: Iaef904ee2448dc0b9ad396d3ad9ae21b9dd6281e
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/mss.c
1 file changed, 4 insertions(+), 7 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/92/492/1

diff --git a/src/openvpn/mss.c b/src/openvpn/mss.c
index 1566c64..797ebf7 100644
--- a/src/openvpn/mss.c
+++ b/src/openvpn/mss.c
@@ -210,13 +210,7 @@
 static inline size_t
 adjust_payload_max_cbc(const struct key_type *kt, size_t target)
 {
-    if (!cipher_kt_mode_cbc(kt->cipher))
-    {
-        /* With stream ciphers (or block cipher in stream modes like CFB, =
AEAD)
-         * we can just use the target as is */
-        return target;
-    }
-    else
+    if (cipher_kt_mode_cbc(kt->cipher))
     {
         /* With CBC we need at least one extra byte for padding and then n=
eed
          * to ensure that the resulting CBC ciphertext length, which is al=
ways
@@ -225,6 +219,9 @@
         target =3D round_down_size(target, block_size);
         return target - 1;
     }
+    /* With stream ciphers (or block cipher in stream modes like CFB, AEAD)
+     * we can just use the target as is */
+    return target;
 }

 static size_t

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/492?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iaef904ee2448dc0b9ad396d3ad9ae21b9dd6281e
Gerrit-Change-Number: 492
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--MJvaDEJM6tw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/492?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">adjust_payload_max_cbc: Fix Coverity issue &quot;Division or =
modulo by zero&quot;<br><br>In error cases cipher_kt_block_size can return =
0.<br>This would lead to a divison by zero in round_down_uint.<br>By reorde=
ring the conditional we can make sure we only<br>take this path if we have =
a valid cipher to begin with.<br><br>Change-Id: Iaef904ee2448dc0b9ad396d3ad=
9ae21b9dd6281e<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;=
<br>---<br>M src/openvpn/mss.c<br>1 file changed, 4 insertions(+), 7 deleti=
ons(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/chang=
es/92/492/1</pre><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;"><span>diff --git a/src/openvpn/mss.c b/src/openvpn/mss.c</spa=
n><br><span>index 1566c64..797ebf7 100644</span><br><span>--- a/src/openvpn=
/mss.c</span><br><span>+++ b/src/openvpn/mss.c</span><br><span>@@ -210,13 +=
210,7 @@</span><br><span> static inline size_t</span><br><span> adjust_payl=
oad_max_cbc(const struct key_type *kt, size_t target)</span><br><span> {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!cipher_kt_mode_=
cbc(kt-&gt;cipher))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* With st=
ream ciphers (or block cipher in stream modes like CFB, AEAD)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-         * we can just use the targ=
et as is */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        re=
turn target;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (cipher_kt_mode_cbc(kt-&gt;ci=
pher))</span><br><span>     {</span><br><span>         /* With CBC we need =
at least one extra byte for padding and then need</span><br><span>         =
 * to ensure that the resulting CBC ciphertext length, which is always</spa=
n><br><span>@@ -225,6 +219,9 @@</span><br><span>         target =3D round_d=
own_size(target, block_size);</span><br><span>         return target - 1;</=
span><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    /* With stream ciphers (or block cipher in stream modes like CFB, AEA=
D)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * we can jus=
t use the target as is */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    return target;</span><br><span> }</span><br><span> </span><br><sp=
an> static size_t</span><br><span></span><br></pre><p>To view, visit <a hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/492?usp=3Demail">change 492</a>.=
 To unsubscribe, or for help writing mail filters, visit <a href=3D"http://=
gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"ht=
tp://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/492?usp=3Demail"/><meta itemprop=3D"name" conte=
nt=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iaef904ee2448dc0b9ad396d3ad9=
ae21b9dd6281e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 492 </div>
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


--MJvaDEJM6tw=--

