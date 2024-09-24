From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 24 Sep 2024 14:01:23 +0000
References: <gerrit.1727186481000.Iec1953415afb53755488dd44407568e72d28e854@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <895ac5ec02bd118c17a83f048bd9d02bf81846c7-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="VTbpSUmvKr4="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--VTbpSUmvKr4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/768?usp=3Demail

to review the following change.


Change subject: t_client.sh: conditionally skip ifconfig+route check
......................................................................

t_client.sh: conditionally skip ifconfig+route check

For --dev null or --dev-type af_unix:lwipopenvn tests, there will be
no visible change to ifconfig or route output, so tests will fail
("how can this be?").  Set EXPECT_IFCONFIG4_<n>=3D- to skip this
check.

(Simply leaving both EXPECT_IFCONFIG* vars empty and using that as
trigger would interfere with the magic from commit df0b00c25)

Change-Id: Iec1953415afb53755488dd44407568e72d28e854
Signed-off-by: Gert Doering <gert@...1296...>
---
M tests/t_client.sh.in
1 file changed, 11 insertions(+), 6 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/68/768/1

diff --git a/tests/t_client.sh.in b/tests/t_client.sh.in
index f6654dd..3b9209d 100755
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
+    if [ "$expect_ifconfig4" =3D=3D "-" ] ; then
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
Gerrit-PatchSet: 1
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--VTbpSUmvKr4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>cron2 would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/768?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">t_client.sh: conditionally skip ifconfig+route check<br><br>F=
or --dev null or --dev-type af_unix:lwipopenvn tests, there will be<br>no v=
isible change to ifconfig or route output, so tests will fail<br>(&quot;how=
 can this be?&quot;).  Set EXPECT_IFCONFIG4_&lt;n&gt;=3D- to skip this<br>c=
heck.<br><br>(Simply leaving both EXPECT_IFCONFIG* vars empty and using tha=
t as<br>trigger would interfere with the magic from commit df0b00c25)<br><b=
r>Change-Id: Iec1953415afb53755488dd44407568e72d28e854<br>Signed-off-by: Ge=
rt Doering &lt;gert@...1296...&gt;<br>---<br>M tests/t_client.sh.in<br>1 fi=
le changed, 11 insertions(+), 6 deletions(-)<br><br></pre><pre style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerri=
t.openvpn.net:29418/openvpn refs/changes/68/768/1</pre><pre style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/test=
s/t_client.sh.in b/tests/t_client.sh.in</span><br><span>index f6654dd..3b92=
09d 100755</span><br><span>--- a/tests/t_client.sh.in</span><br><span>+++ b=
/tests/t_client.sh.in</span><br><span>@@ -225,6 +225,7 @@</span><br><span> =
    expect_list=3D&quot;$@&quot;</span><br><span> </span><br><span>     if =
[ -z &quot;$expect_list&quot; ] ; then return ; fi</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if [ &quot;$expect_list&quot; =3D &quot;=
-&quot; ] ; then return ; fi</span><br><span> </span><br><span>     for exp=
ect in $expect_list</span><br><span>     do</span><br><span>@@ -404,13 +405=
,17 @@</span><br><span>     output &quot;save ifconfig+route&quot;</span><b=
r><span>     get_ifconfig_route &gt;$LOGDIR/$SUF:ifconfig_route.txt</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    output =
-n &quot;compare pre-openvpn ifconfig+route with current values...&quot;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    if diff $LOGDIR/$SUF=
:ifconfig_route_pre.txt \</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-	    $LOGDIR/$SUF:ifconfig_route.txt &gt;/dev/null</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    then</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-	fail &quot;no differences between ifconfig/route befor=
e OpenVPN start and now.&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if [ &quot;$expect_ifconfig4&quot; =3D=3D &quot;-&quot; ] ; =
then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        output =
&quot;skip ifconfig+route check&quot;</span><br><span>     else</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-	output &quot; OK!\n&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+	output -n &quot;compare p=
re-openvpn ifconfig+route with current values...&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+	if diff $LOGDIR/$SUF:ifconfig_route_pre=
.txt \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+		$LOGDIR/$SU=
F:ifconfig_route.txt &gt;/dev/null</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+	then</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+	    fail &quot;no differences between ifconfig/route before OpenVPN start=
 and now.&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	els=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	    output &quot;=
 OK!\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	fi</sp=
an><br><span>     fi</span><br><span> </span><br><span>     # post init scr=
ipt needed?</span><br><span></span><br></pre><p>To view, visit <a href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/768?usp=3Demail">change 768</a>. To un=
subscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://s=
chema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/768?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iec1953415afb53755488dd44407=
568e72d28e854 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 768 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@...1296...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--VTbpSUmvKr4=--

