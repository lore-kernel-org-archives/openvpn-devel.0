From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 8 Apr 2026 12:34:30 +0000
In-Reply-To: <gerrit.1775592384000.I7f983168c263e49da7665fc20bd1ecdd426c21d0@...2715...>
References: <gerrit.1775592384000.I7f983168c263e49da7665fc20bd1ecdd426c21d0@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <5b608d7a9ba5daaab1fad39f63fdd9282a92a48e-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LY3RvDTwro4="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: openvpnserv: Remove
 redundant bit-wise operation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--LY3RvDTwro4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/16=
23?usp=3Demail )

Change subject: openvpnserv: Remove redundant bit-wise operation
......................................................................

openvpnserv: Remove redundant bit-wise operation

Found by cppcheck.

Change-Id: I7f983168c263e49da7665fc20bd1ecdd426c21d0
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1623
Message-Id: <20260407205344.31263-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36=
547.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpnserv/interactive.c
1 file changed, 1 insertion(+), 1 deletion(-)




diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index c96d3f2..4268214 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -3410,7 +3410,7 @@
     ea[0].Trustee.TrusteeForm =3D TRUSTEE_IS_SID;
     ea[0].Trustee.TrusteeType =3D TRUSTEE_IS_UNKNOWN;
     ea[0].Trustee.ptstrName =3D (LPWSTR)svc_user->User.Sid;
-    ea[1].grfAccessPermissions =3D READ_CONTROL | SYNCHRONIZE | PROCESS_VM=
_READ | SYNCHRONIZE
+    ea[1].grfAccessPermissions =3D READ_CONTROL | PROCESS_VM_READ | SYNCHR=
ONIZE
                                  | PROCESS_TERMINATE | PROCESS_QUERY_INFOR=
MATION;
     ea[1].grfAccessMode =3D SET_ACCESS;
     ea[1].grfInheritance =3D NO_INHERITANCE;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1623?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7f983168c263e49da7665fc20bd1ecdd426c21d0
Gerrit-Change-Number: 1623
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--LY3RvDTwro4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1623?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">openvpnserv: Remove redundant bit-wise operation=
<br><br>Found by cppcheck.<br><br>Change-Id: I7f983168c263e49da7665fc20bd1e=
cdd426c21d0<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br=
>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerr=
it.openvpn.net/c/openvpn/+/1623<br>Message-Id: &lt;20260407205344.31263-1-g=
ert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1697...=
.sourceforge.net/msg36547.html<br>Signed-off-by: Gert Doering &lt;gert@...1386...=
296...&gt;<br>---<br>M src/openvpnserv/interactive.c<br>1 file changed, 1 i=
nsertion(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive=
.c</span><br><span>index c96d3f2..4268214 100644</span><br><span>--- a/src/=
openvpnserv/interactive.c</span><br><span>+++ b/src/openvpnserv/interactive=
.c</span><br><span>@@ -3410,7 +3410,7 @@</span><br><span>     ea[0].Trustee=
.TrusteeForm =3D TRUSTEE_IS_SID;</span><br><span>     ea[0].Trustee.Trustee=
Type =3D TRUSTEE_IS_UNKNOWN;</span><br><span>     ea[0].Trustee.ptstrName =
=3D (LPWSTR)svc_user-&gt;User.Sid;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    ea[1].grfAccessPermissions =3D READ_CONTROL | SYNCHRONIZE =
| PROCESS_VM_READ | SYNCHRONIZE</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    ea[1].grfAccessPermissions =3D READ_CONTROL | PROCESS_VM_RE=
AD | SYNCHRONIZE</span><br><span>                                  | PROCES=
S_TERMINATE | PROCESS_QUERY_INFORMATION;</span><br><span>     ea[1].grfAcce=
ssMode =3D SET_ACCESS;</span><br><span>     ea[1].grfInheritance =3D NO_INH=
ERITANCE;</span><br><span></span><br></pre><p>To view, visit <a href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/1623?usp=3Demail">change 1623</a>. To un=
subscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1623?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7f983168c263e49da7665fc20bd=
1ecdd426c21d0 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1623 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--LY3RvDTwro4=--

