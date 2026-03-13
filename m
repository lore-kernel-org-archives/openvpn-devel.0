From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 13 Mar 2026 22:36:20 +0000
In-Reply-To: <gerrit.1773243451000.Ia929c949cceaabe21a2937ad3217052aec4b2b4c@...2715...>
References: <gerrit.1773243451000.Ia929c949cceaabe21a2937ad3217052aec4b2b4c@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <5b66a2dfb067e7da8b53178ea08855bf794c4dcc-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="T9qDPgOIkIQ="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--T9qDPgOIkIQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/1566?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/66/1566/4

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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia929c949cceaabe21a2937ad3217052aec4b2b4c
Gerrit-Change-Number: 1566
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--T9qDPgOIkIQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #4</strong> to the change originally created by plaisthos.<=
/p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1566?usp=3Demail">Vi=
ew Change</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld</p><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">Show version and double chec=
k we use the right TLS library in Github Actions<br><br>We recently discove=
red that the AWS-LC builds in Github Actions were<br>actually using OpenSSL=
. This will now cause an error if something like<br>this happens in the fut=
ure again.<br><br>Change-Id: Ia929c949cceaabe21a2937ad3217052aec4b2b4c<br>S=
igned-off-by: Arne Schwabe &lt;arne-openvpn@...1227...&gt;<br>Acked-by: Fra=
nk Lichtenheld &lt;frank@...2641...&gt;<br>Gerrit URL: https://gerrit.openv=
pn.net/c/openvpn/+/1566<br>Message-Id: &lt;20260313175324.12121-1-gert@...1386...=
296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1535...=
orge.net/msg36115.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&g=
t;<br>---<br>M .github/workflows/build.yaml<br>1 file changed, 12 insertion=
s(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openv=
pn.net:29418/openvpn refs/changes/66/1566/4</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/.github/wo=
rkflows/build.yaml b/.github/workflows/build.yaml</span><br><span>index 2a2=
616b..dd8e472 100644</span><br><span>--- a/.github/workflows/build.yaml</sp=
an><br><span>+++ b/.github/workflows/build.yaml</span><br><span>@@ -363,6 +=
363,10 @@</span><br><span>         run: ./configure --with-crypto-library=
=3Dopenssl ${{matrix.configureflags}} --enable-werror</span><br><span>     =
  - name: make all</span><br><span>         run: make -j3</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+      - name: Ensure the build uses L=
ibreSSL</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        run:=
 |</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          ./src/o=
penvpn/openvpn --version</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+          ./src/openvpn/openvpn --version | grep -q &quot;library vers=
ions: LibreSSL&quot;</span><br><span>       - name: configure checks</span>=
<br><span>         run: echo &#39;RUN_SUDO=3D&quot;sudo -E&quot;&#39; &gt;t=
ests/t_server_null.rc</span><br><span>       - name: make check</span><br><=
span>@@ -422,6 +426,10 @@</span><br><span>         run: ./configure --with-=
crypto-library=3Dmbedtls --enable-werror</span><br><span>       - name: mak=
e all</span><br><span>         run: make -j3</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+      - name: Ensure the build uses mbed TLS 4.x</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        run: |</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+          ./src/openvpn/op=
envpn --version</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
      ./src/openvpn/openvpn --version | grep -q &quot;library versions: mbe=
d TLS 4.&quot;</span><br><span>       - name: configure checks</span><br><s=
pan>         run: echo &#39;RUN_SUDO=3D&quot;sudo -E&quot;&#39; &gt;tests/t=
_server_null.rc</span><br><span>       - name: make check</span><br><span>@=
@ -486,6 +494,10 @@</span><br><span>           ./configure --with-crypto-li=
brary=3Dopenssl</span><br><span>       - name: make all</span><br><span>   =
      run: make -j3</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
      - name: Ensure the build uses AWS-LC</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        run: |</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+          ./src/openvpn/openvpn --version</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+          ./src/openvpn/openvpn --v=
ersion | grep -q &quot;library versions: AWS-LC&quot;</span><br><span>     =
  - name: configure checks</span><br><span>         run: echo &#39;RUN_SUDO=
=3D&quot;sudo -E&quot;&#39; &gt;tests/t_server_null.rc</span><br><span>    =
   - name: make check</span><br><span></span><br></pre><p>To view, visit <a=
 href=3D"http://gerrit.openvpn.net/c/openvpn/+/1566?usp=3Demail">change 156=
6</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"h=
ttp://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemsc=
ope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1566?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
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

--T9qDPgOIkIQ=--

