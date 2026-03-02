From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 2 Mar 2026 21:51:05 +0000
In-Reply-To: <gerrit.1771607942000.I53d47e4a0d33c380ee95e0e33aecad3db3197940@...2715...>
References: <gerrit.1771607942000.I53d47e4a0d33c380ee95e0e33aecad3db3197940@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, steffan@...1856..., max@...2606...
Message-ID: <be6ac528b6d5f74e782b2b68bbab1cdf7409407a-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gzyNTMJ48ec="; charset=UTF-8
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
To: MaxF <max@...2606...>
Cc: plaisthos <arne-openvpn@...1227...>, syzzer <steffan@...1856...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--gzyNTMJ48ec=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/15=
49?usp=3Demail )

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
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1549
Message-Id: <20260302142045.5954-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
807.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/pkcs11_mbedtls.c
1 file changed, 16 insertions(+), 0 deletions(-)




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

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I53d47e4a0d33c380ee95e0e33aecad3db3197940
Gerrit-Change-Number: 1549
Gerrit-PatchSet: 2
Gerrit-Owner: MaxF <max@...2606...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: syzzer <steffan@...1856...>

--gzyNTMJ48ec=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1549?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">Avoid unbounded allocations in pkcs11_mbedtls.c<=
br><br>The PKCS#11 provider can crash OpenVPN by making it try to allocate<=
br>2^64 bytes for a certificate. To avoid this, set a maximum size for<br>c=
ertificates. If the size is exceeded, don&#39;t try to allocate memory and<=
br>instead exit pkcs11_get_x509_cert with an error.<br><br>The chosen maxim=
um size is 100.000 bytes which is twice the size of<br>a SLH-DSA (aka SPHIN=
CS+) signature.<br><br>Found-by: ZeroPath (https://zeropath.com/)<br>Report=
ed-by: Joshua Rogers &lt;contact@...2949...&gt;<br>Github: closes OpenVPN/o=
penvpn-private-issues#42<br><br>Change-Id: I53d47e4a0d33c380ee95e0e33aecad3=
db3197940<br>Signed-off-by: Max Fillinger &lt;maximilian.fillinger@...2920...=
..&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@...1227...&gt;<br>Gerrit =
URL: https://gerrit.openvpn.net/c/openvpn/+/1549<br>Message-Id: &lt;2026030=
2142045.5954-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/ope=
nvpn-devel@lists.sourceforge.net/msg35807.html<br>Signed-off-by: Gert Doeri=
ng &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/pkcs11_mbedtls.c<br>1 fi=
le changed, 16 insertions(+), 0 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/pkcs11_mbedtls.c b/src/openvpn/pkcs11_mbedtls.c=
</span><br><span>index 66aefac..bf9d953 100644</span><br><span>--- a/src/op=
envpn/pkcs11_mbedtls.c</span><br><span>+++ b/src/openvpn/pkcs11_mbedtls.c</=
span><br><span>@@ -42,6 +42,16 @@</span><br><span> static bool</span><br><s=
pan> pkcs11_get_x509_cert(pkcs11h_certificate_t pkcs11_cert, mbedtls_x509_c=
rt *cert)</span><br><span> {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /* We set a maximum size for certificates so that the PKCS pro=
vider cannot crash OpenVPN by</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+     * making it try to allocate 2^64 bytes. The maximum of 100.0=
00 bytes is picked as a round</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+     * number that easily accomodates the currently standardized =
quantum-safe signature algorithms.</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     * It is twice the size of a SLH-DSA (aka SPHINCS+) sign=
ature plus public key.</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+     *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * How=
ever, there are additional digital signature schemes currently on the NIST =
on-ramp</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * (e.g.=
, some parameter settings for LESS) that have even larger public keys or si=
gnatures, so</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * =
if those ever see use on smartcards, we will need to increase this number. =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const size_t =
max_cert_size =3D 100000;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span>     unsigned char *cert_blob =3D NULL;</span><br><s=
pan>     size_t cert_blob_size =3D 0;</span><br><span>     bool ret =3D fal=
se;</span><br><span>@@ -52,6 +62,12 @@</span><br><span>         goto cleanu=
p;</span><br><span>     }</span><br><span> </span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if (cert_blob_size &gt; max_cert_size)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;PKCS#11: Certif=
icate too large: %lu bytes, maximum is %lu&quot;, cert_blob_size, max_cert_=
size);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto =
cleanup;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     che=
ck_malloc_return((cert_blob =3D calloc(1, cert_blob_size)));</span><br><spa=
n>     if (pkcs11h_certificate_getCertificateBlob(pkcs11_cert, cert_blob, &=
amp;cert_blob_size) !=3D CKR_OK)</span><br><span>     {</span><br><span></s=
pan><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/1549?usp=3Demail">change 1549</a>. To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3De=
mail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vie=
wAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1549?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></di=
v></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I53d47e4a0d33c380ee95e0e33ae=
cad3db3197940 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1549 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@...2606...&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@...1296...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: syzzer &lt;steffan@...1856...&gt; <=
/div>

</body></html>=

--gzyNTMJ48ec=--

