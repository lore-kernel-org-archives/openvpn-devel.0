From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Fri, 13 Mar 2026 13:43:14 +0000
In-Reply-To: <gerrit.1773243451000.Ia929c949cceaabe21a2937ad3217052aec4b2b4c@...2715...>
References: <gerrit.1773243451000.Ia929c949cceaabe21a2937ad3217052aec4b2b4c@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <a4c727545fed7ab541cc952a5d104b286ad975f7-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="MlOLRdq/PGA="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Show version and
 double check we use the right TLS library in Github...
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

--MlOLRdq/PGA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello flichtenheld,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1566?usp=3Demail

to look at the new patch set (#3).

The change is no longer submittable: checks~ChecksSubmitRule is unsatisfied=
 now.


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
1 file changed, 12 insertions(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/66/1566/3

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

--=20
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1566?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia929c949cceaabe21a2937ad3217052aec4b2b4c
Gerrit-Change-Number: 1566
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--MlOLRdq/PGA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>plaisthos <strong>uploaded patch set #3</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1566?usp=3Demail">View Chan=
ge</a></p><p>The change is no longer submittable: checks~ChecksSubmitRule i=
s unsatisfied now.</p><pre class=3D"blocks" style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;">Show version and  double check we use t=
he right TLS library in Github Actions<br><br>We recently discovered that t=
he AWS-LC builds in Github Actions were<br>actually using OpenSSL. This wil=
l now cause an error if something like<br>this happens in the future again.=
<br><br>Change-Id: Ia929c949cceaabe21a2937ad3217052aec4b2b4c<br>---<br>M .g=
ithub/workflows/build.yaml<br>1 file changed, 12 insertions(+), 0 deletions=
(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/open=
vpn refs/changes/66/1566/3</pre><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;"><span>diff --git a/.github/workflows/build.yam=
l b/.github/workflows/build.yaml</span><br><span>index 2a2616b..dd8e472 100=
644</span><br><span>--- a/.github/workflows/build.yaml</span><br><span>+++ =
b/.github/workflows/build.yaml</span><br><span>@@ -363,6 +363,10 @@</span><=
br><span>         run: ./configure --with-crypto-library=3Dopenssl ${{matri=
x.configureflags}} --enable-werror</span><br><span>       - name: make all<=
/span><br><span>         run: make -j3</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+      - name: Ensure the build uses LibreSSL</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        run: |</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+          ./src/openvpn/openvpn --ve=
rsion</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          ./sr=
c/openvpn/openvpn --version | grep -q &quot;library versions: LibreSSL&quot=
;</span><br><span>       - name: configure checks</span><br><span>         =
run: echo &#39;RUN_SUDO=3D&quot;sudo -E&quot;&#39; &gt;tests/t_server_null.=
rc</span><br><span>       - name: make check</span><br><span>@@ -422,6 +426=
,10 @@</span><br><span>         run: ./configure --with-crypto-library=3Dmb=
edtls --enable-werror</span><br><span>       - name: make all</span><br><sp=
an>         run: make -j3</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+      - name: Ensure the build uses mbed TLS 4.x</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        run: |</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+          ./src/openvpn/openvpn --version</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+          ./src/openvpn=
/openvpn --version | grep -q &quot;library versions: mbed TLS 4.&quot;</spa=
n><br><span>       - name: configure checks</span><br><span>         run: e=
cho &#39;RUN_SUDO=3D&quot;sudo -E&quot;&#39; &gt;tests/t_server_null.rc</sp=
an><br><span>       - name: make check</span><br><span>@@ -486,6 +494,10 @@=
</span><br><span>           ./configure --with-crypto-library=3Dopenssl</sp=
an><br><span>       - name: make all</span><br><span>         run: make -j3=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      - name: Ensur=
e the build uses AWS-LC</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        run: |</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
         ./src/openvpn/openvpn --version</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+          ./src/openvpn/openvpn --version | grep -q &q=
uot;library versions: AWS-LC&quot;</span><br><span>       - name: configure=
 checks</span><br><span>         run: echo &#39;RUN_SUDO=3D&quot;sudo -E&qu=
ot;&#39; &gt;tests/t_server_null.rc</span><br><span>       - name: make che=
ck</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1566?usp=3Demail">change 1566</a>. To unsubscri=
be, or for help writing mail filters, visit <a href=3D"http://gerrit.openvp=
n.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/1566?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia929c949cceaabe21a2937ad321=
7052aec4b2b4c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1566 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--MlOLRdq/PGA=--

