From: "MaxF (Code Review)" <gerrit@...515...>
Date: Wed, 13 Mar 2024 19:10:42 +0000
References: <gerrit.1710357040000.I1879c893ed19b165fd086728fb97951eac251681@...2715...>
Reply-To: max@...2606..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <754e5379eca734c410c95a6cefb4acc2496e0eec-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="t36cuoAVA44="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[release/2.6]: Remove license
 warning from README.mbedtls
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

--t36cuoAVA44=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/562?usp=3Demail

to review the following change.


Change subject: Remove license warning from README.mbedtls
......................................................................

Remove license warning from README.mbedtls

The licenses are compatible now, so we can remove the warning.

Change-Id: I1879c893ed19b165fd086728fb97951eac251681
Signed-off-by: Max Fillinger <maximilian.fillinger@...2507...>
---
M README.mbedtls
1 file changed, 0 insertions(+), 16 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/62/562/1

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
To view, visit http://gerrit.openvpn.net/c/openvpn/+/562?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: I1879c893ed19b165fd086728fb97951eac251681
Gerrit-Change-Number: 562
Gerrit-PatchSet: 1
Gerrit-Owner: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--t36cuoAVA44=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>MaxF would like plaisthos and flichtenheld to <strong>review</strong> th=
is change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/562?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Remove license warning from README.mbedtls<br><br>The license=
s are compatible now, so we can remove the warning.<br><br>Change-Id: I1879=
c893ed19b165fd086728fb97951eac251681<br>Signed-off-by: Max Fillinger &lt;ma=
ximilian.fillinger@...2507...&gt;<br>---<br>M README.mbedtls<br>1 file chan=
ged, 0 insertions(+), 16 deletions(-)<br><br></pre><pre style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openv=
pn.net:29418/openvpn refs/changes/62/562/1</pre><pre style=3D"font-family: =
monospace,monospace; white-space: pre-wrap;"><span>diff --git a/README.mbed=
tls b/README.mbedtls</span><br><span>index 124eaa2..c4f3924 100644</span><b=
r><span>--- a/README.mbedtls</span><br><span>+++ b/README.mbedtls</span><br=
><span>@@ -11,22 +11,6 @@</span><br><span> </span><br><span> **************=
***********************************************************</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-Warning:</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-As of mbed TLS 2.17, it can be licensed *only* under =
the Apache v2.0 license.</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-That license is incompatible with OpenVPN&#39;s GPLv2.</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-We are currently in the process of resolving this problem, b=
ut for now, if you</span><br><span style=3D"color: hsl(0, 100%, 40%);">-wis=
h to distribute OpenVPN linked with mbed TLS, there are two options:</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- * Ensure that your case falls under the system l=
ibrary exception in GPLv2, or</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Use an ear=
lier version of mbed TLS. Version 2.16.12 is the last release</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-   that may be licensed under GPLv2=
. Unfortunately, this version is</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-   unsupported and won&#39;t receive any more updates.</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-****************************************************=
*********************</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span> Due to limitations in the mbed TLS library, the following=
 features are missing</span><br><span> in the mbed TLS version of OpenVPN:<=
/span><br><span> </span><br><span></span><br></pre><p>To view, visit <a hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/562?usp=3Demail">change 562</a>.=
 To unsubscribe, or for help writing mail filters, visit <a href=3D"http://=
gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"ht=
tp://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/562?usp=3Demail"/><meta itemprop=3D"name" conte=
nt=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1879c893ed19b165fd086728fb9=
7951eac251681 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 562 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@...2606...&gt; </di=
v>
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


--t36cuoAVA44=--

