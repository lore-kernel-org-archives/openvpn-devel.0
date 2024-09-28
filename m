From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 28 Sep 2024 20:12:27 +0000
In-Reply-To: <gerrit.1727186481000.Iec1953415afb53755488dd44407568e72d28e854@...2715...>
References: <gerrit.1727186481000.Iec1953415afb53755488dd44407568e72d28e854@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <b93a89581721e2965f513bf6f054a293ba7c6eb4-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Bp5AOhhU7yM="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: t_client.sh:
 conditionally skip ifconfig+route check
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Bp5AOhhU7yM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/76=
8?usp=3Demail )

Change subject: t_client.sh: conditionally skip ifconfig+route check
......................................................................

t_client.sh: conditionally skip ifconfig+route check

For --dev null or --dev-type af_unix:lwipopenvn tests, there will be
no visible change to ifconfig or route output, so tests will fail
("how can this be?").  Set EXPECT_IFCONFIG4_<n>=3D- to skip this
check.

(Simply leaving both EXPECT_IFCONFIG* vars empty and using that as
trigger would interfere with the magic from commit df0b00c25)

v2: fix string-equal comparison

Change-Id: Iec1953415afb53755488dd44407568e72d28e854
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20240928200508.23747-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29=
473.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M tests/t_client.sh.in
1 file changed, 11 insertions(+), 6 deletions(-)




diff --git a/tests/t_client.sh.in b/tests/t_client.sh.in
index f6654dd..1ccadeb 100755
--- a/tests/t_client.sh.in
+++ b/tests/t_client.sh.in
@@ -225,6 +225,7 @@
     expect_list=3D"$@"

     if [ -z "$expect_list" ] ; then return ; fi
+    if [ "$expect_list" =3D "-" ] ; then return ; fi

     for expect in $expect_list
     do
@@ -404,13 +405,17 @@
     output "save ifconfig+route"
     get_ifconfig_route >$LOGDIR/$SUF:ifconfig_route.txt

-    output -n "compare pre-openvpn ifconfig+route with current values..."
-    if diff $LOGDIR/$SUF:ifconfig_route_pre.txt \
-	    $LOGDIR/$SUF:ifconfig_route.txt >/dev/null
-    then
-	fail "no differences between ifconfig/route before OpenVPN start and now."
+    if [ "$expect_ifconfig4" =3D "-" ] ; then
+        output "skip ifconfig+route check"
     else
-	output " OK!\n"
+	output -n "compare pre-openvpn ifconfig+route with current values..."
+	if diff $LOGDIR/$SUF:ifconfig_route_pre.txt \
+		$LOGDIR/$SUF:ifconfig_route.txt >/dev/null
+	then
+	    fail "no differences between ifconfig/route before OpenVPN start and =
now."
+	else
+	    output " OK!\n"
+	fi
     fi

     # post init script needed?

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/768?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iec1953415afb53755488dd44407568e72d28e854
Gerrit-Change-Number: 768
Gerrit-PatchSet: 3
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--Bp5AOhhU7yM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/768?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">t_client.sh: conditionally skip ifconfig+route=
 check<br><br>For --dev null or --dev-type af_unix:lwipopenvn tests, there =
will be<br>no visible change to ifconfig or route output, so tests will fai=
l<br>(&quot;how can this be?&quot;).  Set EXPECT_IFCONFIG4_&lt;n&gt;=3D- to=
 skip this<br>check.<br><br>(Simply leaving both EXPECT_IFCONFIG* vars empt=
y and using that as<br>trigger would interfere with the magic from commit d=
f0b00c25)<br><br>v2: fix string-equal comparison<br><br>Change-Id: Iec19534=
15afb53755488dd44407568e72d28e854<br>Signed-off-by: Gert Doering &lt;gert@...220...=
..1296...&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Me=
ssage-Id: &lt;20240928200508.23747-1-gert@...1296...&gt;<br>URL: https://ww=
w.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29473.html<br>Sig=
ned-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M tests/t_client=
.sh.in<br>1 file changed, 11 insertions(+), 6 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/tests/t_client.sh.in b/tests/t_client.sh.in</span><br><span=
>index f6654dd..1ccadeb 100755</span><br><span>--- a/tests/t_client.sh.in</=
span><br><span>+++ b/tests/t_client.sh.in</span><br><span>@@ -225,6 +225,7 =
@@</span><br><span>     expect_list=3D&quot;$@&quot;</span><br><span> </spa=
n><br><span>     if [ -z &quot;$expect_list&quot; ] ; then return ; fi</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if [ &quot;$expect_l=
ist&quot; =3D &quot;-&quot; ] ; then return ; fi</span><br><span> </span><b=
r><span>     for expect in $expect_list</span><br><span>     do</span><br><=
span>@@ -404,13 +405,17 @@</span><br><span>     output &quot;save ifconfig+=
route&quot;</span><br><span>     get_ifconfig_route &gt;$LOGDIR/$SUF:ifconf=
ig_route.txt</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    output -n &quot;compare pre-openvpn ifconfig+route with curren=
t values...&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
if diff $LOGDIR/$SUF:ifconfig_route_pre.txt \</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-	    $LOGDIR/$SUF:ifconfig_route.txt &gt;/dev/null<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    then</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-	fail &quot;no differences between =
ifconfig/route before OpenVPN start and now.&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if [ &quot;$expect_ifconfig4&quot; =3D &=
quot;-&quot; ] ; then</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        output &quot;skip ifconfig+route check&quot;</span><br><span>    =
 else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	output &quot; O=
K!\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	output -=
n &quot;compare pre-openvpn ifconfig+route with current values...&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+	if diff $LOGDIR/$SUF:i=
fconfig_route_pre.txt \</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+		$LOGDIR/$SUF:ifconfig_route.txt &gt;/dev/null</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	then</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+	    fail &quot;no differences between ifconfig/route b=
efore OpenVPN start and now.&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+	else</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+	    output &quot; OK!\n&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+	fi</span><br><span>     fi</span><br><span> </span><br><span> =
    # post init script needed?</span><br><span></span><br></pre><p>To view,=
 visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/768?usp=3Demail">ch=
ange 768</a>. To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope i=
temtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"actio=
n" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/768?usp=3Demail"/><meta itemprop=3D"=
name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iec1953415afb53755488dd44407=
568e72d28e854 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 768 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@...1296...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--Bp5AOhhU7yM=--

