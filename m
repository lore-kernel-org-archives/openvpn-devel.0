From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 12 Dec 2023 13:19:44 +0000
References: <gerrit.1702387180000.Ib226079d1543209e08e5fdcf7344cd20850bea9d@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <3c15288b82145c3db21397b2c3e355d32b093fd7-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="iJA/UdS5+WA="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: configure: enable
 silent rules by default
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

--iJA/UdS5+WA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/480?usp=3Demail

to review the following change.


Change subject: configure: enable silent rules by default
......................................................................

configure: enable silent rules by default

The default build log is big and basically
unreadable.

Go the way of other build systems and do not
print compile commands by default. Verbose
output can always be enabled with make V=3D1.

Change-Id: Ib226079d1543209e08e5fdcf7344cd20850bea9d
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M configure.ac
1 file changed, 1 insertion(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/80/480/1

diff --git a/configure.ac b/configure.ac
index 2823f04..9bc4d64 100644
--- a/configure.ac
+++ b/configure.ac
@@ -56,6 +56,7 @@
 # This foreign option prevents autoreconf from overriding our COPYING and
 # INSTALL targets:
 AM_INIT_AUTOMAKE(foreign subdir_objects 1.9) dnl NB: Do not [quote] this p=
arameter.
+AM_SILENT_RULES([yes])
 AC_CANONICAL_HOST
 AC_USE_SYSTEM_EXTENSIONS


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/480?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib226079d1543209e08e5fdcf7344cd20850bea9d
Gerrit-Change-Number: 480
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--iJA/UdS5+WA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/480?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">configure: enable silent rules by default<br><br>The default =
build log is big and basically<br>unreadable.<br><br>Go the way of other bu=
ild systems and do not<br>print compile commands by default. Verbose<br>out=
put can always be enabled with make V=3D1.<br><br>Change-Id: Ib226079d15432=
09e08e5fdcf7344cd20850bea9d<br>Signed-off-by: Frank Lichtenheld &lt;frank@...220...=
..2641...&gt;<br>---<br>M configure.ac<br>1 file changed, 1 insertion(+), 0=
 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn ref=
s/changes/80/480/1</pre><pre style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;"><span>diff --git a/configure.ac b/configure.ac</span><=
br><span>index 2823f04..9bc4d64 100644</span><br><span>--- a/configure.ac</=
span><br><span>+++ b/configure.ac</span><br><span>@@ -56,6 +56,7 @@</span><=
br><span> # This foreign option prevents autoreconf from overriding our COP=
YING and</span><br><span> # INSTALL targets:</span><br><span> AM_INIT_AUTOM=
AKE(foreign subdir_objects 1.9) dnl NB: Do not [quote] this parameter.</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+AM_SILENT_RULES([yes])</=
span><br><span> AC_CANONICAL_HOST</span><br><span> AC_USE_SYSTEM_EXTENSIONS=
</span><br><span> </span><br><span></span><br></pre><p>To view, visit <a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/480?usp=3Demail">change 480</a>=
. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:/=
/gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"h=
ttp://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/480?usp=3Demail"/><meta itemprop=3D"name" conte=
nt=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib226079d1543209e08e5fdcf734=
4cd20850bea9d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 480 </div>
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


--iJA/UdS5+WA=--

