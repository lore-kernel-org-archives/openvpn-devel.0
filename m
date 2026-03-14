From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 14 Mar 2026 16:56:00 +0000
In-Reply-To: <gerrit.1773352679000.Ie502c982bda67d55ee74e4f2f66c26ea82698e60@...2715...>
References: <gerrit.1773352679000.Ie502c982bda67d55ee74e4f2f66c26ea82698e60@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <82af421f29ebbc4a5ad1b5b30ca28e8196577aee-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Edw+x3qgi5A="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: doc: fix typo with
 --ingore-unknown-option
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

--Edw+x3qgi5A=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 d12fk. ( http://gerrit.openvpn.net/c/openvpn/+/1575?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


Change subject: doc: fix typo with --ingore-unknown-option
......................................................................

doc: fix typo with --ingore-unknown-option

Change-Id: Ie502c982bda67d55ee74e4f2f66c26ea82698e60
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1575
Message-Id: <20260313104615.15951-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36=
085.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M doc/man-sections/generic-options.rst
1 file changed, 1 insertion(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/75/1575/2

diff --git a/doc/man-sections/generic-options.rst b/doc/man-sections/generi=
c-options.rst
index f46dfec..8132b48 100644
--- a/doc/man-sections/generic-options.rst
+++ b/doc/man-sections/generic-options.rst
@@ -219,7 +219,7 @@
   Valid syntax:
   ::

-     ignore-unknown-options opt1 opt2 opt3 ... optN
+     ignore-unknown-option opt1 opt2 opt3 ... optN

   When one of options ``opt1 ... optN`` is encountered in the configuration
   file the configuration file parsing does not fail if this OpenVPN version

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1575?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie502c982bda67d55ee74e4f2f66c26ea82698e60
Gerrit-Change-Number: 1575
Gerrit-PatchSet: 2
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Edw+x3qgi5A=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by d12fk.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1575?usp=3Demail">View C=
hange</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld</p><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">doc: fix typo with --ingore-=
unknown-option<br><br>Change-Id: Ie502c982bda67d55ee74e4f2f66c26ea82698e60<=
br>Signed-off-by: Heiko Hund &lt;heiko@...2662...&gt;<br>Acked-by: Frank Li=
chtenheld &lt;frank@...2641...&gt;<br>Gerrit URL: https://gerrit.openvpn.ne=
t/c/openvpn/+/1575<br>Message-Id: &lt;20260313104615.15951-1-frank@...2724...=
..&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...282...=
.net/msg36085.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<b=
r>---<br>M doc/man-sections/generic-options.rst<br>1 file changed, 1 insert=
ion(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.open=
vpn.net:29418/openvpn refs/changes/75/1575/2</pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/doc/man-s=
ections/generic-options.rst b/doc/man-sections/generic-options.rst</span><b=
r><span>index f46dfec..8132b48 100644</span><br><span>--- a/doc/man-section=
s/generic-options.rst</span><br><span>+++ b/doc/man-sections/generic-option=
s.rst</span><br><span>@@ -219,7 +219,7 @@</span><br><span>   Valid syntax:<=
/span><br><span>   ::</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-     ignore-unknown-options opt1 opt2 opt3 ... optN</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+     ignore-unknown-optio=
n opt1 opt2 opt3 ... optN</span><br><span> </span><br><span>   When one of =
options ``opt1 ... optN`` is encountered in the configuration</span><br><sp=
an>   file the configuration file parsing does not fail if this OpenVPN ver=
sion</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://g=
errit.openvpn.net/c/openvpn/+/1575?usp=3Demail">change 1575</a>. To unsubsc=
ribe, or for help writing mail filters, visit <a href=3D"http://gerrit.open=
vpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"h=
ttp://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1575?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie502c982bda67d55ee74e4f2f66=
c26ea82698e60 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1575 </div>
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

--Edw+x3qgi5A=--

