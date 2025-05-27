From: "MaxF (Code Review)" <gerrit@...515...>
Date: Tue, 27 May 2025 16:14:00 +0000
In-Reply-To: <gerrit.1747746380000.If5e832866b312a2f8a1ce6b4e00d40e3dcf63681@...2715...>
References: <gerrit.1747746380000.If5e832866b312a2f8a1ce6b4e00d40e3dcf63681@...2715...>
Reply-To: max@...2606..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <3753f9b30e72508b19619d2abbe48c53db6fcaad-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fmbm1XxM+m8="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: mbedtls: Allow TLS
 1.3 if available
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

--fmbm1XxM+m8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF, flichtenheld.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1042?usp=3Demail

to look at the new patch set (#3).


Change subject: mbedtls: Allow TLS 1.3 if available
......................................................................

mbedtls: Allow TLS 1.3 if available

We need mbedtls_ssl_export_keying_material() to support TLS 1.3. The
workaround we use for TLS 1.2 does not work for TLS 1.3.

Change-Id: If5e832866b312a2f8a1ce6b4e00d40e3dcf63681
Signed-off-by: Max Fillinger <maximilian.fillinger@...2507...>
---
M README.mbedtls
M src/openvpn/ssl_mbedtls.c
2 files changed, 13 insertions(+), 6 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/42/1042/3

diff --git a/README.mbedtls b/README.mbedtls
index c4f3924..a1012e9 100644
--- a/README.mbedtls
+++ b/README.mbedtls
@@ -26,5 +26,9 @@

 *************************************************************************

-Mbed TLS 3 has implemented (parts of) the TLS 1.3 protocol, but we have di=
sabled
-support in OpenVPN because the TLS-Exporter function is not yet implemente=
d.
+Mbed TLS 3 has implemented TLS 1.3, but support in OpenVPN requires the
+function mbedtls_ssl_export_keying_material() which is currently not in
+any released version. It is available when building mbed TLS from source
+(mbedtls-3.6 or development branch).
+
+Without this function, only TLS 1.2 is available.
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 0159166..b78439c 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -1048,11 +1048,14 @@
 int
 tls_version_max(void)
 {
-#if defined(MBEDTLS_SSL_PROTO_TLS1_2)
+    /* We need mbedtls_ssl_export_keying_material() to support TLS 1.3. */
+#if defined(MBEDTLS_SSL_PROTO_TLS1_3) && defined(MBEDTLS_SSL_KEYING_MATERI=
AL_EXPORT)
+    return TLS_VER_1_3;
+#elif defined(MBEDTLS_SSL_PROTO_TLS1_2)
     return TLS_VER_1_2;
-#else /* defined(MBEDTLS_SSL_PROTO_TLS1_2) */
-    #error "mbedtls is compiled without support for TLS 1.2."
-#endif /* defined(MBEDTLS_SSL_PROTO_TLS1_2) */
+#else
+    #error mbedtls is compiled without support for TLS 1.2 or 1.3
+#endif
 }

 /**

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1042?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: If5e832866b312a2f8a1ce6b4e00d40e3dcf63681
Gerrit-Change-Number: 1042
Gerrit-PatchSet: 3
Gerrit-Owner: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: MaxF <max@...2606...>
Gerrit-MessageType: newpatchset

--fmbm1XxM+m8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: MaxF, flichtenheld. </p>
<p>MaxF <strong>uploaded patch set #3</strong> to this change.</p><p><a hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/1042?usp=3Demail">View Change</a=
></p><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
">mbedtls: Allow TLS 1.3 if available<br><br>We need mbedtls_ssl_export_key=
ing_material() to support TLS 1.3. The<br>workaround we use for TLS 1.2 doe=
s not work for TLS 1.3.<br><br>Change-Id: If5e832866b312a2f8a1ce6b4e00d40e3=
dcf63681<br>Signed-off-by: Max Fillinger &lt;maximilian.fillinger@...2782...=
.&gt;<br>---<br>M README.mbedtls<br>M src/openvpn/ssl_mbedtls.c<br>2 files =
changed, 13 insertions(+), 6 deletions(-)<br><br></pre><pre style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.o=
penvpn.net:29418/openvpn refs/changes/42/1042/3</pre><pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/README=
.mbedtls b/README.mbedtls</span><br><span>index c4f3924..a1012e9 100644</sp=
an><br><span>--- a/README.mbedtls</span><br><span>+++ b/README.mbedtls</spa=
n><br><span>@@ -26,5 +26,9 @@</span><br><span> </span><br><span> **********=
***************************************************************</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-Mbed TLS 3 has =
implemented (parts of) the TLS 1.3 protocol, but we have disabled</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-support in OpenVPN because the =
TLS-Exporter function is not yet implemented.</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+Mbed TLS 3 has implemented TLS 1.3, but support i=
n OpenVPN requires the</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+function mbedtls_ssl_export_keying_material() which is currently not in<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+any released version=
. It is available when building mbed TLS from source</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+(mbedtls-3.6 or development branch).</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+Without this function, only TLS 1.2 is av=
ailable.</span><br><span>diff --git a/src/openvpn/ssl_mbedtls.c b/src/openv=
pn/ssl_mbedtls.c</span><br><span>index 0159166..b78439c 100644</span><br><s=
pan>--- a/src/openvpn/ssl_mbedtls.c</span><br><span>+++ b/src/openvpn/ssl_m=
bedtls.c</span><br><span>@@ -1048,11 +1048,14 @@</span><br><span> int</span=
><br><span> tls_version_max(void)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#if defined(MBEDTLS_SSL_PROTO_TLS1_2)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* We need mbedtls_ss=
l_export_keying_material() to support TLS 1.3. */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#if defined(MBEDTLS_SSL_PROTO_TLS1_3) &amp;&a=
mp; defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    return TLS_VER_1_3;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#elif defined(MBEDTLS_SSL_PROTO_TLS1_2)</=
span><br><span>     return TLS_VER_1_2;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#else /* defined(MBEDTLS_SSL_PROTO_TLS1_2) */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    #error &quot;mbedtls is compi=
led without support for TLS 1.2.&quot;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#endif /* defined(MBEDTLS_SSL_PROTO_TLS1_2) */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    #error mbedtls is compiled without suppor=
t for TLS 1.2 or 1.3</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#endif</span><br><span> }</span><br><span> </span><br><span> /**</span><br=
><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/1042?usp=3Demail">change 1042</a>. To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settin=
gs">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/1042?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: If5e832866b312a2f8a1ce6b4e00=
d40e3dcf63681 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1042 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@...2606...&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: MaxF &lt;max@...2606...&gt; =
</div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--fmbm1XxM+m8=--

