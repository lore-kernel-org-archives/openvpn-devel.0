From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 4 Aug 2025 12:14:50 +0000
References: <gerrit.1754309687000.I9159e2e354170ad6dbed5a6ce620f57fa8ab128e@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <54319d258ebb8514212390b37a633e56abbd232c-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="lSrh0K0Nj8Q="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: GHA: enable -Werror
 for mbedTLS v3 and AWS LC builds
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--lSrh0K0Nj8Q=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1128?usp=3Demail

to review the following change.


Change subject: GHA: enable -Werror for mbedTLS v3 and AWS LC builds
......................................................................

GHA: enable -Werror for mbedTLS v3 and AWS LC builds

Because we can and so we should.

Change-Id: I9159e2e354170ad6dbed5a6ce620f57fa8ab128e
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M .github/workflows/build.yaml
1 file changed, 2 insertions(+), 2 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/28/1128/1

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index cc17fba..0f88d0c 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -425,7 +425,7 @@
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
-        run: ./configure --with-crypto-library=3Dmbedtls
+        run: ./configure --with-crypto-library=3Dmbedtls --enable-werror
       - name: make all
         run: make -j3
       - name: configure checks
@@ -489,7 +489,7 @@
           OPENSSL_CFLAGS=3D"-I/${{ env.AWS_LC_INSTALL }}/include" \
           OPENSSL_LIBS=3D"-L/${{ env.AWS_LC_INSTALL }}/lib -lssl -lcrypto"=
 \
           LDFLAGS=3D"-Wl,-rpath=3D/${{ env.AWS_LC_INSTALL }}/lib" \
-          ./configure --with-crypto-library=3Dopenssl
+          ./configure --with-crypto-library=3Dopenssl --enable-werror
       - name: make all
         run: make -j3
       - name: configure checks

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1128?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I9159e2e354170ad6dbed5a6ce620f57fa8ab128e
Gerrit-Change-Number: 1128
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--lSrh0K0Nj8Q=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1128?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">GHA: enable -Werror for mbedTLS v3 and AWS LC builds<br><br>=
Because we can and so we should.<br><br>Change-Id: I9159e2e354170ad6dbed5a6=
ce620f57fa8ab128e<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&=
gt;<br>---<br>M .github/workflows/build.yaml<br>1 file changed, 2 insertion=
s(+), 2 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/open=
vpn refs/changes/28/1128/1</pre><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;"><span>diff --git a/.github/workflows/build.yam=
l b/.github/workflows/build.yaml</span><br><span>index cc17fba..0f88d0c 100=
644</span><br><span>--- a/.github/workflows/build.yaml</span><br><span>+++ =
b/.github/workflows/build.yaml</span><br><span>@@ -425,7 +425,7 @@</span><b=
r><span>       - name: autoconf</span><br><span>         run: autoreconf -f=
vi</span><br><span>       - name: configure</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        run: ./configure --with-crypto-library=3Dmbed=
tls</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        run: ./c=
onfigure --with-crypto-library=3Dmbedtls --enable-werror</span><br><span>  =
     - name: make all</span><br><span>         run: make -j3</span><br><spa=
n>       - name: configure checks</span><br><span>@@ -489,7 +489,7 @@</span=
><br><span>           OPENSSL_CFLAGS=3D&quot;-I/${{ env.AWS_LC_INSTALL }}/i=
nclude&quot; \</span><br><span>           OPENSSL_LIBS=3D&quot;-L/${{ env.A=
WS_LC_INSTALL }}/lib -lssl -lcrypto&quot; \</span><br><span>           LDFL=
AGS=3D&quot;-Wl,-rpath=3D/${{ env.AWS_LC_INSTALL }}/lib&quot; \</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-          ./configure --with-cryp=
to-library=3Dopenssl</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+          ./configure --with-crypto-library=3Dopenssl --enable-werror</spa=
n><br><span>       - name: make all</span><br><span>         run: make -j3<=
/span><br><span>       - name: configure checks</span><br><span></span><br>=
</pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/11=
28?usp=3Demail">change 1128</a>. To unsubscribe, or for help writing mail f=
ilters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.<=
/p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemp=
rop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1128?usp=3Demail"=
/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9159e2e354170ad6dbed5a6ce62=
0f57fa8ab128e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1128 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--lSrh0K0Nj8Q=--

