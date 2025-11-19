From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 19 Nov 2025 17:03:58 +0000
In-Reply-To: <gerrit.1763565716000.I1633ee6207443e041434e9f0dda98afd5a22e1b4@...2715...>
References: <gerrit.1763565716000.I1633ee6207443e041434e9f0dda98afd5a22e1b4@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 yura.uddr@...277...
Message-ID: <0a93e346dd5430449c3e7a321cf88cbf2eb91e3d-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="C9yKSzawbAo="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: uddr <yura.uddr@...277...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--C9yKSzawbAo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/13=
82?usp=3Demail )

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

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1633ee6207443e041434e9f0dda98afd5a22e1b4
Gerrit-Change-Number: 1382
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: uddr <yura.uddr@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--C9yKSzawbAo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1382?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">GHA: Add macos-26 and remove OpenSSL 1.1 builds =
on macOS<br><br>The new runner doesn&#39;t have OpenSSL 1.1 available anymo=
re<br>via homebrew. The formula is also marked as &quot;deprecated&quot;<br=
>for older macOS versions. So I think it is okay to drop<br>it.<br><br>Chan=
ge-Id: I1633ee6207443e041434e9f0dda98afd5a22e1b4<br>Signed-off-by: Frank Li=
chtenheld &lt;frank@...2641...&gt;<br>Acked-by: Yuriy Darnobyt &lt;yura.udd=
r@...277...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1382<=
br>Message-Id: &lt;20251119162934.15672-1-gert@...1296...&gt;<br>Signed-off=
-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M .github/workflows/bui=
ld.yaml<br>1 file changed, 2 insertions(+), 2 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml=
</span><br><span>index 96d2292..357072d 100644</span><br><span>--- a/.githu=
b/workflows/build.yaml</span><br><span>+++ b/.github/workflows/build.yaml</=
span><br><span>@@ -210,9 +210,9 @@</span><br><span>     strategy:</span><br=
><span>       fail-fast: false</span><br><span>       matrix:</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        ssllib: [openssl@...2560...=
, openssl@...1554..., libressl]</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        ssllib: [openssl@...1554..., libressl]</span><br><span>=
         build: [normal, asan]</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        os: [macos-14, macos-15]</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        os: [macos-14, macos-15, macos-26]</span><br>=
<span>         include:</span><br><span>           - build: asan</span><br>=
<span>             cflags: &quot;-fsanitize=3Daddress,undefined -fno-saniti=
ze-recover=3Dall  -fno-optimize-sibling-calls -fsanitize-address-use-after-=
scope -fno-omit-frame-pointer -g -O1&quot;</span><br><span></span><br></pre=
><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1382?us=
p=3Demail">change 1382</a>. To unsubscribe, or for help writing mail filter=
s, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">setting=
s</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><lin=
k itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1382?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
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

--C9yKSzawbAo=--

