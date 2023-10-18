From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 18 Oct 2023 17:21:43 +0000
References: <gerrit.1697649699000.I204b396dea9f22d68e8e091d181a85ffebde4c17@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <d19c133808c950211867a54f65bd990cc228ef28-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="OH3g6y/LPJ8="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Add undefined and
 abort on error to clang sanaitize builds
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

--OH3g6y/LPJ8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/375?usp=3Demail

to review the following change.


Change subject: Add undefined and abort on error to clang sanaitize builds
......................................................................

Add undefined and abort on error to clang sanaitize builds

The -fno-sanitize-recover=3Dall flag ensures that for all errors we actually
abort the tests in the automated testing and not just print some errors in =
red
that nobody sess. Also add the undefined tests to catch more bugs.

For libreSSL we do not add the udefined behaviour as we have (even with the
latest LibreSSL version) an undefined behaviour in LibreSSL itself.

Change-Id: I204b396dea9f22d68e8e091d181a85ffebde4c17
---
M .github/workflows/build.yaml
1 file changed, 5 insertions(+), 5 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/75/375/1

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 58fbc29..2a25582 100644
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
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--OH3g6y/LPJ8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/375?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Add undefined and abort on error to clang sanaitize builds<br=
><br>The -fno-sanitize-recover=3Dall flag ensures that for all errors we ac=
tually<br>abort the tests in the automated testing and not just print some =
errors in red<br>that nobody sess. Also add the undefined tests to catch mo=
re bugs.<br><br>For libreSSL we do not add the udefined behaviour as we hav=
e (even with the<br>latest LibreSSL version) an undefined behaviour in Libr=
eSSL itself.<br><br>Change-Id: I204b396dea9f22d68e8e091d181a85ffebde4c17<br=
>---<br>M .github/workflows/build.yaml<br>1 file changed, 5 insertions(+), =
5 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn re=
fs/changes/75/375/1</pre><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;"><span>diff --git a/.github/workflows/build.yaml b/.gi=
thub/workflows/build.yaml</span><br><span>index 58fbc29..2a25582 100644</sp=
an><br><span>--- a/.github/workflows/build.yaml</span><br><span>+++ b/.gith=
ub/workflows/build.yaml</span><br><span>@@ -186,7 +186,7 @@</span><br><span=
>       - name: autoconf</span><br><span>         run: autoreconf -fvi</spa=
n><br><span>       - name: configure</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        run: CFLAGS=3D&quot;-fsanitize=3Daddress -fno-omit-f=
rame-pointer -O2&quot; CC=3Dclang ./configure --with-crypto-library=3D${{ma=
trix.ssllib}}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  run: CFLAGS=3D&quot;-fsanitize=3Daddress,undefined -fno-sanitize-recover=
=3Dall  -fno-omit-frame-pointer -O2&quot; CC=3Dclang ./configure --with-cry=
pto-library=3D${{matrix.ssllib}}</span><br><span>       - name: make all</s=
pan><br><span>         run: make -j3</span><br><span>       - name: make ch=
eck</span><br><span>@@ -201,8 +201,8 @@</span><br><span>         os: [macos=
-11, macos-12, macos-13]</span><br><span>         include:</span><br><span>=
           - build: asan</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            cflags: &quot;-fsanitize=3Daddress -fno-optimize-sibling-cal=
ls -fsanitize-address-use-after-scope -fno-omit-frame-pointer -g -O1&quot;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ldflags: -=
fsanitize=3Daddress</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            cflags: &quot;-fsanitize=3Daddress,undefined -fno-sanitize-reco=
ver=3Dall  -fno-optimize-sibling-calls -fsanitize-address-use-after-scope -=
fno-omit-frame-pointer -g -O1&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            ldflags: -fsanitize=3Daddress,undefined -fno-sa=
nitize-recover=3Dall </span><br><span>             # Our build system ignor=
es LDFLAGS for plugins</span><br><span>             configureflags: --disab=
le-plugin-auth-pam  --disable-plugin-down-root</span><br><span>           -=
 build: normal</span><br><span>@@ -300,8 +300,8 @@</span><br><span>        =
 configureflags: [&quot;--with-openssl-engine=3Dno&quot;]</span><br><span> =
        include:</span><br><span>           - build: asan</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            cflags: &quot;-fsanitize=3D=
address -fno-optimize-sibling-calls -fsanitize-address-use-after-scope -fno=
-omit-frame-pointer -g -O1&quot;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            ldflags: -fsanitize=3Daddress</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            cflags: &quot;-fsanitize=3Dad=
dress -fno-sanitize-recover=3Dall  -fno-optimize-sibling-calls -fsanitize-a=
ddress-use-after-scope -fno-omit-frame-pointer -g -O1&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            ldflags: -fsanitize=3Da=
ddress -fno-sanitize-recover=3Dall</span><br><span>             cc: clang</=
span><br><span>           - build: normal</span><br><span>             cfla=
gs: &quot;-O2 -g&quot;</span><br><span></span><br></pre><p>To view, visit <=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/375?usp=3Demail">change 375=
</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"ht=
tp://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/375?usp=3Demail"/><meta itemprop=3D"name" c=
ontent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I204b396dea9f22d68e8e091d181=
a85ffebde4c17 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 375 </div>
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


--OH3g6y/LPJ8=--

