From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 8 May 2024 14:19:41 +0000
In-Reply-To: <gerrit.1713800630000.I1c038dc4ec80d3499582d81eee61fee74f26e693@...2715...>
References: <gerrit.1713800630000.I1c038dc4ec80d3499582d81eee61fee74f26e693@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, gert@...1296...
Message-ID: <0e22a53e35f9dc589d199896d2a1f0ae8b564c9a-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="lC3k2Rpq75w="; charset=UTF-8
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

--lC3k2Rpq75w=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/556?usp=3Demail

to look at the new patch set (#3).


Change subject: configure: Try to detect LZO with pkg-config
......................................................................

configure: Try to detect LZO with pkg-config

On most systems this should work just fine.

Also remove the handling to autodetect -llzo. This
seems to be very uncommon now (we do not have examples
of it in our build farm). If you have a system that
needs -llzo just specify LZO_LIBS or configure pkg-config
correctly.

v2:
 - simplify code by removing -llzo special handling

Change-Id: I1c038dc4ec80d3499582d81eee61fee74f26e693
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M configure.ac
1 file changed, 9 insertions(+), 12 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/56/556/3

diff --git a/configure.ac b/configure.ac
index ce8b2b0..e5c11da 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1143,19 +1143,16 @@

 AC_ARG_VAR([LZO_CFLAGS], [C compiler flags for lzo])
 AC_ARG_VAR([LZO_LIBS], [linker flags for lzo])
-have_lzo=3D"yes"
-if test -z "${LZO_LIBS}"; then
-	AC_CHECK_LIB(
+if test -z "${LZO_CFLAGS}" -a -z "${LZO_LIBS}"; then
+   # if the user did not explicitly specify flags, try to autodetect
+   PKG_CHECK_MODULES([LZO],
 		[lzo2],
-		[lzo1x_1_15_compress],
-		[LZO_LIBS=3D"-llzo2"],
-		[AC_CHECK_LIB(
-			[lzo],
-			[lzo1x_1_15_compress],
-			[LZO_LIBS=3D"-llzo"],
-			[have_lzo=3D"no"]
-		)]
-	)
+		[have_lzo=3D"yes"],
+		[have_lzo=3D"no"]
+    )
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
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--lC3k2Rpq75w=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>flichtenheld <strong>uploaded patch set #3</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/556?usp=3Demail">View Ch=
ange</a></p><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">configure: Try to detect LZO with pkg-config<br><br>On most system=
s this should work just fine.<br><br>Also remove the handling to autodetect=
 -llzo. This<br>seems to be very uncommon now (we do not have examples<br>o=
f it in our build farm). If you have a system that<br>needs -llzo just spec=
ify LZO_LIBS or configure pkg-config<br>correctly.<br><br>v2:<br> - simplif=
y code by removing -llzo special handling<br><br>Change-Id: I1c038dc4ec80d3=
499582d81eee61fee74f26e693<br>Signed-off-by: Frank Lichtenheld &lt;frank@...1186...=
.2641...&gt;<br>---<br>M configure.ac<br>1 file changed, 9 insertions(+), 1=
2 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn re=
fs/changes/56/556/3</pre><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;"><span>diff --git a/configure.ac b/configure.ac</span>=
<br><span>index ce8b2b0..e5c11da 100644</span><br><span>--- a/configure.ac<=
/span><br><span>+++ b/configure.ac</span><br><span>@@ -1143,19 +1143,16 @@<=
/span><br><span> </span><br><span> AC_ARG_VAR([LZO_CFLAGS], [C compiler fla=
gs for lzo])</span><br><span> AC_ARG_VAR([LZO_LIBS], [linker flags for lzo]=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-have_lzo=3D&quot;yes=
&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-if test -z &quo=
t;${LZO_LIBS}&quot;; then</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-	AC_CHECK_LIB(</span><br><span style=3D"color: hsl(120, 100%, 40%);">+i=
f test -z &quot;${LZO_CFLAGS}&quot; -a -z &quot;${LZO_LIBS}&quot;; then</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+   # if the user did no=
t explicitly specify flags, try to autodetect</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+   PKG_CHECK_MODULES([LZO],</span><br><span> 		[l=
zo2],</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		[lzo1x_1_15_co=
mpress],</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		[LZO_LIBS=
=3D&quot;-llzo2&quot;],</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-		[AC_CHECK_LIB(</span><br><span style=3D"color: hsl(0, 100%, 40%);">-			=
[lzo],</span><br><span style=3D"color: hsl(0, 100%, 40%);">-			[lzo1x_1_15_=
compress],</span><br><span style=3D"color: hsl(0, 100%, 40%);">-			[LZO_LIB=
S=3D&quot;-llzo&quot;],</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-			[have_lzo=3D&quot;no&quot;]</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-		)]</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+		[have_lzo=3D&quot;yes=
&quot;],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+		[have_lzo=
=3D&quot;no&quot;]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   )</span><br><span style=3D"color: hsl(120, 100%, 40%);">+else</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    # assume the user configur=
ed it correctly</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
have_lzo=3D&quot;yes&quot;</span><br><span> fi</span><br><span> if test &qu=
ot;${have_lzo}&quot; =3D &quot;yes&quot;; then</span><br><span> 	saved_CFLA=
GS=3D&quot;${CFLAGS}&quot;</span><br><span></span><br></pre><p>To view, vis=
it <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/556?usp=3Demail">change=
 556</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/556?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1c038dc4ec80d3499582d81eee6=
1fee74f26e693 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 556 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@...1296...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--lC3k2Rpq75w=--

