From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 3 Nov 2025 15:22:01 +0000
In-Reply-To: <gerrit.1762180786000.I356faeebfade1eed9b40d6700b13621c357ec5ac@...2715...>
References: <gerrit.1762180786000.I356faeebfade1eed9b40d6700b13621c357ec5ac@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., selva.nair@...277...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <65f619a9f710ddcf3d054fdcea2246f39c2e748e-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Q93B2aSvygw="; charset=UTF-8
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
To: selvanair <selva.nair@...277...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Q93B2aSvygw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/13=
43?usp=3Demail )

Change subject: openvpnserv: Disallow stdin as config unless user is author=
ized
......................................................................

openvpnserv: Disallow stdin as config unless user is authorized

Reported by: <stephan@...2953...>

Change-Id: I356faeebfade1eed9b40d6700b13621c357ec5ac
Signed-off-by: Selva Nair <selva.nair@...277...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1343
Message-Id: <20251103150002.23187-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
156.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpnserv/validate.c
1 file changed, 5 insertions(+), 0 deletions(-)




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

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I356faeebfade1eed9b40d6700b13621c357ec5ac
Gerrit-Change-Number: 1343
Gerrit-PatchSet: 2
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Q93B2aSvygw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1343?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">openvpnserv: Disallow stdin as config unless use=
r is authorized<br><br>Reported by: &lt;stephan@...2953...&gt;<br><br>Chang=
e-Id: I356faeebfade1eed9b40d6700b13621c357ec5ac<br>Signed-off-by: Selva Nai=
r &lt;selva.nair@...277...&gt;<br>Acked-by: Gert Doering &lt;gert@...2132...=
.&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1343<br>Message=
-Id: &lt;20251103150002.23187-1-gert@...1296...&gt;<br>URL: https://www.mai=
l-archive.com/openvpn-devel@lists.sourceforge.net/msg34156.html<br>Signed-o=
ff-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpnserv/val=
idate.c<br>1 file changed, 5 insertions(+), 0 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpnserv/validate.c b/src/openvpnserv/validate.c</sp=
an><br><span>index 2187fb5..ddaa381 100644</span><br><span>--- a/src/openvp=
nserv/validate.c</span><br><span>+++ b/src/openvpnserv/validate.c</span><br=
><span>@@ -68,6 +68,11 @@</span><br><span>     const WCHAR *config_file =3D=
 NULL;</span><br><span>     WCHAR config_dir[MAX_PATH];</span><br><span> </=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* fname =3D stdi=
n is special: do not treat it as a relative path */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (wcscmp(fname, L&quot;stdin&quot;)=
 =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        return FALSE;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
>     /* convert fname to full path */</span><br><span>     if (PathIsRelat=
iveW(fname))</span><br><span>     {</span><br><span></span><br></pre><p>To =
view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1343?usp=3Dema=
il">change 1343</a>. To unsubscribe, or for help writing mail filters, visi=
t <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.<=
/p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemp=
rop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1343?usp=3Demail"=
/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I356faeebfade1eed9b40d6700b1=
3621c357ec5ac </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1343 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: selvanair &lt;selva.nair@...1354...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--Q93B2aSvygw=--

