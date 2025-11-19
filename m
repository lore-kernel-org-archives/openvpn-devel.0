From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 19 Nov 2025 15:21:58 +0000
References: <gerrit.1763565716000.I1633ee6207443e041434e9f0dda98afd5a22e1b4@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <9e8deb115bbf4600053bca0b3771d7b37c8ea041-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="pT0oZcByNhQ="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--pT0oZcByNhQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1382?usp=3Demail

to review the following change.


Change subject: GHA: Add macos-26 and remove OpenSSL 1.1 builds on macOS
......................................................................

GHA: Add macos-26 and remove OpenSSL 1.1 builds on macOS

The new runner doesn't have OpenSSL 1.1 available anymore
via homebrew. The formula is also marked as "deprecated"
for older macOS versions. So I think it is okay to drop
it.

Change-Id: I1633ee6207443e041434e9f0dda98afd5a22e1b4
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M .github/workflows/build.yaml
1 file changed, 2 insertions(+), 2 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/82/1382/1

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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1633ee6207443e041434e9f0dda98afd5a22e1b4
Gerrit-Change-Number: 1382
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--pT0oZcByNhQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1382?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">GHA: Add macos-26 and remove OpenSSL 1.1 bu=
ilds on macOS<br><br>The new runner doesn&#39;t have OpenSSL 1.1 available =
anymore<br>via homebrew. The formula is also marked as &quot;deprecated&quo=
t;<br>for older macOS versions. So I think it is okay to drop<br>it.<br><br=
>Change-Id: I1633ee6207443e041434e9f0dda98afd5a22e1b4<br>Signed-off-by: Fra=
nk Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M .github/workflows/build=
.yaml<br>1 file changed, 2 insertions(+), 2 deletions(-)<br><br></pre><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/82/13=
82/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;"><span>diff --git a/.github/workflows/build.yaml b/.github/workflows/=
build.yaml</span><br><span>index 96d2292..357072d 100644</span><br><span>--=
- a/.github/workflows/build.yaml</span><br><span>+++ b/.github/workflows/bu=
ild.yaml</span><br><span>@@ -210,9 +210,9 @@</span><br><span>     strategy:=
</span><br><span>       fail-fast: false</span><br><span>       matrix:</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        ssllib: [openssl@=
...2560..., openssl@...1554..., libressl]</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        ssllib: [openssl@...1554..., libressl]</span>=
<br><span>         build: [normal, asan]</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        os: [macos-14, macos-15]</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        os: [macos-14, macos-15, macos-26=
]</span><br><span>         include:</span><br><span>           - build: asa=
n</span><br><span>             cflags: &quot;-fsanitize=3Daddress,undefined=
 -fno-sanitize-recover=3Dall  -fno-optimize-sibling-calls -fsanitize-addres=
s-use-after-scope -fno-omit-frame-pointer -g -O1&quot;</span><br><span></sp=
an><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/1382?usp=3Demail">change 1382</a>. To unsubscribe, or for help writing=
 mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Dem=
ail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/View=
Action"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/1382?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div=
></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1633ee6207443e041434e9f0dda=
98afd5a22e1b4 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1382 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--pT0oZcByNhQ=--

