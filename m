From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Fri, 13 Mar 2026 12:22:36 +0000
In-Reply-To: <gerrit.1773243451000.I090f5b201d67f51d2e42df1914a8466bcfcb6bf8@...2715...>
References: <gerrit.1773243451000.I090f5b201d67f51d2e42df1914a8466bcfcb6bf8@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <994783d67842be9babd6e3ebcbb91112c7a23959-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="djw/D872N3s="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: [GHA] Install aws-lc
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

--djw/D872N3s=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1565?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld


Change subject: [GHA] Install aws-lc under /opt/aws-lc
......................................................................

[GHA] Install aws-lc under /opt/aws-lc

The previous installation inside the OpenVPN workspace directory
caused the AWS-LC installation to be deleted. And that caused to OpenSSL
to be used instead of AWS-LC during the build

This also removes the --enable-werror flag from AWS-LC because it
currently not even close to build without warnings.

Change-Id: I090f5b201d67f51d2e42df1914a8466bcfcb6bf8
---
M .github/workflows/build.yaml
1 file changed, 8 insertions(+), 6 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/65/1565/2

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index b213192..b3b731b 100644
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
@@ -478,12 +478,14 @@
         uses: actions/checkout@...2998... # v6.0.2
       - name: autoconf
         run: autoreconf -fvi
+      - name: list aws-lc install
+        run: find ${{ env.AWS_LC_INSTALL }}
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
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--djw/D872N3s=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>plaisthos <strong>uploaded patch set #2</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1565?usp=3Demail">View Chan=
ge</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">[GHA] Install aws-lc under /=
opt/aws-lc<br><br>The previous installation inside the OpenVPN workspace di=
rectory<br>caused the AWS-LC installation to be deleted. And that caused to=
 OpenSSL<br>to be used instead of AWS-LC during the build<br><br>This also =
removes the --enable-werror flag from AWS-LC because it<br>currently not ev=
en close to build without warnings.<br><br>Change-Id: I090f5b201d67f51d2e42=
df1914a8466bcfcb6bf8<br>---<br>M .github/workflows/build.yaml<br>1 file cha=
nged, 8 insertions(+), 6 deletions(-)<br><br></pre><pre class=3D"blocks" st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull s=
sh://gerrit.openvpn.net:29418/openvpn refs/changes/65/1565/2</pre><pre styl=
e=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff -=
-git a/.github/workflows/build.yaml b/.github/workflows/build.yaml</span><b=
r><span>index b213192..b3b731b 100644</span><br><span>--- a/.github/workflo=
ws/build.yaml</span><br><span>+++ b/.github/workflows/build.yaml</span><br>=
<span>@@ -454,7 +454,7 @@</span><br><span>       CC: ${{matrix.cc}}</span><=
br><span>       CXX: ${{matrix.cxx}}</span><br><span>       UBSAN_OPTIONS: =
print_stacktrace=3D1</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
     AWS_LC_INSTALL: ${{ github.workspace }}/aws-lc/aws-lc-install</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+      AWS_LC_INSTALL: /opt/a=
ws-lc</span><br><span> </span><br><span>     steps:</span><br><span>       =
- name: Install dependencies</span><br><span>@@ -465,7 +465,7 @@</span><br>=
<span>           path: aws-lc</span><br><span>           # versioning=3Dsem=
ver-coerced</span><br><span>           repository: aws/aws-lc</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-          ref: v1.67.0</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+          ref: v1.70.0</span><br=
><span>       - uses: lukka/get-cmake@...2999... # v4.2.3</span><br><span> =
      - name: &quot;AWS-LC: build&quot;</span><br><span>         run: |</sp=
an><br><span>@@ -478,12 +478,14 @@</span><br><span>         uses: actions/c=
heckout@...2998... # v6.0.2</span><br><span>       - name: autoconf</span><=
br><span>         run: autoreconf -fvi</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+      - name: list aws-lc install</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        run: find ${{ env.AWS_LC_INSTALL =
}}</span><br><span>       - name: configure with AWS-LC</span><br><span>   =
      run: |</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
 OPENSSL_CFLAGS=3D&quot;-I/${{ env.AWS_LC_INSTALL }}/include&quot; \</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-          OPENSSL_LIBS=3D&qu=
ot;-L/${{ env.AWS_LC_INSTALL }}/lib -lssl -lcrypto&quot; \</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-          LDFLAGS=3D&quot;-Wl,-rpath=
=3D/${{ env.AWS_LC_INSTALL }}/lib&quot; \</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-          ./configure --with-crypto-library=3Dopenssl -=
-enable-werror</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
     OPENSSL_CFLAGS=3D&quot;-I${{ env.AWS_LC_INSTALL }}/include&quot; \</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+          OPENSSL_LIBS=
=3D&quot;-L${{ env.AWS_LC_INSTALL }}/lib -lssl -lcrypto&quot; \</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+          LDFLAGS=3D&quot;-Wl,-=
rpath=3D${{ env.AWS_LC_INSTALL }}/lib&quot; \</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+          ./configure --with-crypto-library=3Dope=
nssl</span><br><span>       - name: make all</span><br><span>         run: =
make -j3</span><br><span>       - name: configure checks</span><br><span></=
span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/1565?usp=3Demail">change 1565</a>. To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3D=
email">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailM=
essage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vi=
ewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/1565?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></d=
iv></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I090f5b201d67f51d2e42df1914a=
8466bcfcb6bf8 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1565 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
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

--djw/D872N3s=--

