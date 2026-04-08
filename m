From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 8 Apr 2026 12:34:28 +0000
In-Reply-To: <gerrit.1775592384000.I7f983168c263e49da7665fc20bd1ecdd426c21d0@...2715...>
References: <gerrit.1775592384000.I7f983168c263e49da7665fc20bd1ecdd426c21d0@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <5b608d7a9ba5daaab1fad39f63fdd9282a92a48e-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZtFVAloBeWE="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ZtFVAloBeWE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1623?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/23/1623/2

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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7f983168c263e49da7665fc20bd1ecdd426c21d0
Gerrit-Change-Number: 1623
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ZtFVAloBeWE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1623?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">openvpnserv: Remove redundant bit-w=
ise operation<br><br>Found by cppcheck.<br><br>Change-Id: I7f983168c263e49d=
a7665fc20bd1ecdd426c21d0<br>Signed-off-by: Frank Lichtenheld &lt;frank@...1665...=
641...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL:=
 https://gerrit.openvpn.net/c/openvpn/+/1623<br>Message-Id: &lt;20260407205=
344.31263-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvp=
n-devel@lists.sourceforge.net/msg36547.html<br>Signed-off-by: Gert Doering =
&lt;gert@...1296...&gt;<br>---<br>M src/openvpnserv/interactive.c<br>1 file=
 changed, 1 insertion(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull=
 ssh://gerrit.openvpn.net:29418/openvpn refs/changes/23/1623/2</pre><pre st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff=
 --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c</spa=
n><br><span>index c96d3f2..4268214 100644</span><br><span>--- a/src/openvpn=
serv/interactive.c</span><br><span>+++ b/src/openvpnserv/interactive.c</spa=
n><br><span>@@ -3410,7 +3410,7 @@</span><br><span>     ea[0].Trustee.Truste=
eForm =3D TRUSTEE_IS_SID;</span><br><span>     ea[0].Trustee.TrusteeType =
=3D TRUSTEE_IS_UNKNOWN;</span><br><span>     ea[0].Trustee.ptstrName =3D (L=
PWSTR)svc_user-&gt;User.Sid;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    ea[1].grfAccessPermissions =3D READ_CONTROL | SYNCHRONIZE | PROC=
ESS_VM_READ | SYNCHRONIZE</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    ea[1].grfAccessPermissions =3D READ_CONTROL | PROCESS_VM_READ | S=
YNCHRONIZE</span><br><span>                                  | PROCESS_TERM=
INATE | PROCESS_QUERY_INFORMATION;</span><br><span>     ea[1].grfAccessMode=
 =3D SET_ACCESS;</span><br><span>     ea[1].grfInheritance =3D NO_INHERITAN=
CE;</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1623?usp=3Demail">change 1623</a>. To unsubscr=
ibe, or for help writing mail filters, visit <a href=3D"http://gerrit.openv=
pn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"ht=
tp://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1623?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
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

--ZtFVAloBeWE=--

