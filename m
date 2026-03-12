From: "d12fk (Code Review)" <gerrit@...515...>
Date: Thu, 12 Mar 2026 21:58:03 +0000
References: <gerrit.1773352679000.Ie502c982bda67d55ee74e4f2f66c26ea82698e60@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <947122a1eee000aea9ac694f91ed21f96b4dc2f4-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="VumHgEXiDgQ="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--VumHgEXiDgQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1575?usp=3Demail

to review the following change.


Change subject: doc: fix typo with --ingore-unknown-option
......................................................................

doc: fix typo with --ingore-unknown-option

Change-Id: Ie502c982bda67d55ee74e4f2f66c26ea82698e60
Signed-off-by: Heiko Hund <heiko@...2662...>
---
M doc/man-sections/generic-options.rst
1 file changed, 1 insertion(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/75/1575/1

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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie502c982bda67d55ee74e4f2f66c26ea82698e60
Gerrit-Change-Number: 1575
Gerrit-PatchSet: 1
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--VumHgEXiDgQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>d12fk would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1575?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">doc: fix typo with --ingore-unknown-option<=
br><br>Change-Id: Ie502c982bda67d55ee74e4f2f66c26ea82698e60<br>Signed-off-b=
y: Heiko Hund &lt;heiko@...2662...&gt;<br>---<br>M doc/man-sections/generic=
-options.rst<br>1 file changed, 1 insertion(+), 1 deletion(-)<br><br></pre>=
<pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/=
75/1575/1</pre><pre style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;"><span>diff --git a/doc/man-sections/generic-options.rst b/doc/m=
an-sections/generic-options.rst</span><br><span>index f46dfec..8132b48 1006=
44</span><br><span>--- a/doc/man-sections/generic-options.rst</span><br><sp=
an>+++ b/doc/man-sections/generic-options.rst</span><br><span>@@ -219,7 +21=
9,7 @@</span><br><span>   Valid syntax:</span><br><span>   ::</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-     ignore-unkno=
wn-options opt1 opt2 opt3 ... optN</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     ignore-unknown-option opt1 opt2 opt3 ... optN</span><br=
><span> </span><br><span>   When one of options ``opt1 ... optN`` is encoun=
tered in the configuration</span><br><span>   file the configuration file p=
arsing does not fail if this OpenVPN version</span><br><span></span><br></p=
re><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1575?=
usp=3Demail">change 1575</a>. To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">setti=
ngs</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><l=
ink itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1575?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie502c982bda67d55ee74e4f2f66=
c26ea82698e60 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1575 </div>
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

--VumHgEXiDgQ=--

