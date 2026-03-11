From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 11 Mar 2026 15:37:36 +0000
References: <gerrit.1773243451000.Ia929c949cceaabe21a2937ad3217052aec4b2b4c@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net
Message-ID: <47b26053f277846feaed150c9664c76e86c566f1-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="tUzouei/nu8="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Show version and
 double check we use the right TLS library in Github...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--tUzouei/nu8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review. ( http://gerrit.openvpn.net/=
c/openvpn/+/1566?usp=3Demail )


Change subject: Show version and  double check we use the right TLS library=
 in Github Actions
......................................................................

Show version and  double check we use the right TLS library in Github Actio=
ns

We recently discovered that the AWS-LC builds in Github Actions were
actually using OpenSSL. This will now cause an error if something like
this happens in the future again.

Change-Id: Ia929c949cceaabe21a2937ad3217052aec4b2b4c
---
M .github/workflows/build.yaml
1 file changed, 8 insertions(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/66/1566/1

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 2e9b62a..4207606 100644
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
@@ -497,6 +501,10 @@
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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia929c949cceaabe21a2937ad3217052aec4b2b4c
Gerrit-Change-Number: 1566
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--tUzouei/nu8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>.</p><p><a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/1566?usp=3Demail">View Change</a></p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">Show version and  double check we use the right TLS library in Github A=
ctions<br><br>We recently discovered that the AWS-LC builds in Github Actio=
ns were<br>actually using OpenSSL. This will now cause an error if somethin=
g like<br>this happens in the future again.<br><br>Change-Id: Ia929c949ccea=
abe21a2937ad3217052aec4b2b4c<br>---<br>M .github/workflows/build.yaml<br>1 =
file changed, 8 insertions(+), 0 deletions(-)<br><br></pre><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">gi=
t pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/66/1566/1</pre><=
pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><spa=
n>diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml<=
/span><br><span>index 2e9b62a..4207606 100644</span><br><span>--- a/.github=
/workflows/build.yaml</span><br><span>+++ b/.github/workflows/build.yaml</s=
pan><br><span>@@ -363,6 +363,10 @@</span><br><span>         run: ./configur=
e --with-crypto-library=3Dopenssl ${{matrix.configureflags}} --enable-werro=
r</span><br><span>       - name: make all</span><br><span>         run: mak=
e -j3</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      - name: =
Ensure the build uses LibreSSL</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        run: |</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+          ./src/openvpn/openvpn --version</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+          ./src/openvpn/openvpn --version | gre=
p -q &quot;library versions: LibreSSL&quot;</span><br><span>       - name: =
configure checks</span><br><span>         run: echo &#39;RUN_SUDO=3D&quot;s=
udo -E&quot;&#39; &gt;tests/t_server_null.rc</span><br><span>       - name:=
 make check</span><br><span>@@ -497,6 +501,10 @@</span><br><span>          =
 ./configure --with-crypto-library=3Dopenssl</span><br><span>       - name:=
 make all</span><br><span>         run: make -j3</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+      - name: Ensure the build uses AWS-LC</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        run: |</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+          ./src/openvpn/open=
vpn --version</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
    ./src/openvpn/openvpn --version | grep -q &quot;library versions: AWS-L=
C&quot;</span><br><span>       - name: configure checks</span><br><span>   =
      run: echo &#39;RUN_SUDO=3D&quot;sudo -E&quot;&#39; &gt;tests/t_server=
_null.rc</span><br><span>       - name: make check</span><br><span></span><=
br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/1566?usp=3Demail">change 1566</a>. To unsubscribe, or for help writing mai=
l filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail"=
>settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage=
"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewActi=
on"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/15=
66?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia929c949cceaabe21a2937ad321=
7052aec4b2b4c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1566 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--tUzouei/nu8=--

