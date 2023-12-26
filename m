From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 26 Dec 2023 19:41:17 +0000
In-Reply-To: <gerrit.1700590714000.Ib3b64b52beed69dc7740f191b0e9a9dc9af5b7f3@...2715...>
References: <gerrit.1700590714000.Ib3b64b52beed69dc7740f191b0e9a9dc9af5b7f3@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <2f3aa975592c2f167ff8906b20ea1f9faed9908a-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="vrzr/1z6T5A="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--vrzr/1z6T5A=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/45=
6?usp=3Demail )

Change subject: Extend the error message when TLS 1.0 PRF fails
......................................................................

Extend the error message when TLS 1.0 PRF fails

This error will probably become more and more common in the future when
more and more systems will drop TLS 1.0 PRF support. We are already
seeing people stumbling upon this (see GitHub issue #460)

The current error messages

  TLS Error: PRF calcuation failed
  TLS Error: generate_key_expansion failed

are not very helpful for people that do not have deep understanding
of TLS or the OpenVPN protocol. Improve this message to give a normal
user a chance to understand that the peer needs to be OpenVPN 2.6.x or
newer.

Change-Id: Ib3b64b52beed69dc7740f191b0e9a9dc9af5b7f3
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20231213105308.121460-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27=
796.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/ssl.c
1 file changed, 6 insertions(+), 1 deletion(-)




diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 6eddb68..7597412 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1477,7 +1477,12 @@
     {
         if (!generate_key_expansion_openvpn_prf(session, &key2))
         {
-            msg(D_TLS_ERRORS, "TLS Error: PRF calcuation failed");
+            msg(D_TLS_ERRORS, "TLS Error: PRF calculation failed. Your sys=
tem "
+                "might not support the old TLS 1.0 PRF calculation anymore=
 or "
+                "the policy does not allow it (e.g. running in FIPS mode).=
 "
+                "The peer did not announce support for the modern TLS Expo=
rt "
+                "feature that replaces the TLS 1.0 PRF (requires OpenVPN "
+                "2.6.x or higher)");
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
Gerrit-PatchSet: 9
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--vrzr/1z6T5A=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/456?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Extend the error message when TLS 1.0 PRF fail=
s<br><br>This error will probably become more and more common in the future=
 when<br>more and more systems will drop TLS 1.0 PRF support. We are alread=
y<br>seeing people stumbling upon this (see GitHub issue #460)<br><br>The c=
urrent error messages<br><br>  TLS Error: PRF calcuation failed<br>  TLS Er=
ror: generate_key_expansion failed<br><br>are not very helpful for people t=
hat do not have deep understanding<br>of TLS or the OpenVPN protocol. Impro=
ve this message to give a normal<br>user a chance to understand that the pe=
er needs to be OpenVPN 2.6.x or<br>newer.<br><br>Change-Id: Ib3b64b52beed69=
dc7740f191b0e9a9dc9af5b7f3<br>Signed-off-by: Arne Schwabe &lt;arne@...2639...=
..&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Message-I=
d: &lt;20231213105308.121460-1-frank@...2641...&gt;<br>URL: https://www.mai=
l-archive.com/openvpn-devel@lists.sourceforge.net/msg27796.html<br>Signed-o=
ff-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/ssl.c<b=
r>1 file changed, 6 insertions(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c</span><br><span>index=
 6eddb68..7597412 100644</span><br><span>--- a/src/openvpn/ssl.c</span><br>=
<span>+++ b/src/openvpn/ssl.c</span><br><span>@@ -1477,7 +1477,12 @@</span>=
<br><span>     {</span><br><span>         if (!generate_key_expansion_openv=
pn_prf(session, &amp;key2))</span><br><span>         {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            msg(D_TLS_ERRORS, &quot;TLS Er=
ror: PRF calcuation failed&quot;);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            msg(D_TLS_ERRORS, &quot;TLS Error: PRF calculati=
on failed. Your system &quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                &quot;might not support the old TLS 1.0 PRF calcu=
lation anymore or &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                &quot;the policy does not allow it (e.g. running in FI=
PS mode). &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             &quot;The peer did not announce support for the modern TLS Exp=
ort &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       &quot;feature that replaces the TLS 1.0 PRF (requires OpenVPN &quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                &qu=
ot;2.6.x or higher)&quot;);</span><br><span>             goto exit;</span><=
br><span>         }</span><br><span>     }</span><br><span></span><br></pre=
><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/456?usp=
=3Demail">change 456</a>. To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div=
 itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/456?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib3b64b52beed69dc7740f191b0e=
9a9dc9af5b7f3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 456 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 9 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--vrzr/1z6T5A=--

