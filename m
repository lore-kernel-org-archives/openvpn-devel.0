From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 14 Mar 2026 16:56:00 +0000
In-Reply-To: <gerrit.1773352679000.I29a33ac23f3c1a7cf16196aecc46ec3597a22175@...2715...>
References: <gerrit.1773352679000.I29a33ac23f3c1a7cf16196aecc46ec3597a22175@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <5caf2cf8756fc08169c6a3c967a56b65ebd98753-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="qXWgm2Bu8eE="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: doc: improve
 Windows-specific options section
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: d12fk <heiko@...515...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--qXWgm2Bu8eE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 d12fk. ( http://gerrit.openvpn.net/c/openvpn/+/1574?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


Change subject: doc: improve Windows-specific options section
......................................................................

doc: improve Windows-specific options section

Change-Id: I29a33ac23f3c1a7cf16196aecc46ec3597a22175
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1574
Message-Id: <20260313103707.14534-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36=
084.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M doc/man-sections/windows-options.rst
1 file changed, 6 insertions(+), 6 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/74/1574/2

diff --git a/doc/man-sections/windows-options.rst b/doc/man-sections/window=
s-options.rst
index af2fb45..8d7dcbb 100644
--- a/doc/man-sections/windows-options.rst
+++ b/doc/man-sections/windows-options.rst
@@ -1,6 +1,12 @@
 Windows-Specific Options
 -------------------------

+These options are considered unknown on non-Windows platforms, resulting
+in fatal error (except ``--route-method``). You may want to use
+``--setenv opt`` or ``--ignore-unknown-option`` to ignore said error.
+Note that pushing unknown options from server does not trigger fatal
+errors.
+
 --allow-nonadmin TAP-adapter
   (Standalone) Set ``TAP-adapter`` to allow access from non-administrative
   accounts. If ``TAP-adapter`` is omitted, all TAP adapters on the system
@@ -16,12 +22,6 @@
   one inside the tunnel. It uses Windows Filtering Platform (WFP) and
   works on Windows Vista or later.

-  This option is considered unknown on non-Windows platforms and
-  unsupported on Windows XP, resulting in fatal error. You may want to use
-  ``--setenv opt`` or ``--ignore-unknown-option`` (not suitable for
-  Windows XP) to ignore said error. Note that pushing unknown options from
-  server does not trigger fatal errors.
-
 --cryptoapicert select-string
   *(Windows/OpenSSL Only)* Load the certificate and private key from the
   Windows Certificate System Store.

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1574?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I29a33ac23f3c1a7cf16196aecc46ec3597a22175
Gerrit-Change-Number: 1574
Gerrit-PatchSet: 2
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--qXWgm2Bu8eE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by d12fk.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1574?usp=3Demail">View C=
hange</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld</p><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">doc: improve Windows-specifi=
c options section<br><br>Change-Id: I29a33ac23f3c1a7cf16196aecc46ec3597a221=
75<br>Signed-off-by: Heiko Hund &lt;heiko@...2662...&gt;<br>Acked-by: Frank=
 Lichtenheld &lt;frank@...2641...&gt;<br>Gerrit URL: https://gerrit.openvpn=
.net/c/openvpn/+/1574<br>Message-Id: &lt;20260313103707.14534-1-frank@...2375...=
41...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1357...=
rge.net/msg36084.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt=
;<br>---<br>M doc/man-sections/windows-options.rst<br>1 file changed, 6 ins=
ertions(+), 6 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
.openvpn.net:29418/openvpn refs/changes/74/1574/2</pre><pre style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/doc/=
man-sections/windows-options.rst b/doc/man-sections/windows-options.rst</sp=
an><br><span>index af2fb45..8d7dcbb 100644</span><br><span>--- a/doc/man-se=
ctions/windows-options.rst</span><br><span>+++ b/doc/man-sections/windows-o=
ptions.rst</span><br><span>@@ -1,6 +1,12 @@</span><br><span> Windows-Specif=
ic Options</span><br><span> -------------------------</span><br><span> </sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+These options are consi=
dered unknown on non-Windows platforms, resulting</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+in fatal error (except ``--route-method``). Y=
ou may want to use</span><br><span style=3D"color: hsl(120, 100%, 40%);">+`=
`--setenv opt`` or ``--ignore-unknown-option`` to ignore said error.</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+Note that pushing unknown =
options from server does not trigger fatal</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+errors.</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span> --allow-nonadmin TAP-adapter</span><br><span> =
  (Standalone) Set ``TAP-adapter`` to allow access from non-administrative<=
/span><br><span>   accounts. If ``TAP-adapter`` is omitted, all TAP adapter=
s on the system</span><br><span>@@ -16,12 +22,6 @@</span><br><span>   one i=
nside the tunnel. It uses Windows Filtering Platform (WFP) and</span><br><s=
pan>   works on Windows Vista or later.</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-  This option is considered unknown on =
non-Windows platforms and</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-  unsupported on Windows XP, resulting in fatal error. You may want to =
use</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  ``--setenv opt``=
 or ``--ignore-unknown-option`` (not suitable for</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-  Windows XP) to ignore said error. Note that p=
ushing unknown options from</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-  server does not trigger fatal errors.</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span> --cryptoapicert select-string</sp=
an><br><span>   *(Windows/OpenSSL Only)* Load the certificate and private k=
ey from the</span><br><span>   Windows Certificate System Store.</span><br>=
<span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/1574?usp=3Demail">change 1574</a>. To unsubscribe, or for he=
lp writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/setting=
s?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.or=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/1574?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chan=
ge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I29a33ac23f3c1a7cf16196aecc4=
6ec3597a22175 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1574 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--qXWgm2Bu8eE=--

