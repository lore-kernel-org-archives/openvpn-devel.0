From: "MaxF (Code Review)" <gerrit@...515...>
Date: Fri, 20 Feb 2026 17:19:06 +0000
References: <gerrit.1771607942000.I53d47e4a0d33c380ee95e0e33aecad3db3197940@...2715...>
Reply-To: max@...2606..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <44cad7afe3494e5681d45a756a96c01356d352ff-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="UyA/W+baBu8="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Avoid unbounded
 allocations in pkcs11_mbedtls.c
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

--UyA/W+baBu8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1549?usp=3Demail

to review the following change.


Change subject: Avoid unbounded allocations in pkcs11_mbedtls.c
......................................................................

Avoid unbounded allocations in pkcs11_mbedtls.c

The PKCS#11 provider can crash OpenVPN by making it try to allocate
2^64 bytes for a certificate. To avoid this, set a maximum size for
certificates. If the size is exceeded, don't try to allocate memory and
instead exit pkcs11_get_x509_cert with an error.

The chosen maximum size is 100.000 bytes which is twice the size of
a SLH-DSA (aka SPHINCS+) signature.

Found-by: ZeroPath (https://zeropath.com/)
Reported-by: Joshua Rogers <contact@...2949...>
Github: closes OpenVPN/openvpn-private-issues#42

Change-Id: I53d47e4a0d33c380ee95e0e33aecad3db3197940
Signed-off-by: Max Fillinger <maximilian.fillinger@...2918...>
---
M src/openvpn/pkcs11_mbedtls.c
1 file changed, 16 insertions(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/49/1549/1

diff --git a/src/openvpn/pkcs11_mbedtls.c b/src/openvpn/pkcs11_mbedtls.c
index 66aefac..bf9d953 100644
--- a/src/openvpn/pkcs11_mbedtls.c
+++ b/src/openvpn/pkcs11_mbedtls.c
@@ -42,6 +42,16 @@
 static bool
 pkcs11_get_x509_cert(pkcs11h_certificate_t pkcs11_cert, mbedtls_x509_crt *=
cert)
 {
+    /* We set a maximum size for certificates so that the PKCS provider ca=
nnot crash OpenVPN by
+     * making it try to allocate 2^64 bytes. The maximum of 100.000 bytes =
is picked as a round
+     * number that easily accomodates the currently standardized quantum-s=
afe signature algorithms.
+     * It is twice the size of a SLH-DSA (aka SPHINCS+) signature plus pub=
lic key.
+     *
+     * However, there are additional digital signature schemes currently o=
n the NIST on-ramp
+     * (e.g., some parameter settings for LESS) that have even larger publ=
ic keys or signatures, so
+     * if those ever see use on smartcards, we will need to increase this =
number. */
+    const size_t max_cert_size =3D 100000;
+
     unsigned char *cert_blob =3D NULL;
     size_t cert_blob_size =3D 0;
     bool ret =3D false;
@@ -52,6 +62,12 @@
         goto cleanup;
     }

+    if (cert_blob_size > max_cert_size)
+    {
+        msg(M_WARN, "PKCS#11: Certificate too large: %lu bytes, maximum is=
 %lu", cert_blob_size, max_cert_size);
+        goto cleanup;
+    }
+
     check_malloc_return((cert_blob =3D calloc(1, cert_blob_size)));
     if (pkcs11h_certificate_getCertificateBlob(pkcs11_cert, cert_blob, &ce=
rt_blob_size) !=3D CKR_OK)
     {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1549?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I53d47e4a0d33c380ee95e0e33aecad3db3197940
Gerrit-Change-Number: 1549
Gerrit-PatchSet: 1
Gerrit-Owner: MaxF <max@...2606...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--UyA/W+baBu8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>MaxF would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1549?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">Avoid unbounded allocations in pkcs11_mbedt=
ls.c<br><br>The PKCS#11 provider can crash OpenVPN by making it try to allo=
cate<br>2^64 bytes for a certificate. To avoid this, set a maximum size for=
<br>certificates. If the size is exceeded, don&#39;t try to allocate memory=
 and<br>instead exit pkcs11_get_x509_cert with an error.<br><br>The chosen =
maximum size is 100.000 bytes which is twice the size of<br>a SLH-DSA (aka =
SPHINCS+) signature.<br><br>Found-by: ZeroPath (https://zeropath.com/)<br>R=
eported-by: Joshua Rogers &lt;contact@...2949...&gt;<br>Github: closes Open=
VPN/openvpn-private-issues#42<br><br>Change-Id: I53d47e4a0d33c380ee95e0e33a=
ecad3db3197940<br>Signed-off-by: Max Fillinger &lt;maximilian.fillinger@...493...=
2918...&gt;<br>---<br>M src/openvpn/pkcs11_mbedtls.c<br>1 file changed, 16 =
insertions(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ger=
rit.openvpn.net:29418/openvpn refs/changes/49/1549/1</pre><pre style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/s=
rc/openvpn/pkcs11_mbedtls.c b/src/openvpn/pkcs11_mbedtls.c</span><br><span>=
index 66aefac..bf9d953 100644</span><br><span>--- a/src/openvpn/pkcs11_mbed=
tls.c</span><br><span>+++ b/src/openvpn/pkcs11_mbedtls.c</span><br><span>@@=
 -42,6 +42,16 @@</span><br><span> static bool</span><br><span> pkcs11_get_x=
509_cert(pkcs11h_certificate_t pkcs11_cert, mbedtls_x509_crt *cert)</span><=
br><span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* W=
e set a maximum size for certificates so that the PKCS provider cannot cras=
h OpenVPN by</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * =
making it try to allocate 2^64 bytes. The maximum of 100.000 bytes is picke=
d as a round</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * =
number that easily accomodates the currently standardized quantum-safe sign=
ature algorithms.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
   * It is twice the size of a SLH-DSA (aka SPHINCS+) signature plus public=
 key.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     *</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+     * However, there are a=
dditional digital signature schemes currently on the NIST on-ramp</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+     * (e.g., some parameter =
settings for LESS) that have even larger public keys or signatures, so</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+     * if those ever see=
 use on smartcards, we will need to increase this number. */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    const size_t max_cert_size =3D=
 100000;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span>     unsigned char *cert_blob =3D NULL;</span><br><span>     size_t c=
ert_blob_size =3D 0;</span><br><span>     bool ret =3D false;</span><br><sp=
an>@@ -52,6 +62,12 @@</span><br><span>         goto cleanup;</span><br><spa=
n>     }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (cert_blob_size &gt; max_cert_size)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        msg(M_WARN, &quot;PKCS#11: Certificate too large: %=
lu bytes, maximum is %lu&quot;, cert_blob_size, max_cert_size);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        goto cleanup;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     check_malloc_return=
((cert_blob =3D calloc(1, cert_blob_size)));</span><br><span>     if (pkcs1=
1h_certificate_getCertificateBlob(pkcs11_cert, cert_blob, &amp;cert_blob_si=
ze) !=3D CKR_OK)</span><br><span>     {</span><br><span></span><br></pre><p=
>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1549?usp=
=3Demail">change 1549</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings=
</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link=
 itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1549?usp=3D=
email"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I53d47e4a0d33c380ee95e0e33ae=
cad3db3197940 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1549 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@...2606...&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--UyA/W+baBu8=--

