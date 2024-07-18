From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Thu, 18 Jul 2024 12:47:20 +0000
References: <gerrit.1721306838000.I44b9003143fdad90bfff7b2c86d0bb503f9157de@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <2354d1da61f66b6ef2e013d6446369ea93d592bd-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="D8vwy3pv1S4="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Add Ubuntu 24.04
 runner to Github Actions
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

--D8vwy3pv1S4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/676?usp=3Demail

to review the following change.


Change subject: Add Ubuntu 24.04 runner to Github Actions
......................................................................

Add Ubuntu 24.04 runner to Github Actions

Change-Id: I44b9003143fdad90bfff7b2c86d0bb503f9157de
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M .github/workflows/build.yaml
1 file changed, 8 insertions(+), 2 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/76/676/1

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index d7c3ecd..6e361d5 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -106,7 +106,7 @@
     strategy:
       fail-fast: false
       matrix:
-        os: [ubuntu-20.04, ubuntu-22.04]
+        os: [ubuntu-20.04, ubuntu-22.04, ubuntu-24.04]
         sslpkg: [libmbedtls-dev]
         ssllib: [mbedtls]
         libname: [mbed TLS]
@@ -122,6 +122,12 @@
             ssllib: openssl
             pkcs11pkg: "libpkcs11-helper1-dev softhsm2 gnutls-bin"
             extraconf: --enable-pkcs11
+          - os: ubuntu-24.04
+            sslpkg: "libssl-dev"
+            libname: OpenSSL 3.0.13
+            ssllib: openssl
+            pkcs11pkg: "libpkcs11-helper1-dev softhsm2 gnutls-bin"
+            extraconf: --enable-pkcs11
           - os: ubuntu-20.04
             sslpkg: "libssl-dev"
             libname: OpenSSL 1.1.1
@@ -173,7 +179,7 @@
     strategy:
       fail-fast: false
       matrix:
-        os: [ubuntu-20.04]
+        os: [ubuntu-20.04, ubuntu-22.04, ubuntu-24.04]
         ssllib: [mbedtls, openssl]

     name: "clang-asan - ${{matrix.os}} - ${{matrix.ssllib}}"

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/676?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I44b9003143fdad90bfff7b2c86d0bb503f9157de
Gerrit-Change-Number: 676
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--D8vwy3pv1S4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/676?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Add Ubuntu 24.04 runner to Github Actions<br><br>Change-Id: I=
44b9003143fdad90bfff7b2c86d0bb503f9157de<br>Signed-off-by: Arne Schwabe &lt=
;arne@...1227...&gt;<br>---<br>M .github/workflows/build.yaml<br>1 file cha=
nged, 8 insertions(+), 2 deletions(-)<br><br></pre><pre style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openv=
pn.net:29418/openvpn refs/changes/76/676/1</pre><pre style=3D"font-family: =
monospace,monospace; white-space: pre-wrap;"><span>diff --git a/.github/wor=
kflows/build.yaml b/.github/workflows/build.yaml</span><br><span>index d7c3=
ecd..6e361d5 100644</span><br><span>--- a/.github/workflows/build.yaml</spa=
n><br><span>+++ b/.github/workflows/build.yaml</span><br><span>@@ -106,7 +1=
06,7 @@</span><br><span>     strategy:</span><br><span>       fail-fast: fa=
lse</span><br><span>       matrix:</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        os: [ubuntu-20.04, ubuntu-22.04]</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        os: [ubuntu-20.04, ubuntu-22.04, =
ubuntu-24.04]</span><br><span>         sslpkg: [libmbedtls-dev]</span><br><=
span>         ssllib: [mbedtls]</span><br><span>         libname: [mbed TLS=
]</span><br><span>@@ -122,6 +122,12 @@</span><br><span>             ssllib:=
 openssl</span><br><span>             pkcs11pkg: &quot;libpkcs11-helper1-de=
v softhsm2 gnutls-bin&quot;</span><br><span>             extraconf: --enabl=
e-pkcs11</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          -=
 os: ubuntu-24.04</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          sslpkg: &quot;libssl-dev&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            libname: OpenSSL 3.0.13</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            ssllib: openssl</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            pkcs11pkg: &quot;l=
ibpkcs11-helper1-dev softhsm2 gnutls-bin&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            extraconf: --enable-pkcs11</span><br=
><span>           - os: ubuntu-20.04</span><br><span>             sslpkg: &=
quot;libssl-dev&quot;</span><br><span>             libname: OpenSSL 1.1.1</=
span><br><span>@@ -173,7 +179,7 @@</span><br><span>     strategy:</span><br=
><span>       fail-fast: false</span><br><span>       matrix:</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        os: [ubuntu-20.04]</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        os: [ubuntu-20.04, u=
buntu-22.04, ubuntu-24.04]</span><br><span>         ssllib: [mbedtls, opens=
sl]</span><br><span> </span><br><span>     name: &quot;clang-asan - ${{matr=
ix.os}} - ${{matrix.ssllib}}&quot;</span><br><span></span><br></pre><p>To v=
iew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/676?usp=3Demail=
">change 676</a>. To unsubscribe, or for help writing mail filters, visit <=
a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemsco=
pe itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/676?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I44b9003143fdad90bfff7b2c86d=
0bb503f9157de </div>
<div style=3D"display:none"> Gerrit-Change-Number: 676 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--D8vwy3pv1S4=--

