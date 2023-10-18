From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 18 Oct 2023 17:21:42 +0000
References: <gerrit.1697649699000.I8f06a1213fdca233671f8d5746216ae46e84233b@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <1e26c6425110ab7b2363fe9e87179e3d2df5e7db-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2Bd9qElABtI="; charset=UTF-8
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

--2Bd9qElABtI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/376?usp=3Demail

to review the following change.


Change subject: Add --enable-werror to all platforms in Github Actions
......................................................................

Add --enable-werror to all platforms in Github Actions

Change-Id: I8f06a1213fdca233671f8d5746216ae46e84233b
---
M .github/workflows/build.yaml
1 file changed, 3 insertions(+), 3 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/76/376/1

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 2a25582..4344121 100644
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
@@ -235,7 +235,7 @@
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
-        run: ./configure --enable-werror ${{matrix.configureflags}} ${{mat=
rix.configuressllib}}
+        run: ./configure --enable-werror ${{matrix.configureflags}} ${{mat=
rix.configuressllib}} --enable-werror
       - name: make all
         run: make -j4
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
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--2Bd9qElABtI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/376?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Add --enable-werror to all platforms in Github Actions<br><br=
>Change-Id: I8f06a1213fdca233671f8d5746216ae46e84233b<br>---<br>M .github/w=
orkflows/build.yaml<br>1 file changed, 3 insertions(+), 3 deletions(-)<br><=
br></pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/76/376/1=
</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;"><span>diff --git a/.github/workflows/build.yaml b/.github/workflows/buil=
d.yaml</span><br><span>index 2a25582..4344121 100644</span><br><span>--- a/=
.github/workflows/build.yaml</span><br><span>+++ b/.github/workflows/build.=
yaml</span><br><span>@@ -186,7 +186,7 @@</span><br><span>       - name: aut=
oconf</span><br><span>         run: autoreconf -fvi</span><br><span>       =
- name: configure</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    run: CFLAGS=3D&quot;-fsanitize=3Daddress,undefined -fno-sanitize-recove=
r=3Dall  -fno-omit-frame-pointer -O2&quot; CC=3Dclang ./configure --with-cr=
ypto-library=3D${{matrix.ssllib}}</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        run: CFLAGS=3D&quot;-fsanitize=3Daddress,undefined -f=
no-sanitize-recover=3Dall  -fno-omit-frame-pointer -O2&quot; CC=3Dclang ./c=
onfigure --with-crypto-library=3D${{matrix.ssllib}} --enable-werror</span><=
br><span>       - name: make all</span><br><span>         run: make -j3</sp=
an><br><span>       - name: make check</span><br><span>@@ -235,7 +235,7 @@<=
/span><br><span>       - name: autoconf</span><br><span>         run: autor=
econf -fvi</span><br><span>       - name: configure</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        run: ./configure --enable-werror ${=
{matrix.configureflags}} ${{matrix.configuressllib}}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        run: ./configure --enable-werror =
${{matrix.configureflags}} ${{matrix.configuressllib}} --enable-werror</spa=
n><br><span>       - name: make all</span><br><span>         run: make -j4<=
/span><br><span>       - name: make check</span><br><span>@@ -355,7 +355,7 =
@@</span><br><span>       - name: autoconf</span><br><span>         run: au=
toreconf -fvi</span><br><span>       - name: configure</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        run: ./configure --with-crypto-lib=
rary=3Dopenssl ${{matrix.configureflags}}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        run: ./configure --with-crypto-library=3Dopen=
ssl ${{matrix.configureflags}} --enable-werror</span><br><span>       - nam=
e: make all</span><br><span>         run: make -j3</span><br><span>       -=
 name: make check</span><br><span></span><br></pre><p>To view, visit <a hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/376?usp=3Demail">change 376</a>.=
 To unsubscribe, or for help writing mail filters, visit <a href=3D"http://=
gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"ht=
tp://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/376?usp=3Demail"/><meta itemprop=3D"name" conte=
nt=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8f06a1213fdca233671f8d57462=
16ae46e84233b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 376 </div>
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


--2Bd9qElABtI=--

