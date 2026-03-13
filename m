From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 13 Mar 2026 22:36:22 +0000
In-Reply-To: <gerrit.1773243451000.I090f5b201d67f51d2e42df1914a8466bcfcb6bf8@...2715...>
References: <gerrit.1773243451000.I090f5b201d67f51d2e42df1914a8466bcfcb6bf8@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <5d9a1f507690c5e7558681141753131b961c1581-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hqMfzc4jnlg="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--hqMfzc4jnlg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/15=
65?usp=3Demail )

Change subject: GHA: Install aws-lc under /opt/aws-lc
......................................................................

GHA: Install aws-lc under /opt/aws-lc

The previous installation inside the OpenVPN workspace directory
caused the AWS-LC installation to be deleted. And that caused to OpenSSL
to be used instead of AWS-LC during the build

This also removes the --enable-werror flag from AWS-LC because it
currently not even close to build without warnings.

Change-Id: I090f5b201d67f51d2e42df1914a8466bcfcb6bf8
Signed-off-by: Arne Schwabe <arne-openvpn@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1565
Message-Id: <20260313153007.31810-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36=
106.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M .github/workflows/build.yaml
1 file changed, 6 insertions(+), 6 deletions(-)




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

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I090f5b201d67f51d2e42df1914a8466bcfcb6bf8
Gerrit-Change-Number: 1565
Gerrit-PatchSet: 5
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--hqMfzc4jnlg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1565?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">GHA: Install aws-lc under /opt/aws-lc<br><br>The=
 previous installation inside the OpenVPN workspace directory<br>caused the=
 AWS-LC installation to be deleted. And that caused to OpenSSL<br>to be use=
d instead of AWS-LC during the build<br><br>This also removes the --enable-=
werror flag from AWS-LC because it<br>currently not even close to build wit=
hout warnings.<br><br>Change-Id: I090f5b201d67f51d2e42df1914a8466bcfcb6bf8<=
br>Signed-off-by: Arne Schwabe &lt;arne-openvpn@...1227...&gt;<br>Acked-by:=
 Frank Lichtenheld &lt;frank@...2641...&gt;<br>Gerrit URL: https://gerrit.o=
penvpn.net/c/openvpn/+/1565<br>Message-Id: &lt;20260313153007.31810-1-gert@=
...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1885...=
rceforge.net/msg36106.html<br>Signed-off-by: Gert Doering &lt;gert@...1725...=
..&gt;<br>---<br>M .github/workflows/build.yaml<br>1 file changed, 6 insert=
ions(+), 6 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml=
</span><br><span>index b213192..2a2616b 100644</span><br><span>--- a/.githu=
b/workflows/build.yaml</span><br><span>+++ b/.github/workflows/build.yaml</=
span><br><span>@@ -454,7 +454,7 @@</span><br><span>       CC: ${{matrix.cc}=
}</span><br><span>       CXX: ${{matrix.cxx}}</span><br><span>       UBSAN_=
OPTIONS: print_stacktrace=3D1</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-      AWS_LC_INSTALL: ${{ github.workspace }}/aws-lc/aws-lc-install=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      AWS_LC_INSTAL=
L: /opt/aws-lc</span><br><span> </span><br><span>     steps:</span><br><spa=
n>       - name: Install dependencies</span><br><span>@@ -465,7 +465,7 @@</=
span><br><span>           path: aws-lc</span><br><span>           # version=
ing=3Dsemver-coerced</span><br><span>           repository: aws/aws-lc</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-          ref: v1.67.0</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+          ref: v1.70.0<=
/span><br><span>       - uses: lukka/get-cmake@...2999... # v4.2.3</span><b=
r><span>       - name: &quot;AWS-LC: build&quot;</span><br><span>         r=
un: |</span><br><span>@@ -480,10 +480,10 @@</span><br><span>         run: a=
utoreconf -fvi</span><br><span>       - name: configure with AWS-LC</span><=
br><span>         run: |</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-          OPENSSL_CFLAGS=3D&quot;-I/${{ env.AWS_LC_INSTALL }}/include&qu=
ot; \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          OPENSS=
L_LIBS=3D&quot;-L/${{ env.AWS_LC_INSTALL }}/lib -lssl -lcrypto&quot; \</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-          LDFLAGS=3D&quot;=
-Wl,-rpath=3D/${{ env.AWS_LC_INSTALL }}/lib&quot; \</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-          ./configure --with-crypto-library=
=3Dopenssl --enable-werror</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+          OPENSSL_CFLAGS=3D&quot;-I${{ env.AWS_LC_INSTALL }}/include=
&quot; \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          O=
PENSSL_LIBS=3D&quot;-L${{ env.AWS_LC_INSTALL }}/lib -lssl -lcrypto&quot; \<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+          LDFLAGS=3D=
&quot;-Wl,-rpath=3D${{ env.AWS_LC_INSTALL }}/lib&quot; \</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+          ./configure --with-crypto-li=
brary=3Dopenssl</span><br><span>       - name: make all</span><br><span>   =
      run: make -j3</span><br><span>       - name: configure checks</span><=
br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/1565?usp=3Demail">change 1565</a>. To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/sett=
ings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema=
.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sc=
hema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/1565?usp=3Demail"/><meta itemprop=3D"name" content=3D"View C=
hange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I090f5b201d67f51d2e42df1914a=
8466bcfcb6bf8 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1565 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--hqMfzc4jnlg=--

