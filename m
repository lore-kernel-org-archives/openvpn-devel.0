From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 1 Dec 2025 11:11:20 +0000
In-Reply-To: <gerrit.1764370297000.Ic4e233c788b16a862c1fddcf314a3da661072fb5@...2715...>
References: <gerrit.1764370297000.Ic4e233c788b16a862c1fddcf314a3da661072fb5@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., selva.nair@...277...,
 openvpn-devel@lists.sourceforge.net, lstipakov@...277...
Message-ID: <a56016f4b5eddab176cdb3f19751c36a1d74e4a9-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="KazDMgt82j8="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Set UTF-8 as the
 codepage using manifest declaration
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: selvanair <selva.nair@...277...>
Cc: stipa <lstipakov@...277...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--KazDMgt82j8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/14=
13?usp=3Demail )

Change subject: Set UTF-8 as the codepage using manifest declaration
......................................................................

Set UTF-8 as the codepage using manifest declaration

Works on Windows 10+. This ensures any UTF-8 string we pass to
ANSI API will not get interpreted in some local code page
in effect at runtime.

Although we do not use any such API, OpenSSL dll we link to
does (e.g., the store API used for reading certificate and
key from files). OpenSSL may fix this in future versions,
but this is an easy workaround that looks harmless and appropriate.

Fixes failure to read certificates when filenames contain non-ascii
characters reported by: Carsten Mietzsch <Carsten.Mietzsch@...2971...>

Ref: https://learn.microsoft.com/en-us/windows/apps/design/globalizing/use-=
utf8-code-page
Github: OpenVPN/openvpn#920

Change-Id: Ic4e233c788b16a862c1fddcf314a3da661072fb5
Signed-off-by: Selva Nair <selva.nair@...277...>
Acked-by: Lev Stipakov <lstipakov@...277...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1413
Message-Id: <20251201090110.5487-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
805.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/openvpn.manifest
1 file changed, 5 insertions(+), 0 deletions(-)




diff --git a/src/openvpn/openvpn.manifest b/src/openvpn/openvpn.manifest
index fa5b3d7..f964152 100644
--- a/src/openvpn/openvpn.manifest
+++ b/src/openvpn/openvpn.manifest
@@ -14,6 +14,11 @@
             <supportedOS Id=3D"{e2011457-1546-43c5-a5fe-008deee3d3f0}"/>
         </application>
     </compatibility>
+    <application>
+        <windowsSettings>
+            <activeCodePage xmlns=3D"http://schemas.microsoft.com/SMI/2019=
/WindowsSettings">UTF-8</activeCodePage>
+        </windowsSettings>
+    </application>
     <trustInfo xmlns=3D"urn:schemas-microsoft-com:asm.v3">
         <security>
             <requestedPrivileges>

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1413?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic4e233c788b16a862c1fddcf314a3da661072fb5
Gerrit-Change-Number: 1413
Gerrit-PatchSet: 2
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--KazDMgt82j8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1413?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">Set UTF-8 as the codepage using manifest declara=
tion<br><br>Works on Windows 10+. This ensures any UTF-8 string we pass to<=
br>ANSI API will not get interpreted in some local code page<br>in effect a=
t runtime.<br><br>Although we do not use any such API, OpenSSL dll we link =
to<br>does (e.g., the store API used for reading certificate and<br>key fro=
m files). OpenSSL may fix this in future versions,<br>but this is an easy w=
orkaround that looks harmless and appropriate.<br><br>Fixes failure to read=
 certificates when filenames contain non-ascii<br>characters reported by: C=
arsten Mietzsch &lt;Carsten.Mietzsch@...2971...&gt;<br><br>Ref: https://lea=
rn.microsoft.com/en-us/windows/apps/design/globalizing/use-utf8-code-page<b=
r>Github: OpenVPN/openvpn#920<br><br>Change-Id: Ic4e233c788b16a862c1fddcf31=
4a3da661072fb5<br>Signed-off-by: Selva Nair &lt;selva.nair@...277...&gt;<br=
>Acked-by: Lev Stipakov &lt;lstipakov@...277...&gt;<br>Gerrit URL: https://=
gerrit.openvpn.net/c/openvpn/+/1413<br>Message-Id: &lt;20251201090110.5487-=
1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1224...=
sts.sourceforge.net/msg34805.html<br>Signed-off-by: Gert Doering &lt;gert@...220...=
..1296...&gt;<br>---<br>M src/openvpn/openvpn.manifest<br>1 file changed, 5=
 insertions(+), 0 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/openvpn.manifest b/src/openvpn/openvpn.manifest=
</span><br><span>index fa5b3d7..f964152 100644</span><br><span>--- a/src/op=
envpn/openvpn.manifest</span><br><span>+++ b/src/openvpn/openvpn.manifest</=
span><br><span>@@ -14,6 +14,11 @@</span><br><span>             &lt;supporte=
dOS Id=3D&quot;{e2011457-1546-43c5-a5fe-008deee3d3f0}&quot;/&gt;</span><br>=
<span>         &lt;/application&gt;</span><br><span>     &lt;/compatibility=
&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;applica=
tion&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &lt=
;windowsSettings&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            &lt;activeCodePage xmlns=3D&quot;http://schemas.microsoft.com/=
SMI/2019/WindowsSettings&quot;&gt;UTF-8&lt;/activeCodePage&gt;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        &lt;/windowsSettings&gt;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;/applicatio=
n&gt;</span><br><span>     &lt;trustInfo xmlns=3D&quot;urn:schemas-microsof=
t-com:asm.v3&quot;&gt;</span><br><span>         &lt;security&gt;</span><br>=
<span>             &lt;requestedPrivileges&gt;</span><br><span></span><br><=
/pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/141=
3?usp=3Demail">change 1413</a>. To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">set=
tings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><d=
iv itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction">=
<link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1413?u=
sp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic4e233c788b16a862c1fddcf314=
a3da661072fb5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1413 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: selvanair &lt;selva.nair@...1354...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--KazDMgt82j8=--

