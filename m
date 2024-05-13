From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 13 May 2024 11:04:13 +0000
In-Reply-To: <gerrit.1713800630000.I1c038dc4ec80d3499582d81eee61fee74f26e693@...2715...>
References: <gerrit.1713800630000.I1c038dc4ec80d3499582d81eee61fee74f26e693@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, gert@...1296...
Message-ID: <99bcd311edd093901eb26cfd3196380e455025e2-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="j+uwxYpQhho="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: configure: Try to
 detect LZO with pkg-config
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: cron2 <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--j+uwxYpQhho=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, plaisthos.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/556?usp=3Demail

to look at the new patch set (#4).


Change subject: configure: Try to detect LZO with pkg-config
......................................................................

configure: Try to detect LZO with pkg-config

On most systems this should work just fine.

v2:
 - simplify code by removing -llzo special handling
v3:
 - reintroduce support for autodetection without pkg-config,
   no need to break backwards compatibility right now

Change-Id: I1c038dc4ec80d3499582d81eee61fee74f26e693
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M configure.ac
1 file changed, 15 insertions(+), 2 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/56/556/4

diff --git a/configure.ac b/configure.ac
index ce8b2b0..d834f30 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1143,8 +1143,17 @@

 AC_ARG_VAR([LZO_CFLAGS], [C compiler flags for lzo])
 AC_ARG_VAR([LZO_LIBS], [linker flags for lzo])
-have_lzo=3D"yes"
-if test -z "${LZO_LIBS}"; then
+if test -z "${LZO_CFLAGS}" -a -z "${LZO_LIBS}"; then
+    # if the user did not explicitly specify flags, try to autodetect
+    PKG_CHECK_MODULES([LZO],
+		[lzo2],
+		[have_lzo=3D"yes"],
+		[]
+    )
+
+    if test "${have_lzo}" !=3D "yes"; then
+	# try to detect without pkg-config
+	have_lzo=3D"yes"
 	AC_CHECK_LIB(
 		[lzo2],
 		[lzo1x_1_15_compress],
@@ -1156,6 +1165,10 @@
 			[have_lzo=3D"no"]
 		)]
 	)
+    fi
+else
+    # assume the user configured it correctly
+    have_lzo=3D"yes"
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
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-MessageType: newpatchset

--j+uwxYpQhho=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #4</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/556?usp=3Demail">View Ch=
ange</a></p><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">configure: Try to detect LZO with pkg-config<br><br>On most system=
s this should work just fine.<br><br>v2:<br> - simplify code by removing -l=
lzo special handling<br>v3:<br> - reintroduce support for autodetection wit=
hout pkg-config,<br>   no need to break backwards compatibility right now<b=
r><br>Change-Id: I1c038dc4ec80d3499582d81eee61fee74f26e693<br>Signed-off-by=
: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M configure.ac<br>1 =
file changed, 15 insertions(+), 2 deletions(-)<br><br></pre><pre style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ger=
rit.openvpn.net:29418/openvpn refs/changes/56/556/4</pre><pre style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/co=
nfigure.ac b/configure.ac</span><br><span>index ce8b2b0..d834f30 100644</sp=
an><br><span>--- a/configure.ac</span><br><span>+++ b/configure.ac</span><b=
r><span>@@ -1143,8 +1143,17 @@</span><br><span> </span><br><span> AC_ARG_VA=
R([LZO_CFLAGS], [C compiler flags for lzo])</span><br><span> AC_ARG_VAR([LZ=
O_LIBS], [linker flags for lzo])</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-have_lzo=3D&quot;yes&quot;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-if test -z &quot;${LZO_LIBS}&quot;; then</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+if test -z &quot;${LZO_CFLAGS}&quot; -=
a -z &quot;${LZO_LIBS}&quot;; then</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    # if the user did not explicitly specify flags, try to a=
utodetect</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    PKG_CH=
ECK_MODULES([LZO],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	=
	[lzo2],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+		[have_lzo=
=3D&quot;yes&quot;],</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+		[]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    )</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if test &quot;${have_lzo}&quot; !=3D &quot;=
yes&quot;; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	# t=
ry to detect without pkg-config</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+	have_lzo=3D&quot;yes&quot;</span><br><span> 	AC_CHECK_LIB(</sp=
an><br><span> 		[lzo2],</span><br><span> 		[lzo1x_1_15_compress],</span><br=
><span>@@ -1156,6 +1165,10 @@</span><br><span> 			[have_lzo=3D&quot;no&quot=
;]</span><br><span> 		)]</span><br><span> 	)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    fi</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 # assume the user configured it correctly</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    have_lzo=3D&quot;yes&quot;</span><br><span> fi</=
span><br><span> if test &quot;${have_lzo}&quot; =3D &quot;yes&quot;; then</=
span><br><span> 	saved_CFLAGS=3D&quot;${CFLAGS}&quot;</span><br><span></spa=
n><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/556?usp=3Demail">change 556</a>. To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</=
a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div item=
scope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link i=
temprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/556?usp=3Dema=
il"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1c038dc4ec80d3499582d81eee6=
1fee74f26e693 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 556 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@...1296...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--j+uwxYpQhho=--

