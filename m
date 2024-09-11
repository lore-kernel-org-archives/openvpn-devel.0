From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 11 Sep 2024 14:59:23 +0000
In-Reply-To: <gerrit.1725974500000.I86ceceb4e1c716b33c6c6ec8853eca0fb4b394f1@...2715...>
References: <gerrit.1725974500000.I86ceceb4e1c716b33c6c6ec8853eca0fb4b394f1@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <94cc2e403ab8a7b1547a4573514abe18ab2a9bf7-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="aWS0PnaYmYg="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--aWS0PnaYmYg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/74=
1?usp=3Demail )

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
Gerrit-MessageType: merged

--aWS0PnaYmYg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/741?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">GHA: Update dependency Mbed-TLS/mbedtls to v3.=
6.1<br><br>Requires submodule checkout.<br><br>Change-Id: I86ceceb4e1c716b3=
3c6c6ec8853eca0fb4b394f1<br>Signed-off-by: Frank Lichtenheld &lt;frank@...1665...=
641...&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@...1227...&gt;<br>Mes=
sage-Id: &lt;20240911144231.32553-1-gert@...1296...&gt;<br>URL: https://www=
.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29208.html<br>Sign=
ed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M .github/workflo=
ws/build.yaml<br>1 file changed, 2 insertions(+), 1 deletion(-)<br><br></pr=
e>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml=
</span><br><span>index 6207c95..8f0a7b5 100644</span><br><span>--- a/.githu=
b/workflows/build.yaml</span><br><span>+++ b/.github/workflows/build.yaml</=
span><br><span>@@ -404,9 +404,10 @@</span><br><span>         uses: actions/=
checkout@...2691...</span><br><span>         with:</span><br><span>        =
   path: mbedtls</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
       submodules: true</span><br><span>           # versioning=3Dsemver-co=
erced</span><br><span>           repository: Mbed-TLS/mbedtls</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-          ref: v3.5.2</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+          ref: v3.6.1</span><br><=
span>       - name: &quot;mbedtls: make no_test&quot;</span><br><span>     =
    run: make -j3 no_test SHARED=3D1</span><br><span>         working-direc=
tory: mbedtls</span><br><span></span><br></pre><p>To view, visit <a href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/741?usp=3Demail">change 741</a>. To =
unsubscribe, or for help writing mail filters, visit <a href=3D"http://gerr=
it.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http:/=
/schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"ht=
tp://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/741?usp=3Demail"/><meta itemprop=3D"name" content=3D"=
View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--aWS0PnaYmYg=--

