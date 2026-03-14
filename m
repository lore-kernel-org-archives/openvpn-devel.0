From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 14 Mar 2026 16:56:03 +0000
In-Reply-To: <gerrit.1773352679000.I29a33ac23f3c1a7cf16196aecc46ec3597a22175@...2715...>
References: <gerrit.1773352679000.I29a33ac23f3c1a7cf16196aecc46ec3597a22175@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <5caf2cf8756fc08169c6a3c967a56b65ebd98753-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="EyCMuLogwLo="; charset=UTF-8
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
To: d12fk <heiko@...515...>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--EyCMuLogwLo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/15=
74?usp=3Demail )

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

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I29a33ac23f3c1a7cf16196aecc46ec3597a22175
Gerrit-Change-Number: 1574
Gerrit-PatchSet: 2
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--EyCMuLogwLo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1574?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">doc: improve Windows-specific options section<br=
><br>Change-Id: I29a33ac23f3c1a7cf16196aecc46ec3597a22175<br>Signed-off-by:=
 Heiko Hund &lt;heiko@...2662...&gt;<br>Acked-by: Frank Lichtenheld &lt;fra=
nk@...2641...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/157=
4<br>Message-Id: &lt;20260313103707.14534-1-frank@...2641...&gt;<br>URL: ht=
tps://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36084.htm=
l<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M doc/ma=
n-sections/windows-options.rst<br>1 file changed, 6 insertions(+), 6 deleti=
ons(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/doc/man-sections/windows-options.rst b/doc/man-sections/win=
dows-options.rst</span><br><span>index af2fb45..8d7dcbb 100644</span><br><s=
pan>--- a/doc/man-sections/windows-options.rst</span><br><span>+++ b/doc/ma=
n-sections/windows-options.rst</span><br><span>@@ -1,6 +1,12 @@</span><br><=
span> Windows-Specific Options</span><br><span> -------------------------</=
span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+The=
se options are considered unknown on non-Windows platforms, resulting</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+in fatal error (except ``=
--route-method``). You may want to use</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+``--setenv opt`` or ``--ignore-unknown-option`` to ignor=
e said error.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Note t=
hat pushing unknown options from server does not trigger fatal</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+errors.</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span> --allow-nonadmin TAP-adapt=
er</span><br><span>   (Standalone) Set ``TAP-adapter`` to allow access from=
 non-administrative</span><br><span>   accounts. If ``TAP-adapter`` is omit=
ted, all TAP adapters on the system</span><br><span>@@ -16,12 +22,6 @@</spa=
n><br><span>   one inside the tunnel. It uses Windows Filtering Platform (W=
FP) and</span><br><span>   works on Windows Vista or later.</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  This option is co=
nsidered unknown on non-Windows platforms and</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-  unsupported on Windows XP, resulting in fatal err=
or. You may want to use</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-  ``--setenv opt`` or ``--ignore-unknown-option`` (not suitable for</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-  Windows XP) to ignore sai=
d error. Note that pushing unknown options from</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-  server does not trigger fatal errors.</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> --cryptoapice=
rt select-string</span><br><span>   *(Windows/OpenSSL Only)* Load the certi=
ficate and private key from the</span><br><span>   Windows Certificate Syst=
em Store.</span><br><span></span><br></pre><p>To view, visit <a href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/1574?usp=3Demail">change 1574</a>. To un=
subscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1574?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
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

--EyCMuLogwLo=--

