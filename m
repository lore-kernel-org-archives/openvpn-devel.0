From: "MaxF (Code Review)" <gerrit@...515...>
Date: Wed, 3 Jul 2024 15:37:02 +0000
References: <gerrit.1720021020000.Ibc641388d8016533c94dfef3618376f6dfa91f4e@...2715...>
Reply-To: max@...2606..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <f5ebe4c3e2ac9bfe718df0e21a7986a03b7d3090-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="K9qZoId7Pok="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: mbedtls: Warn if
 --tls-version-min is too low
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--K9qZoId7Pok=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/684?usp=3Demail

to review the following change.


Change subject: mbedtls: Warn if --tls-version-min is too low
......................................................................

mbedtls: Warn if --tls-version-min is too low

Recent versions of mbedtls only support TLS 1.2. When the minimum
version is set to TLS 1.0 or 1.1, log a warning and use 1.2 as the
actual minimum version.

Change-Id: Ibc641388d8016533c94dfef3618376f6dfa91f4e
Signed-off-by: Max Fillinger <maximilian.fillinger@...2507...>
---
M src/openvpn/options.c
1 file changed, 9 insertions(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/84/684/1

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index dbe1425..64e67aa 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -8942,6 +8942,15 @@
             msg(msglevel, "unknown tls-version-min parameter: %s", p[1]);
             goto err;
         }
+
+#ifdef ENABLE_CRYPTO_MBEDTLS
+        if (ver < TLS_VER_1_2)
+        {
+            msg(M_WARN, "--tls-version-min %s is not supported by mbedtls,=
 using 1.2", p[1]);
+            ver =3D TLS_VER_1_2;
+        }
+#endif
+
         options->ssl_flags &=3D
             ~(SSLF_TLS_VERSION_MIN_MASK << SSLF_TLS_VERSION_MIN_SHIFT);
         options->ssl_flags |=3D (ver << SSLF_TLS_VERSION_MIN_SHIFT);

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/684?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ibc641388d8016533c94dfef3618376f6dfa91f4e
Gerrit-Change-Number: 684
Gerrit-PatchSet: 1
Gerrit-Owner: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--K9qZoId7Pok=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>MaxF would like plaisthos and flichtenheld to <strong>review</strong> th=
is change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/684?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">mbedtls: Warn if --tls-version-min is too low<br><br>Recent v=
ersions of mbedtls only support TLS 1.2. When the minimum<br>version is set=
 to TLS 1.0 or 1.1, log a warning and use 1.2 as the<br>actual minimum vers=
ion.<br><br>Change-Id: Ibc641388d8016533c94dfef3618376f6dfa91f4e<br>Signed-=
off-by: Max Fillinger &lt;maximilian.fillinger@...2507...&gt;<br>---<br>M s=
rc/openvpn/options.c<br>1 file changed, 9 insertions(+), 0 deletions(-)<br>=
<br></pre><pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/84/684/=
1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;"><span>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</span>=
<br><span>index dbe1425..64e67aa 100644</span><br><span>--- a/src/openvpn/o=
ptions.c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -89=
42,6 +8942,15 @@</span><br><span>             msg(msglevel, &quot;unknown t=
ls-version-min parameter: %s&quot;, p[1]);</span><br><span>             got=
o err;</span><br><span>         }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifde=
f ENABLE_CRYPTO_MBEDTLS</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        if (ver &lt; TLS_VER_1_2)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            msg(M_WARN, &quot;--tls-version-min %s is not supported=
 by mbedtls, using 1.2&quot;, p[1]);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            ver =3D TLS_VER_1_2;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span>         options-&gt;ssl_flags &amp;=3D</span><br><=
span>             ~(SSLF_TLS_VERSION_MIN_MASK &lt;&lt; SSLF_TLS_VERSION_MIN=
_SHIFT);</span><br><span>         options-&gt;ssl_flags |=3D (ver &lt;&lt; =
SSLF_TLS_VERSION_MIN_SHIFT);</span><br><span></span><br></pre><p>To view, v=
isit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/684?usp=3Demail">chan=
ge 684</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/684?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ibc641388d8016533c94dfef3618=
376f6dfa91f4e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 684 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@...2606...&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--K9qZoId7Pok=--

