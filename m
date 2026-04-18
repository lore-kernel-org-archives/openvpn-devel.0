From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 18 Apr 2026 19:00:12 +0000
In-Reply-To: <gerrit.1774997396000.Ic9c993cb8dcfedfd6f99f416c286e0968eb45255@...2715...>
References: <gerrit.1774997396000.Ic9c993cb8dcfedfd6f99f416c286e0968eb45255@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <77e39bc812f2478cfc2627b722b54c04c9a1dbee-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="nUG1zOOG17M="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: GHA: Add OpenSSL 4.0
 build
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

--nUG1zOOG17M=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/1601?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


Change subject: GHA: Add OpenSSL 4.0 build
......................................................................

GHA: Add OpenSSL 4.0 build

Change-Id: Ic9c993cb8dcfedfd6f99f416c286e0968eb45255
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1601
Message-Id: <20260417110942.16538-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36=
648.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M .github/workflows/build.yaml
1 file changed, 81 insertions(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/01/1601/4

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 186662d..365e72a 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -390,6 +390,87 @@
       - name: make check
         run: make -j3 check VERBOSE=3D1

+  openssl:
+    strategy:
+      fail-fast: false
+      matrix:
+        os: [ubuntu-24.04]
+        ssllib: [openssl]
+        build: [ normal, asan ]
+        configureflags: ["--with-openssl-engine=3Dno"]
+        include:
+          - build: asan
+            cflags: "-fsanitize=3Daddress -fno-sanitize-recover=3Dall  -fn=
o-optimize-sibling-calls -fsanitize-address-use-after-scope -fno-omit-frame=
-pointer -g -O1"
+            ldflags: -fsanitize=3Daddress -fno-sanitize-recover=3Dall
+            cc: clang
+          - build: normal
+            cflags: "-O2 -g"
+            ldflags: ""
+            cc: gcc
+
+    name: "${{matrix.cc}} ${{matrix.build}} - ${{matrix.os}} - ${{matrix.s=
sllib}} - 4.0"
+    runs-on: ${{matrix.os}}
+    env:
+      CFLAGS: ${{ matrix.cflags }}
+      LDFLAGS: ${{ matrix.ldflags }}
+      CC: ${{matrix.cc}}
+      UBSAN_OPTIONS: print_stacktrace=3D1
+      # versioning=3Dsemver-coerced
+      OPENSSL_REPO: openssl/openssl
+      OPENSSL_VERSION: openssl-4.0.0-beta1
+      OPENSSL_INSTALL: /opt/openssl
+
+    steps:
+      - name: Install dependencies
+        run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-d=
ev liblz4-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils =
libtool automake autoconf pkg-config libcap-ng-dev libnl-genl-3-dev
+      - name: Restore OpenSSL 4.0 from cache
+        uses: actions/cache@...3010...
+        id: openssl-cache
+        with:
+          path: ${{ env.OPENSSL_INSTALL }}
+          key: ${{ matrix.os }}-openssl-${{matrix.build }}-${{ env.OPENSSL=
_VERSION }}
+      - name: "openssl: checkout"
+        if: steps.openssl-cache.outputs.cache-hit !=3D 'true'
+        uses: actions/checkout@...2998... # v6.0.2
+        with:
+          path: openssl
+          repository: ${{ env.OPENSSL_REPO }}
+          ref: ${{ env.OPENSSL_VERSION }}
+      - name: "openssl: configure"
+        if: steps.openssl-cache.outputs.cache-hit !=3D 'true'
+        run: ./Configure  --prefix=3D${{ env.OPENSSL_INSTALL }} --libdir=
=3D${{ env.OPENSSL_INSTALL }}/lib --openssldir=3D${{ env.OPENSSL_INSTALL }}=
 -g
+        working-directory: openssl
+      - name: "openssl: make all"
+        if: steps.openssl-cache.outputs.cache-hit !=3D 'true'
+        run: make -j3
+        working-directory: openssl
+      - name: "openssl: make install"
+        if: steps.openssl-cache.outputs.cache-hit !=3D 'true'
+        run: sudo make install
+        working-directory: openssl
+      - name: "ldconfig"
+        run: sudo ldconfig
+      - name: Checkout OpenVPN
+        uses: actions/checkout@...2998... # v6.0.2
+      - name: autoconf
+        run: autoreconf -fvi
+      - name: configure
+        run: |
+          OPENSSL_CFLAGS=3D"-I${{ env.OPENSSL_INSTALL }}/include" \
+          OPENSSL_LIBS=3D"-L${{ env.OPENSSL_INSTALL }}/lib -lssl -lcrypto"=
 \
+          LDFLAGS=3D"-Wl,-rpath=3D${{ env.OPENSSL_INSTALL }}/lib" \
+          ./configure --with-crypto-library=3Dopenssl --enable-werror ${{m=
atrix.configureflags}}
+      - name: make all
+        run: make -j3
+      - name: Ensure the build uses Openssl
+        run: |
+          ./src/openvpn/openvpn --version
+          ./src/openvpn/openvpn --version | grep -q "library versions: Ope=
nSSL 4.0"
+      - name: configure checks
+        run: echo 'RUN_SUDO=3D"sudo -E"' >tests/t_server_null.rc
+      - name: make check
+        run: make -j3 check VERBOSE=3D1
+
   mbedtls4:
     strategy:
       fail-fast: false

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1601?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic9c993cb8dcfedfd6f99f416c286e0968eb45255
Gerrit-Change-Number: 1601
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--nUG1zOOG17M=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #4</strong> to the change originally created by plaisthos.<=
/p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1601?usp=3Demail">Vi=
ew Change</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld</p><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">GHA: Add OpenSSL 4.0 build<b=
r><br>Change-Id: Ic9c993cb8dcfedfd6f99f416c286e0968eb45255<br>Signed-off-by=
: Arne Schwabe &lt;arne@...1227...&gt;<br>Acked-by: Frank Lichtenheld &lt;f=
rank@...2641...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1=
601<br>Message-Id: &lt;20260417110942.16538-1-gert@...1296...&gt;<br>URL: h=
ttps://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36648.ht=
ml<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M .gith=
ub/workflows/build.yaml<br>1 file changed, 81 insertions(+), 0 deletions(-)=
<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn=
 refs/changes/01/1601/4</pre><pre style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;"><span>diff --git a/.github/workflows/build.yaml b=
/.github/workflows/build.yaml</span><br><span>index 186662d..365e72a 100644=
</span><br><span>--- a/.github/workflows/build.yaml</span><br><span>+++ b/.=
github/workflows/build.yaml</span><br><span>@@ -390,6 +390,87 @@</span><br>=
<span>       - name: make check</span><br><span>         run: make -j3 chec=
k VERBOSE=3D1</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  openssl:</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    strategy:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
   fail-fast: false</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
      matrix:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  os: [ubuntu-24.04]</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        ssllib: [openssl]</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        build: [ normal, asan ]</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        configureflags: [&quot;--with-openssl-engine=3Dn=
o&quot;]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        inc=
lude:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          - bu=
ild: asan</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  cflags: &quot;-fsanitize=3Daddress -fno-sanitize-recover=3Dall  -fno-opti=
mize-sibling-calls -fsanitize-address-use-after-scope -fno-omit-frame-point=
er -g -O1&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        ldflags: -fsanitize=3Daddress -fno-sanitize-recover=3Dall</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            cc: clang</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+          - build: normal</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            cflags: &=
quot;-O2 -g&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          ldflags: &quot;&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            cc: gcc</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    nam=
e: &quot;${{matrix.cc}} ${{matrix.build}} - ${{matrix.os}} - ${{matrix.ssll=
ib}} - 4.0&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 runs-on: ${{matrix.os}}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    env:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
CFLAGS: ${{ matrix.cflags }}</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+      LDFLAGS: ${{ matrix.ldflags }}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+      CC: ${{matrix.cc}}</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+      UBSAN_OPTIONS: print_stacktrace=3D1</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+      # versioning=3Ds=
emver-coerced</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
OPENSSL_REPO: openssl/openssl</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+      OPENSSL_VERSION: openssl-4.0.0-beta1</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+      OPENSSL_INSTALL: /opt/openssl</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    steps:</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+      - name: Install dependencies</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        run: sudo apt update &amp;&amp=
; sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev linux-libc-dev ma=
n2html clang libcmocka-dev python3-docutils libtool automake autoconf pkg-c=
onfig libcap-ng-dev libnl-genl-3-dev</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+      - name: Restore OpenSSL 4.0 from cache</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        uses: actions/cache@...3021...=
10...</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        id: op=
enssl-cache</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
with:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          path=
: ${{ env.OPENSSL_INSTALL }}</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+          key: ${{ matrix.os }}-openssl-${{matrix.build }}-${{ env=
.OPENSSL_VERSION }}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
      - name: &quot;openssl: checkout&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        if: steps.openssl-cache.outputs.cache-hit !=
=3D &#39;true&#39;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       uses: actions/checkout@...2998... # v6.0.2</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        with:</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+          path: openssl</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+          repository: ${{ env.OPENSSL_REPO }}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+          ref: ${{ en=
v.OPENSSL_VERSION }}</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+      - name: &quot;openssl: configure&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        if: steps.openssl-cache.outputs.cache-hit=
 !=3D &#39;true&#39;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        run: ./Configure  --prefix=3D${{ env.OPENSSL_INSTALL }} --libdir=
=3D${{ env.OPENSSL_INSTALL }}/lib --openssldir=3D${{ env.OPENSSL_INSTALL }}=
 -g</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        working-=
directory: openssl</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
     - name: &quot;openssl: make all&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        if: steps.openssl-cache.outputs.cache-hit !=
=3D &#39;true&#39;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       run: make -j3</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        working-directory: openssl</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+      - name: &quot;openssl: make install&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        if: steps.openssl-cache=
.outputs.cache-hit !=3D &#39;true&#39;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        run: sudo make install</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        working-directory: openssl</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+      - name: &quot;ldconfig&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        run: su=
do ldconfig</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      - =
name: Checkout OpenVPN</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        uses: actions/checkout@...2998... # v6.0.2</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+      - name: autoconf</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        run: autoreconf -fvi</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+      - name: configure</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        run: |</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+          OPENSSL_CFLAGS=3D&qu=
ot;-I${{ env.OPENSSL_INSTALL }}/include&quot; \</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+          OPENSSL_LIBS=3D&quot;-L${{ env.OPENSS=
L_INSTALL }}/lib -lssl -lcrypto&quot; \</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+          LDFLAGS=3D&quot;-Wl,-rpath=3D${{ env.OPENSSL_=
INSTALL }}/lib&quot; \</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+          ./configure --with-crypto-library=3Dopenssl --enable-werror ${=
{matrix.configureflags}}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+      - name: make all</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        run: make -j3</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+      - name: Ensure the build uses Openssl</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        run: |</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+          ./src/openvpn/openvpn --version</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+          ./src/openvpn/=
openvpn --version | grep -q &quot;library versions: OpenSSL 4.0&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+      - name: configure c=
hecks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        run: e=
cho &#39;RUN_SUDO=3D&quot;sudo -E&quot;&#39; &gt;tests/t_server_null.rc</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+      - name: make chec=
k</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        run: make =
-j3 check VERBOSE=3D1</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span>   mbedtls4:</span><br><span>     strategy:</span><br><s=
pan>       fail-fast: false</span><br><span></span><br></pre><p>To view, vi=
sit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1601?usp=3Demail">chan=
ge 1601</a>. To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div =
itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"u=
rl" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1601?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic9c993cb8dcfedfd6f99f416c28=
6e0968eb45255 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1601 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--nUG1zOOG17M=--

