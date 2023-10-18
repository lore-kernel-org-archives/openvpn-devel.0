From: "MaxF (Code Review)" <gerrit@...515...>
Date: Wed, 18 Oct 2023 16:58:06 +0000
In-Reply-To: <gerrit.1697562354000.Ia61c467d85d690752011bafcf112e39d5b252aa7@...2715...>
References: <gerrit.1697562354000.Ia61c467d85d690752011bafcf112e39d5b252aa7@...2715...>
Reply-To: max@...2606..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <75f11c5b1dfe60b5b2f56d3535858f05f8be8302-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+g3XDkiIYSg="; charset=UTF-8
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

--+g3XDkiIYSg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF, flichtenheld, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/372?usp=3Demail

to look at the new patch set (#3).

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld

The change is no longer submittable: Code-Review and checks~ChecksSubmitRul=
e are unsatisfied now.


Change subject: Update README.mbedtls
......................................................................

Update README.mbedtls

Change-Id: Ia61c467d85d690752011bafcf112e39d5b252aa7
Signed-off-by: Max Fillinger <max@...2606...>
---
M README.mbedtls
1 file changed, 25 insertions(+), 8 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/72/372/3

diff --git a/README.mbedtls b/README.mbedtls
index d3466fa..572a061 100644
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
+This version requires mbed TLS version >=3D 2.16.0 or >=3D 3.2.1.

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
Gerrit-PatchSet: 3
Gerrit-Owner: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: MaxF <max@...2606...>
Gerrit-MessageType: newpatchset

--+g3XDkiIYSg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: MaxF, flichtenheld, plaisthos. </=
p>
<p>MaxF <strong>uploaded patch set #3</strong> to this change.</p><p><a hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/372?usp=3Demail">View Change</a>=
</p><p>The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld</p><p>The change is no longer submittable: Co=
de-Review and checks~ChecksSubmitRule are unsatisfied now.</p><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;">Update README.mb=
edtls<br><br>Change-Id: Ia61c467d85d690752011bafcf112e39d5b252aa7<br>Signed=
-off-by: Max Fillinger &lt;max@...2606...&gt;<br>---<br>M README.mbedtls<br=
>1 file changed, 25 insertions(+), 8 deletions(-)<br><br></pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit.openvpn.net:29418/openvpn refs/changes/72/372/3</pre><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git=
 a/README.mbedtls b/README.mbedtls</span><br><span>index d3466fa..572a061 1=
00644</span><br><span>--- a/README.mbedtls</span><br><span>+++ b/README.mbe=
dtls</span><br><span>@@ -1,13 +1,13 @@</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-This version of OpenVPN has mbed TLS support. To enable fo=
llow the following</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ins=
tructions:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+This vers=
ion of OpenVPN has mbed TLS support. To enable, follow the</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+instructions below:</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-To Build and Install=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+To build and insta=
ll,</span><br><span> </span><br><span> 	./configure --with-crypto-library=
=3Dmbedtls</span><br><span> 	make</span><br><span> 	make install</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-This version d=
epends on mbed TLS 2.0 (and requires at least 2.0.0).</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+This version requires mbed TLS version &g=
t;=3D 2.16.0 or &gt;=3D 3.2.1.</span><br><span> </span><br><span> *********=
****************************************************************</span><br>=
<span> </span><br><span>@@ -16,7 +16,8 @@</span><br><span> As of mbed TLS 2=
.17, it can be licensed *only* under the Apache v2.0 license.</span><br><sp=
an> That license is incompatible with OpenVPN&#39;s GPLv2.</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-If you wish to distr=
ibute OpenVPN linked with mbed TLS, there are two options:</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+We are currently in the process of r=
esolving this problem, but for now, if you</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+wish to distribute OpenVPN linked with mbed TLS, the=
re are two options:</span><br><span> </span><br><span>  * Ensure that your =
case falls under the system library exception in GPLv2, or</span><br><span>=
 </span><br><span>@@ -24,9 +25,6 @@</span><br><span>    that may be license=
d under GPLv2. Unfortunately, this version is</span><br><span>    unsupport=
ed and won&#39;t receive any more updates.</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-If nothing changes about the license=
 situation, mbed TLS support may be</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-deprecated in a future release of OpenVPN.</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span> **********************=
***************************************************</span><br><span> </span=
><br><span> Due to limitations in the mbed TLS library, the following featu=
res are missing</span><br><span>@@ -42,3 +40,22 @@</span><br><span>  * X.50=
9 subject line has a different format than the OpenSSL subject line</span><=
br><span>  * X.509 certificate export does not work</span><br><span>  * X.5=
09 certificate tracking</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+***************=
**********************************************************</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+Mbed TLS 3 supports the TLS 1.3 protocol, but the imple=
mentation is not yet</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+complete. Therefore, using TLS 1.3 in the mbed TLS build of OpenVPN is not=
 yet</span><br><span style=3D"color: hsl(120, 100%, 40%);">+supported.</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+Nevertheless, here are some pointers to m=
ake it work with mbed TLS 3.5.0:</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * The=
 stock configuration of mbed TLS does not support TLS 1.3. To enable it,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+   uncomment `#define =
MBEDTLS_SSL_PROTO_TLS1_3` in your mbedtls_config.h before</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+   compiling the library.</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * An OpenVPN client with mbed =
TLS cannot connect to a server with OpenSSL</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+   using TLS 1.3.</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * An OpenVPN client with OpenSSL *can* connect to a =
server using mbed TLS with</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+   TLS 1.3, but *only* if `#define MBEDTLS_SSL_TLS1_3_COMPATIBILITY_=
MODE` has</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   been un=
commented in mbedtls_config.h.</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Note tha=
t none of these limitations apply to TLS 1.2.</span><br><span></span><br></=
pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/372?=
usp=3Demail">change 372</a>. To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><=
div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/372?usp=3Demail"/><m=
eta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia61c467d85d690752011bafcf11=
2e39d5b252aa7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 372 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
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
<div style=3D"display:none"> Gerrit-Attention: MaxF &lt;max@...2606...&gt; =
</div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--+g3XDkiIYSg=--

