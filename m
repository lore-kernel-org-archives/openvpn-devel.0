From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 21 Nov 2023 19:35:58 +0000
In-Reply-To: <gerrit.1700590714000.Ib3b64b52beed69dc7740f191b0e9a9dc9af5b7f3@...2715...>
References: <gerrit.1700590714000.Ib3b64b52beed69dc7740f191b0e9a9dc9af5b7f3@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <620cbb70fa7781fa1d140a523377557e4cd54656-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="HL4xUDtb5bM="; charset=UTF-8
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

--HL4xUDtb5bM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,=20

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/456?usp=3Demail

to look at the new patch set (#2).


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
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/ssl.c
1 file changed, 6 insertions(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/56/456/2

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
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--HL4xUDtb5bM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos <strong>uploaded patch set #2</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/456?usp=3Demail">View Chang=
e</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">Extend the error message when TLS 1.0 PRF fails<br><br>This error wil=
l probably become more and more common in the future when<br>more and more =
system will drop TLS 1.0 PRF support. We are already seeing<br>people stumb=
ling upon this (see GitHub issue #460)<br><br>The current error messages<br=
><br>  TLS Error: PRF calcuation failed<br>  TLS Error: generate_key_expans=
ion failed<br><br>are not very helpful for people that do not have deep und=
erstanding of TLS or<br>the OpenVPN protocol. Improve a on this message to =
give a normal user a chance<br>to understand that the peer needs to be Open=
VPN 2.6.x or newer.<br><br>Change-Id: Ib3b64b52beed69dc7740f191b0e9a9dc9af5=
b7f3<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>---<br>M src=
/openvpn/ssl.c<br>1 file changed, 6 insertions(+), 1 deletion(-)<br><br></p=
re><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/56/456/2</pre>=
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c</span><br><span>index=
 400230c..9817b2e 100644</span><br><span>--- a/src/openvpn/ssl.c</span><br>=
<span>+++ b/src/openvpn/ssl.c</span><br><span>@@ -1641,7 +1641,12 @@</span>=
<br><span>     {</span><br><span>         if (!generate_key_expansion_openv=
pn_prf(session, &amp;key2))</span><br><span>         {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            msg(D_TLS_ERRORS, &quot;TLS Er=
ror: PRF calcuation failed&quot;);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            msg(D_TLS_ERRORS, &quot;TLS Error: PRF calculati=
on failed. Your system &quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                &quot;might not support the old TLS 1.0 PRF calcu=
lation anymore or &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                &quot;the policy does not allow TLS1 PRF calculation a=
nymore &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          &quot;(e.g. running in FIPS mode). The peer did not announce supp=
ort &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       &quot;for the modern TLS Export feature that replaces the TLS 1.0&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
&quot;RPF (requires OpenVPN 2.6.x or higher)&quot;);</span><br><span>      =
       goto exit;</span><br><span>         }</span><br><span>     }</span><=
br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/456?usp=3Demail">change 456</a>. To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settin=
gs">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/456?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div><=
/div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib3b64b52beed69dc7740f191b0e=
9a9dc9af5b7f3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 456 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--HL4xUDtb5bM=--

