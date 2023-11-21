From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 21 Nov 2023 18:18:36 +0000
References: <gerrit.1700590714000.Ib3b64b52beed69dc7740f191b0e9a9dc9af5b7f3@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <7a28bedac4ce2e50fb3c3504c97b7fd91f6cddd3-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="pdxoC7yxKp8="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Extend the error
 message when TLS 1.0 PRF fails
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--pdxoC7yxKp8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/456?usp=3Demail

to review the following change.


Change subject: Extend the error message when TLS 1.0 PRF fails
......................................................................

Extend the error message when TLS 1.0 PRF fails

This error will probably become more and more common in the future when
more and more system will drop TLS 1.0 PRF support. We are already seeing
people stumbling upon this (see GitHub issue #460)

The current error messages

  TLS Error: PRF calcuation failed
  TLS Error: generate_key_expansion failed

are not very helpful for people that do not have deep understanding of TLS =
or
the OpenVPN protocol. Improve a on this message to give a normal user a cha=
nce
to understand that the peer needs to be OpenVPN 2.6.x or newer.

Change-Id: Ib3b64b52beed69dc7740f191b0e9a9dc9af5b7f3
---
M src/openvpn/ssl.c
1 file changed, 6 insertions(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/56/456/1

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 400230c..9817b2e 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1641,7 +1641,12 @@
     {
         if (!generate_key_expansion_openvpn_prf(session, &key2))
         {
-            msg(D_TLS_ERRORS, "TLS Error: PRF calcuation failed");
+            msg(D_TLS_ERRORS, "TLS Error: PRF calculation failed. Your sys=
tem "
+                "might not support the old TLS 1.0 PRF calculation anymore=
 or "
+                "the policy does not allow TLS1 PRF calculation anymore "
+                "(e.g. running in FIPS mode). The peer did not announce su=
pport "
+                "for the modern TLS Export feature that replaces the TLS 1=
.0"
+                "RPF (requires OpenVPN 2.6.x or higher)");
             goto exit;
         }
     }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/456?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib3b64b52beed69dc7740f191b0e9a9dc9af5b7f3
Gerrit-Change-Number: 456
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--pdxoC7yxKp8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/456?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Extend the error message when TLS 1.0 PRF fails<br><br>This e=
rror will probably become more and more common in the future when<br>more a=
nd more system will drop TLS 1.0 PRF support. We are already seeing<br>peop=
le stumbling upon this (see GitHub issue #460)<br><br>The current error mes=
sages<br><br>  TLS Error: PRF calcuation failed<br>  TLS Error: generate_ke=
y_expansion failed<br><br>are not very helpful for people that do not have =
deep understanding of TLS or<br>the OpenVPN protocol. Improve a on this mes=
sage to give a normal user a chance<br>to understand that the peer needs to=
 be OpenVPN 2.6.x or newer.<br><br>Change-Id: Ib3b64b52beed69dc7740f191b0e9=
a9dc9af5b7f3<br>---<br>M src/openvpn/ssl.c<br>1 file changed, 6 insertions(=
+), 1 deletion(-)<br><br></pre><pre style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn=
 refs/changes/56/456/1</pre><pre style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl.c b/src/openvpn=
/ssl.c</span><br><span>index 400230c..9817b2e 100644</span><br><span>--- a/=
src/openvpn/ssl.c</span><br><span>+++ b/src/openvpn/ssl.c</span><br><span>@=
@ -1641,7 +1641,12 @@</span><br><span>     {</span><br><span>         if (!=
generate_key_expansion_openvpn_prf(session, &amp;key2))</span><br><span>   =
      {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ms=
g(D_TLS_ERRORS, &quot;TLS Error: PRF calcuation failed&quot;);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            msg(D_TLS_ERRORS, &q=
uot;TLS Error: PRF calculation failed. Your system &quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                &quot;might not suppo=
rt the old TLS 1.0 PRF calculation anymore or &quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                &quot;the policy does not=
 allow TLS1 PRF calculation anymore &quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                &quot;(e.g. running in FIPS mode). T=
he peer did not announce support &quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                &quot;for the modern TLS Export feature=
 that replaces the TLS 1.0&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                &quot;RPF (requires OpenVPN 2.6.x or higher)&q=
uot;);</span><br><span>             goto exit;</span><br><span>         }</=
span><br><span>     }</span><br><span></span><br></pre><p>To view, visit <a=
 href=3D"http://gerrit.openvpn.net/c/openvpn/+/456?usp=3Demail">change 456<=
/a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
p://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/456?usp=3Demail"/><meta itemprop=3D"name" c=
ontent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib3b64b52beed69dc7740f191b0e=
9a9dc9af5b7f3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 456 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--pdxoC7yxKp8=--

