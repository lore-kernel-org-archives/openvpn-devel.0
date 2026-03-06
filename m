From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 6 Mar 2026 16:25:02 +0000
In-Reply-To: <gerrit.1772309250000.I5e17e184f666317df21460108da4f70670358ece@...2715...>
References: <gerrit.1772309250000.I5e17e184f666317df21460108da4f70670358ece@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., selva.nair@...277...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <b479104433562bc4d1d53105cfd1cc59f46dfcbd-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="rFbJKh5dY0M="; charset=UTF-8
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
To: selvanair <selva.nair@...277...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--rFbJKh5dY0M=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 selvanair. ( http://gerrit.openvpn.net/c/openvpn/+/1553?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/53/1553/2

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


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1553?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5e17e184f666317df21460108da4f70670358ece
Gerrit-Change-Number: 1553
Gerrit-PatchSet: 2
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--rFbJKh5dY0M=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by selvanair.<=
/p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1553?usp=3Demail">Vi=
ew Change</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by plaisthos</p><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">Use USER_PASS_LEN for private k=
ey password buffer size<br><br>GitHub: fixes OpenVPN/openvpn#993<br><br>Cha=
nge-Id: I5e17e184f666317df21460108da4f70670358ece<br>Signed-off-by: Selva N=
air &lt;selva.nair@...277...&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn=
@...1227...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1553<=
br>Message-Id: &lt;20260305065952.24348-1-gert@...1296...&gt;<br>URL: https=
://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35914.html<b=
r>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openv=
pn/ssl_openssl.c<br>1 file changed, 1 insertion(+), 1 deletion(-)<br><br></=
pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/chan=
ges/53/1553/2</pre><pre style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;"><span>diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/=
ssl_openssl.c</span><br><span>index 840d9a0..48cbaa8 100644</span><br><span=
>--- a/src/openvpn/ssl_openssl.c</span><br><span>+++ b/src/openvpn/ssl_open=
ssl.c</span><br><span>@@ -796,7 +796,7 @@</span><br><span>         }</span>=
<br><span>         else /* use our generic &#39;Private Key&#39; passphrase=
 callback */</span><br><span>         {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            char password[64];</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            char password[USER_PASS_LEN];</spa=
n><br><span>             pem_password_cb *cb =3D SSL_CTX_get_default_passwd=
_cb(ctx);</span><br><span>             void *d =3D SSL_CTX_get_default_pass=
wd_cb_userdata(ctx);</span><br><span> </span><br><span></span><br></pre><p>=
To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1553?usp=3D=
email">change 1553</a>. To unsubscribe, or for help writing mail filters, v=
isit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a=
>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link it=
emprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1553?usp=3Dema=
il"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
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

--rFbJKh5dY0M=--

