From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 14 Oct 2025 11:33:58 +0000
References: <gerrit.1760441635000.I54b11a5540fb236580a3b80c6d1e8678b24bd852@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <7337e2584def18d0e2039fc1410aa060a6ee1abf-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8m+qQRRjN4Y="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Silence unhelpful
 compiler truncation warning with bigger buffer
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--8m+qQRRjN4Y=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1272?usp=3Demail

to review the following change.


Change subject: Silence unhelpful compiler truncation warning with bigger b=
uffer
......................................................................

Silence unhelpful compiler truncation warning with bigger buffer

On the more recent mingw compilers (homebrew mingw 13.0.0, GCC 15.2.0) the
compiler complains about a potential truncation in these two places.

  src/openvpn/tun.c:3806:57:
  error: '%s' directive output may be truncated writing up
  to 255 bytes into a region of size 178
  [-Werror=3Dformat-truncation=3D]

This not very helpful but just increasing the buffer sizes makes the warning
go away.

Change-Id: I54b11a5540fb236580a3b80c6d1e8678b24bd852
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/tun.c
1 file changed, 2 insertions(+), 2 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/72/1272/1

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 06b7ae5..fc06b16 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -3784,7 +3784,7 @@
     while (true)
     {
         char enum_name[256];
-        char unit_string[256];
+        char unit_string[512];
         HKEY unit_key;
         char component_id_string[] =3D "ComponentId";
         char component_id[256];
@@ -3895,7 +3895,7 @@
     while (true)
     {
         char enum_name[256];
-        char connection_string[256];
+        char connection_string[512];
         HKEY connection_key;
         WCHAR name_data[256];
         DWORD name_type;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1272?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I54b11a5540fb236580a3b80c6d1e8678b24bd852
Gerrit-Change-Number: 1272
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>

--8m+qQRRjN4Y=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1272?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">Silence unhelpful compiler truncation warni=
ng with bigger buffer<br><br>On the more recent mingw compilers (homebrew m=
ingw 13.0.0, GCC 15.2.0) the<br>compiler complains about a potential trunca=
tion in these two places.<br><br>  src/openvpn/tun.c:3806:57:<br>  error: &=
#39;%s&#39; directive output may be truncated writing up<br>  to 255 bytes =
into a region of size 178<br>  [-Werror=3Dformat-truncation=3D]<br><br>This=
 not very helpful but just increasing the buffer sizes makes the warning<br=
>go away.<br><br>Change-Id: I54b11a5540fb236580a3b80c6d1e8678b24bd852<br>Si=
gned-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>---<br>M src/openvpn/t=
un.c<br>1 file changed, 2 insertions(+), 2 deletions(-)<br><br></pre><pre c=
lass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/72/127=
2/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c</span><br><s=
pan>index 06b7ae5..fc06b16 100644</span><br><span>--- a/src/openvpn/tun.c</=
span><br><span>+++ b/src/openvpn/tun.c</span><br><span>@@ -3784,7 +3784,7 @=
@</span><br><span>     while (true)</span><br><span>     {</span><br><span>=
         char enum_name[256];</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        char unit_string[256];</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        char unit_string[512];</span><br><span>         =
HKEY unit_key;</span><br><span>         char component_id_string[] =3D &quo=
t;ComponentId&quot;;</span><br><span>         char component_id[256];</span=
><br><span>@@ -3895,7 +3895,7 @@</span><br><span>     while (true)</span><b=
r><span>     {</span><br><span>         char enum_name[256];</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        char connection_string[256];=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        char connec=
tion_string[512];</span><br><span>         HKEY connection_key;</span><br><=
span>         WCHAR name_data[256];</span><br><span>         DWORD name_typ=
e;</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1272?usp=3Demail">change 1272</a>. To unsubscri=
be, or for help writing mail filters, visit <a href=3D"http://gerrit.openvp=
n.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/1272?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I54b11a5540fb236580a3b80c6d1=
e8678b24bd852 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1272 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--8m+qQRRjN4Y=--

