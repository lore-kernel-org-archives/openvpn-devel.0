From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 14 Jul 2025 12:25:51 +0000
References: <gerrit.1752495948000.I152577b7d9b3b3a0d298971f47ba412d3f43d50d@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <6c123e85dd1556fdbefde0851bb97534536dc71a-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="HERsdyqJRFQ="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Do not check for
 pkcs11-helper when pkcs11 is not enabled
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

--HERsdyqJRFQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1085?usp=3Demail

to review the following change.


Change subject: Do not check for pkcs11-helper when pkcs11 is not enabled
......................................................................

Do not check for pkcs11-helper when pkcs11 is not enabled

On my system with mac and homebrew this pulls in a version from homebrew
that adds OpenSSL paths/flags from homebrew as well. Those flags then
end up in various other locations.

Change-Id: I152577b7d9b3b3a0d298971f47ba412d3f43d50d
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M configure.ac
1 file changed, 8 insertions(+), 6 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/85/1085/1

diff --git a/configure.ac b/configure.ac
index 51c20ef..c1ee69c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -798,12 +798,14 @@
 		;;
 esac

-PKG_CHECK_MODULES(
-	[PKCS11_HELPER],
-	[libpkcs11-helper-1 >=3D 1.11],
-	[have_pkcs11_helper=3D"yes"],
-	[]
-)
+if test "${enable_pkcs11}" =3D "yes"; then
+    PKG_CHECK_MODULES(
+        [PKCS11_HELPER],
+        [libpkcs11-helper-1 >=3D 1.11],
+        [have_pkcs11_helper=3D"yes"],
+        []
+    )
+fi


 if test "$enable_dco" !=3D "no"; then

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1085?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I152577b7d9b3b3a0d298971f47ba412d3f43d50d
Gerrit-Change-Number: 1085
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--HERsdyqJRFQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1085?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">Do not check for pkcs11-helper when pkcs11 is not enabled<br=
><br>On my system with mac and homebrew this pulls in a version from homebr=
ew<br>that adds OpenSSL paths/flags from homebrew as well. Those flags then=
<br>end up in various other locations.<br><br>Change-Id: I152577b7d9b3b3a0d=
298971f47ba412d3f43d50d<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&=
gt;<br>---<br>M configure.ac<br>1 file changed, 8 insertions(+), 6 deletion=
s(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes=
/85/1085/1</pre><pre style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;"><span>diff --git a/configure.ac b/configure.ac</span><br><span=
>index 51c20ef..c1ee69c 100644</span><br><span>--- a/configure.ac</span><br=
><span>+++ b/configure.ac</span><br><span>@@ -798,12 +798,14 @@</span><br><=
span> 		;;</span><br><span> esac</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-PKG_CHECK_MODULES(</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-	[PKCS11_HELPER],</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-	[libpkcs11-helper-1 &gt;=3D 1.11],</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-	[have_pkcs11_helper=3D&quot;yes&quot;]=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	[]</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+if test &quot;${enable_pkcs11}&quot; =3D &quot;yes&quot;=
; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    PKG_CHECK=
_MODULES(</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        [P=
KCS11_HELPER],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   [libpkcs11-helper-1 &gt;=3D 1.11],</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        [have_pkcs11_helper=3D&quot;yes&quot;],</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        []</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    )</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+fi</span><br><span> </span><br><span> </span><br><sp=
an> if test &quot;$enable_dco&quot; !=3D &quot;no&quot;; then</span><br><sp=
an></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/1085?usp=3Demail">change 1085</a>. To unsubscribe, or for help =
writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">=
settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"=
><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewActio=
n"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/108=
5?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I152577b7d9b3b3a0d298971f47b=
a412d3f43d50d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1085 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--HERsdyqJRFQ=--

