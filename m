From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 6 Mar 2026 16:25:05 +0000
In-Reply-To: <gerrit.1772309250000.I5e17e184f666317df21460108da4f70670358ece@...2715...>
References: <gerrit.1772309250000.I5e17e184f666317df21460108da4f70670358ece@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., selva.nair@...277...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <b479104433562bc4d1d53105cfd1cc59f46dfcbd-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="k23gUOeXBuA="; charset=UTF-8
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
To: selvanair <selva.nair@...277...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--k23gUOeXBuA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/15=
53?usp=3Demail )

Change subject: Use USER_PASS_LEN for private key password buffer size
......................................................................

Use USER_PASS_LEN for private key password buffer size

GitHub: fixes OpenVPN/openvpn#993

Change-Id: I5e17e184f666317df21460108da4f70670358ece
Signed-off-by: Selva Nair <selva.nair@...277...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1553
Message-Id: <20260305065952.24348-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
914.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/ssl_openssl.c
1 file changed, 1 insertion(+), 1 deletion(-)




diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 840d9a0..48cbaa8 100644
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


--=20
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1553?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5e17e184f666317df21460108da4f70670358ece
Gerrit-Change-Number: 1553
Gerrit-PatchSet: 2
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--k23gUOeXBuA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1553?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">Use USER_PASS_LEN for private key password buffe=
r size<br><br>GitHub: fixes OpenVPN/openvpn#993<br><br>Change-Id: I5e17e184=
f666317df21460108da4f70670358ece<br>Signed-off-by: Selva Nair &lt;selva.nai=
r@...277...&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@...1227...&gt;<b=
r>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1553<br>Message-Id: &l=
t;20260305065952.24348-1-gert@...1296...&gt;<br>URL: https://www.mail-archi=
ve.com/openvpn-devel@lists.sourceforge.net/msg35914.html<br>Signed-off-by: =
Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/ssl_openssl.c<=
br>1 file changed, 1 insertion(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c</span=
><br><span>index 840d9a0..48cbaa8 100644</span><br><span>--- a/src/openvpn/=
ssl_openssl.c</span><br><span>+++ b/src/openvpn/ssl_openssl.c</span><br><sp=
an>@@ -796,7 +796,7 @@</span><br><span>         }</span><br><span>         =
else /* use our generic &#39;Private Key&#39; passphrase callback */</span>=
<br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           char password[64];</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            char password[USER_PASS_LEN];</span><br><span>       =
      pem_password_cb *cb =3D SSL_CTX_get_default_passwd_cb(ctx);</span><br=
><span>             void *d =3D SSL_CTX_get_default_passwd_cb_userdata(ctx)=
;</span><br><span> </span><br><span></span><br></pre><p>To view, visit <a h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/1553?usp=3Demail">change 1553<=
/a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
p://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscop=
e itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"ac=
tion" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1553?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5e17e184f666317df21460108da=
4f70670358ece </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1553 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: selvanair &lt;selva.nair@...1354...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--k23gUOeXBuA=--

