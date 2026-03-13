From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Fri, 13 Mar 2026 13:43:14 +0000
In-Reply-To: <gerrit.1773243451000.I090f5b201d67f51d2e42df1914a8466bcfcb6bf8@...2715...>
References: <gerrit.1773243451000.I090f5b201d67f51d2e42df1914a8466bcfcb6bf8@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <d344c538fa676917caf8e90de8bc99163e26d76e-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="pqEPczZoevY="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: GHA: Install aws-lc
 under /opt/aws-lc
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

--pqEPczZoevY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1565?usp=3Demail

to look at the new patch set (#4).

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld

The change is no longer submittable: Code-Review and checks~ChecksSubmitRul=
e are unsatisfied now.


Change subject: GHA: Install aws-lc under /opt/aws-lc
......................................................................

GHA: Install aws-lc under /opt/aws-lc

The previous installation inside the OpenVPN workspace directory
caused the AWS-LC installation to be deleted. And that caused to OpenSSL
to be used instead of AWS-LC during the build

This also removes the --enable-werror flag from AWS-LC because it
currently not even close to build without warnings.

Change-Id: I090f5b201d67f51d2e42df1914a8466bcfcb6bf8
---
M .github/workflows/build.yaml
1 file changed, 6 insertions(+), 6 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/65/1565/4

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index b213192..2a2616b 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -454,7 +454,7 @@
       CC: ${{matrix.cc}}
       CXX: ${{matrix.cxx}}
       UBSAN_OPTIONS: print_stacktrace=3D1
-      AWS_LC_INSTALL: ${{ github.workspace }}/aws-lc/aws-lc-install
+      AWS_LC_INSTALL: /opt/aws-lc

     steps:
       - name: Install dependencies
@@ -465,7 +465,7 @@
           path: aws-lc
           # versioning=3Dsemver-coerced
           repository: aws/aws-lc
-          ref: v1.67.0
+          ref: v1.70.0
       - uses: lukka/get-cmake@...2999... # v4.2.3
       - name: "AWS-LC: build"
         run: |
@@ -480,10 +480,10 @@
         run: autoreconf -fvi
       - name: configure with AWS-LC
         run: |
-          OPENSSL_CFLAGS=3D"-I/${{ env.AWS_LC_INSTALL }}/include" \
-          OPENSSL_LIBS=3D"-L/${{ env.AWS_LC_INSTALL }}/lib -lssl -lcrypto"=
 \
-          LDFLAGS=3D"-Wl,-rpath=3D/${{ env.AWS_LC_INSTALL }}/lib" \
-          ./configure --with-crypto-library=3Dopenssl --enable-werror
+          OPENSSL_CFLAGS=3D"-I${{ env.AWS_LC_INSTALL }}/include" \
+          OPENSSL_LIBS=3D"-L${{ env.AWS_LC_INSTALL }}/lib -lssl -lcrypto" \
+          LDFLAGS=3D"-Wl,-rpath=3D${{ env.AWS_LC_INSTALL }}/lib" \
+          ./configure --with-crypto-library=3Dopenssl
       - name: make all
         run: make -j3
       - name: configure checks

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1565?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I090f5b201d67f51d2e42df1914a8466bcfcb6bf8
Gerrit-Change-Number: 1565
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--pqEPczZoevY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>plaisthos <strong>uploaded patch set #4</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1565?usp=3Demail">View Chan=
ge</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld</p><p>The change is no longer submittable: Co=
de-Review and checks~ChecksSubmitRule are unsatisfied now.</p><pre class=3D=
"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
>GHA: Install aws-lc under /opt/aws-lc<br><br>The previous installation ins=
ide the OpenVPN workspace directory<br>caused the AWS-LC installation to be=
 deleted. And that caused to OpenSSL<br>to be used instead of AWS-LC during=
 the build<br><br>This also removes the --enable-werror flag from AWS-LC be=
cause it<br>currently not even close to build without warnings.<br><br>Chan=
ge-Id: I090f5b201d67f51d2e42df1914a8466bcfcb6bf8<br>---<br>M .github/workfl=
ows/build.yaml<br>1 file changed, 6 insertions(+), 6 deletions(-)<br><br></=
pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/chan=
ges/65/1565/4</pre><pre style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;"><span>diff --git a/.github/workflows/build.yaml b/.github/w=
orkflows/build.yaml</span><br><span>index b213192..2a2616b 100644</span><br=
><span>--- a/.github/workflows/build.yaml</span><br><span>+++ b/.github/wor=
kflows/build.yaml</span><br><span>@@ -454,7 +454,7 @@</span><br><span>     =
  CC: ${{matrix.cc}}</span><br><span>       CXX: ${{matrix.cxx}}</span><br>=
<span>       UBSAN_OPTIONS: print_stacktrace=3D1</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-      AWS_LC_INSTALL: ${{ github.workspace }}/aw=
s-lc/aws-lc-install</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
      AWS_LC_INSTALL: /opt/aws-lc</span><br><span> </span><br><span>     st=
eps:</span><br><span>       - name: Install dependencies</span><br><span>@@=
 -465,7 +465,7 @@</span><br><span>           path: aws-lc</span><br><span> =
          # versioning=3Dsemver-coerced</span><br><span>           reposito=
ry: aws/aws-lc</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
   ref: v1.67.0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
      ref: v1.70.0</span><br><span>       - uses: lukka/get-cmake@...3001...=
. # v4.2.3</span><br><span>       - name: &quot;AWS-LC: build&quot;</span><=
br><span>         run: |</span><br><span>@@ -480,10 +480,10 @@</span><br><s=
pan>         run: autoreconf -fvi</span><br><span>       - name: configure =
with AWS-LC</span><br><span>         run: |</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-          OPENSSL_CFLAGS=3D&quot;-I/${{ env.AWS_LC_IN=
STALL }}/include&quot; \</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-          OPENSSL_LIBS=3D&quot;-L/${{ env.AWS_LC_INSTALL }}/lib -lssl -l=
crypto&quot; \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
   LDFLAGS=3D&quot;-Wl,-rpath=3D/${{ env.AWS_LC_INSTALL }}/lib&quot; \</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-          ./configure --wi=
th-crypto-library=3Dopenssl --enable-werror</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+          OPENSSL_CFLAGS=3D&quot;-I${{ env.AWS_LC_I=
NSTALL }}/include&quot; \</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+          OPENSSL_LIBS=3D&quot;-L${{ env.AWS_LC_INSTALL }}/lib -lssl =
-lcrypto&quot; \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
       LDFLAGS=3D&quot;-Wl,-rpath=3D${{ env.AWS_LC_INSTALL }}/lib&quot; \</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+          ./configure=
 --with-crypto-library=3Dopenssl</span><br><span>       - name: make all</s=
pan><br><span>         run: make -j3</span><br><span>       - name: configu=
re checks</span><br><span></span><br></pre><p>To view, visit <a href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/1565?usp=3Demail">change 1565</a>. To un=
subscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1565?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I090f5b201d67f51d2e42df1914a=
8466bcfcb6bf8 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1565 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--pqEPczZoevY=--

