From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 13 Oct 2025 15:48:45 +0000
In-Reply-To: <gerrit.1760364129000.I77a59b9b74a13793782fbfbff6bd2ec581f86be0@...2715...>
References: <gerrit.1760364129000.I77a59b9b74a13793782fbfbff6bd2ec581f86be0@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <b59f51eb8d6ceb26421710d478c50083b702e6f6-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="PIXLL7aXG2s="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: CONTRIBUTING: Update
 outdated/obsolete information
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

--PIXLL7aXG2s=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1271?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos


Change subject: CONTRIBUTING: Update outdated/obsolete information
......................................................................

CONTRIBUTING: Update outdated/obsolete information

- uncrustify -> clang-format
- add Gerrit
- update Wiki links

Change-Id: I77a59b9b74a13793782fbfbff6bd2ec581f86be0
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M CONTRIBUTING.rst
1 file changed, 13 insertions(+), 8 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/71/1271/2

diff --git a/CONTRIBUTING.rst b/CONTRIBUTING.rst
index 67baa4e..bd76f7a 100644
--- a/CONTRIBUTING.rst
+++ b/CONTRIBUTING.rst
@@ -4,27 +4,32 @@
 Patches should be written against the Git "master" branch. Some patches ma=
y get
 backported to a release branch.

-The preferred procedure to send patches to the "openvpn-devel" mailing lis=
t:
+The preferred procedure is to send patches to the "openvpn-devel" mailing =
list:

 - https://lists.sourceforge.net/lists/listinfo/openvpn-devel

+Instead of directly sending patches to the list you can also create an acc=
ount
+in our instance of the Gerrit review tool: https://gerrit.openvpn.net/
+See https://community.openvpn.net/Development/GerritBestPractices.
+
 While we do not merge GitHub pull requests as-is, we do allow their use fo=
r code
 review purposes. After the patch has been ACKed (reviewed and accepted), i=
t must
 be sent to the mailing list. This last step does not necessarily need to b=
e done
 by the patch author, although that is definitely recommended.

 When sending patches to "openvpn-devel" the subject line should be prefixe=
d with
-[PATCH]. To avoid merging issues the patches should be generated with
+``[PATCH]``. To avoid merging issues the patches should be generated with
 git-format-patch or sent using git-send-email. Try to split large patches =
into
 small, atomic pieces to make reviews easier.
=20
 Please make sure that the source code formatting follows the guidelines at
-https://community.openvpn.net/openvpn/wiki/CodeStyle. Automated checking c=
an be
-done with uncrustify (https://uncrustify.sourceforge.net/) and the configu=
ration
-file which can be found in the git repository at dev-tools/uncrustify.conf.
-There is also a git pre-commit hook script, which runs uncrustify automati=
cally
+https://community.openvpn.net/Development/CodeStyle. Automated checking ca=
n be
+done with clang-format (https://community.openvpn.net/Development/CodeStyl=
e)
+and the configuration file which can be found in the git repository at ``.=
clang-format``.
+
+There is also a git pre-commit hook script, which runs clang-format automa=
tically
 each time you commit and lets you format your code conveniently, if needed.
-To install the hook simply run: dev-tools/git-pre-commit-uncrustify.sh ins=
tall
+To install the hook simply run: ``dev-tools/git-pre-commit-format.sh insta=
ll``

 If you want quick feedback on a patch before sending it to openvpn-devel m=
ailing
 list, you can visit the #openvpn-devel channel on irc.libera.chat. Note th=
at
@@ -34,7 +39,7 @@

 More detailed contribution instructions are available here:

-- https://community.openvpn.net/openvpn/wiki/DeveloperDocumentation
+- https://community.openvpn.net/Development/DeveloperDocumentation

 Note that the process for contributing to other OpenVPN projects such as
 openvpn-build, openvpn-gui, tap-windows6 and easy-rsa may differ from what=
 was

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1271?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I77a59b9b74a13793782fbfbff6bd2ec581f86be0
Gerrit-Change-Number: 1271
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--PIXLL7aXG2s=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #2</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1271?usp=3Demail">View C=
hange</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by plaisthos</p><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">CONTRIBUTING: Update outdated/o=
bsolete information<br><br>- uncrustify -&gt; clang-format<br>- add Gerrit<=
br>- update Wiki links<br><br>Change-Id: I77a59b9b74a13793782fbfbff6bd2ec58=
1f86be0<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---=
<br>M CONTRIBUTING.rst<br>1 file changed, 13 insertions(+), 8 deletions(-)<=
br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn =
refs/changes/71/1271/2</pre><pre style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;"><span>diff --git a/CONTRIBUTING.rst b/CONTRIBUTING=
.rst</span><br><span>index 67baa4e..bd76f7a 100644</span><br><span>--- a/CO=
NTRIBUTING.rst</span><br><span>+++ b/CONTRIBUTING.rst</span><br><span>@@ -4=
,27 +4,32 @@</span><br><span> Patches should be written against the Git &qu=
ot;master&quot; branch. Some patches may get</span><br><span> backported to=
 a release branch.</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-The preferred procedure to send patches to the &quot;openvpn=
-devel&quot; mailing list:</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+The preferred procedure is to send patches to the &quot;openvpn-deve=
l&quot; mailing list:</span><br><span> </span><br><span> - https://lists.so=
urceforge.net/lists/listinfo/openvpn-devel</span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+Instead of directly sending patche=
s to the list you can also create an account</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+in our instance of the Gerrit review tool: https:/=
/gerrit.openvpn.net/</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+See https://community.openvpn.net/Development/GerritBestPractices.</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> While we =
do not merge GitHub pull requests as-is, we do allow their use for code</sp=
an><br><span> review purposes. After the patch has been ACKed (reviewed and=
 accepted), it must</span><br><span> be sent to the mailing list. This last=
 step does not necessarily need to be done</span><br><span> by the patch au=
thor, although that is definitely recommended.</span><br><span> </span><br>=
<span> When sending patches to &quot;openvpn-devel&quot; the subject line s=
hould be prefixed with</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-[PATCH]. To avoid merging issues the patches should be generated with</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+``[PATCH]``. To avoid me=
rging issues the patches should be generated with</span><br><span> git-form=
at-patch or sent using git-send-email. Try to split large patches into</spa=
n><br><span> small, atomic pieces to make reviews easier.</span><br><span> =
</span><br><span> Please make sure that the source code formatting follows =
the guidelines at</span><br><span style=3D"color: hsl(0, 100%, 40%);">-http=
s://community.openvpn.net/openvpn/wiki/CodeStyle. Automated checking can be=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-done with uncrustify =
(https://uncrustify.sourceforge.net/) and the configuration</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-file which can be found in the git re=
pository at dev-tools/uncrustify.conf.</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-There is also a git pre-commit hook script, which runs unc=
rustify automatically</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+https://community.openvpn.net/Development/CodeStyle. Automated checking c=
an be</span><br><span style=3D"color: hsl(120, 100%, 40%);">+done with clan=
g-format (https://community.openvpn.net/Development/CodeStyle)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+and the configuration file which=
 can be found in the git repository at ``.clang-format``.</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+There is also a git pre-commit hook script, which runs c=
lang-format automatically</span><br><span> each time you commit and lets yo=
u format your code conveniently, if needed.</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-To install the hook simply run: dev-tools/git-pre-com=
mit-uncrustify.sh install</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+To install the hook simply run: ``dev-tools/git-pre-commit-format.sh =
install``</span><br><span> </span><br><span> If you want quick feedback on =
a patch before sending it to openvpn-devel mailing</span><br><span> list, y=
ou can visit the #openvpn-devel channel on irc.libera.chat. Note that</span=
><br><span>@@ -34,7 +39,7 @@</span><br><span> </span><br><span> More detail=
ed contribution instructions are available here:</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-- https://community.openvpn.ne=
t/openvpn/wiki/DeveloperDocumentation</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+- https://community.openvpn.net/Development/DeveloperDocu=
mentation</span><br><span> </span><br><span> Note that the process for cont=
ributing to other OpenVPN projects such as</span><br><span> openvpn-build, =
openvpn-gui, tap-windows6 and easy-rsa may differ from what was</span><br><=
span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/1271?usp=3Demail">change 1271</a>. To unsubscribe, or for hel=
p writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings=
?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/1271?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I77a59b9b74a13793782fbfbff6b=
d2ec581f86be0 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1271 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--PIXLL7aXG2s=--

