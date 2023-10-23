From: "MaxF (Code Review)" <gerrit@...515...>
Date: Mon, 23 Oct 2023 17:37:06 +0000
In-Reply-To: <gerrit.1697562354000.Ia61c467d85d690752011bafcf112e39d5b252aa7@...2715...>
References: <gerrit.1697562354000.Ia61c467d85d690752011bafcf112e39d5b252aa7@...2715...>
Reply-To: max@...2606..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <c3909748c598db9477c05e4e57fe3dcb314f3d65-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3qjaFaYsdi0="; charset=UTF-8
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

--3qjaFaYsdi0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/372?usp=3Demail

to look at the new patch set (#8).

The change is no longer submittable: checks~ChecksSubmitRule is unsatisfied=
 now.


Change subject: Update README.mbedtls
......................................................................

Update README.mbedtls

Change-Id: Ia61c467d85d690752011bafcf112e39d5b252aa7
Signed-off-by: Max Fillinger <max@...2606...>
---
M README.mbedtls
1 file changed, 25 insertions(+), 8 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/72/372/8

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
=20
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
Gerrit-PatchSet: 8
Gerrit-Owner: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: MaxF <max@...2606...>
Gerrit-MessageType: newpatchset

--3qjaFaYsdi0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: MaxF, plaisthos. </p>
<p>MaxF <strong>uploaded patch set #8</strong> to this change.</p><p><a hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/372?usp=3Demail">View Change</a>=
</p><p>The change is no longer submittable: checks~ChecksSubmitRule is unsa=
tisfied now.</p><pre style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">Update README.mbedtls<br><br>Change-Id: Ia61c467d85d690752011b=
afcf112e39d5b252aa7<br>Signed-off-by: Max Fillinger &lt;max@...2606...&gt;<=
br>---<br>M README.mbedtls<br>1 file changed, 25 insertions(+), 8 deletions=
(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/=
72/372/8</pre><pre style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;"><span>diff --git a/README.mbedtls b/README.mbedtls</span><br><sp=
an>index d3466fa..9b75c2b 100644</span><br><span>--- a/README.mbedtls</span=
><br><span>+++ b/README.mbedtls</span><br><span>@@ -1,13 +1,13 @@</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-This version of OpenVPN has mbe=
d TLS support. To enable follow the following</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-instructions:</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+This version of OpenVPN has mbed TLS support. To enable, =
follow the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+instructi=
ons below:</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-To Build and Install,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+To build and install,</span><br><span> </span><br><span> 	./config=
ure --with-crypto-library=3Dmbedtls</span><br><span> 	make</span><br><span>=
 	make install</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-This version depends on mbed TLS 2.0 (and requires at least 2.0.=
0).</span><br><span style=3D"color: hsl(120, 100%, 40%);">+This version req=
uires mbed TLS version &gt;=3D 2.0.0 or &gt;=3D 3.2.1.</span><br><span> </s=
pan><br><span> ************************************************************=
*************</span><br><span> </span><br><span>@@ -16,7 +16,8 @@</span><br=
><span> As of mbed TLS 2.17, it can be licensed *only* under the Apache v2.=
0 license.</span><br><span> That license is incompatible with OpenVPN&#39;s=
 GPLv2.</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-If you wish to distribute OpenVPN linked with mbed TLS, there are two o=
ptions:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+We are curre=
ntly in the process of resolving this problem, but for now, if you</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+wish to distribute OpenVPN l=
inked with mbed TLS, there are two options:</span><br><span> </span><br><sp=
an>  * Ensure that your case falls under the system library exception in GP=
Lv2, or</span><br><span> </span><br><span>@@ -24,9 +25,6 @@</span><br><span=
>    that may be licensed under GPLv2. Unfortunately, this version is</span=
><br><span>    unsupported and won&#39;t receive any more updates.</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-If nothing c=
hanges about the license situation, mbed TLS support may be</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-deprecated in a future release of Ope=
nVPN.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
> *************************************************************************=
</span><br><span> </span><br><span> Due to limitations in the mbed TLS libr=
ary, the following features are missing</span><br><span>@@ -42,3 +40,22 @@<=
/span><br><span>  * X.509 subject line has a different format than the Open=
SSL subject line</span><br><span>  * X.509 certificate export does not work=
</span><br><span>  * X.509 certificate tracking</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+******************************************************************=
*******</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+Mbed TLS 3 supports the TLS 1.3=
 protocol, but the implementation is not yet</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+complete. Therefore, using TLS 1.3 in the mbed TLS=
 build of OpenVPN is not yet</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+supported.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Nevertheless, here =
are some pointers to make it work with mbed TLS 3.5.0:</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * The stock configuration of mbed TLS does not support TLS=
 1.3. To enable it,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
   uncomment `#define MBEDTLS_SSL_PROTO_TLS1_3` in your mbedtls_config.h be=
fore</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   compiling th=
e library.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * An Ope=
nVPN client with mbed TLS cannot connect to a server with OpenSSL</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+   using TLS 1.3.</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * An OpenVPN client with OpenS=
SL *can* connect to a server using mbed TLS with</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+   TLS 1.3, but *only* if `#define MBEDTLS_SSL=
_TLS1_3_COMPATIBILITY_MODE` has</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+   been uncommented in mbedtls_config.h.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+Note that none of these limitations apply to TLS 1.2.</span>=
<br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/372?usp=3Demail">change 372</a>. To unsubscribe, or for =
help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/setti=
ngs">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/View=
Action"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/372?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia61c467d85d690752011bafcf11=
2e39d5b252aa7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 372 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 8 </div>
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
<div style=3D"display:none"> Gerrit-Attention: MaxF &lt;max@...2606...&gt; =
</div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--3qjaFaYsdi0=--

