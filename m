From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 31 Oct 2023 13:06:55 +0000
In-Reply-To: <gerrit.1697562354000.Ia61c467d85d690752011bafcf112e39d5b252aa7@...2715...>
References: <gerrit.1697562354000.Ia61c467d85d690752011bafcf112e39d5b252aa7@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 max@...2606...
Message-ID: <05418189adb975f704e18f29493a5e094cfd98c4-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="NimbPGqn6lE="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Update README.mbedtls
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: MaxF <max@...2606...>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--NimbPGqn6lE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/37=
2?usp=3Demail )

Change subject: Update README.mbedtls
......................................................................

Update README.mbedtls

Change-Id: Ia61c467d85d690752011bafcf112e39d5b252aa7
Signed-off-by: Max Fillinger <max@...2606...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20231025121928.1031109-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27=
295.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M README.mbedtls
1 file changed, 25 insertions(+), 8 deletions(-)




diff --git a/README.mbedtls b/README.mbedtls
index d3466fa..9b75c2b 100644
--- a/README.mbedtls
+++ b/README.mbedtls
@@ -1,13 +1,13 @@
-This version of OpenVPN has mbed TLS support. To enable follow the followi=
ng
-instructions:
+This version of OpenVPN has mbed TLS support. To enable, follow the
+instructions below:

-To Build and Install,
+To build and install,

 	./configure --with-crypto-library=3Dmbedtls
 	make
 	make install

-This version depends on mbed TLS 2.0 (and requires at least 2.0.0).
+This version requires mbed TLS version >=3D 2.0.0 or >=3D 3.2.1.

 *************************************************************************

@@ -16,7 +16,8 @@
 As of mbed TLS 2.17, it can be licensed *only* under the Apache v2.0 licen=
se.
 That license is incompatible with OpenVPN's GPLv2.

-If you wish to distribute OpenVPN linked with mbed TLS, there are two opti=
ons:
+We are currently in the process of resolving this problem, but for now, if=
 you
+wish to distribute OpenVPN linked with mbed TLS, there are two options:

  * Ensure that your case falls under the system library exception in GPLv2=
, or

@@ -24,9 +25,6 @@
    that may be licensed under GPLv2. Unfortunately, this version is
    unsupported and won't receive any more updates.

-If nothing changes about the license situation, mbed TLS support may be
-deprecated in a future release of OpenVPN.
-
 *************************************************************************

 Due to limitations in the mbed TLS library, the following features are mis=
sing
@@ -42,3 +40,22 @@
  * X.509 subject line has a different format than the OpenSSL subject line
  * X.509 certificate export does not work
  * X.509 certificate tracking
+
+*************************************************************************
+
+Mbed TLS 3 supports the TLS 1.3 protocol, but the implementation is not yet
+complete. Therefore, using TLS 1.3 in the mbed TLS build of OpenVPN is not=
 yet
+supported.
+
+Nevertheless, here are some pointers to make it work with mbed TLS 3.5.0:
+
+ * The stock configuration of mbed TLS does not support TLS 1.3. To enable=
 it,
+   uncomment `#define MBEDTLS_SSL_PROTO_TLS1_3` in your mbedtls_config.h b=
efore
+   compiling the library.
+ * An OpenVPN client with mbed TLS cannot connect to a server with OpenSSL
+   using TLS 1.3.
+ * An OpenVPN client with OpenSSL *can* connect to a server using mbed TLS=
 with
+   TLS 1.3, but *only* if `#define MBEDTLS_SSL_TLS1_3_COMPATIBILITY_MODE` =
has
+   been uncommented in mbedtls_config.h.
+
+Note that none of these limitations apply to TLS 1.2.

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/372?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia61c467d85d690752011bafcf112e39d5b252aa7
Gerrit-Change-Number: 372
Gerrit-PatchSet: 9
Gerrit-Owner: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--NimbPGqn6lE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/372?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Update README.mbedtls<br><br>Change-Id: Ia61c4=
67d85d690752011bafcf112e39d5b252aa7<br>Signed-off-by: Max Fillinger &lt;max=
@...2606...&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>=
Message-Id: &lt;20231025121928.1031109-1-frank@...2641...&gt;<br>URL: https=
://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27295.html<b=
r>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M README.mb=
edtls<br>1 file changed, 25 insertions(+), 8 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/README.mbedtls b/README.mbedtls</span><br><span>index d3466=
fa..9b75c2b 100644</span><br><span>--- a/README.mbedtls</span><br><span>+++=
 b/README.mbedtls</span><br><span>@@ -1,13 +1,13 @@</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-This version of OpenVPN has mbed TLS suppor=
t. To enable follow the following</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-instructions:</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+This version of OpenVPN has mbed TLS support. To enable, follow the</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+instructions below:</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-To Bu=
ild and Install,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+To =
build and install,</span><br><span> </span><br><span> 	./configure --with-c=
rypto-library=3Dmbedtls</span><br><span> 	make</span><br><span> 	make insta=
ll</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-T=
his version depends on mbed TLS 2.0 (and requires at least 2.0.0).</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+This version requires mbed T=
LS version &gt;=3D 2.0.0 or &gt;=3D 3.2.1.</span><br><span> </span><br><spa=
n> ************************************************************************=
*</span><br><span> </span><br><span>@@ -16,7 +16,8 @@</span><br><span> As o=
f mbed TLS 2.17, it can be licensed *only* under the Apache v2.0 license.</=
span><br><span> That license is incompatible with OpenVPN&#39;s GPLv2.</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-If you w=
ish to distribute OpenVPN linked with mbed TLS, there are two options:</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+We are currently in the =
process of resolving this problem, but for now, if you</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+wish to distribute OpenVPN linked with m=
bed TLS, there are two options:</span><br><span> </span><br><span>  * Ensur=
e that your case falls under the system library exception in GPLv2, or</spa=
n><br><span> </span><br><span>@@ -24,9 +25,6 @@</span><br><span>    that ma=
y be licensed under GPLv2. Unfortunately, this version is</span><br><span> =
   unsupported and won&#39;t receive any more updates.</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-If nothing changes about=
 the license situation, mbed TLS support may be</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-deprecated in a future release of OpenVPN.</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> **********=
***************************************************************</span><br><=
span> </span><br><span> Due to limitations in the mbed TLS library, the fol=
lowing features are missing</span><br><span>@@ -42,3 +40,22 @@</span><br><s=
pan>  * X.509 subject line has a different format than the OpenSSL subject =
line</span><br><span>  * X.509 certificate export does not work</span><br><=
span>  * X.509 certificate tracking</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+***=
**********************************************************************</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+Mbed TLS 3 supports the TLS 1.3 protocol,=
 but the implementation is not yet</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+complete. Therefore, using TLS 1.3 in the mbed TLS build of =
OpenVPN is not yet</span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
upported.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+Nevertheless, here are some p=
ointers to make it work with mbed TLS 3.5.0:</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * The stock configuration of mbed TLS does not support TLS 1.3. To e=
nable it,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   uncomme=
nt `#define MBEDTLS_SSL_PROTO_TLS1_3` in your mbedtls_config.h before</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+   compiling the library.=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * An OpenVPN clien=
t with mbed TLS cannot connect to a server with OpenSSL</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+   using TLS 1.3.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * An OpenVPN client with OpenSSL *can* c=
onnect to a server using mbed TLS with</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+   TLS 1.3, but *only* if `#define MBEDTLS_SSL_TLS1_3_CO=
MPATIBILITY_MODE` has</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+   been uncommented in mbedtls_config.h.</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+Note that none of these limitations apply to TLS 1.2.</span><br><span><=
/span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/372?usp=3Demail">change 372</a>. To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settin=
gs</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div =
itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/372?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia61c467d85d690752011bafcf11=
2e39d5b252aa7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 372 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 9 </div>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@...2606...&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--NimbPGqn6lE=--

