From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 24 Jan 2026 22:18:18 +0000
In-Reply-To: <gerrit.1768409585000.I658b1b24da304938225a8f834d7484671a63360f@...2715...>
References: <gerrit.1768409585000.I658b1b24da304938225a8f834d7484671a63360f@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 yura.uddr@...277...
Message-ID: <3da781fc107a86ca405f6c285dab65bbf350afab-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="zK0b5vdRkJU="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: uddr <yura.uddr@...277...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--zK0b5vdRkJU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/14=
74?usp=3Demail )

Change subject: GHA: Update mbedtls to v4
......................................................................

GHA: Update mbedtls to v4

Also switch from Make to CMake for building it
because the former is not supported anymore.

Change-Id: I658b1b24da304938225a8f834d7484671a63360f
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Yuriy Darnobyt <yura.uddr@...277...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1474
Message-Id: <20260124181814.30331-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
421.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M .github/workflows/build.yaml
1 file changed, 12 insertions(+), 8 deletions(-)




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

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I658b1b24da304938225a8f834d7484671a63360f
Gerrit-Change-Number: 1474
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: uddr <yura.uddr@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--zK0b5vdRkJU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1474?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">GHA: Update mbedtls to v4<br><br>Also switch fro=
m Make to CMake for building it<br>because the former is not supported anym=
ore.<br><br>Change-Id: I658b1b24da304938225a8f834d7484671a63360f<br>Signed-=
off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Yuriy Darno=
byt &lt;yura.uddr@...277...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c=
/openvpn/+/1474<br>Message-Id: &lt;20260124181814.30331-1-gert@...1296...&g=
t;<br>URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net=
/msg35421.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>--=
-<br>M .github/workflows/build.yaml<br>1 file changed, 12 insertions(+), 8 =
deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml=
</span><br><span>index d1322c7..ef9b3f5 100644</span><br><span>--- a/.githu=
b/workflows/build.yaml</span><br><span>+++ b/.github/workflows/build.yaml</=
span><br><span>@@ -366,12 +366,12 @@</span><br><span>       - name: make ch=
eck</span><br><span>         run: make -j3 check VERBOSE=3D1</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  mbedtls3:</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  mbedtls4:</span><br><spa=
n>     strategy:</span><br><span>       fail-fast: false</span><br><span>  =
     matrix:</span><br><span>         os: [ubuntu-22.04]</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        ssllib: [mbedtls3]</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        ssllib: [mbedtls4]</span>=
<br><span>         build: [ normal, asan ]</span><br><span>         include=
:</span><br><span>           - build: asan</span><br><span>@@ -398,15 +398,=
19 @@</span><br><span>         uses: actions/checkout@...2977... # v6.0.1</=
span><br><span>         with:</span><br><span>           path: mbedtls</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-          submodules: true=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          submodule=
s: recursive</span><br><span>           # versioning=3Dsemver-coerced</span=
><br><span>           repository: Mbed-TLS/mbedtls</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-          ref: v3.6.5</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-      - name: &quot;mbedtls: make no_test&quot=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        run: make -j=
3 no_test SHARED=3D1</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+          ref: v4.0.0</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+      - uses: lukka/get-cmake@...2927... # v4.1.1</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+      - name: &quot;mbedtls: cmake&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        run: cmake -=
B build</span><br><span>         working-directory: mbedtls</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-      - name: &quot;mbedtls: make ins=
tall&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        run=
: sudo make install DESTDIR=3D/usr</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+      - name: &quot;mbedtls: cmake --build&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        run: cmake --build buil=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        working-di=
rectory: mbedtls</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
   - name: &quot;mbedtls: cmake --install&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        run: sudo cmake --install build --prefi=
x /usr</span><br><span>         working-directory: mbedtls</span><br><span>=
       - name: Checkout OpenVPN</span><br><span>         uses: actions/chec=
kout@...2977... # v6.0.1</span><br><span></span><br></pre><p>To view, visit=
 <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1474?usp=3Demail">change =
1474</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div i=
temscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"ur=
l" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1474?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I658b1b24da304938225a8f834d7=
484671a63360f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1474 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: uddr &lt;yura.uddr@...277...&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--zK0b5vdRkJU=--

