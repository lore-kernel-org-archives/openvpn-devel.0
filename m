From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 7 Apr 2026 20:06:35 +0000
References: <gerrit.1775592384000.I7f983168c263e49da7665fc20bd1ecdd426c21d0@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <ae8ed2cf0f24ae56ab52a0a908a556c86330bdd0-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="EzLp3jky1gs="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--EzLp3jky1gs=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1623?usp=3Demail

to review the following change.


Change subject: openvpnserv: Remove redundant bit-wise operation
......................................................................

openvpnserv: Remove redundant bit-wise operation

Found by cppcheck.

Change-Id: I7f983168c263e49da7665fc20bd1ecdd426c21d0
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpnserv/interactive.c
1 file changed, 1 insertion(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/23/1623/1

diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index a2f9f09..ace25b9 100644
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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7f983168c263e49da7665fc20bd1ecdd426c21d0
Gerrit-Change-Number: 1623
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--EzLp3jky1gs=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1623?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">openvpnserv: Remove redundant bit-wise oper=
ation<br><br>Found by cppcheck.<br><br>Change-Id: I7f983168c263e49da7665fc2=
0bd1ecdd426c21d0<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&g=
t;<br>---<br>M src/openvpnserv/interactive.c<br>1 file changed, 1 insertion=
(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn=
.net:29418/openvpn refs/changes/23/1623/1</pre><pre style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpns=
erv/interactive.c b/src/openvpnserv/interactive.c</span><br><span>index a2f=
9f09..ace25b9 100644</span><br><span>--- a/src/openvpnserv/interactive.c</s=
pan><br><span>+++ b/src/openvpnserv/interactive.c</span><br><span>@@ -3410,=
7 +3410,7 @@</span><br><span>     ea[0].Trustee.TrusteeForm =3D TRUSTEE_IS_=
SID;</span><br><span>     ea[0].Trustee.TrusteeType =3D TRUSTEE_IS_UNKNOWN;=
</span><br><span>     ea[0].Trustee.ptstrName =3D (LPWSTR)svc_user-&gt;User=
.Sid;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ea[1].grfAcc=
essPermissions =3D READ_CONTROL | SYNCHRONIZE | PROCESS_VM_READ | SYNCHRONI=
ZE</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ea[1].grfAcce=
ssPermissions =3D READ_CONTROL | PROCESS_VM_READ | SYNCHRONIZE</span><br><s=
pan>                                  | PROCESS_TERMINATE | PROCESS_QUERY_I=
NFORMATION;</span><br><span>     ea[1].grfAccessMode =3D SET_ACCESS;</span>=
<br><span>     ea[1].grfInheritance =3D NO_INHERITANCE;</span><br><span></s=
pan><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/1623?usp=3Demail">change 1623</a>. To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3De=
mail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vie=
wAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1623?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></di=
v></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7f983168c263e49da7665fc20bd=
1ecdd426c21d0 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1623 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--EzLp3jky1gs=--

