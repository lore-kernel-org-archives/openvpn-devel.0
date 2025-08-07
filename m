From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Thu, 7 Aug 2025 15:07:51 +0000
References: <gerrit.1754579268000.Ice8c7ff4d8118a9e6465a4724207a355138360b8@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <e4f7a61fe76d5dfa62661f12fe6ddc25213ff1d3-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="xOE4UhdgvnQ="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: t_client.sh: Do not
 wait 3 seconds for OpenVPN to come up
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

--xOE4UhdgvnQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1139?usp=3Demail

to review the following change.


Change subject: t_client.sh: Do not wait 3 seconds for OpenVPN to come up
......................................................................

t_client.sh: Do not wait 3 seconds for OpenVPN to come up

On most machines 1 second should be quite enough. Given
that we run currently 23 tests on most t_client runs, this
makes over 40 seconds difference. Not nothing.

Change-Id: Ice8c7ff4d8118a9e6465a4724207a355138360b8
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M tests/t_client.sh.in
1 file changed, 1 insertion(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/39/1139/1

diff --git a/tests/t_client.sh.in b/tests/t_client.sh.in
index 7a271b6..1309ba1 100755
--- a/tests/t_client.sh.in
+++ b/tests/t_client.sh.in
@@ -383,7 +383,7 @@
     ovpn_init_success=3D0
     while [ $ovpn_init_check -gt 0 ];
     do
-       sleep 3  # Wait for OpenVPN to initialize and have had time to writ=
e the pid file
+       sleep 1  # Wait for OpenVPN to initialize and have had time to writ=
e the pid file
        grep "Initialization Sequence Completed" $LOGDIR/$SUF:openvpn.log >=
/dev/null
        if [ $? -eq 0 ]; then
            ovpn_init_check=3D0

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1139?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ice8c7ff4d8118a9e6465a4724207a355138360b8
Gerrit-Change-Number: 1139
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--xOE4UhdgvnQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1139?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">t_client.sh: Do not wait 3 seconds for OpenVPN to come up<br=
><br>On most machines 1 second should be quite enough. Given<br>that we run=
 currently 23 tests on most t_client runs, this<br>makes over 40 seconds di=
fference. Not nothing.<br><br>Change-Id: Ice8c7ff4d8118a9e6465a4724207a3551=
38360b8<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---=
<br>M tests/t_client.sh.in<br>1 file changed, 1 insertion(+), 1 deletion(-)=
<br><br></pre><pre style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/39/=
1139/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;"><span>diff --git a/tests/t_client.sh.in b/tests/t_client.sh.in</sp=
an><br><span>index 7a271b6..1309ba1 100755</span><br><span>--- a/tests/t_cl=
ient.sh.in</span><br><span>+++ b/tests/t_client.sh.in</span><br><span>@@ -3=
83,7 +383,7 @@</span><br><span>     ovpn_init_success=3D0</span><br><span> =
    while [ $ovpn_init_check -gt 0 ];</span><br><span>     do</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-       sleep 3  # Wait for OpenVPN =
to initialize and have had time to write the pid file</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+       sleep 1  # Wait for OpenVPN to ini=
tialize and have had time to write the pid file</span><br><span>        gre=
p &quot;Initialization Sequence Completed&quot; $LOGDIR/$SUF:openvpn.log &g=
t;/dev/null</span><br><span>        if [ $? -eq 0 ]; then</span><br><span> =
           ovpn_init_check=3D0</span><br><span></span><br></pre><p>To view,=
 visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1139?usp=3Demail">c=
hange 1139</a>. To unsubscribe, or for help writing mail filters, visit <a =
href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope=
 itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1139?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ice8c7ff4d8118a9e6465a472420=
7a355138360b8 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1139 </div>
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


--xOE4UhdgvnQ=--

