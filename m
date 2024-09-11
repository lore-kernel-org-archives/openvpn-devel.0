From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 11 Sep 2024 14:33:42 +0000
References: <gerrit.1726065220000.I86203b8f9a6d3cfc5e56d3ce9452af694fd11011@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <73512253abd82a644d72f5c297ac252926f6e0d4-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mOivqnrsD6U="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: GHA: Enable
 t_server_null tests
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

--mOivqnrsD6U=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/743?usp=3Demail

to review the following change.


Change subject: GHA: Enable t_server_null tests
......................................................................

GHA: Enable t_server_null tests

Change-Id: I86203b8f9a6d3cfc5e56d3ce9452af694fd11011
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M .github/workflows/build.yaml
1 file changed, 16 insertions(+), 5 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/43/743/1

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 8f0a7b5..361d457 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -172,8 +172,11 @@
         run: ./configure --with-crypto-library=3D${{matrix.ssllib}} ${{mat=
rix.extraconf}} --enable-werror
       - name: make all
         run: make -j3
+      - name: configure checks
+        if: ${{ matrix.extraconf !=3D '--disable-management' }}
+        run: echo 'RUN_SUDO=3D"sudo -E"' >tests/t_server_null.rc
       - name: make check
-        run: make check VERBOSE=3D1
+        run: make -j3 check VERBOSE=3D1

   ubuntu-clang-asan:
     strategy:
@@ -199,8 +202,10 @@
         run: CFLAGS=3D"-fsanitize=3Daddress,undefined -fno-sanitize-recove=
r=3Dall  -fno-omit-frame-pointer -O2" CC=3Dclang ./configure --with-crypto-=
library=3D${{matrix.ssllib}} --enable-werror
       - name: make all
         run: make -j3
+      - name: configure checks
+        run: echo 'RUN_SUDO=3D"sudo -E"' >tests/t_server_null.rc
       - name: make check
-        run: make check VERBOSE=3D1
+        run: make -j3 check VERBOSE=3D1
=20
   macos:
     strategy:
@@ -258,8 +263,10 @@
         run: ./configure --enable-werror ${{matrix.configureflags}} ${{mat=
rix.configuressllib}}
       - name: make all
         run: make -j4
+      - name: configure checks
+        run: echo 'RUN_SUDO=3D"sudo -E"' >tests/t_server_null.rc
       - name: make check
-        run: make check VERBOSE=3D1
+        run: make -j4 check VERBOSE=3D1

   msvc:
       strategy:
@@ -369,8 +376,10 @@
         run: ./configure --with-crypto-library=3Dopenssl ${{matrix.configu=
reflags}} --enable-werror
       - name: make all
         run: make -j3
+      - name: configure checks
+        run: echo 'RUN_SUDO=3D"sudo -E"' >tests/t_server_null.rc
       - name: make check
-        run: make check VERBOSE=3D1
+        run: make -j3 check VERBOSE=3D1

   mbedtls3:
     strategy:
@@ -422,5 +431,7 @@
         run: ./configure --with-crypto-library=3Dmbedtls
       - name: make all
         run: make -j3
+      - name: configure checks
+        run: echo 'RUN_SUDO=3D"sudo -E"' >tests/t_server_null.rc
       - name: make check
-        run: make check VERBOSE=3D1
+        run: make -j3 check VERBOSE=3D1

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/743?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I86203b8f9a6d3cfc5e56d3ce9452af694fd11011
Gerrit-Change-Number: 743
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--mOivqnrsD6U=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/743?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">GHA: Enable t_server_null tests<br><br>Change-Id: I86203b8f9a=
6d3cfc5e56d3ce9452af694fd11011<br>Signed-off-by: Frank Lichtenheld &lt;fran=
k@...2641...&gt;<br>---<br>M .github/workflows/build.yaml<br>1 file changed=
, 16 insertions(+), 5 deletions(-)<br><br></pre><pre style=3D"font-family: =
monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.=
net:29418/openvpn refs/changes/43/743/1</pre><pre style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;"><span>diff --git a/.github/workfl=
ows/build.yaml b/.github/workflows/build.yaml</span><br><span>index 8f0a7b5=
..361d457 100644</span><br><span>--- a/.github/workflows/build.yaml</span><=
br><span>+++ b/.github/workflows/build.yaml</span><br><span>@@ -172,8 +172,=
11 @@</span><br><span>         run: ./configure --with-crypto-library=3D${{=
matrix.ssllib}} ${{matrix.extraconf}} --enable-werror</span><br><span>     =
  - name: make all</span><br><span>         run: make -j3</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+      - name: configure checks</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        if: ${{ matrix.ext=
raconf !=3D &#39;--disable-management&#39; }}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        run: echo &#39;RUN_SUDO=3D&quot;sudo -E&q=
uot;&#39; &gt;tests/t_server_null.rc</span><br><span>       - name: make ch=
eck</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        run: make =
check VERBOSE=3D1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      run: make -j3 check VERBOSE=3D1</span><br><span> </span><br><span>   =
ubuntu-clang-asan:</span><br><span>     strategy:</span><br><span>@@ -199,8=
 +202,10 @@</span><br><span>         run: CFLAGS=3D&quot;-fsanitize=3Daddre=
ss,undefined -fno-sanitize-recover=3Dall  -fno-omit-frame-pointer -O2&quot;=
 CC=3Dclang ./configure --with-crypto-library=3D${{matrix.ssllib}} --enable=
-werror</span><br><span>       - name: make all</span><br><span>         ru=
n: make -j3</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      - =
name: configure checks</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        run: echo &#39;RUN_SUDO=3D&quot;sudo -E&quot;&#39; &gt;tests/t_s=
erver_null.rc</span><br><span>       - name: make check</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        run: make check VERBOSE=3D1</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        run: make -j3 che=
ck VERBOSE=3D1</span><br><span> </span><br><span>   macos:</span><br><span>=
     strategy:</span><br><span>@@ -258,8 +263,10 @@</span><br><span>       =
  run: ./configure --enable-werror ${{matrix.configureflags}} ${{matrix.con=
figuressllib}}</span><br><span>       - name: make all</span><br><span>    =
     run: make -j4</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
     - name: configure checks</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        run: echo &#39;RUN_SUDO=3D&quot;sudo -E&quot;&#39; &gt;te=
sts/t_server_null.rc</span><br><span>       - name: make check</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        run: make check VERBOSE=3D=
1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        run: make =
-j4 check VERBOSE=3D1</span><br><span> </span><br><span>   msvc:</span><br>=
<span>       strategy:</span><br><span>@@ -369,8 +376,10 @@</span><br><span=
>         run: ./configure --with-crypto-library=3Dopenssl ${{matrix.config=
ureflags}} --enable-werror</span><br><span>       - name: make all</span><b=
r><span>         run: make -j3</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+      - name: configure checks</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        run: echo &#39;RUN_SUDO=3D&quot;sudo -E&quot;=
&#39; &gt;tests/t_server_null.rc</span><br><span>       - name: make check<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        run: make chec=
k VERBOSE=3D1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  run: make -j3 check VERBOSE=3D1</span><br><span> </span><br><span>   mbed=
tls3:</span><br><span>     strategy:</span><br><span>@@ -422,5 +431,7 @@</s=
pan><br><span>         run: ./configure --with-crypto-library=3Dmbedtls</sp=
an><br><span>       - name: make all</span><br><span>         run: make -j3=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      - name: confi=
gure checks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
run: echo &#39;RUN_SUDO=3D&quot;sudo -E&quot;&#39; &gt;tests/t_server_null.=
rc</span><br><span>       - name: make check</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        run: make check VERBOSE=3D1</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        run: make -j3 check VERBOSE=
=3D1</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://g=
errit.openvpn.net/c/openvpn/+/743?usp=3Demail">change 743</a>. To unsubscri=
be, or for help writing mail filters, visit <a href=3D"http://gerrit.openvp=
n.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.o=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/743?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chan=
ge"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I86203b8f9a6d3cfc5e56d3ce945=
2af694fd11011 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 743 </div>
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


--mOivqnrsD6U=--

