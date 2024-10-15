From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 15 Oct 2024 12:35:03 +0000
References: <gerrit.1728995699000.Ibaa591904095a824df2c0c5aaff73687e0af24fe@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <3f16ba14d41977c139213154fd8eb81ebfe543a6-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="d1k7xqkJjYE="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--d1k7xqkJjYE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/780?usp=3Demail

to review the following change.


Change subject: GHA: Update macOS runners
......................................................................

GHA: Update macOS runners

Remove macos-12, not supported anymore.
Add macos-15, runner is available in Beta status.

Change-Id: Ibaa591904095a824df2c0c5aaff73687e0af24fe
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M .github/workflows/build.yaml
1 file changed, 3 insertions(+), 3 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/80/780/1

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
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--d1k7xqkJjYE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/780?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">GHA: Update macOS runners<br><br>Remove macos-12, not support=
ed anymore.<br>Add macos-15, runner is available in Beta status.<br><br>Cha=
nge-Id: Ibaa591904095a824df2c0c5aaff73687e0af24fe<br>Signed-off-by: Frank L=
ichtenheld &lt;frank@...2641...&gt;<br>---<br>M .github/workflows/build.yam=
l<br>1 file changed, 3 insertions(+), 3 deletions(-)<br><br></pre><pre styl=
e=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh=
://gerrit.openvpn.net:29418/openvpn refs/changes/80/780/1</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/.github/workflows/build.yaml b/.github/workflows/build.yaml</span><br=
><span>index 1bc250d..fdd133e 100644</span><br><span>--- a/.github/workflow=
s/build.yaml</span><br><span>+++ b/.github/workflows/build.yaml</span><br><=
span>@@ -213,16 +213,16 @@</span><br><span>       matrix:</span><br><span> =
        ssllib: [ openssl11, openssl3, libressl]</span><br><span>         b=
uild: [ normal, asan ]</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        os: [macos-12, macos-13, macos-14]</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        os: [macos-13, macos-14, macos-15]</span><b=
r><span>         include:</span><br><span>            # macos14 and newer r=
unners use ARM CPUs and homebrew uses /opt/homebrew/</span><br><span>      =
      # on ARM instead of /usr/local/</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-          - os: macos-12</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            homebrew: /usr/local/opt</span><br><span>   =
        - os: macos-13</span><br><span>             homebrew: /usr/local/op=
t</span><br><span>           - os: macos-14</span><br><span>             ho=
mebrew: /opt/homebrew/opt</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+          - os: macos-15</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            homebrew: /opt/homebrew/opt</span><br><span>        =
   - build: asan</span><br><span>             cflags: &quot;-fsanitize=3Dad=
dress,undefined -fno-sanitize-recover=3Dall  -fno-optimize-sibling-calls -f=
sanitize-address-use-after-scope -fno-omit-frame-pointer -g -O1&quot;</span=
><br><span>             ldflags: -fsanitize=3Daddress,undefined -fno-saniti=
ze-recover=3Dall</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/780?usp=3Demail">change 780</a>. =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/780?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ibaa591904095a824df2c0c5aaff=
73687e0af24fe </div>
<div style=3D"display:none"> Gerrit-Change-Number: 780 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--d1k7xqkJjYE=--

