From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 14 Mar 2026 16:56:04 +0000
In-Reply-To: <gerrit.1773352679000.Ie502c982bda67d55ee74e4f2f66c26ea82698e60@...2715...>
References: <gerrit.1773352679000.Ie502c982bda67d55ee74e4f2f66c26ea82698e60@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <82af421f29ebbc4a5ad1b5b30ca28e8196577aee-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4goKZcXxtKQ="; charset=UTF-8
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
To: d12fk <heiko@...515...>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--4goKZcXxtKQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/15=
75?usp=3Demail )

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

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie502c982bda67d55ee74e4f2f66c26ea82698e60
Gerrit-Change-Number: 1575
Gerrit-PatchSet: 2
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--4goKZcXxtKQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1575?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">doc: fix typo with --ingore-unknown-option<br><b=
r>Change-Id: Ie502c982bda67d55ee74e4f2f66c26ea82698e60<br>Signed-off-by: He=
iko Hund &lt;heiko@...2662...&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@=
...2641...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1575<b=
r>Message-Id: &lt;20260313104615.15951-1-frank@...2641...&gt;<br>URL: https=
://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36085.html<b=
r>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M doc/man-s=
ections/generic-options.rst<br>1 file changed, 1 insertion(+), 1 deletion(-=
)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/doc/man-sections/generic-options.rst b/doc/man-sections/gen=
eric-options.rst</span><br><span>index f46dfec..8132b48 100644</span><br><s=
pan>--- a/doc/man-sections/generic-options.rst</span><br><span>+++ b/doc/ma=
n-sections/generic-options.rst</span><br><span>@@ -219,7 +219,7 @@</span><b=
r><span>   Valid syntax:</span><br><span>   ::</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-     ignore-unknown-options opt1=
 opt2 opt3 ... optN</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
     ignore-unknown-option opt1 opt2 opt3 ... optN</span><br><span> </span>=
<br><span>   When one of options ``opt1 ... optN`` is encountered in the co=
nfiguration</span><br><span>   file the configuration file parsing does not=
 fail if this OpenVPN version</span><br><span></span><br></pre><p>To view, =
visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1575?usp=3Demail">ch=
ange 1575</a>. To unsubscribe, or for help writing mail filters, visit <a h=
ref=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><di=
v itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1575?usp=3Demail"/><met=
a itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
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

--4goKZcXxtKQ=--

