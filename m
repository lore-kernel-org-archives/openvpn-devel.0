From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 11 Mar 2026 15:37:35 +0000
References: <gerrit.1773243451000.I090f5b201d67f51d2e42df1914a8466bcfcb6bf8@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net
Message-ID: <8ad3977ebf8d5895c07d879b2906a9b3ecca3c25-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ESbVeoG0mDE="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: [GHA] Install aws-lc
 under /opt/aws-lc and chache it
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ESbVeoG0mDE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review. ( http://gerrit.openvpn.net/=
c/openvpn/+/1565?usp=3Demail )


Change subject: [GHA] Install aws-lc under /opt/aws-lc and chache it
......................................................................

[GHA] Install aws-lc under /opt/aws-lc and chache it

The previous installation inside the OpenVPN workspace directory
caused the AWS-LC installation to be deleted. And that caused to OpenSSL
to be used instead of AWS-LC during the build

This also removes the --enable-werror flag from AWS-LC because it
currently not even close to build without warnings.

Change-Id: I090f5b201d67f51d2e42df1914a8466bcfcb6bf8
---
M .github/workflows/build.yaml
1 file changed, 17 insertions(+), 6 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/65/1565/1

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index b213192..2e9b62a 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -454,20 +454,29 @@
       CC: ${{matrix.cc}}
       CXX: ${{matrix.cxx}}
       UBSAN_OPTIONS: print_stacktrace=3D1
-      AWS_LC_INSTALL: ${{ github.workspace }}/aws-lc/aws-lc-install
+      AWS_LC_INSTALL: /opt/aws-lc
+      AWS_LC_VERSION: v1.70.0

     steps:
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y gcc golang make liblzo=
2-dev libpam0g-dev liblz4-dev linux-libc-dev man2html clang libcmocka-dev p=
ython3-docutils python3-jinja2 python3-jsonschema libtool automake autoconf=
 pkg-config libcap-ng-dev libnl-genl-3-dev
+      - name: Restore AWS-LC from cache
+        uses: actions/cache@...3010...
+        id: aws-lc-cache
+        with:
+          path: ${{ env.AWS_LC_INSTALL }}
+          key: ${{ matrix.os }}-aws-lc-${{ env.AWS_LC_VERSION }}
       - name: "AWS-LC: checkout"
+        if: steps.aws-lc-cache.outputs.cache-hit !=3D 'true'
         uses: actions/checkout@...2998... # v6.0.2
         with:
           path: aws-lc
           # versioning=3Dsemver-coerced
           repository: aws/aws-lc
-          ref: v1.67.0
+          ref: ${{ env.AWS_LC_VERSION }}
       - uses: lukka/get-cmake@...2999... # v4.2.3
       - name: "AWS-LC: build"
+        if: steps.aws-lc-cache.outputs.cache-hit !=3D 'true'
         run: |
           mkdir build
           cd build
@@ -478,12 +487,14 @@
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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I090f5b201d67f51d2e42df1914a8466bcfcb6bf8
Gerrit-Change-Number: 1565
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ESbVeoG0mDE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>.</p><p><a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/1565?usp=3Demail">View Change</a></p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">[GHA] Install aws-lc under /opt/aws-lc and chache it<br><br>The previou=
s installation inside the OpenVPN workspace directory<br>caused the AWS-LC =
installation to be deleted. And that caused to OpenSSL<br>to be used instea=
d of AWS-LC during the build<br><br>This also removes the --enable-werror f=
lag from AWS-LC because it<br>currently not even close to build without war=
nings.<br><br>Change-Id: I090f5b201d67f51d2e42df1914a8466bcfcb6bf8<br>---<b=
r>M .github/workflows/build.yaml<br>1 file changed, 17 insertions(+), 6 del=
etions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:2941=
8/openvpn refs/changes/65/1565/1</pre><pre style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;"><span>diff --git a/.github/workflows/bui=
ld.yaml b/.github/workflows/build.yaml</span><br><span>index b213192..2e9b6=
2a 100644</span><br><span>--- a/.github/workflows/build.yaml</span><br><spa=
n>+++ b/.github/workflows/build.yaml</span><br><span>@@ -454,20 +454,29 @@<=
/span><br><span>       CC: ${{matrix.cc}}</span><br><span>       CXX: ${{ma=
trix.cxx}}</span><br><span>       UBSAN_OPTIONS: print_stacktrace=3D1</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-      AWS_LC_INSTALL: ${{ g=
ithub.workspace }}/aws-lc/aws-lc-install</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+      AWS_LC_INSTALL: /opt/aws-lc</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+      AWS_LC_VERSION: v1.70.0</span><br>=
<span> </span><br><span>     steps:</span><br><span>       - name: Install =
dependencies</span><br><span>         run: sudo apt update &amp;&amp; sudo =
apt install -y gcc golang make liblzo2-dev libpam0g-dev liblz4-dev linux-li=
bc-dev man2html clang libcmocka-dev python3-docutils python3-jinja2 python3=
-jsonschema libtool automake autoconf pkg-config libcap-ng-dev libnl-genl-3=
-dev</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      - name: R=
estore AWS-LC from cache</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        uses: actions/cache@...3010...</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        id: aws-lc-cache</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        with:</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+          path: ${{ env.AWS_LC_INSTALL }}</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+          key: ${{ matrix.os }=
}-aws-lc-${{ env.AWS_LC_VERSION }}</span><br><span>       - name: &quot;AWS=
-LC: checkout&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        if: steps.aws-lc-cache.outputs.cache-hit !=3D &#39;true&#39;</span>=
<br><span>         uses: actions/checkout@...2998... # v6.0.2</span><br><sp=
an>         with:</span><br><span>           path: aws-lc</span><br><span> =
          # versioning=3Dsemver-coerced</span><br><span>           reposito=
ry: aws/aws-lc</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
   ref: v1.67.0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
      ref: ${{ env.AWS_LC_VERSION }}</span><br><span>       - uses: lukka/g=
et-cmake@...2999... # v4.2.3</span><br><span>       - name: &quot;AWS-LC: b=
uild&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=
f: steps.aws-lc-cache.outputs.cache-hit !=3D &#39;true&#39;</span><br><span=
>         run: |</span><br><span>           mkdir build</span><br><span>   =
        cd build</span><br><span>@@ -478,12 +487,14 @@</span><br><span>    =
     uses: actions/checkout@...2998... # v6.0.2</span><br><span>       - na=
me: autoconf</span><br><span>         run: autoreconf -fvi</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+      - name: list aws-lc install</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        run: find ${{ =
env.AWS_LC_INSTALL }}</span><br><span>       - name: configure with AWS-LC<=
/span><br><span>         run: |</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-          OPENSSL_CFLAGS=3D&quot;-I/${{ env.AWS_LC_INSTALL }}/inc=
lude&quot; \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
 OPENSSL_LIBS=3D&quot;-L/${{ env.AWS_LC_INSTALL }}/lib -lssl -lcrypto&quot;=
 \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          LDFLAGS=
=3D&quot;-Wl,-rpath=3D/${{ env.AWS_LC_INSTALL }}/lib&quot; \</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-          ./configure --with-crypto-=
library=3Dopenssl --enable-werror</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+          OPENSSL_CFLAGS=3D&quot;-I${{ env.AWS_LC_INSTALL }}/=
include&quot; \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
      OPENSSL_LIBS=3D&quot;-L${{ env.AWS_LC_INSTALL }}/lib -lssl -lcrypto&q=
uot; \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          LDF=
LAGS=3D&quot;-Wl,-rpath=3D${{ env.AWS_LC_INSTALL }}/lib&quot; \</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+          ./configure --with-cr=
ypto-library=3Dopenssl</span><br><span>       - name: make all</span><br><s=
pan>         run: make -j3</span><br><span>       - name: configure checks<=
/span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/1565?usp=3Demail">change 1565</a>. To unsubscribe,=
 or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.n=
et/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http:/=
/schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"ht=
tp://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/1565?usp=3Demail"/><meta itemprop=3D"name" content=3D=
"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I090f5b201d67f51d2e42df1914a=
8466bcfcb6bf8 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1565 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--ESbVeoG0mDE=--

