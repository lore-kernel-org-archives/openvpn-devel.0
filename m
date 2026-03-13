From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 13 Mar 2026 22:36:24 +0000
In-Reply-To: <gerrit.1773243451000.Ia929c949cceaabe21a2937ad3217052aec4b2b4c@...2715...>
References: <gerrit.1773243451000.Ia929c949cceaabe21a2937ad3217052aec4b2b4c@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <5b66a2dfb067e7da8b53178ea08855bf794c4dcc-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="lcU5loOkxPQ="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Show version and
 double check we use the right TLS library in Github ...
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

--lcU5loOkxPQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/15=
66?usp=3Demail )

Change subject: Show version and double check we use the right TLS library =
in Github Actions
......................................................................

Show version and double check we use the right TLS library in Github Actions

We recently discovered that the AWS-LC builds in Github Actions were
actually using OpenSSL. This will now cause an error if something like
this happens in the future again.

Change-Id: Ia929c949cceaabe21a2937ad3217052aec4b2b4c
Signed-off-by: Arne Schwabe <arne-openvpn@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1566
Message-Id: <20260313175324.12121-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36=
115.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M .github/workflows/build.yaml
1 file changed, 12 insertions(+), 0 deletions(-)




diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 2a2616b..dd8e472 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -363,6 +363,10 @@
         run: ./configure --with-crypto-library=3Dopenssl ${{matrix.configu=
reflags}} --enable-werror
       - name: make all
         run: make -j3
+      - name: Ensure the build uses LibreSSL
+        run: |
+          ./src/openvpn/openvpn --version
+          ./src/openvpn/openvpn --version | grep -q "library versions: Lib=
reSSL"
       - name: configure checks
         run: echo 'RUN_SUDO=3D"sudo -E"' >tests/t_server_null.rc
       - name: make check
@@ -422,6 +426,10 @@
         run: ./configure --with-crypto-library=3Dmbedtls --enable-werror
       - name: make all
         run: make -j3
+      - name: Ensure the build uses mbed TLS 4.x
+        run: |
+          ./src/openvpn/openvpn --version
+          ./src/openvpn/openvpn --version | grep -q "library versions: mbe=
d TLS 4."
       - name: configure checks
         run: echo 'RUN_SUDO=3D"sudo -E"' >tests/t_server_null.rc
       - name: make check
@@ -486,6 +494,10 @@
           ./configure --with-crypto-library=3Dopenssl
       - name: make all
         run: make -j3
+      - name: Ensure the build uses AWS-LC
+        run: |
+          ./src/openvpn/openvpn --version
+          ./src/openvpn/openvpn --version | grep -q "library versions: AWS=
-LC"
       - name: configure checks
         run: echo 'RUN_SUDO=3D"sudo -E"' >tests/t_server_null.rc
       - name: make check

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1566?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia929c949cceaabe21a2937ad3217052aec4b2b4c
Gerrit-Change-Number: 1566
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--lcU5loOkxPQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1566?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">Show version and double check we use the right T=
LS library in Github Actions<br><br>We recently discovered that the AWS-LC =
builds in Github Actions were<br>actually using OpenSSL. This will now caus=
e an error if something like<br>this happens in the future again.<br><br>Ch=
ange-Id: Ia929c949cceaabe21a2937ad3217052aec4b2b4c<br>Signed-off-by: Arne S=
chwabe &lt;arne-openvpn@...1227...&gt;<br>Acked-by: Frank Lichtenheld &lt;f=
rank@...2641...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1=
566<br>Message-Id: &lt;20260313175324.12121-1-gert@...1296...&gt;<br>URL: h=
ttps://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36115.ht=
ml<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M .gith=
ub/workflows/build.yaml<br>1 file changed, 12 insertions(+), 0 deletions(-)=
<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml=
</span><br><span>index 2a2616b..dd8e472 100644</span><br><span>--- a/.githu=
b/workflows/build.yaml</span><br><span>+++ b/.github/workflows/build.yaml</=
span><br><span>@@ -363,6 +363,10 @@</span><br><span>         run: ./configu=
re --with-crypto-library=3Dopenssl ${{matrix.configureflags}} --enable-werr=
or</span><br><span>       - name: make all</span><br><span>         run: ma=
ke -j3</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      - name:=
 Ensure the build uses LibreSSL</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        run: |</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+          ./src/openvpn/openvpn --version</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+          ./src/openvpn/openvpn --version | gr=
ep -q &quot;library versions: LibreSSL&quot;</span><br><span>       - name:=
 configure checks</span><br><span>         run: echo &#39;RUN_SUDO=3D&quot;=
sudo -E&quot;&#39; &gt;tests/t_server_null.rc</span><br><span>       - name=
: make check</span><br><span>@@ -422,6 +426,10 @@</span><br><span>         =
run: ./configure --with-crypto-library=3Dmbedtls --enable-werror</span><br>=
<span>       - name: make all</span><br><span>         run: make -j3</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+      - name: Ensure the b=
uild uses mbed TLS 4.x</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        run: |</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
        ./src/openvpn/openvpn --version</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+          ./src/openvpn/openvpn --version | grep -q &qu=
ot;library versions: mbed TLS 4.&quot;</span><br><span>       - name: confi=
gure checks</span><br><span>         run: echo &#39;RUN_SUDO=3D&quot;sudo -=
E&quot;&#39; &gt;tests/t_server_null.rc</span><br><span>       - name: make=
 check</span><br><span>@@ -486,6 +494,10 @@</span><br><span>           ./co=
nfigure --with-crypto-library=3Dopenssl</span><br><span>       - name: make=
 all</span><br><span>         run: make -j3</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+      - name: Ensure the build uses AWS-LC</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        run: |</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+          ./src/openvpn/openvpn -=
-version</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          .=
/src/openvpn/openvpn --version | grep -q &quot;library versions: AWS-LC&quo=
t;</span><br><span>       - name: configure checks</span><br><span>        =
 run: echo &#39;RUN_SUDO=3D&quot;sudo -E&quot;&#39; &gt;tests/t_server_null=
.rc</span><br><span>       - name: make check</span><br><span></span><br></=
pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1566=
?usp=3Demail">change 1566</a>. To unsubscribe, or for help writing mail fil=
ters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">sett=
ings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><di=
v itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><=
link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1566?us=
p=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia929c949cceaabe21a2937ad321=
7052aec4b2b4c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1566 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--lcU5loOkxPQ=--

