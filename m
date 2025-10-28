From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 28 Oct 2025 09:23:52 +0000
In-Reply-To: <gerrit.1761596820000.I85320b8f1cfc02dfd561916e5637d9481edac59e@...2715...>
References: <gerrit.1761596820000.I85320b8f1cfc02dfd561916e5637d9481edac59e@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., selva.nair@...277...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <10943344e419d02f5d5ed86bb5d570e25c652f9e-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="xwbsC9jPSS4="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]:
 pkcs11_management_id_get: Free certificate object after use
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: selvanair <selva.nair@...277...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--xwbsC9jPSS4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 selvanair. ( http://gerrit.openvpn.net/c/openvpn/+/1317?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos


Change subject: pkcs11_management_id_get: Free certificate object after use
......................................................................

pkcs11_management_id_get: Free certificate object after use

Found by ZeroPath

Change-Id: I85320b8f1cfc02dfd561916e5637d9481edac59e
Signed-off-by: Selva Nair <selva.nair@...277...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1317
Message-Id: <20251027212747.4161-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33=
908.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/pkcs11.c
1 file changed, 3 insertions(+), 3 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/17/1317/2

diff --git a/src/openvpn/pkcs11.c b/src/openvpn/pkcs11.c
index ce64135..9afb181 100644
--- a/src/openvpn/pkcs11.c
+++ b/src/openvpn/pkcs11.c
@@ -436,9 +436,6 @@
 {
     pkcs11h_certificate_id_list_t id_list =3D NULL;
     pkcs11h_certificate_id_list_t entry =3D NULL;
-#if 0 /* certificate_id seems to be unused -- JY */
-    pkcs11h_certificate_id_t certificate_id =3D NULL;
-#endif
     pkcs11h_certificate_t certificate =3D NULL;
     CK_RV rv =3D CKR_OK;
     unsigned char *certificate_blob =3D NULL;
@@ -548,6 +545,9 @@
     pkcs11h_certificate_freeCertificateIdList(id_list);
     id_list =3D NULL;

+    pkcs11h_certificate_freeCertificate(certificate);
+    certificate =3D NULL;
+
     free(internal_id);
     internal_id =3D NULL;
=20

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1317?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I85320b8f1cfc02dfd561916e5637d9481edac59e
Gerrit-Change-Number: 1317
Gerrit-PatchSet: 2
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--xwbsC9jPSS4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by selvanair.<=
/p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1317?usp=3Demail">Vi=
ew Change</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by plaisthos</p><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">pkcs11_management_id_get: Free =
certificate object after use<br><br>Found by ZeroPath<br><br>Change-Id: I85=
320b8f1cfc02dfd561916e5637d9481edac59e<br>Signed-off-by: Selva Nair &lt;sel=
va.nair@...277...&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@...1227...=
&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1317<br>Message-=
Id: &lt;20251027212747.4161-1-gert@...1296...&gt;<br>URL: https://www.mail-=
archive.com/openvpn-devel@lists.sourceforge.net/msg33908.html<br>Signed-off=
-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/pkcs11.c<=
br>1 file changed, 3 insertions(+), 3 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/17/1317/2<=
/pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
"><span>diff --git a/src/openvpn/pkcs11.c b/src/openvpn/pkcs11.c</span><br>=
<span>index ce64135..9afb181 100644</span><br><span>--- a/src/openvpn/pkcs1=
1.c</span><br><span>+++ b/src/openvpn/pkcs11.c</span><br><span>@@ -436,9 +4=
36,6 @@</span><br><span> {</span><br><span>     pkcs11h_certificate_id_list=
_t id_list =3D NULL;</span><br><span>     pkcs11h_certificate_id_list_t ent=
ry =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if 0 /* =
certificate_id seems to be unused -- JY */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    pkcs11h_certificate_id_t certificate_id =3D NULL;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span=
>     pkcs11h_certificate_t certificate =3D NULL;</span><br><span>     CK_R=
V rv =3D CKR_OK;</span><br><span>     unsigned char *certificate_blob =3D N=
ULL;</span><br><span>@@ -548,6 +545,9 @@</span><br><span>     pkcs11h_certi=
ficate_freeCertificateIdList(id_list);</span><br><span>     id_list =3D NUL=
L;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    pkcs11h_certificate_freeCertificate(certificate);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    certificate =3D NULL;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     free(interna=
l_id);</span><br><span>     internal_id =3D NULL;</span><br><span> </span><=
br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/1317?usp=3Demail">change 1317</a>. To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/sett=
ings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema=
.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sc=
hema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/1317?usp=3Demail"/><meta itemprop=3D"name" content=3D"View C=
hange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I85320b8f1cfc02dfd561916e563=
7d9481edac59e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1317 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: selvanair &lt;selva.nair@...1354...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--xwbsC9jPSS4=--

