From: "MaxF (Code Review)" <gerrit@...515...>
Date: Tue, 17 Oct 2023 17:06:01 +0000
References: <gerrit.1697562354000.Ia61c467d85d690752011bafcf112e39d5b252aa7@...2715...>
Reply-To: max@...2606..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <25fd60a859c3ead3d8e71b6658f6eeae145a40be-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mlD6Gw7pAGQ="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Update README.mbedtls
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

--mlD6Gw7pAGQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/372?usp=3Demail

to review the following change.


Change subject: Update README.mbedtls
......................................................................

Update README.mbedtls

Change-Id: Ia61c467d85d690752011bafcf112e39d5b252aa7
Signed-off-by: Max Fillinger <max@...2606...>
---
M README.mbedtls
1 file changed, 27 insertions(+), 8 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/72/372/1

diff --git a/README.mbedtls b/README.mbedtls
index d3466fa..f6ebafa 100644
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
+This version requires mbed TLS version >=3D 2.16.12 or >=3D 3.2.1.

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
@@ -42,3 +40,24 @@
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
+Nevertheless, here are some pointers to make it work with mbed TLS 3.4.1:
+
+ * The stock configuration of mbed TLS does not support TLS 1.3. To enable=
 it,
+   uncomment `MBEDTLS_SSL_PROTO_TLS1_3` in your mbedtls_config.h before
+   compiling the library.
+ * The server cannot speak both TLS 1.2 and TLS 1.3. Run the server with t=
he
+   option `--tls-version-min 1.3` to ensure that it speaks only TLS 1.3.
+ * An OpenVPN client with mbed TLS cannot connect to a server with OpenSSL
+   using TLS 1.3.
+ * An OpenVPN client with OpenSSL *can* connect to a server using mbed TLS=
 with
+   TLS 1.3, but *only* if `MBEDTLS_SSL_TLS1_3_COMPATIBILITY_MODE` has been
+   uncommented in mbedtls_config.h.
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
Gerrit-PatchSet: 1
Gerrit-Owner: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--mlD6Gw7pAGQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>MaxF would like plaisthos and flichtenheld to <strong>review</strong> th=
is change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/372?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Update README.mbedtls<br><br>Change-Id: Ia61c467d85d690752011=
bafcf112e39d5b252aa7<br>Signed-off-by: Max Fillinger &lt;max@...2606...&gt;=
<br>---<br>M README.mbedtls<br>1 file changed, 27 insertions(+), 8 deletion=
s(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes=
/72/372/1</pre><pre style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;"><span>diff --git a/README.mbedtls b/README.mbedtls</span><br><s=
pan>index d3466fa..f6ebafa 100644</span><br><span>--- a/README.mbedtls</spa=
n><br><span>+++ b/README.mbedtls</span><br><span>@@ -1,13 +1,13 @@</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-This version of OpenVPN has mb=
ed TLS support. To enable follow the following</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-instructions:</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+This version of OpenVPN has mbed TLS support. To enable,=
 follow the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+instruct=
ions below:</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-To Build and Install,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+To build and install,</span><br><span> </span><br><span> 	./confi=
gure --with-crypto-library=3Dmbedtls</span><br><span> 	make</span><br><span=
> 	make install</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-This version depends on mbed TLS 2.0 (and requires at least 2.0=
.0).</span><br><span style=3D"color: hsl(120, 100%, 40%);">+This version re=
quires mbed TLS version &gt;=3D 2.16.12 or &gt;=3D 3.2.1.</span><br><span> =
</span><br><span> *********************************************************=
****************</span><br><span> </span><br><span>@@ -16,7 +16,8 @@</span>=
<br><span> As of mbed TLS 2.17, it can be licensed *only* under the Apache =
v2.0 license.</span><br><span> That license is incompatible with OpenVPN&#3=
9;s GPLv2.</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-If you wish to distribute OpenVPN linked with mbed TLS, there are tw=
o options:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+We are cu=
rrently in the process of resolving this problem, but for now, if you</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+wish to distribute OpenVP=
N linked with mbed TLS, there are two options:</span><br><span> </span><br>=
<span>  * Ensure that your case falls under the system library exception in=
 GPLv2, or</span><br><span> </span><br><span>@@ -24,9 +25,6 @@</span><br><s=
pan>    that may be licensed under GPLv2. Unfortunately, this version is</s=
pan><br><span>    unsupported and won&#39;t receive any more updates.</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-If nothin=
g changes about the license situation, mbed TLS support may be</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-deprecated in a future release of =
OpenVPN.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan> **********************************************************************=
***</span><br><span> </span><br><span> Due to limitations in the mbed TLS l=
ibrary, the following features are missing</span><br><span>@@ -42,3 +40,24 =
@@</span><br><span>  * X.509 subject line has a different format than the O=
penSSL subject line</span><br><span>  * X.509 certificate export does not w=
ork</span><br><span>  * X.509 certificate tracking</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+***************************************************************=
**********</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+Mbed TLS 3 supports the TLS =
1.3 protocol, but the implementation is not yet</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+complete. Therefore, using TLS 1.3 in the mbed =
TLS build of OpenVPN is not yet</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+supported.</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Nevertheless, he=
re are some pointers to make it work with mbed TLS 3.4.1:</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * The stock configuration of mbed TLS does not support =
TLS 1.3. To enable it,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+   uncomment `MBEDTLS_SSL_PROTO_TLS1_3` in your mbedtls_config.h before<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+   compiling the lib=
rary.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * The server =
cannot speak both TLS 1.2 and TLS 1.3. Run the server with the</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+   option `--tls-version-min 1.3=
` to ensure that it speaks only TLS 1.3.</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * An OpenVPN client with mbed TLS cannot connect to a=
 server with OpenSSL</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+   using TLS 1.3.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* An OpenVPN client with OpenSSL *can* connect to a server using mbed TLS w=
ith</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   TLS 1.3, but =
*only* if `MBEDTLS_SSL_TLS1_3_COMPATIBILITY_MODE` has been</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+   uncommented in mbedtls_config.h.<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+Note that none of these limitations app=
ly to TLS 1.2.</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/372?usp=3Demail">change 372</a>. =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/372?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia61c467d85d690752011bafcf11=
2e39d5b252aa7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 372 </div>
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


--mlD6Gw7pAGQ=--

