From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 15 Mar 2024 08:18:08 +0000
In-Reply-To: <gerrit.1710356871000.I1879c893ed19b165fd086728fb97951eac251681@...2715...>
References: <gerrit.1710356871000.I1879c893ed19b165fd086728fb97951eac251681@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 max@...2606...
Message-ID: <10e945738f93e5f4478edaa47448d66840a1c46d-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Bt58Q05NAOk="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Remove license
 warning from README.mbedtls
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: MaxF <max@...2606...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Bt58Q05NAOk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 MaxF. ( http://gerrit.openvpn.net/c/openvpn/+/561?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: Remove license warning from README.mbedtls
......................................................................

Remove license warning from README.mbedtls

The licenses are compatible now, so we can remove the warning.

Change-Id: I1879c893ed19b165fd086728fb97951eac251681
Signed-off-by: Max Fillinger <maximilian.fillinger@...2507...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20240314185527.26803-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28=
400.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M README.mbedtls
1 file changed, 0 insertions(+), 16 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/61/561/2

diff --git a/README.mbedtls b/README.mbedtls
index 124eaa2..c4f3924 100644
--- a/README.mbedtls
+++ b/README.mbedtls
@@ -11,22 +11,6 @@

 *************************************************************************

-Warning:
-
-As of mbed TLS 2.17, it can be licensed *only* under the Apache v2.0 licen=
se.
-That license is incompatible with OpenVPN's GPLv2.
-
-We are currently in the process of resolving this problem, but for now, if=
 you
-wish to distribute OpenVPN linked with mbed TLS, there are two options:
-
- * Ensure that your case falls under the system library exception in GPLv2=
, or
-
- * Use an earlier version of mbed TLS. Version 2.16.12 is the last release
-   that may be licensed under GPLv2. Unfortunately, this version is
-   unsupported and won't receive any more updates.
-
-*************************************************************************
-
 Due to limitations in the mbed TLS library, the following features are mis=
sing
 in the mbed TLS version of OpenVPN:


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/561?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1879c893ed19b165fd086728fb97951eac251681
Gerrit-Change-Number: 561
Gerrit-PatchSet: 2
Gerrit-Owner: MaxF <max@...2606...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--Bt58Q05NAOk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by MaxF.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/561?u=
sp=3Demail">View Change</a></p><p>The following approvals got outdated and =
were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">Remove license warning from README.mbedtls<br><br>Th=
e licenses are compatible now, so we can remove the warning.<br><br>Change-=
Id: I1879c893ed19b165fd086728fb97951eac251681<br>Signed-off-by: Max Filling=
er &lt;maximilian.fillinger@...2507...&gt;<br>Acked-by: Gert Doering &lt;ge=
rt@...1296...&gt;<br>Message-Id: &lt;20240314185527.26803-1-gert@...1296...=
&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1223...=
et/msg28400.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>=
---<br>M README.mbedtls<br>1 file changed, 0 insertions(+), 16 deletions(-)=
<br><br></pre><pre style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/61/=
561/2</pre><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;"><span>diff --git a/README.mbedtls b/README.mbedtls</span><br><span>=
index 124eaa2..c4f3924 100644</span><br><span>--- a/README.mbedtls</span><b=
r><span>+++ b/README.mbedtls</span><br><span>@@ -11,22 +11,6 @@</span><br><=
span> </span><br><span> ***************************************************=
**********************</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-Warning:</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-As of mbed TLS =
2.17, it can be licensed *only* under the Apache v2.0 license.</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-That license is incompatible with =
OpenVPN&#39;s GPLv2.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-We are currently in th=
e process of resolving this problem, but for now, if you</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-wish to distribute OpenVPN linked with m=
bed TLS, there are two options:</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Ensure t=
hat your case falls under the system library exception in GPLv2, or</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- * Use an earlier version of mbed TLS. Version 2.1=
6.12 is the last release</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-   that may be licensed under GPLv2. Unfortunately, this version is</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-   unsupported and won&#39=
;t receive any more updates.</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-**************=
***********************************************************</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> Due to limitations =
in the mbed TLS library, the following features are missing</span><br><span=
> in the mbed TLS version of OpenVPN:</span><br><span> </span><br><span></s=
pan><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/561?usp=3Demail">change 561</a>. To unsubscribe, or for help writing =
mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings=
</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link=
 itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/561?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1879c893ed19b165fd086728fb9=
7951eac251681 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 561 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@...2606...&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--Bt58Q05NAOk=--

