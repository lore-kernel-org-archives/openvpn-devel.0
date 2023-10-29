From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 29 Oct 2023 18:54:32 +0000
In-Reply-To: <gerrit.1697649699000.I8f06a1213fdca233671f8d5746216ae46e84233b@...2715...>
References: <gerrit.1697649699000.I8f06a1213fdca233671f8d5746216ae46e84233b@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <d8fb3bbae0047e72df0b8d5a7a1d7fa05bfbc729-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="FI70dKEjrHk="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--FI70dKEjrHk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/376?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


Change subject: Add --enable-werror to all platforms in Github Actions
......................................................................

Add --enable-werror to all platforms in Github Actions

Change-Id: I8f06a1213fdca233671f8d5746216ae46e84233b
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20231025121710.1030736-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27=
293.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M .github/workflows/build.yaml
1 file changed, 2 insertions(+), 2 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/76/376/3

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
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--FI70dKEjrHk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #3</strong> to the change originally cr=
eated by plaisthos.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
376?usp=3Demail">View Change</a></p><p>The following approvals got outdated=
 and were removed:
Code-Review+2 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Add --enable-werror to all platforms in Githu=
b Actions<br><br>Change-Id: I8f06a1213fdca233671f8d5746216ae46e84233b<br>Si=
gned-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>Acked-by: Frank Lichte=
nheld &lt;frank@...2641...&gt;<br>Message-Id: &lt;20231025121710.1030736-1-=
frank@...2641...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1484...=
ts.sourceforge.net/msg27293.html<br>Signed-off-by: Gert Doering &lt;gert@...1186...=
.1296...&gt;<br>---<br>M .github/workflows/build.yaml<br>1 file changed, 2 =
insertions(+), 2 deletions(-)<br><br></pre><pre style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:2=
9418/openvpn refs/changes/76/376/3</pre><pre style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;"><span>diff --git a/.github/workflows/b=
uild.yaml b/.github/workflows/build.yaml</span><br><span>index 06567e0..60d=
3da5 100644</span><br><span>--- a/.github/workflows/build.yaml</span><br><s=
pan>+++ b/.github/workflows/build.yaml</span><br><span>@@ -186,7 +186,7 @@<=
/span><br><span>       - name: autoconf</span><br><span>         run: autor=
econf -fvi</span><br><span>       - name: configure</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        run: CFLAGS=3D&quot;-fsanitize=3Dad=
dress,undefined -fno-sanitize-recover=3Dall  -fno-omit-frame-pointer -O2&qu=
ot; CC=3Dclang ./configure --with-crypto-library=3D${{matrix.ssllib}}</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        run: CFLAGS=3D&qu=
ot;-fsanitize=3Daddress,undefined -fno-sanitize-recover=3Dall  -fno-omit-fr=
ame-pointer -O2&quot; CC=3Dclang ./configure --with-crypto-library=3D${{mat=
rix.ssllib}} --enable-werror</span><br><span>       - name: make all</span>=
<br><span>         run: make -j3</span><br><span>       - name: make check<=
/span><br><span>@@ -355,7 +355,7 @@</span><br><span>       - name: autoconf=
</span><br><span>         run: autoreconf -fvi</span><br><span>       - nam=
e: configure</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        r=
un: ./configure --with-crypto-library=3Dopenssl ${{matrix.configureflags}}<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        run: ./confi=
gure --with-crypto-library=3Dopenssl ${{matrix.configureflags}} --enable-we=
rror</span><br><span>       - name: make all</span><br><span>         run: =
make -j3</span><br><span>       - name: make check</span><br><span></span><=
br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/376?usp=3Demail">change 376</a>. To unsubscribe, or for help writing mail =
filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.=
</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/376?usp=3Demail"=
/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8f06a1213fdca233671f8d57462=
16ae46e84233b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 376 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--FI70dKEjrHk=--

