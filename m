From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 6 Aug 2025 14:29:43 +0000
References: <gerrit.1754490554000.If971006b6d3a1a93d87b29627d91dd72faf5ceb2@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <a29a5a69e659b5300dd6858f68a010f276f54a74-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="j3OVn6UcLew="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--j3OVn6UcLew=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1138?usp=3Demail

to review the following change.


Change subject: ssl_verify: Change backend_x509_* functions to size_t for l=
engths
......................................................................

ssl_verify: Change backend_x509_* functions to size_t for lengths

Fix conversion warnings without actual code changes.

Change-Id: If971006b6d3a1a93d87b29627d91dd72faf5ceb2
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/ssl_verify_backend.h
M src/openvpn/ssl_verify_mbedtls.c
M src/openvpn/ssl_verify_openssl.c
3 files changed, 5 insertions(+), 5 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/38/1138/1

diff --git a/src/openvpn/ssl_verify_backend.h b/src/openvpn/ssl_verify_back=
end.h
index af7a08f..8a1e0e1 100644
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
index eb556c1..ae045de 100644
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
index 22659aa..c72785a 100644
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
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--j3OVn6UcLew=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1138?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">ssl_verify: Change backend_x509_* functions to size_t for le=
ngths<br><br>Fix conversion warnings without actual code changes.<br><br>Ch=
ange-Id: If971006b6d3a1a93d87b29627d91dd72faf5ceb2<br>Signed-off-by: Frank =
Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/ssl_verify_bac=
kend.h<br>M src/openvpn/ssl_verify_mbedtls.c<br>M src/openvpn/ssl_verify_op=
enssl.c<br>3 files changed, 5 insertions(+), 5 deletions(-)<br><br></pre><p=
re style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git p=
ull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/38/1138/1</pre><pre=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>d=
iff --git a/src/openvpn/ssl_verify_backend.h b/src/openvpn/ssl_verify_backe=
nd.h</span><br><span>index af7a08f..8a1e0e1 100644</span><br><span>--- a/sr=
c/openvpn/ssl_verify_backend.h</span><br><span>+++ b/src/openvpn/ssl_verify=
_backend.h</span><br><span>@@ -123,7 +123,7 @@</span><br><span>  *</span><b=
r><span>  * @return              \c FAILURE, \c or SUCCESS</span><br><span>=
  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-result_t backend_=
x509_get_username(char *common_name, int cn_len, char *x509_username_field,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+result_t backend_x5=
09_get_username(char *common_name, size_t cn_len, char *x509_username_field=
,</span><br><span>                                    openvpn_x509_cert_t *=
peer_cert);</span><br><span> </span><br><span> #ifdef ENABLE_X509ALTUSERNAM=
E</span><br><span>diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openv=
pn/ssl_verify_mbedtls.c</span><br><span>index eb556c1..ae045de 100644</span=
><br><span>--- a/src/openvpn/ssl_verify_mbedtls.c</span><br><span>+++ b/src=
/openvpn/ssl_verify_mbedtls.c</span><br><span>@@ -128,7 +128,7 @@</span><br=
><span> #endif</span><br><span> </span><br><span> result_t</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-backend_x509_get_username(char *cn, in=
t cn_len, char *x509_username_field, mbedtls_x509_crt *cert)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+backend_x509_get_username(char *cn=
, size_t cn_len, char *x509_username_field, mbedtls_x509_crt *cert)</span><=
br><span> {</span><br><span>     mbedtls_x509_name *name;</span><br><span> =
</span><br><span>diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvp=
n/ssl_verify_openssl.c</span><br><span>index 22659aa..c72785a 100644</span>=
<br><span>--- a/src/openvpn/ssl_verify_openssl.c</span><br><span>+++ b/src/=
openvpn/ssl_verify_openssl.c</span><br><span>@@ -120,7 +120,7 @@</span><br>=
<span> }</span><br><span> </span><br><span> static bool</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-extract_x509_extension(X509 *cert, char *=
fieldname, char *out, int size)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+extract_x509_extension(X509 *cert, char *fieldname, char *out, =
size_t size)</span><br><span> {</span><br><span>     bool retval =3D false;=
</span><br><span>     char *buf =3D 0;</span><br><span>@@ -195,7 +195,7 @@<=
/span><br><span>  * to contain result is grounds for error).</span><br><spa=
n>  */</span><br><span> static result_t</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-extract_x509_field_ssl(X509_NAME *x509, const char *field=
_name, char *out, int size)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+extract_x509_field_ssl(X509_NAME *x509, const char *field_name, cha=
r *out, size_t size)</span><br><span> {</span><br><span>     int lastpos =
=3D -1;</span><br><span>     int tmp =3D -1;</span><br><span>@@ -252,7 +252=
,7 @@</span><br><span> }</span><br><span> </span><br><span> result_t</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-backend_x509_get_username(ch=
ar *common_name, int cn_len, char *x509_username_field, X509 *peer_cert)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+backend_x509_get_usern=
ame(char *common_name, size_t cn_len, char *x509_username_field, X509 *peer=
_cert)</span><br><span> {</span><br><span> #ifdef ENABLE_X509ALTUSERNAME</s=
pan><br><span>     if (strncmp(&quot;ext:&quot;, x509_username_field, 4) =
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
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--j3OVn6UcLew=--

