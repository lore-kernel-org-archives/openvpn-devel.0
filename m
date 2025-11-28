From: "selvanair (Code Review)" <gerrit@...515...>
Date: Fri, 28 Nov 2025 22:51:41 +0000
References: <gerrit.1764370297000.Ic4e233c788b16a862c1fddcf314a3da661072fb5@...2715...>
Reply-To: selva.nair@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <f69a72cf411b2287365d2edc809a28e396bdf8a4-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="DPzG9kOP2ZU="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--DPzG9kOP2ZU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1413?usp=3Demail

to review the following change.


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

Change-Id: Ic4e233c788b16a862c1fddcf314a3da661072fb5
Signed-off-by: Selva Nair <selva.nair@...277...>
---
M src/openvpn/openvpn.manifest
1 file changed, 5 insertions(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/13/1413/1

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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic4e233c788b16a862c1fddcf314a3da661072fb5
Gerrit-Change-Number: 1413
Gerrit-PatchSet: 1
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--DPzG9kOP2ZU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>selvanair would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1413?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">Set UTF-8 as the codepage using manifest de=
claration<br><br>Works on Windows 10+. This ensures any UTF-8 string we pas=
s to<br>ANSI API will not get interpreted in some local code page<br>in eff=
ect at runtime.<br><br>Although we do not use any such API, OpenSSL dll we =
link to<br>does (e.g., the store API used for reading certificate and<br>ke=
y from files). OpenSSL may fix this in future versions,<br>but this is an e=
asy workaround that looks harmless and appropriate.<br><br>Fixes failure to=
 read certificates when filenames contain non-ascii<br>characters reported =
by: Carsten Mietzsch &lt;Carsten.Mietzsch@...2971...&gt;<br><br>Ref: https:=
//learn.microsoft.com/en-us/windows/apps/design/globalizing/use-utf8-code-p=
age<br><br>Change-Id: Ic4e233c788b16a862c1fddcf314a3da661072fb5<br>Signed-o=
ff-by: Selva Nair &lt;selva.nair@...277...&gt;<br>---<br>M src/openvpn/open=
vpn.manifest<br>1 file changed, 5 insertions(+), 0 deletions(-)<br><br></pr=
e><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/change=
s/13/1413/1</pre><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;"><span>diff --git a/src/openvpn/openvpn.manifest b/src/openvpn=
/openvpn.manifest</span><br><span>index fa5b3d7..f964152 100644</span><br><=
span>--- a/src/openvpn/openvpn.manifest</span><br><span>+++ b/src/openvpn/o=
penvpn.manifest</span><br><span>@@ -14,6 +14,11 @@</span><br><span>        =
     &lt;supportedOS Id=3D&quot;{e2011457-1546-43c5-a5fe-008deee3d3f0}&quot=
;/&gt;</span><br><span>         &lt;/application&gt;</span><br><span>     &=
lt;/compatibility&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    &lt;application&gt;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        &lt;windowsSettings&gt;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            &lt;activeCodePage xmlns=3D&quot;http://schem=
as.microsoft.com/SMI/2019/WindowsSettings&quot;&gt;UTF-8&lt;/activeCodePage=
&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &lt;/wi=
ndowsSettings&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  &lt;/application&gt;</span><br><span>     &lt;trustInfo xmlns=3D&quot;urn=
:schemas-microsoft-com:asm.v3&quot;&gt;</span><br><span>         &lt;securi=
ty&gt;</span><br><span>             &lt;requestedPrivileges&gt;</span><br><=
span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/1413?usp=3Demail">change 1413</a>. To unsubscribe, or for hel=
p writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings=
?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/1413?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic4e233c788b16a862c1fddcf314=
a3da661072fb5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1413 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: selvanair &lt;selva.nair@...1354...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--DPzG9kOP2ZU=--

