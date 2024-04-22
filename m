From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 22 Apr 2024 15:43:51 +0000
References: <gerrit.1713800630000.I1c038dc4ec80d3499582d81eee61fee74f26e693@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <7bb7024258ddc0adf342620e9bafebd19d0ea135-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="jb+bpwGxlpk="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: configure: Try to
 detect LZO with pkg-config first
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

--jb+bpwGxlpk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/556?usp=3Demail

to review the following change.


Change subject: configure: Try to detect LZO with pkg-config first
......................................................................

configure: Try to detect LZO with pkg-config first

On most systems this should work just fine.

Change-Id: I1c038dc4ec80d3499582d81eee61fee74f26e693
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M configure.ac
1 file changed, 12 insertions(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/56/556/1

diff --git a/configure.ac b/configure.ac
index ce8b2b0..159d47c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1143,8 +1143,18 @@

 AC_ARG_VAR([LZO_CFLAGS], [C compiler flags for lzo])
 AC_ARG_VAR([LZO_LIBS], [linker flags for lzo])
-have_lzo=3D"yes"
+have_lzo=3D"no"
 if test -z "${LZO_LIBS}"; then
+    if test -z "${LZO_CFLAGS}" -a -z "${LZO_LIBS}"; then
+	# if the user did not explicitly specify flags, try to autodetect
+	PKG_CHECK_MODULES([LZO],
+			  [lzo2],
+			  [AC_CHECK_LIB([lzo2], [lzo1x_1_15_compress], [have_lzo=3D"yes"], [LZO=
_CFLAGS=3D"" LZO_LIBS=3D""])]
+			  []
+	)
+    fi
+    if test "${have_lzo}" =3D "no"; then
+	have_lzo=3D"yes"
 	AC_CHECK_LIB(
 		[lzo2],
 		[lzo1x_1_15_compress],
@@ -1156,6 +1166,7 @@
 			[have_lzo=3D"no"]
 		)]
 	)
+    fi
 fi
 if test "${have_lzo}" =3D "yes"; then
 	saved_CFLAGS=3D"${CFLAGS}"

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/556?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1c038dc4ec80d3499582d81eee61fee74f26e693
Gerrit-Change-Number: 556
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--jb+bpwGxlpk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/556?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">configure: Try to detect LZO with pkg-config first<br><br>On =
most systems this should work just fine.<br><br>Change-Id: I1c038dc4ec80d34=
99582d81eee61fee74f26e693<br>Signed-off-by: Frank Lichtenheld &lt;frank@...493...=
2641...&gt;<br>---<br>M configure.ac<br>1 file changed, 12 insertions(+), 1=
 deletion(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs=
/changes/56/556/1</pre><pre style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;"><span>diff --git a/configure.ac b/configure.ac</span><b=
r><span>index ce8b2b0..159d47c 100644</span><br><span>--- a/configure.ac</s=
pan><br><span>+++ b/configure.ac</span><br><span>@@ -1143,8 +1143,18 @@</sp=
an><br><span> </span><br><span> AC_ARG_VAR([LZO_CFLAGS], [C compiler flags =
for lzo])</span><br><span> AC_ARG_VAR([LZO_LIBS], [linker flags for lzo])</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-have_lzo=3D&quot;yes&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+have_lzo=3D&quot=
;no&quot;</span><br><span> if test -z &quot;${LZO_LIBS}&quot;; then</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if test -z &quot;${LZO_=
CFLAGS}&quot; -a -z &quot;${LZO_LIBS}&quot;; then</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+	# if the user did not explicitly specify fla=
gs, try to autodetect</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+	PKG_CHECK_MODULES([LZO],</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+			  [lzo2],</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+			  [AC_CHECK_LIB([lzo2], [lzo1x_1_15_compress], [have_lzo=3D&quot;yes&qu=
ot;], [LZO_CFLAGS=3D&quot;&quot; LZO_LIBS=3D&quot;&quot;])]</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+			  []</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+	)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    fi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if test &quot;${have_lzo}&quot; =3D &quot;no&quot;; then</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+	have_lzo=3D&quot;yes&quot;</span><b=
r><span> 	AC_CHECK_LIB(</span><br><span> 		[lzo2],</span><br><span> 		[lzo1=
x_1_15_compress],</span><br><span>@@ -1156,6 +1166,7 @@</span><br><span> 		=
	[have_lzo=3D&quot;no&quot;]</span><br><span> 		)]</span><br><span> 	)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    fi</span><br><span> =
fi</span><br><span> if test &quot;${have_lzo}&quot; =3D &quot;yes&quot;; th=
en</span><br><span> 	saved_CFLAGS=3D&quot;${CFLAGS}&quot;</span><br><span><=
/span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/556?usp=3Demail">change 556</a>. To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settin=
gs</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div =
itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/556?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1c038dc4ec80d3499582d81eee6=
1fee74f26e693 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 556 </div>
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


--jb+bpwGxlpk=--

