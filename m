From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 22 Oct 2023 11:03:25 +0000
In-Reply-To: <gerrit.1697649699000.I204b396dea9f22d68e8e091d181a85ffebde4c17@...2715...>
References: <gerrit.1697649699000.I204b396dea9f22d68e8e091d181a85ffebde4c17@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <4f2d6fb554b2b9d1a9840ffcaf71bad83eba7469-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="s9KVGJ2xeKI="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Add undefined and
 abort on error to clang sanitize builds
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

--s9KVGJ2xeKI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/37=
5?usp=3Demail )

Change subject: Add undefined and abort on error to clang sanitize builds
......................................................................

Add undefined and abort on error to clang sanitize builds

The -fno-sanitize-recover=3Dall flag ensures that for all errors we actually
abort the tests in the automated testing and not just print some errors in =
red
that nobody sees. Also add the undefined tests to catch more bugs.

For libreSSL we do not add the udefined behaviour as we have (even with the
latest LibreSSL version) an undefined behaviour in LibreSSL itself.

Change-Id: I204b396dea9f22d68e8e091d181a85ffebde4c17
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20231022105756.21080-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27=
278.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M .github/workflows/build.yaml
1 file changed, 5 insertions(+), 5 deletions(-)




diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 58fbc29..06567e0 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -186,7 +186,7 @@
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
-        run: CFLAGS=3D"-fsanitize=3Daddress -fno-omit-frame-pointer -O2" C=
C=3Dclang ./configure --with-crypto-library=3D${{matrix.ssllib}}
+        run: CFLAGS=3D"-fsanitize=3Daddress,undefined -fno-sanitize-recove=
r=3Dall  -fno-omit-frame-pointer -O2" CC=3Dclang ./configure --with-crypto-=
library=3D${{matrix.ssllib}}
       - name: make all
         run: make -j3
       - name: make check
@@ -201,8 +201,8 @@
         os: [macos-11, macos-12, macos-13]
         include:
           - build: asan
-            cflags: "-fsanitize=3Daddress -fno-optimize-sibling-calls -fsa=
nitize-address-use-after-scope -fno-omit-frame-pointer -g -O1"
-            ldflags: -fsanitize=3Daddress
+            cflags: "-fsanitize=3Daddress,undefined -fno-sanitize-recover=
=3Dall  -fno-optimize-sibling-calls -fsanitize-address-use-after-scope -fno=
-omit-frame-pointer -g -O1"
+            ldflags: -fsanitize=3Daddress,undefined -fno-sanitize-recover=
=3Dall
             # Our build system ignores LDFLAGS for plugins
             configureflags: --disable-plugin-auth-pam  --disable-plugin-do=
wn-root
           - build: normal
@@ -300,8 +300,8 @@
         configureflags: ["--with-openssl-engine=3Dno"]
         include:
           - build: asan
-            cflags: "-fsanitize=3Daddress -fno-optimize-sibling-calls -fsa=
nitize-address-use-after-scope -fno-omit-frame-pointer -g -O1"
-            ldflags: -fsanitize=3Daddress
+            cflags: "-fsanitize=3Daddress -fno-sanitize-recover=3Dall  -fn=
o-optimize-sibling-calls -fsanitize-address-use-after-scope -fno-omit-frame=
-pointer -g -O1"
+            ldflags: -fsanitize=3Daddress -fno-sanitize-recover=3Dall
             cc: clang
           - build: normal
             cflags: "-O2 -g"

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/375?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I204b396dea9f22d68e8e091d181a85ffebde4c17
Gerrit-Change-Number: 375
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--s9KVGJ2xeKI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/375?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Add undefined and abort on error to clang sani=
tize builds<br><br>The -fno-sanitize-recover=3Dall flag ensures that for al=
l errors we actually<br>abort the tests in the automated testing and not ju=
st print some errors in red<br>that nobody sees. Also add the undefined tes=
ts to catch more bugs.<br><br>For libreSSL we do not add the udefined behav=
iour as we have (even with the<br>latest LibreSSL version) an undefined beh=
aviour in LibreSSL itself.<br><br>Change-Id: I204b396dea9f22d68e8e091d181a8=
5ffebde4c17<br>Acked-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Mess=
age-Id: &lt;20231022105756.21080-1-gert@...1296...&gt;<br>URL: https://www.=
mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27278.html<br>Signe=
d-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M .github/workflow=
s/build.yaml<br>1 file changed, 5 insertions(+), 5 deletions(-)<br><br></pr=
e>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml=
</span><br><span>index 58fbc29..06567e0 100644</span><br><span>--- a/.githu=
b/workflows/build.yaml</span><br><span>+++ b/.github/workflows/build.yaml</=
span><br><span>@@ -186,7 +186,7 @@</span><br><span>       - name: autoconf<=
/span><br><span>         run: autoreconf -fvi</span><br><span>       - name=
: configure</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ru=
n: CFLAGS=3D&quot;-fsanitize=3Daddress -fno-omit-frame-pointer -O2&quot; CC=
=3Dclang ./configure --with-crypto-library=3D${{matrix.ssllib}}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        run: CFLAGS=3D&quot;-fs=
anitize=3Daddress,undefined -fno-sanitize-recover=3Dall  -fno-omit-frame-po=
inter -O2&quot; CC=3Dclang ./configure --with-crypto-library=3D${{matrix.ss=
llib}}</span><br><span>       - name: make all</span><br><span>         run=
: make -j3</span><br><span>       - name: make check</span><br><span>@@ -20=
1,8 +201,8 @@</span><br><span>         os: [macos-11, macos-12, macos-13]</=
span><br><span>         include:</span><br><span>           - build: asan</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            cflags: &qu=
ot;-fsanitize=3Daddress -fno-optimize-sibling-calls -fsanitize-address-use-=
after-scope -fno-omit-frame-pointer -g -O1&quot;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            ldflags: -fsanitize=3Daddress</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            cflags: &quot;=
-fsanitize=3Daddress,undefined -fno-sanitize-recover=3Dall  -fno-optimize-s=
ibling-calls -fsanitize-address-use-after-scope -fno-omit-frame-pointer -g =
-O1&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  ldflags: -fsanitize=3Daddress,undefined -fno-sanitize-recover=3Dall</span=
><br><span>             # Our build system ignores LDFLAGS for plugins</spa=
n><br><span>             configureflags: --disable-plugin-auth-pam  --disab=
le-plugin-down-root</span><br><span>           - build: normal</span><br><s=
pan>@@ -300,8 +300,8 @@</span><br><span>         configureflags: [&quot;--w=
ith-openssl-engine=3Dno&quot;]</span><br><span>         include:</span><br>=
<span>           - build: asan</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            cflags: &quot;-fsanitize=3Daddress -fno-optimize-sibli=
ng-calls -fsanitize-address-use-after-scope -fno-omit-frame-pointer -g -O1&=
quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ldfl=
ags: -fsanitize=3Daddress</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            cflags: &quot;-fsanitize=3Daddress -fno-sanitize-recover=
=3Dall  -fno-optimize-sibling-calls -fsanitize-address-use-after-scope -fno=
-omit-frame-pointer -g -O1&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            ldflags: -fsanitize=3Daddress -fno-sanitize-recove=
r=3Dall</span><br><span>             cc: clang</span><br><span>           -=
 build: normal</span><br><span>             cflags: &quot;-O2 -g&quot;</spa=
n><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/375?usp=3Demail">change 375</a>. To unsubscribe, or fo=
r help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/set=
tings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailM=
essage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vi=
ewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/375?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></di=
v></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I204b396dea9f22d68e8e091d181=
a85ffebde4c17 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 375 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--s9KVGJ2xeKI=--

