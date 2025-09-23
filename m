From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 23 Sep 2025 09:27:27 +0000
In-Reply-To: <gerrit.1754490554000.If971006b6d3a1a93d87b29627d91dd72faf5ceb2@...2715...>
References: <gerrit.1754490554000.If971006b6d3a1a93d87b29627d91dd72faf5ceb2@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <72f1e89ef6e1b00f98bd4f0f5c27e4cdfe123d21-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Vv6hN8OB/a4="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: ssl_verify: Change
 backend_x509_* functions to size_t for lengths
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

--Vv6hN8OB/a4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/11=
38?usp=3Demail )

Change subject: ssl_verify: Change backend_x509_* functions to size_t for l=
engths
......................................................................

ssl_verify: Change backend_x509_* functions to size_t for lengths

Fix conversion warnings without actual code changes.

Change-Id: If971006b6d3a1a93d87b29627d91dd72faf5ceb2
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1138
Message-Id: <20250922204329.23460-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33=
152.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/ssl_verify_backend.h
M src/openvpn/ssl_verify_mbedtls.c
M src/openvpn/ssl_verify_openssl.c
3 files changed, 5 insertions(+), 5 deletions(-)




diff --git a/src/openvpn/ssl_verify_backend.h b/src/openvpn/ssl_verify_back=
end.h
index ceaef3f..1d56533 100644
--- a/src/openvpn/ssl_verify_backend.h
+++ b/src/openvpn/ssl_verify_backend.h
@@ -123,7 +123,7 @@
  *
  * @return              \c FAILURE, \c or SUCCESS
  */
-result_t backend_x509_get_username(char *common_name, int cn_len, char *x5=
09_username_field,
+result_t backend_x509_get_username(char *common_name, size_t cn_len, char =
*x509_username_field,
                                    openvpn_x509_cert_t *peer_cert);

 #ifdef ENABLE_X509ALTUSERNAME
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbed=
tls.c
index 61f64af..c92eaf1 100644
--- a/src/openvpn/ssl_verify_mbedtls.c
+++ b/src/openvpn/ssl_verify_mbedtls.c
@@ -128,7 +128,7 @@
 #endif

 result_t
-backend_x509_get_username(char *cn, int cn_len, char *x509_username_field,=
 mbedtls_x509_crt *cert)
+backend_x509_get_username(char *cn, size_t cn_len, char *x509_username_fie=
ld, mbedtls_x509_crt *cert)
 {
     mbedtls_x509_name *name;

diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_open=
ssl.c
index 9cd2418..7a7b21e 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -120,7 +120,7 @@
 }

 static bool
-extract_x509_extension(X509 *cert, char *fieldname, char *out, int size)
+extract_x509_extension(X509 *cert, char *fieldname, char *out, size_t size)
 {
     bool retval =3D false;
     char *buf =3D 0;
@@ -195,7 +195,7 @@
  * to contain result is grounds for error).
  */
 static result_t
-extract_x509_field_ssl(X509_NAME *x509, const char *field_name, char *out,=
 int size)
+extract_x509_field_ssl(X509_NAME *x509, const char *field_name, char *out,=
 size_t size)
 {
     int lastpos =3D -1;
     int tmp =3D -1;
@@ -252,7 +252,7 @@
 }

 result_t
-backend_x509_get_username(char *common_name, int cn_len, char *x509_userna=
me_field, X509 *peer_cert)
+backend_x509_get_username(char *common_name, size_t cn_len, char *x509_use=
rname_field, X509 *peer_cert)
 {
 #ifdef ENABLE_X509ALTUSERNAME
     if (strncmp("ext:", x509_username_field, 4) =3D=3D 0)

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1138?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: If971006b6d3a1a93d87b29627d91dd72faf5ceb2
Gerrit-Change-Number: 1138
Gerrit-PatchSet: 10
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--Vv6hN8OB/a4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1138?usp=3Demail">View Change</a></p><div styl=
e=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">ssl_verify: Change backend_x509_* functions t=
o size_t for lengths<br><br>Fix conversion warnings without actual code cha=
nges.<br><br>Change-Id: If971006b6d3a1a93d87b29627d91dd72faf5ceb2<br>Signed=
-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doeri=
ng &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/open=
vpn/+/1138<br>Message-Id: &lt;20250922204329.23460-1-gert@...1296...&gt;<br=
>URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg3=
3152.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>=
M src/openvpn/ssl_verify_backend.h<br>M src/openvpn/ssl_verify_mbedtls.c<br=
>M src/openvpn/ssl_verify_openssl.c<br>3 files changed, 5 insertions(+), 5 =
deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/ssl_verify_backend.h b/src/openvpn/ssl_verify_b=
ackend.h</span><br><span>index ceaef3f..1d56533 100644</span><br><span>--- =
a/src/openvpn/ssl_verify_backend.h</span><br><span>+++ b/src/openvpn/ssl_ve=
rify_backend.h</span><br><span>@@ -123,7 +123,7 @@</span><br><span>  *</spa=
n><br><span>  * @return              \c FAILURE, \c or SUCCESS</span><br><s=
pan>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-result_t back=
end_x509_get_username(char *common_name, int cn_len, char *x509_username_fi=
eld,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+result_t backen=
d_x509_get_username(char *common_name, size_t cn_len, char *x509_username_f=
ield,</span><br><span>                                    openvpn_x509_cert=
_t *peer_cert);</span><br><span> </span><br><span> #ifdef ENABLE_X509ALTUSE=
RNAME</span><br><span>diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/o=
penvpn/ssl_verify_mbedtls.c</span><br><span>index 61f64af..c92eaf1 100644</=
span><br><span>--- a/src/openvpn/ssl_verify_mbedtls.c</span><br><span>+++ b=
/src/openvpn/ssl_verify_mbedtls.c</span><br><span>@@ -128,7 +128,7 @@</span=
><br><span> #endif</span><br><span> </span><br><span> result_t</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-backend_x509_get_username(char *cn=
, int cn_len, char *x509_username_field, mbedtls_x509_crt *cert)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+backend_x509_get_username(char=
 *cn, size_t cn_len, char *x509_username_field, mbedtls_x509_crt *cert)</sp=
an><br><span> {</span><br><span>     mbedtls_x509_name *name;</span><br><sp=
an> </span><br><span>diff --git a/src/openvpn/ssl_verify_openssl.c b/src/op=
envpn/ssl_verify_openssl.c</span><br><span>index 9cd2418..7a7b21e 100644</s=
pan><br><span>--- a/src/openvpn/ssl_verify_openssl.c</span><br><span>+++ b/=
src/openvpn/ssl_verify_openssl.c</span><br><span>@@ -120,7 +120,7 @@</span>=
<br><span> }</span><br><span> </span><br><span> static bool</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-extract_x509_extension(X509 *cert, ch=
ar *fieldname, char *out, int size)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+extract_x509_extension(X509 *cert, char *fieldname, char *o=
ut, size_t size)</span><br><span> {</span><br><span>     bool retval =3D fa=
lse;</span><br><span>     char *buf =3D 0;</span><br><span>@@ -195,7 +195,7=
 @@</span><br><span>  * to contain result is grounds for error).</span><br>=
<span>  */</span><br><span> static result_t</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-extract_x509_field_ssl(X509_NAME *x509, const char *f=
ield_name, char *out, int size)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+extract_x509_field_ssl(X509_NAME *x509, const char *field_name,=
 char *out, size_t size)</span><br><span> {</span><br><span>     int lastpo=
s =3D -1;</span><br><span>     int tmp =3D -1;</span><br><span>@@ -252,7 +2=
52,7 @@</span><br><span> }</span><br><span> </span><br><span> result_t</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-backend_x509_get_username(=
char *common_name, int cn_len, char *x509_username_field, X509 *peer_cert)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+backend_x509_get_use=
rname(char *common_name, size_t cn_len, char *x509_username_field, X509 *pe=
er_cert)</span><br><span> {</span><br><span> #ifdef ENABLE_X509ALTUSERNAME<=
/span><br><span>     if (strncmp(&quot;ext:&quot;, x509_username_field, 4) =
=3D=3D 0)</span><br><span></span><br></pre><p>To view, visit <a href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/1138?usp=3Demail">change 1138</a>. To un=
subscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://s=
chema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/1138?usp=3Demail"/><meta itemprop=3D"name" content=3D"V=
iew Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: If971006b6d3a1a93d87b29627d9=
1dd72faf5ceb2 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1138 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 10 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--Vv6hN8OB/a4=--

