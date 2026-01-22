From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Thu, 22 Jan 2026 15:15:54 +0000
In-Reply-To: <gerrit.1768409585000.I658b1b24da304938225a8f834d7484671a63360f@...2715...>
References: <gerrit.1768409585000.I658b1b24da304938225a8f834d7484671a63360f@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <21dcb5e3f43377e745a445018dca14018afc7078-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="bH9WUQgHP/0="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: GHA: Update mbedtls
 to v4
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

--bH9WUQgHP/0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, uddr,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1474?usp=3Demail

to look at the new patch set (#2).

The change is no longer submittable: checks~ChecksSubmitRule is unsatisfied=
 now.


Change subject: GHA: Update mbedtls to v4
......................................................................

GHA: Update mbedtls to v4

Also switch from Make to CMake for building it
because the former is not supported anymore.

Change-Id: I658b1b24da304938225a8f834d7484671a63360f
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M .github/workflows/build.yaml
1 file changed, 12 insertions(+), 8 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/74/1474/2

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index d1322c7..ef9b3f5 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -366,12 +366,12 @@
       - name: make check
         run: make -j3 check VERBOSE=3D1

-  mbedtls3:
+  mbedtls4:
     strategy:
       fail-fast: false
       matrix:
         os: [ubuntu-22.04]
-        ssllib: [mbedtls3]
+        ssllib: [mbedtls4]
         build: [ normal, asan ]
         include:
           - build: asan
@@ -398,15 +398,19 @@
         uses: actions/checkout@...2977... # v6.0.1
         with:
           path: mbedtls
-          submodules: true
+          submodules: recursive
           # versioning=3Dsemver-coerced
           repository: Mbed-TLS/mbedtls
-          ref: v3.6.5
-      - name: "mbedtls: make no_test"
-        run: make -j3 no_test SHARED=3D1
+          ref: v4.0.0
+      - uses: lukka/get-cmake@...2927... # v4.1.1
+      - name: "mbedtls: cmake"
+        run: cmake -B build
         working-directory: mbedtls
-      - name: "mbedtls: make install"
-        run: sudo make install DESTDIR=3D/usr
+      - name: "mbedtls: cmake --build"
+        run: cmake --build build
+        working-directory: mbedtls
+      - name: "mbedtls: cmake --install"
+        run: sudo cmake --install build --prefix /usr
         working-directory: mbedtls
       - name: Checkout OpenVPN
         uses: actions/checkout@...2977... # v6.0.1

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1474?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I658b1b24da304938225a8f834d7484671a63360f
Gerrit-Change-Number: 1474
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: uddr <yura.uddr@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--bH9WUQgHP/0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #2</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1474?usp=3Demail">View C=
hange</a></p><p>The change is no longer submittable: checks~ChecksSubmitRul=
e is unsatisfied now.</p><pre class=3D"blocks" style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;">GHA: Update mbedtls to v4<br><br>Als=
o switch from Make to CMake for building it<br>because the former is not su=
pported anymore.<br><br>Change-Id: I658b1b24da304938225a8f834d7484671a63360=
f<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M =
.github/workflows/build.yaml<br>1 file changed, 12 insertions(+), 8 deletio=
ns(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/op=
envpn refs/changes/74/1474/2</pre><pre style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;"><span>diff --git a/.github/workflows/build.y=
aml b/.github/workflows/build.yaml</span><br><span>index d1322c7..ef9b3f5 1=
00644</span><br><span>--- a/.github/workflows/build.yaml</span><br><span>++=
+ b/.github/workflows/build.yaml</span><br><span>@@ -366,12 +366,12 @@</spa=
n><br><span>       - name: make check</span><br><span>         run: make -j=
3 check VERBOSE=3D1</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-  mbedtls3:</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+  mbedtls4:</span><br><span>     strategy:</span><br><span>       f=
ail-fast: false</span><br><span>       matrix:</span><br><span>         os:=
 [ubuntu-22.04]</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  ssllib: [mbedtls3]</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        ssllib: [mbedtls4]</span><br><span>         build: [ normal, asan =
]</span><br><span>         include:</span><br><span>           - build: asa=
n</span><br><span>@@ -398,15 +398,19 @@</span><br><span>         uses: acti=
ons/checkout@...2977... # v6.0.1</span><br><span>         with:</span><br><=
span>           path: mbedtls</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-          submodules: true</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+          submodules: recursive</span><br><span>           #=
 versioning=3Dsemver-coerced</span><br><span>           repository: Mbed-TL=
S/mbedtls</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          re=
f: v3.6.5</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      - name=
: &quot;mbedtls: make no_test&quot;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        run: make -j3 no_test SHARED=3D1</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+          ref: v4.0.0</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+      - uses: lukka/get-cmake@...2939...=
.. # v4.1.1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      - =
name: &quot;mbedtls: cmake&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        run: cmake -B build</span><br><span>         working-d=
irectory: mbedtls</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
  - name: &quot;mbedtls: make install&quot;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        run: sudo make install DESTDIR=3D/usr</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+      - name: &quot;mbedtls=
: cmake --build&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        run: cmake --build build</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        working-directory: mbedtls</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+      - name: &quot;mbedtls: cmake --install&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        run: s=
udo cmake --install build --prefix /usr</span><br><span>         working-di=
rectory: mbedtls</span><br><span>       - name: Checkout OpenVPN</span><br>=
<span>         uses: actions/checkout@...2977... # v6.0.1</span><br><span><=
/span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/1474?usp=3Demail">change 1474</a>. To unsubscribe, or for help writ=
ing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=
=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org=
/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/1474?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I658b1b24da304938225a8f834d7=
484671a63360f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1474 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: uddr &lt;yura.uddr@...277...&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--bH9WUQgHP/0=--

