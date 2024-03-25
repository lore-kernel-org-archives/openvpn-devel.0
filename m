From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 25 Mar 2024 16:43:41 +0000
In-Reply-To: <gerrit.1711123146000.I3c6fd36eb9daee9244d6dc6d9f22de1c5cf9d039@...2715...>
References: <gerrit.1711123146000.I3c6fd36eb9daee9244d6dc6d9f22de1c5cf9d039@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <265ed2abd8d156ab31bb182b44e192413d5ab3db-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/UUg7i2bOrg="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Use snprintf
 instead of sprintf for get_ssl_library_version
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

--/UUg7i2bOrg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/54=
5?usp=3Demail )

Change subject: Use snprintf instead of sprintf for get_ssl_library_version
......................................................................

Use snprintf instead of sprintf for get_ssl_library_version

This is avoid a warning/error (when using -Werror) under current macOS
of sprintf:

   __deprecated_msg("This function is provided for compatibility
   reasons only.  Due to security concerns inherent in the design
   of sprintf(3), it is highly recommended that you use snprintf(3)
   instead.")

Change-Id: I3c6fd36eb9daee9244d6dc6d9f22de1c5cf9d039
Signed-off-by: Arne Schwabe <arne-openvpn@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20240325125052.14135-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28=
458.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/ssl_mbedtls.c
1 file changed, 1 insertion(+), 1 deletion(-)




diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index b44ddd5..0730d25 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -1614,7 +1614,7 @@
 {
     static char mbedtls_version[30];
     unsigned int pv =3D mbedtls_version_get_number();
-    sprintf( mbedtls_version, "mbed TLS %d.%d.%d",
+    snprintf(mbedtls_version, sizeof(mbedtls_version), "mbed TLS %d.%d.%d",
              (pv>>24)&0xff, (pv>>16)&0xff, (pv>>8)&0xff );
     return mbedtls_version;
 }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/545?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3c6fd36eb9daee9244d6dc6d9f22de1c5cf9d039
Gerrit-Change-Number: 545
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--/UUg7i2bOrg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/545?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Use snprintf instead of sprintf for get_ssl_li=
brary_version<br><br>This is avoid a warning/error (when using -Werror) und=
er current macOS<br>of sprintf:<br><br>   __deprecated_msg(&quot;This funct=
ion is provided for compatibility<br>   reasons only.  Due to security conc=
erns inherent in the design<br>   of sprintf(3), it is highly recommended t=
hat you use snprintf(3)<br>   instead.&quot;)<br><br>Change-Id: I3c6fd36eb9=
daee9244d6dc6d9f22de1c5cf9d039<br>Signed-off-by: Arne Schwabe &lt;arne-open=
vpn@...1227...&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@...2641...&gt;<=
br>Message-Id: &lt;20240325125052.14135-1-gert@...1296...&gt;<br>URL: https=
://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28458.html<b=
r>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openv=
pn/ssl_mbedtls.c<br>1 file changed, 1 insertion(+), 1 deletion(-)<br><br></=
pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c</span=
><br><span>index b44ddd5..0730d25 100644</span><br><span>--- a/src/openvpn/=
ssl_mbedtls.c</span><br><span>+++ b/src/openvpn/ssl_mbedtls.c</span><br><sp=
an>@@ -1614,7 +1614,7 @@</span><br><span> {</span><br><span>     static cha=
r mbedtls_version[30];</span><br><span>     unsigned int pv =3D mbedtls_ver=
sion_get_number();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 sprintf( mbedtls_version, &quot;mbed TLS %d.%d.%d&quot;,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    snprintf(mbedtls_version, sizeof(=
mbedtls_version), &quot;mbed TLS %d.%d.%d&quot;,</span><br><span>          =
    (pv&gt;&gt;24)&amp;0xff, (pv&gt;&gt;16)&amp;0xff, (pv&gt;&gt;8)&amp;0xf=
f );</span><br><span>     return mbedtls_version;</span><br><span> }</span>=
<br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/545?usp=3Demail">change 545</a>. To unsubscribe, or for =
help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/setti=
ngs">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/View=
Action"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/545?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3c6fd36eb9daee9244d6dc6d9f2=
2de1c5cf9d039 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 545 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--/UUg7i2bOrg=--

