From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 12 Sep 2024 18:48:33 +0000
In-Reply-To: <gerrit.1726065220000.I86203b8f9a6d3cfc5e56d3ce9452af694fd11011@...2715...>
References: <gerrit.1726065220000.I86203b8f9a6d3cfc5e56d3ce9452af694fd11011@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <5adac681468b5bdb48e5e0ef088fb9ec1f79d7ed-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="AXUmixlr5Yg="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--AXUmixlr5Yg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/74=
3?usp=3Demail )

Change subject: GHA: Enable t_server_null tests
......................................................................

GHA: Enable t_server_null tests

Change-Id: I86203b8f9a6d3cfc5e56d3ce9452af694fd11011
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20240912174910.21058-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29=
231.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M .github/workflows/build.yaml
1 file changed, 16 insertions(+), 5 deletions(-)




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
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--AXUmixlr5Yg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/743?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">GHA: Enable t_server_null tests<br><br>Change-=
Id: I86203b8f9a6d3cfc5e56d3ce9452af694fd11011<br>Signed-off-by: Frank Licht=
enheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...1725...=
..&gt;<br>Message-Id: &lt;20240912174910.21058-1-gert@...1296...&gt;<br>URL=
: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29231=
.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M .g=
ithub/workflows/build.yaml<br>1 file changed, 16 insertions(+), 5 deletions=
(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml=
</span><br><span>index 8f0a7b5..361d457 100644</span><br><span>--- a/.githu=
b/workflows/build.yaml</span><br><span>+++ b/.github/workflows/build.yaml</=
span><br><span>@@ -172,8 +172,11 @@</span><br><span>         run: ./configu=
re --with-crypto-library=3D${{matrix.ssllib}} ${{matrix.extraconf}} --enabl=
e-werror</span><br><span>       - name: make all</span><br><span>         r=
un: make -j3</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      -=
 name: configure checks</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        if: ${{ matrix.extraconf !=3D &#39;--disable-management&#39; }}=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        run: echo &=
#39;RUN_SUDO=3D&quot;sudo -E&quot;&#39; &gt;tests/t_server_null.rc</span><b=
r><span>       - name: make check</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        run: make check VERBOSE=3D1</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        run: make -j3 check VERBOSE=3D1</span><=
br><span> </span><br><span>   ubuntu-clang-asan:</span><br><span>     strat=
egy:</span><br><span>@@ -199,8 +202,10 @@</span><br><span>         run: CFL=
AGS=3D&quot;-fsanitize=3Daddress,undefined -fno-sanitize-recover=3Dall  -fn=
o-omit-frame-pointer -O2&quot; CC=3Dclang ./configure --with-crypto-library=
=3D${{matrix.ssllib}} --enable-werror</span><br><span>       - name: make a=
ll</span><br><span>         run: make -j3</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+      - name: configure checks</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        run: echo &#39;RUN_SUDO=3D&quot;s=
udo -E&quot;&#39; &gt;tests/t_server_null.rc</span><br><span>       - name:=
 make check</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ru=
n: make check VERBOSE=3D1</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        run: make -j3 check VERBOSE=3D1</span><br><span> </span><br><=
span>   macos:</span><br><span>     strategy:</span><br><span>@@ -258,8 +26=
3,10 @@</span><br><span>         run: ./configure --enable-werror ${{matrix=
.configureflags}} ${{matrix.configuressllib}}</span><br><span>       - name=
: make all</span><br><span>         run: make -j4</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+      - name: configure checks</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        run: echo &#39;RUN_SUDO=3D=
&quot;sudo -E&quot;&#39; &gt;tests/t_server_null.rc</span><br><span>       =
- name: make check</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     run: make check VERBOSE=3D1</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        run: make -j4 check VERBOSE=3D1</span><br><span> </spa=
n><br><span>   msvc:</span><br><span>       strategy:</span><br><span>@@ -3=
69,8 +376,10 @@</span><br><span>         run: ./configure --with-crypto-lib=
rary=3Dopenssl ${{matrix.configureflags}} --enable-werror</span><br><span> =
      - name: make all</span><br><span>         run: make -j3</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+      - name: configure checks</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        run: echo &#39=
;RUN_SUDO=3D&quot;sudo -E&quot;&#39; &gt;tests/t_server_null.rc</span><br><=
span>       - name: make check</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        run: make check VERBOSE=3D1</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        run: make -j3 check VERBOSE=3D1</span><br>=
<span> </span><br><span>   mbedtls3:</span><br><span>     strategy:</span><=
br><span>@@ -422,5 +431,7 @@</span><br><span>         run: ./configure --wi=
th-crypto-library=3Dmbedtls</span><br><span>       - name: make all</span><=
br><span>         run: make -j3</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+      - name: configure checks</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        run: echo &#39;RUN_SUDO=3D&quot;sudo -E&quot=
;&#39; &gt;tests/t_server_null.rc</span><br><span>       - name: make check=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        run: make che=
ck VERBOSE=3D1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   run: make -j3 check VERBOSE=3D1</span><br><span></span><br></pre><p>To v=
iew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/743?usp=3Demail=
">change 743</a>. To unsubscribe, or for help writing mail filters, visit <=
a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemsco=
pe itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/743?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I86203b8f9a6d3cfc5e56d3ce945=
2af694fd11011 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 743 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--AXUmixlr5Yg=--

