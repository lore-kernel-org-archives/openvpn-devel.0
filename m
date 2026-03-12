From: "d12fk (Code Review)" <gerrit@...515...>
Date: Thu, 12 Mar 2026 21:58:02 +0000
References: <gerrit.1773352679000.I29a33ac23f3c1a7cf16196aecc46ec3597a22175@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <6ceb8720720955d2fa88d8f1302d4fd6890db6c0-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7nCjH1vuj0w="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--7nCjH1vuj0w=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1574?usp=3Demail

to review the following change.


Change subject: doc: improve Windows-specific options section
......................................................................

doc: improve Windows-specific options section

Change-Id: I29a33ac23f3c1a7cf16196aecc46ec3597a22175
Signed-off-by: Heiko Hund <heiko@...2662...>
---
M doc/man-sections/windows-options.rst
1 file changed, 6 insertions(+), 6 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/74/1574/1

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
=20
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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I29a33ac23f3c1a7cf16196aecc46ec3597a22175
Gerrit-Change-Number: 1574
Gerrit-PatchSet: 1
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--7nCjH1vuj0w=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>d12fk would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1574?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">doc: improve Windows-specific options secti=
on<br><br>Change-Id: I29a33ac23f3c1a7cf16196aecc46ec3597a22175<br>Signed-of=
f-by: Heiko Hund &lt;heiko@...2662...&gt;<br>---<br>M doc/man-sections/wind=
ows-options.rst<br>1 file changed, 6 insertions(+), 6 deletions(-)<br><br><=
/pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/cha=
nges/74/1574/1</pre><pre style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;"><span>diff --git a/doc/man-sections/windows-options.rst b/=
doc/man-sections/windows-options.rst</span><br><span>index af2fb45..8d7dcbb=
 100644</span><br><span>--- a/doc/man-sections/windows-options.rst</span><b=
r><span>+++ b/doc/man-sections/windows-options.rst</span><br><span>@@ -1,6 =
+1,12 @@</span><br><span> Windows-Specific Options</span><br><span> -------=
------------------</span><br><span> </span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+These options are considered unknown on non-Windows platfo=
rms, resulting</span><br><span style=3D"color: hsl(120, 100%, 40%);">+in fa=
tal error (except ``--route-method``). You may want to use</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+``--setenv opt`` or ``--ignore-unkno=
wn-option`` to ignore said error.</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+Note that pushing unknown options from server does not trigge=
r fatal</span><br><span style=3D"color: hsl(120, 100%, 40%);">+errors.</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> --allo=
w-nonadmin TAP-adapter</span><br><span>   (Standalone) Set ``TAP-adapter`` =
to allow access from non-administrative</span><br><span>   accounts. If ``T=
AP-adapter`` is omitted, all TAP adapters on the system</span><br><span>@@ =
-16,12 +22,6 @@</span><br><span>   one inside the tunnel. It uses Windows F=
iltering Platform (WFP) and</span><br><span>   works on Windows Vista or la=
ter.</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-  This option is considered unknown on non-Windows platforms and</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-  unsupported on Windows XP, re=
sulting in fatal error. You may want to use</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-  ``--setenv opt`` or ``--ignore-unknown-option`` (no=
t suitable for</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  Windo=
ws XP) to ignore said error. Note that pushing unknown options from</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-  server does not trigger fat=
al errors.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span> --cryptoapicert select-string</span><br><span>   *(Windows/OpenSSL O=
nly)* Load the certificate and private key from the</span><br><span>   Wind=
ows Certificate System Store.</span><br><span></span><br></pre><p>To view, =
visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1574?usp=3Demail">ch=
ange 1574</a>. To unsubscribe, or for help writing mail filters, visit <a h=
ref=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><di=
v itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1574?usp=3Demail"/><met=
a itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I29a33ac23f3c1a7cf16196aecc4=
6ec3597a22175 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1574 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--7nCjH1vuj0w=--

