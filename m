From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 6 May 2026 12:30:28 +0000
References: <gerrit.1778070626000.I7cf7146c3c4f1a01b0bcb57e03d09b32f8b59780@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <101c5494681bb12c07afd7582ee0444cb613e0a6-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+eziZ3vatKU="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: t_client.sh: Do not
 use CA_CERT variable as indicator for good .rc file
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

--+eziZ3vatKU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1664?usp=3Demail

to review the following change.


Change subject: t_client.sh: Do not use CA_CERT variable as indicator for g=
ood .rc file
......................................................................

t_client.sh: Do not use CA_CERT variable as indicator for good .rc file

t_client.sh doesn't actually care about this variable, and our
.rc files do not use it anymore. If you really want to dynamically
skip running t_client.sh just set TEST_RUN_LIST to empty in the .rc
file.

Change-Id: I7cf7146c3c4f1a01b0bcb57e03d09b32f8b59780
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M tests/t_client.sh.in
1 file changed, 0 insertions(+), 5 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/64/1664/1

diff --git a/tests/t_client.sh.in b/tests/t_client.sh.in
index a49de40..48e2446 100755
--- a/tests/t_client.sh.in
+++ b/tests/t_client.sh.in
@@ -62,11 +62,6 @@
     exit 1
 fi

-if [ -z "$CA_CERT" ] ; then
-    echo "CA_CERT not defined in 't_client.rc'. SKIP test." >&2
-    exit "${TCLIENT_SKIP_RC}"
-fi
-
 if [ -z "$TEST_RUN_LIST" ] ; then
     echo "TEST_RUN_LIST empty, no tests defined.  SKIP test." >&2
     exit "${TCLIENT_SKIP_RC}"

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1664?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7cf7146c3c4f1a01b0bcb57e03d09b32f8b59780
Gerrit-Change-Number: 1664
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--+eziZ3vatKU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1664?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">t_client.sh: Do not use CA_CERT variable as=
 indicator for good .rc file<br><br>t_client.sh doesn&#39;t actually care a=
bout this variable, and our<br>.rc files do not use it anymore. If you real=
ly want to dynamically<br>skip running t_client.sh just set TEST_RUN_LIST t=
o empty in the .rc<br>file.<br><br>Change-Id: I7cf7146c3c4f1a01b0bcb57e03d0=
9b32f8b59780<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<b=
r>---<br>M tests/t_client.sh.in<br>1 file changed, 0 insertions(+), 5 delet=
ions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/=
openvpn refs/changes/64/1664/1</pre><pre style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;"><span>diff --git a/tests/t_client.sh.in b/=
tests/t_client.sh.in</span><br><span>index a49de40..48e2446 100755</span><b=
r><span>--- a/tests/t_client.sh.in</span><br><span>+++ b/tests/t_client.sh.=
in</span><br><span>@@ -62,11 +62,6 @@</span><br><span>     exit 1</span><br=
><span> fi</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-if [ -z &quot;$CA_CERT&quot; ] ; then</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    echo &quot;CA_CERT not defined in &#39;t_client.=
rc&#39;. SKIP test.&quot; &gt;&amp;2</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    exit &quot;${TCLIENT_SKIP_RC}&quot;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-fi</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span> if [ -z &quot;$TEST_RUN_LIST&quot; ] ; then=
</span><br><span>     echo &quot;TEST_RUN_LIST empty, no tests defined.  SK=
IP test.&quot; &gt;&amp;2</span><br><span>     exit &quot;${TCLIENT_SKIP_RC=
}&quot;</span><br><span></span><br></pre><p>To view, visit <a href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/1664?usp=3Demail">change 1664</a>. To unsu=
bscribe, or for help writing mail filters, visit <a href=3D"http://gerrit.o=
penvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1664?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7cf7146c3c4f1a01b0bcb57e03d=
09b32f8b59780 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1664 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--+eziZ3vatKU=--

