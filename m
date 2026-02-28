From: "selvanair (Code Review)" <gerrit@...515...>
Date: Sat, 28 Feb 2026 20:07:35 +0000
References: <gerrit.1772309250000.I5e17e184f666317df21460108da4f70670358ece@...2715...>
Reply-To: selva.nair@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <3550ca66937d261c952b6c1a48b57be1141a20ed-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="P2NgfGPhEkc="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Use USER_PASS_LEN
 for private key password buffer size
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

--P2NgfGPhEkc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1553?usp=3Demail

to review the following change.


Change subject: Use USER_PASS_LEN for private key password buffer size
......................................................................

Use USER_PASS_LEN for private key password buffer size

GitHub: fixes OpenVPN/openvpn#993

Change-Id: I5e17e184f666317df21460108da4f70670358ece
---
M src/openvpn/ssl_openssl.c
1 file changed, 1 insertion(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/53/1553/1

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 09f23964..80aef69 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -796,7 +796,7 @@
         }
         else /* use our generic 'Private Key' passphrase callback */
         {
-            char password[64];
+            char password[USER_PASS_LEN];
             pem_password_cb *cb =3D SSL_CTX_get_default_passwd_cb(ctx);
             void *d =3D SSL_CTX_get_default_passwd_cb_userdata(ctx);


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1553?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5e17e184f666317df21460108da4f70670358ece
Gerrit-Change-Number: 1553
Gerrit-PatchSet: 1
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--P2NgfGPhEkc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>selvanair would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1553?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">Use USER_PASS_LEN for private key password =
buffer size<br><br>GitHub: fixes OpenVPN/openvpn#993<br><br>Change-Id: I5e1=
7e184f666317df21460108da4f70670358ece<br>---<br>M src/openvpn/ssl_openssl.c=
<br>1 file changed, 1 insertion(+), 1 deletion(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/53/1553/1<=
/pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
"><span>diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c<=
/span><br><span>index 09f23964..80aef69 100644</span><br><span>--- a/src/op=
envpn/ssl_openssl.c</span><br><span>+++ b/src/openvpn/ssl_openssl.c</span><=
br><span>@@ -796,7 +796,7 @@</span><br><span>         }</span><br><span>   =
      else /* use our generic &#39;Private Key&#39; passphrase callback */<=
/span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            char password[64];</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            char password[USER_PASS_LEN];</span><br><span> =
            pem_password_cb *cb =3D SSL_CTX_get_default_passwd_cb(ctx);</sp=
an><br><span>             void *d =3D SSL_CTX_get_default_passwd_cb_userdat=
a(ctx);</span><br><span> </span><br><span></span><br></pre><p>To view, visi=
t <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1553?usp=3Demail">change=
 1553</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div i=
temscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"ur=
l" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1553?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5e17e184f666317df21460108da=
4f70670358ece </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1553 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: selvanair &lt;selva.nair@...1354...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--P2NgfGPhEkc=--

