From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Sun, 22 Oct 2023 22:00:43 +0000
In-Reply-To: <gerrit.1697649699000.I8f06a1213fdca233671f8d5746216ae46e84233b@...2715...>
References: <gerrit.1697649699000.I8f06a1213fdca233671f8d5746216ae46e84233b@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <bbb4233cb84b37d096257a8b034a1c23f69fde40-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+6HedJfM2/0="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Add --enable-werror
 to all platforms in Github Actions
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

--+6HedJfM2/0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/376?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld


Change subject: Add --enable-werror to all platforms in Github Actions
......................................................................

Add --enable-werror to all platforms in Github Actions

Change-Id: I8f06a1213fdca233671f8d5746216ae46e84233b
---
M .github/workflows/build.yaml
1 file changed, 2 insertions(+), 2 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/76/376/2

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 06567e0..60d3da5 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -186,7 +186,7 @@
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
-        run: CFLAGS=3D"-fsanitize=3Daddress,undefined -fno-sanitize-recove=
r=3Dall  -fno-omit-frame-pointer -O2" CC=3Dclang ./configure --with-crypto-=
library=3D${{matrix.ssllib}}
+        run: CFLAGS=3D"-fsanitize=3Daddress,undefined -fno-sanitize-recove=
r=3Dall  -fno-omit-frame-pointer -O2" CC=3Dclang ./configure --with-crypto-=
library=3D${{matrix.ssllib}} --enable-werror
       - name: make all
         run: make -j3
       - name: make check
@@ -355,7 +355,7 @@
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
-        run: ./configure --with-crypto-library=3Dopenssl ${{matrix.configu=
reflags}}
+        run: ./configure --with-crypto-library=3Dopenssl ${{matrix.configu=
reflags}} --enable-werror
       - name: make all
         run: make -j3
       - name: make check

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/376?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8f06a1213fdca233671f8d5746216ae46e84233b
Gerrit-Change-Number: 376
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--+6HedJfM2/0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>plaisthos <strong>uploaded patch set #2</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/376?usp=3Demail">View Chang=
e</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Add --enable-werror to all platforms in Githu=
b Actions<br><br>Change-Id: I8f06a1213fdca233671f8d5746216ae46e84233b<br>--=
-<br>M .github/workflows/build.yaml<br>1 file changed, 2 insertions(+), 2 d=
eletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/=
changes/76/376/2</pre><pre style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;"><span>diff --git a/.github/workflows/build.yaml b/.githu=
b/workflows/build.yaml</span><br><span>index 06567e0..60d3da5 100644</span>=
<br><span>--- a/.github/workflows/build.yaml</span><br><span>+++ b/.github/=
workflows/build.yaml</span><br><span>@@ -186,7 +186,7 @@</span><br><span>  =
     - name: autoconf</span><br><span>         run: autoreconf -fvi</span><=
br><span>       - name: configure</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        run: CFLAGS=3D&quot;-fsanitize=3Daddress,undefined -fno=
-sanitize-recover=3Dall  -fno-omit-frame-pointer -O2&quot; CC=3Dclang ./con=
figure --with-crypto-library=3D${{matrix.ssllib}}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        run: CFLAGS=3D&quot;-fsanitize=3Daddr=
ess,undefined -fno-sanitize-recover=3Dall  -fno-omit-frame-pointer -O2&quot=
; CC=3Dclang ./configure --with-crypto-library=3D${{matrix.ssllib}} --enabl=
e-werror</span><br><span>       - name: make all</span><br><span>         r=
un: make -j3</span><br><span>       - name: make check</span><br><span>@@ -=
355,7 +355,7 @@</span><br><span>       - name: autoconf</span><br><span>   =
      run: autoreconf -fvi</span><br><span>       - name: configure</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        run: ./configure --wi=
th-crypto-library=3Dopenssl ${{matrix.configureflags}}</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        run: ./configure --with-crypto-l=
ibrary=3Dopenssl ${{matrix.configureflags}} --enable-werror</span><br><span=
>       - name: make all</span><br><span>         run: make -j3</span><br><=
span>       - name: make check</span><br><span></span><br></pre><p>To view,=
 visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/376?usp=3Demail">ch=
ange 376</a>. To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope i=
temtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"actio=
n" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/376?usp=3Demail"/><meta itemprop=3D"=
name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8f06a1213fdca233671f8d57462=
16ae46e84233b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 376 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--+6HedJfM2/0=--

