From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 19 Nov 2025 17:03:56 +0000
In-Reply-To: <gerrit.1763565716000.I1633ee6207443e041434e9f0dda98afd5a22e1b4@...2715...>
References: <gerrit.1763565716000.I1633ee6207443e041434e9f0dda98afd5a22e1b4@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <0a93e346dd5430449c3e7a321cf88cbf2eb91e3d-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="TP72GDziX5E="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: GHA: Add macos-26
 and remove OpenSSL 1.1 builds on macOS
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--TP72GDziX5E=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1382?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by uddr


Change subject: GHA: Add macos-26 and remove OpenSSL 1.1 builds on macOS
......................................................................

GHA: Add macos-26 and remove OpenSSL 1.1 builds on macOS

The new runner doesn't have OpenSSL 1.1 available anymore
via homebrew. The formula is also marked as "deprecated"
for older macOS versions. So I think it is okay to drop
it.

Change-Id: I1633ee6207443e041434e9f0dda98afd5a22e1b4
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Yuriy Darnobyt <yura.uddr@...277...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1382
Message-Id: <20251119162934.15672-1-gert@...1296...>
Signed-off-by: Gert Doering <gert@...1296...>
---
M .github/workflows/build.yaml
1 file changed, 2 insertions(+), 2 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/82/1382/2

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 96d2292..357072d 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -210,9 +210,9 @@
     strategy:
       fail-fast: false
       matrix:
-        ssllib: [openssl@...2560..., openssl@...1554..., libressl]
+        ssllib: [openssl@...1554..., libressl]
         build: [normal, asan]
-        os: [macos-14, macos-15]
+        os: [macos-14, macos-15, macos-26]
         include:
           - build: asan
             cflags: "-fsanitize=3Daddress,undefined -fno-sanitize-recover=
=3Dall  -fno-optimize-sibling-calls -fsanitize-address-use-after-scope -fno=
-omit-frame-pointer -g -O1"

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1382?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1633ee6207443e041434e9f0dda98afd5a22e1b4
Gerrit-Change-Number: 1382
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: uddr <yura.uddr@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--TP72GDziX5E=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1382?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by uddr</p><pre class=3D"blocks" style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;">GHA: Add macos-26 and remove OpenSSL=
 1.1 builds on macOS<br><br>The new runner doesn&#39;t have OpenSSL 1.1 ava=
ilable anymore<br>via homebrew. The formula is also marked as &quot;depreca=
ted&quot;<br>for older macOS versions. So I think it is okay to drop<br>it.=
<br><br>Change-Id: I1633ee6207443e041434e9f0dda98afd5a22e1b4<br>Signed-off-=
by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Yuriy Darnobyt =
&lt;yura.uddr@...277...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/ope=
nvpn/+/1382<br>Message-Id: &lt;20251119162934.15672-1-gert@...1296...&gt;<b=
r>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M .github/w=
orkflows/build.yaml<br>1 file changed, 2 insertions(+), 2 deletions(-)<br><=
br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs=
/changes/82/1382/2</pre><pre style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;"><span>diff --git a/.github/workflows/build.yaml b/.git=
hub/workflows/build.yaml</span><br><span>index 96d2292..357072d 100644</spa=
n><br><span>--- a/.github/workflows/build.yaml</span><br><span>+++ b/.githu=
b/workflows/build.yaml</span><br><span>@@ -210,9 +210,9 @@</span><br><span>=
     strategy:</span><br><span>       fail-fast: false</span><br><span>    =
   matrix:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ssl=
lib: [openssl@...2560..., openssl@...1554..., libressl]</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        ssllib: [openssl@...1554..., li=
bressl]</span><br><span>         build: [normal, asan]</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        os: [macos-14, macos-15]</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        os: [macos-14, macos-=
15, macos-26]</span><br><span>         include:</span><br><span>           =
- build: asan</span><br><span>             cflags: &quot;-fsanitize=3Daddre=
ss,undefined -fno-sanitize-recover=3Dall  -fno-optimize-sibling-calls -fsan=
itize-address-use-after-scope -fno-omit-frame-pointer -g -O1&quot;</span><b=
r><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/1382?usp=3Demail">change 1382</a>. To unsubscribe, or for =
help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/setti=
ngs?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.=
org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sch=
ema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/1382?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1633ee6207443e041434e9f0dda=
98afd5a22e1b4 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1382 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: uddr &lt;yura.uddr@...277...&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--TP72GDziX5E=--

