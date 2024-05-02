From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Thu, 2 May 2024 15:49:43 +0000
References: <gerrit.1714664981000.Id95e0124d943912439c6ec6f562c0eb40d434163@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <1648efbba68331f7662b0becca1c580427d99add-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="x4kCOjMO9mc="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Only run coverity
 scan in OpenVPN/OpenVPN repository
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--x4kCOjMO9mc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/583?usp=3Demail

to review the following change.


Change subject: Only run coverity scan in OpenVPN/OpenVPN repository
......................................................................

Only run coverity scan in OpenVPN/OpenVPN repository

This avoids the error message triggering every night that the run
failed in forked repositories

Change-Id: Id95e0124d943912439c6ec6f562c0eb40d434163
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M .github/workflows/coverity-scan.yml
1 file changed, 3 insertions(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/83/583/1

diff --git a/.github/workflows/coverity-scan.yml b/.github/workflows/coveri=
ty-scan.yml
index e289746..37b8102 100644
--- a/.github/workflows/coverity-scan.yml
+++ b/.github/workflows/coverity-scan.yml
@@ -6,6 +6,9 @@

 jobs:
   latest:
+    # Running coverity requires the secrets.COVERITY_SCAN_TOKEN token
+    # which is only available on the main repository
+    if: github.repository_owner =3D=3D 'OpenVPN'
     runs-on: ubuntu-latest
     steps:
       - name: Check submission cache

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/583?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id95e0124d943912439c6ec6f562c0eb40d434163
Gerrit-Change-Number: 583
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--x4kCOjMO9mc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/583?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Only run coverity scan in OpenVPN/OpenVPN repository<br><br>T=
his avoids the error message triggering every night that the run<br>failed =
in forked repositories<br><br>Change-Id: Id95e0124d943912439c6ec6f562c0eb40=
d434163<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>---<br>M =
.github/workflows/coverity-scan.yml<br>1 file changed, 3 insertions(+), 0 d=
eletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/=
changes/83/583/1</pre><pre style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;"><span>diff --git a/.github/workflows/coverity-scan.yml b=
/.github/workflows/coverity-scan.yml</span><br><span>index e289746..37b8102=
 100644</span><br><span>--- a/.github/workflows/coverity-scan.yml</span><br=
><span>+++ b/.github/workflows/coverity-scan.yml</span><br><span>@@ -6,6 +6=
,9 @@</span><br><span> </span><br><span> jobs:</span><br><span>   latest:</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    # Running coverit=
y requires the secrets.COVERITY_SCAN_TOKEN token</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    # which is only available on the main repo=
sitory</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if: githu=
b.repository_owner =3D=3D &#39;OpenVPN&#39;</span><br><span>     runs-on: u=
buntu-latest</span><br><span>     steps:</span><br><span>       - name: Che=
ck submission cache</span><br><span></span><br></pre><p>To view, visit <a h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/583?usp=3Demail">change 583</a=
>. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:=
//gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"=
http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/583?usp=3Demail"/><meta itemprop=3D"name" conte=
nt=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id95e0124d943912439c6ec6f562=
c0eb40d434163 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 583 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--x4kCOjMO9mc=--

