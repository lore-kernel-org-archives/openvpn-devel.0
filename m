From: "selvanair (Code Review)" <gerrit@...515...>
Date: Mon, 3 Nov 2025 14:39:48 +0000
References: <gerrit.1762180786000.I356faeebfade1eed9b40d6700b13621c357ec5ac@...2715...>
Reply-To: selva.nair@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <af97b544558e1c5fd9e17703ca1eef1ac8f7d105-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="pSHJbNHzhBA="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: openvpnserv:
 Disallow stdin as config unless user is authorized
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

--pSHJbNHzhBA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1343?usp=3Demail

to review the following change.


Change subject: openvpnserv: Disallow stdin as config unless user is author=
ized
......................................................................

openvpnserv: Disallow stdin as config unless user is authorized

Reported by: <stephan@...2953...>

Change-Id: I356faeebfade1eed9b40d6700b13621c357ec5ac
Signed-off-by: Selva Nair <selva.nair@...277...>
---
M src/openvpnserv/validate.c
1 file changed, 5 insertions(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/43/1343/1

diff --git a/src/openvpnserv/validate.c b/src/openvpnserv/validate.c
index 2187fb5..ddaa381 100644
--- a/src/openvpnserv/validate.c
+++ b/src/openvpnserv/validate.c
@@ -68,6 +68,11 @@
     const WCHAR *config_file =3D NULL;
     WCHAR config_dir[MAX_PATH];

+    /* fname =3D stdin is special: do not treat it as a relative path */
+    if (wcscmp(fname, L"stdin") =3D=3D 0)
+    {
+        return FALSE;
+    }
     /* convert fname to full path */
     if (PathIsRelativeW(fname))
     {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1343?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I356faeebfade1eed9b40d6700b13621c357ec5ac
Gerrit-Change-Number: 1343
Gerrit-PatchSet: 1
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--pSHJbNHzhBA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>selvanair would like plaisthos and flichtenheld to <strong>review</stron=
g> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1343?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">openvpnserv: Disallow stdin as config unles=
s user is authorized<br><br>Reported by: &lt;stephan@...2953...&gt;<br><br>=
Change-Id: I356faeebfade1eed9b40d6700b13621c357ec5ac<br>Signed-off-by: Selv=
a Nair &lt;selva.nair@...277...&gt;<br>---<br>M src/openvpnserv/validate.c<=
br>1 file changed, 5 insertions(+), 0 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/43/1343/1<=
/pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
"><span>diff --git a/src/openvpnserv/validate.c b/src/openvpnserv/validate.=
c</span><br><span>index 2187fb5..ddaa381 100644</span><br><span>--- a/src/o=
penvpnserv/validate.c</span><br><span>+++ b/src/openvpnserv/validate.c</spa=
n><br><span>@@ -68,6 +68,11 @@</span><br><span>     const WCHAR *config_fil=
e =3D NULL;</span><br><span>     WCHAR config_dir[MAX_PATH];</span><br><spa=
n> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* fname =3D=
 stdin is special: do not treat it as a relative path */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (wcscmp(fname, L&quot;stdin&quo=
t;) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return FALSE=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan>     /* convert fname to full path */</span><br><span>     if (PathIsRe=
lativeW(fname))</span><br><span>     {</span><br><span></span><br></pre><p>=
To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1343?usp=3D=
email">change 1343</a>. To unsubscribe, or for help writing mail filters, v=
isit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a=
>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link it=
emprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1343?usp=3Dema=
il"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I356faeebfade1eed9b40d6700b1=
3621c357ec5ac </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1343 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: selvanair &lt;selva.nair@...1354...=
..&gt; </div>
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

</body></html>=

--pSHJbNHzhBA=--

