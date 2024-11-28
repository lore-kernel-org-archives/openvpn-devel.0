From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 28 Nov 2024 12:34:12 +0000
In-Reply-To: <gerrit.1732795471000.Ifad21a2841e97e910775f3618ddac1c483d74b65@...2715...>
References: <gerrit.1732795471000.Ifad21a2841e97e910775f3618ddac1c483d74b65@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <ff39ca1fa4b33ab06dab0feff9c994aa411486e9-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="CxgYjxMSRS4="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Various typo fixes
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

--CxgYjxMSRS4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/82=
2?usp=3Demail )

Change subject: Various typo fixes
......................................................................

Various typo fixes

This collects some minor typo fixes that are not
worth each their own commit.

Fixes: OpenVPN/openvpn#644
Fixes: OpenVPN/openvpn#442

Change-Id: Ifad21a2841e97e910775f3618ddac1c483d74b65
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20241128123016.10444-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29=
956.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M doc/man-sections/connection-profiles.rst
M sample/sample-config-files/server.conf
M src/openvpn/options.c
3 files changed, 5 insertions(+), 5 deletions(-)




diff --git a/doc/man-sections/connection-profiles.rst b/doc/man-sections/co=
nnection-profiles.rst
index 520bbef..767ff3a 100644
--- a/doc/man-sections/connection-profiles.rst
+++ b/doc/man-sections/connection-profiles.rst
@@ -6,7 +6,7 @@
 options which are related to specific ``--remote`` options.  For these
 use cases, connection profiles are the solution.

-By enacpulating the ``--remote`` option and related options within
+By encapsulating the ``--remote`` option and related options within
 ``<connection>`` and ``</connection>``, these options are handled as a
 group.

diff --git a/sample/sample-config-files/server.conf b/sample/sample-config-=
files/server.conf
index 48716a0..f6d9e65 100644
--- a/sample/sample-config-files/server.conf
+++ b/sample/sample-config-files/server.conf
@@ -199,7 +199,7 @@
 # all clients to redirect their default
 # network gateway through the VPN, causing
 # all IP traffic such as web browsing and
-# and DNS lookups to go through the VPN
+# DNS lookups to go through the VPN
 # (The OpenVPN server machine may need to NAT
 # or bridge the TUN/TAP interface to the internet
 # in order for this to work properly).
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 043b240..d8dd518 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -879,7 +879,7 @@
     o->pkcs11_pin_cache_period =3D -1;
 #endif                  /* ENABLE_PKCS11 */

-/* P2MP server context features */
+    /* P2MP server context features */
     o->auth_token_generate =3D false;

     /* Set default --tmp-dir */
@@ -2966,7 +2966,7 @@
         if (options->pkcs12_file)
         {
 #ifdef ENABLE_CRYPTO_MBEDTLS
-            msg(M_USAGE, "Parameter --pkcs12 cannot be used with the mbed =
TLS version version of OpenVPN.");
+            msg(M_USAGE, "Parameter --pkcs12 cannot be used with the mbed =
TLS version of OpenVPN.");
 #else
             if (options->ca_path)
             {
@@ -2995,7 +2995,7 @@
 #ifdef ENABLE_CRYPTO_MBEDTLS
             if (options->ca_path)
             {
-                msg(M_USAGE, "Parameter --capath cannot be used with the m=
bed TLS version version of OpenVPN.");
+                msg(M_USAGE, "Parameter --capath cannot be used with the m=
bed TLS version of OpenVPN.");
             }
 #endif  /* ifdef ENABLE_CRYPTO_MBEDTLS */
             if (pull)

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/822?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ifad21a2841e97e910775f3618ddac1c483d74b65
Gerrit-Change-Number: 822
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--CxgYjxMSRS4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/822?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Various typo fixes<br><br>This collects some m=
inor typo fixes that are not<br>worth each their own commit.<br><br>Fixes: =
OpenVPN/openvpn#644<br>Fixes: OpenVPN/openvpn#442<br><br>Change-Id: Ifad21a=
2841e97e910775f3618ddac1c483d74b65<br>Signed-off-by: Frank Lichtenheld &lt;=
frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>M=
essage-Id: &lt;20241128123016.10444-1-gert@...1296...&gt;<br>URL: https://w=
ww.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29956.html<br>Si=
gned-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M doc/man-secti=
ons/connection-profiles.rst<br>M sample/sample-config-files/server.conf<br>=
M src/openvpn/options.c<br>3 files changed, 5 insertions(+), 5 deletions(-)=
<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/doc/man-sections/connection-profiles.rst b/doc/man-sections=
/connection-profiles.rst</span><br><span>index 520bbef..767ff3a 100644</spa=
n><br><span>--- a/doc/man-sections/connection-profiles.rst</span><br><span>=
+++ b/doc/man-sections/connection-profiles.rst</span><br><span>@@ -6,7 +6,7=
 @@</span><br><span> options which are related to specific ``--remote`` opt=
ions.  For these</span><br><span> use cases, connection profiles are the so=
lution.</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-By enacpulating the ``--remote`` option and related options within</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+By encapsulating the ``-=
-remote`` option and related options within</span><br><span> ``&lt;connecti=
on&gt;`` and ``&lt;/connection&gt;``, these options are handled as a</span>=
<br><span> group.</span><br><span> </span><br><span>diff --git a/sample/sam=
ple-config-files/server.conf b/sample/sample-config-files/server.conf</span=
><br><span>index 48716a0..f6d9e65 100644</span><br><span>--- a/sample/sampl=
e-config-files/server.conf</span><br><span>+++ b/sample/sample-config-files=
/server.conf</span><br><span>@@ -199,7 +199,7 @@</span><br><span> # all cli=
ents to redirect their default</span><br><span> # network gateway through t=
he VPN, causing</span><br><span> # all IP traffic such as web browsing and<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-# and DNS lookups to g=
o through the VPN</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# =
DNS lookups to go through the VPN</span><br><span> # (The OpenVPN server ma=
chine may need to NAT</span><br><span> # or bridge the TUN/TAP interface to=
 the internet</span><br><span> # in order for this to work properly).</span=
><br><span>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</span=
><br><span>index 043b240..d8dd518 100644</span><br><span>--- a/src/openvpn/=
options.c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -8=
79,7 +879,7 @@</span><br><span>     o-&gt;pkcs11_pin_cache_period =3D -1;</=
span><br><span> #endif                  /* ENABLE_PKCS11 */</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* P2MP server cont=
ext features */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/* P2MP server context features */</span><br><span>     o-&gt;auth_token_ge=
nerate =3D false;</span><br><span> </span><br><span>     /* Set default --t=
mp-dir */</span><br><span>@@ -2966,7 +2966,7 @@</span><br><span>         if=
 (options-&gt;pkcs12_file)</span><br><span>         {</span><br><span> #ifd=
ef ENABLE_CRYPTO_MBEDTLS</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            msg(M_USAGE, &quot;Parameter --pkcs12 cannot be used with th=
e mbed TLS version version of OpenVPN.&quot;);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            msg(M_USAGE, &quot;Parameter --pkcs1=
2 cannot be used with the mbed TLS version of OpenVPN.&quot;);</span><br><s=
pan> #else</span><br><span>             if (options-&gt;ca_path)</span><br>=
<span>             {</span><br><span>@@ -2995,7 +2995,7 @@</span><br><span>=
 #ifdef ENABLE_CRYPTO_MBEDTLS</span><br><span>             if (options-&gt;=
ca_path)</span><br><span>             {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                msg(M_USAGE, &quot;Parameter --capath can=
not be used with the mbed TLS version version of OpenVPN.&quot;);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                msg(M_USAGE, =
&quot;Parameter --capath cannot be used with the mbed TLS version of OpenVP=
N.&quot;);</span><br><span>             }</span><br><span> #endif  /* ifdef=
 ENABLE_CRYPTO_MBEDTLS */</span><br><span>             if (pull)</span><br>=
<span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/822?usp=3Demail">change 822</a>. To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings"=
>settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage=
"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewActi=
on"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/82=
2?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifad21a2841e97e910775f3618dd=
ac1c483d74b65 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 822 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--CxgYjxMSRS4=--

