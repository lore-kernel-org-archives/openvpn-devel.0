From: "ordex (Code Review)" <gerrit@...515...>
Date: Mon, 16 Feb 2026 23:24:53 +0000
References: <gerrit.1771284291000.I0ca7b5b7ec1a01acaad222c99db137c94c88555a@...2715...>
Reply-To: antonio@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <974aa7f78ea6fb0ff4e0452d6555ba0849844bbd-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="oPuy+nXzax8="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: options: make `tun`
 the default for `--dev`
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

--oPuy+nXzax8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1537?usp=3Demail

to review the following change.


Change subject: options: make `tun` the default for `--dev`
......................................................................

options: make `tun` the default for `--dev`

With this change, OpenVPN can be launched without specifying
any --dev option and it will start a `tun` (L3) tunnel with the
interface named `tunX`.
As before, this behaviour can be changed using --dev or --dev-type.

Existing configs won't see any behavioural change as they all
had to contain at least one --dev directive.

Change-Id: I0ca7b5b7ec1a01acaad222c99db137c94c88555a
Signed-off-by: Antonio Quartulli <antonio@...2726...>
---
M Changes.rst
M src/openvpn/options.c
2 files changed, 10 insertions(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/37/1537/1

diff --git a/Changes.rst b/Changes.rst
index 36af4e7..1d6c166 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -1,6 +1,14 @@
 Overview of changes in 2.8
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
-
+User-visible Changes
+--------------------
+- Default for ``--dev`` is now ``tun``. This implies that, unless another
+  name is specified, the OpenVPN interface will always be named ``tunX``.
+  More importantly, this means that by default OpenVPN will start a L3
+  tunnel.
+  Since ``--dev`` had no default value until now, all existing
+  configurations will behave exactly the same because they all had to
+  contain one ``--dev`` directive.

 Overview of changes in 2.7
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 4e1e32a..9081d1d 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -799,6 +799,7 @@
     gc_init(&o->dns_options.gc);

     o->mode =3D MODE_POINT_TO_POINT;
+    o->dev =3D "tun";
     o->topology =3D TOP_UNDEF;
     o->ce.proto =3D PROTO_UDP;
     o->ce.af =3D AF_UNSPEC;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1537?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0ca7b5b7ec1a01acaad222c99db137c94c88555a
Gerrit-Change-Number: 1537
Gerrit-PatchSet: 1
Gerrit-Owner: ordex <antonio@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--oPuy+nXzax8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>ordex would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1537?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">options: make `tun` the default for `--dev`=
<br><br>With this change, OpenVPN can be launched without specifying<br>any=
 --dev option and it will start a `tun` (L3) tunnel with the<br>interface n=
amed `tunX`.<br>As before, this behaviour can be changed using --dev or --d=
ev-type.<br><br>Existing configs won&#39;t see any behavioural change as th=
ey all<br>had to contain at least one --dev directive.<br><br>Change-Id: I0=
ca7b5b7ec1a01acaad222c99db137c94c88555a<br>Signed-off-by: Antonio Quartulli=
 &lt;antonio@...2726...&gt;<br>---<br>M Changes.rst<br>M src/openvpn/option=
s.c<br>2 files changed, 10 insertions(+), 1 deletion(-)<br><br></pre><pre c=
lass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/37/153=
7/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/Changes.rst b/Changes.rst</span><br><span>index 36=
af4e7..1d6c166 100644</span><br><span>--- a/Changes.rst</span><br><span>+++=
 b/Changes.rst</span><br><span>@@ -1,6 +1,14 @@</span><br><span> Overview o=
f changes in 2.8</span><br><span> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(120, 100%, 40%);">+U=
ser-visible Changes</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
--------------------</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+- Default for ``--dev`` is now ``tun``. This implies that, unless another<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+  name is specified,=
 the OpenVPN interface will always be named ``tunX``.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  More importantly, this means that by de=
fault OpenVPN will start a L3</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  tunnel.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
  Since ``--dev`` had no default value until now, all existing</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  configurations will behave exa=
ctly the same because they all had to</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+  contain one ``--dev`` directive.</span><br><span> </spa=
n><br><span> Overview of changes in 2.7</span><br><span> =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</span><br><spa=
n>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</span><br><spa=
n>index 4e1e32a..9081d1d 100644</span><br><span>--- a/src/openvpn/options.c=
</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -799,6 +799=
,7 @@</span><br><span>     gc_init(&amp;o-&gt;dns_options.gc);</span><br><s=
pan> </span><br><span>     o-&gt;mode =3D MODE_POINT_TO_POINT;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    o-&gt;dev =3D &quot;tun&quot=
;;</span><br><span>     o-&gt;topology =3D TOP_UNDEF;</span><br><span>     =
o-&gt;ce.proto =3D PROTO_UDP;</span><br><span>     o-&gt;ce.af =3D AF_UNSPE=
C;</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1537?usp=3Demail">change 1537</a>. To unsubscri=
be, or for help writing mail filters, visit <a href=3D"http://gerrit.openvp=
n.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/1537?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0ca7b5b7ec1a01acaad222c99db=
137c94c88555a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1537 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@...2726...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--oPuy+nXzax8=--

