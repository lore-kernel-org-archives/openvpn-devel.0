From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 11 Sep 2024 14:59:22 +0000
In-Reply-To: <gerrit.1725974500000.I86ceceb4e1c716b33c6c6ec8853eca0fb4b394f1@...2715...>
References: <gerrit.1725974500000.I86ceceb4e1c716b33c6c6ec8853eca0fb4b394f1@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <94cc2e403ab8a7b1547a4573514abe18ab2a9bf7-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="maJQ+8VLodM="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: GHA: Update
 dependency Mbed-TLS/mbedtls to v3.6.1
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

--maJQ+8VLodM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/741?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos


Change subject: GHA: Update dependency Mbed-TLS/mbedtls to v3.6.1
......................................................................

GHA: Update dependency Mbed-TLS/mbedtls to v3.6.1

Requires submodule checkout.

Change-Id: I86ceceb4e1c716b33c6c6ec8853eca0fb4b394f1
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Message-Id: <20240911144231.32553-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29=
208.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M .github/workflows/build.yaml
1 file changed, 2 insertions(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/41/741/2

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 6207c95..8f0a7b5 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -404,9 +404,10 @@
         uses: actions/checkout@...2691...
         with:
           path: mbedtls
+          submodules: true
           # versioning=3Dsemver-coerced
           repository: Mbed-TLS/mbedtls
-          ref: v3.5.2
+          ref: v3.6.1
       - name: "mbedtls: make no_test"
         run: make -j3 no_test SHARED=3D1
         working-directory: mbedtls

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/741?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I86ceceb4e1c716b33c6c6ec8853eca0fb4b394f1
Gerrit-Change-Number: 741
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--maJQ+8VLodM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/741?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by plaisthos</p><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">GHA: Update dependency Mbed-TLS/mbedtls to v3.6.=
1<br><br>Requires submodule checkout.<br><br>Change-Id: I86ceceb4e1c716b33c=
6c6ec8853eca0fb4b394f1<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2716...=
1...&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@...1227...&gt;<br>Messa=
ge-Id: &lt;20240911144231.32553-1-gert@...1296...&gt;<br>URL: https://www.m=
ail-archive.com/openvpn-devel@lists.sourceforge.net/msg29208.html<br>Signed=
-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M .github/workflows=
/build.yaml<br>1 file changed, 2 insertions(+), 1 deletion(-)<br><br></pre>=
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git=
 pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/41/741/2</pre><pr=
e style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>=
diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml</s=
pan><br><span>index 6207c95..8f0a7b5 100644</span><br><span>--- a/.github/w=
orkflows/build.yaml</span><br><span>+++ b/.github/workflows/build.yaml</spa=
n><br><span>@@ -404,9 +404,10 @@</span><br><span>         uses: actions/che=
ckout@...2691...</span><br><span>         with:</span><br><span>           =
path: mbedtls</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
    submodules: true</span><br><span>           # versioning=3Dsemver-coerc=
ed</span><br><span>           repository: Mbed-TLS/mbedtls</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-          ref: v3.5.2</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+          ref: v3.6.1</span><br><spa=
n>       - name: &quot;mbedtls: make no_test&quot;</span><br><span>        =
 run: make -j3 no_test SHARED=3D1</span><br><span>         working-director=
y: mbedtls</span><br><span></span><br></pre><p>To view, visit <a href=3D"ht=
tp://gerrit.openvpn.net/c/openvpn/+/741?usp=3Demail">change 741</a>. To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit.=
openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://sc=
hema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:=
//schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/741?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vie=
w Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I86ceceb4e1c716b33c6c6ec8853=
eca0fb4b394f1 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 741 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--maJQ+8VLodM=--

