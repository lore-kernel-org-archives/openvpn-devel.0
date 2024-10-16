From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 16 Oct 2024 09:57:49 +0000
In-Reply-To: <gerrit.1728995699000.Ibaa591904095a824df2c0c5aaff73687e0af24fe@...2715...>
References: <gerrit.1728995699000.Ibaa591904095a824df2c0c5aaff73687e0af24fe@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 yura.uddr@...277...
Message-ID: <804433e532c95627ba858a76e41751c20b59140f-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="uP/OGiGYhWc="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: GHA: Update macOS
 runners
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, uddr <yura.uddr@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--uP/OGiGYhWc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/780?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos, Code-Review+2 by uddr


Change subject: GHA: Update macOS runners
......................................................................

GHA: Update macOS runners

Remove macos-12, not supported anymore.
Add macos-15, runner is available in Beta status.

Change-Id: Ibaa591904095a824df2c0c5aaff73687e0af24fe
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Acked-by: Yuriy Darnobyt <yura.uddr@...277...>
Message-Id: <20241015205627.25644-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29=
551.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M .github/workflows/build.yaml
1 file changed, 3 insertions(+), 3 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/80/780/2

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 1bc250d..fdd133e 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -213,16 +213,16 @@
       matrix:
         ssllib: [ openssl11, openssl3, libressl]
         build: [ normal, asan ]
-        os: [macos-12, macos-13, macos-14]
+        os: [macos-13, macos-14, macos-15]
         include:
            # macos14 and newer runners use ARM CPUs and homebrew uses /opt=
/homebrew/
            # on ARM instead of /usr/local/
-          - os: macos-12
-            homebrew: /usr/local/opt
           - os: macos-13
             homebrew: /usr/local/opt
           - os: macos-14
             homebrew: /opt/homebrew/opt
+          - os: macos-15
+            homebrew: /opt/homebrew/opt
           - build: asan
             cflags: "-fsanitize=3Daddress,undefined -fno-sanitize-recover=
=3Dall  -fno-optimize-sibling-calls -fsanitize-address-use-after-scope -fno=
-omit-frame-pointer -g -O1"
             ldflags: -fsanitize=3Daddress,undefined -fno-sanitize-recover=
=3Dall

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/780?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ibaa591904095a824df2c0c5aaff73687e0af24fe
Gerrit-Change-Number: 780
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: uddr <yura.uddr@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--uP/OGiGYhWc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/780?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by plaisthos, Code-Review+2 by uddr</p><pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;">GHA: Update macOS runners=
<br><br>Remove macos-12, not supported anymore.<br>Add macos-15, runner is =
available in Beta status.<br><br>Change-Id: Ibaa591904095a824df2c0c5aaff736=
87e0af24fe<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>=
Acked-by: Arne Schwabe &lt;arne-openvpn@...1227...&gt;<br>Acked-by: Yuriy D=
arnobyt &lt;yura.uddr@...277...&gt;<br>Message-Id: &lt;20241015205627.25644=
-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...465...=
ists.sourceforge.net/msg29551.html<br>Signed-off-by: Gert Doering &lt;gert@=
...1296...&gt;<br>---<br>M .github/workflows/build.yaml<br>1 file changed, =
3 insertions(+), 3 deletions(-)<br><br></pre><pre style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net=
:29418/openvpn refs/changes/80/780/2</pre><pre style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;"><span>diff --git a/.github/workflows=
/build.yaml b/.github/workflows/build.yaml</span><br><span>index 1bc250d..f=
dd133e 100644</span><br><span>--- a/.github/workflows/build.yaml</span><br>=
<span>+++ b/.github/workflows/build.yaml</span><br><span>@@ -213,16 +213,16=
 @@</span><br><span>       matrix:</span><br><span>         ssllib: [ opens=
sl11, openssl3, libressl]</span><br><span>         build: [ normal, asan ]<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        os: [macos-12,=
 macos-13, macos-14]</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        os: [macos-13, macos-14, macos-15]</span><br><span>         includ=
e:</span><br><span>            # macos14 and newer runners use ARM CPUs and=
 homebrew uses /opt/homebrew/</span><br><span>            # on ARM instead =
of /usr/local/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
   - os: macos-12</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        homebrew: /usr/local/opt</span><br><span>           - os: macos-13<=
/span><br><span>             homebrew: /usr/local/opt</span><br><span>     =
      - os: macos-14</span><br><span>             homebrew: /opt/homebrew/o=
pt</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          - os: m=
acos-15</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
homebrew: /opt/homebrew/opt</span><br><span>           - build: asan</span>=
<br><span>             cflags: &quot;-fsanitize=3Daddress,undefined -fno-sa=
nitize-recover=3Dall  -fno-optimize-sibling-calls -fsanitize-address-use-af=
ter-scope -fno-omit-frame-pointer -g -O1&quot;</span><br><span>            =
 ldflags: -fsanitize=3Daddress,undefined -fno-sanitize-recover=3Dall</span>=
<br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/780?usp=3Demail">change 780</a>. To unsubscribe, or for =
help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/setti=
ngs">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/View=
Action"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/780?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ibaa591904095a824df2c0c5aaff=
73687e0af24fe </div>
<div style=3D"display:none"> Gerrit-Change-Number: 780 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: uddr &lt;yura.uddr@...277...&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--uP/OGiGYhWc=--

