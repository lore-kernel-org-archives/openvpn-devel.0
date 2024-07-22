From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 22 Jul 2024 17:46:08 +0000
In-Reply-To: <gerrit.1721306838000.I44b9003143fdad90bfff7b2c86d0bb503f9157de@...2715...>
References: <gerrit.1721306838000.I44b9003143fdad90bfff7b2c86d0bb503f9157de@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <8b3983f6f0dde88c4868be4b7c4538f9ddaf228e-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="UXeuUkWGLS0="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--UXeuUkWGLS0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/67=
6?usp=3Demail )

Change subject: Add Ubuntu 24.04 runner to Github Actions
......................................................................

Add Ubuntu 24.04 runner to Github Actions

Change-Id: I44b9003143fdad90bfff7b2c86d0bb503f9157de
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20240719131141.75324-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28=
942.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M .github/workflows/build.yaml
1 file changed, 8 insertions(+), 2 deletions(-)




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
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--UXeuUkWGLS0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/676?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Add Ubuntu 24.04 runner to Github Actions<br><=
br>Change-Id: I44b9003143fdad90bfff7b2c86d0bb503f9157de<br>Signed-off-by: A=
rne Schwabe &lt;arne@...1227...&gt;<br>Acked-by: Frank Lichtenheld &lt;fran=
k@...2641...&gt;<br>Message-Id: &lt;20240719131141.75324-1-frank@...2641...=
&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1223...=
et/msg28942.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>=
---<br>M .github/workflows/build.yaml<br>1 file changed, 8 insertions(+), 2=
 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml=
</span><br><span>index d7c3ecd..6e361d5 100644</span><br><span>--- a/.githu=
b/workflows/build.yaml</span><br><span>+++ b/.github/workflows/build.yaml</=
span><br><span>@@ -106,7 +106,7 @@</span><br><span>     strategy:</span><br=
><span>       fail-fast: false</span><br><span>       matrix:</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        os: [ubuntu-20.04, ubuntu-2=
2.04]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        os: [u=
buntu-20.04, ubuntu-22.04, ubuntu-24.04]</span><br><span>         sslpkg: [=
libmbedtls-dev]</span><br><span>         ssllib: [mbedtls]</span><br><span>=
         libname: [mbed TLS]</span><br><span>@@ -122,6 +122,12 @@</span><br=
><span>             ssllib: openssl</span><br><span>             pkcs11pkg:=
 &quot;libpkcs11-helper1-dev softhsm2 gnutls-bin&quot;</span><br><span>    =
         extraconf: --enable-pkcs11</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+          - os: ubuntu-24.04</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            sslpkg: &quot;libssl-dev&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            libname: OpenSS=
L 3.0.13</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 ssllib: openssl</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         pkcs11pkg: &quot;libpkcs11-helper1-dev softhsm2 gnutls-bin&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            extraconf=
: --enable-pkcs11</span><br><span>           - os: ubuntu-20.04</span><br><=
span>             sslpkg: &quot;libssl-dev&quot;</span><br><span>          =
   libname: OpenSSL 1.1.1</span><br><span>@@ -173,7 +179,7 @@</span><br><sp=
an>     strategy:</span><br><span>       fail-fast: false</span><br><span> =
      matrix:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
os: [ubuntu-20.04]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       os: [ubuntu-20.04, ubuntu-22.04, ubuntu-24.04]</span><br><span>     =
    ssllib: [mbedtls, openssl]</span><br><span> </span><br><span>     name:=
 &quot;clang-asan - ${{matrix.os}} - ${{matrix.ssllib}}&quot;</span><br><sp=
an></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/676?usp=3Demail">change 676</a>. To unsubscribe, or for help wr=
iting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">se=
ttings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><=
div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"=
><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/676?u=
sp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I44b9003143fdad90bfff7b2c86d=
0bb503f9157de </div>
<div style=3D"display:none"> Gerrit-Change-Number: 676 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--UXeuUkWGLS0=--

