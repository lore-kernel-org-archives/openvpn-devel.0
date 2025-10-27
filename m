From: "selvanair (Code Review)" <gerrit@...515...>
Date: Mon, 27 Oct 2025 20:27:05 +0000
References: <gerrit.1761596820000.I85320b8f1cfc02dfd561916e5637d9481edac59e@...2715...>
Reply-To: selva.nair@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <4fe197a379436411793cc1124b11ec473af5a893-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="YYyYhPyB5qM="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--YYyYhPyB5qM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1317?usp=3Demail

to review the following change.


Change subject: pkcs11_management_id_get: Free certificate object after use
......................................................................

pkcs11_management_id_get: Free certificate object after use

Found by ZeroPath

Change-Id: I85320b8f1cfc02dfd561916e5637d9481edac59e
Signed-off-by: Selva Nair <selva.nair@...277...>
---
M src/openvpn/pkcs11.c
1 file changed, 3 insertions(+), 3 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/17/1317/1

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


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1317?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I85320b8f1cfc02dfd561916e5637d9481edac59e
Gerrit-Change-Number: 1317
Gerrit-PatchSet: 1
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--YYyYhPyB5qM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>selvanair would like plaisthos and flichtenheld to <strong>review</stron=
g> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1317?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">pkcs11_management_id_get: Free certificate =
object after use<br><br>Found by ZeroPath<br><br>Change-Id: I85320b8f1cfc02=
dfd561916e5637d9481edac59e<br>Signed-off-by: Selva Nair &lt;selva.nair@...1665...=
77...&gt;<br>---<br>M src/openvpn/pkcs11.c<br>1 file changed, 3 insertions(=
+), 3 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn=
.net:29418/openvpn refs/changes/17/1317/1</pre><pre style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/=
pkcs11.c b/src/openvpn/pkcs11.c</span><br><span>index ce64135..9afb181 1006=
44</span><br><span>--- a/src/openvpn/pkcs11.c</span><br><span>+++ b/src/ope=
nvpn/pkcs11.c</span><br><span>@@ -436,9 +436,6 @@</span><br><span> {</span>=
<br><span>     pkcs11h_certificate_id_list_t id_list =3D NULL;</span><br><s=
pan>     pkcs11h_certificate_id_list_t entry =3D NULL;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#if 0 /* certificate_id seems to be unused=
 -- JY */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    pkcs11h_=
certificate_id_t certificate_id =3D NULL;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#endif</span><br><span>     pkcs11h_certificate_t certi=
ficate =3D NULL;</span><br><span>     CK_RV rv =3D CKR_OK;</span><br><span>=
     unsigned char *certificate_blob =3D NULL;</span><br><span>@@ -548,6 +5=
45,9 @@</span><br><span>     pkcs11h_certificate_freeCertificateIdList(id_l=
ist);</span><br><span>     id_list =3D NULL;</span><br><span> </span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    pkcs11h_certificate_freeCert=
ificate(certificate);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    certificate =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span>     free(internal_id);</span><br><span>     inter=
nal_id =3D NULL;</span><br><span> </span><br><span></span><br></pre><p>To v=
iew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1317?usp=3Demai=
l">change 1317</a>. To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</=
p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempr=
op=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1317?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I85320b8f1cfc02dfd561916e563=
7d9481edac59e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1317 </div>
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

--YYyYhPyB5qM=--

