From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 10 Feb 2026 11:09:09 +0000
In-Reply-To: <gerrit.1769619521000.I740991f22b728fe2f5a48bc18d5ca4b62f56f399@...2715...>
References: <gerrit.1769619521000.I740991f22b728fe2f5a48bc18d5ca4b62f56f399@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, max@...2606...
Message-ID: <f8a9a79dc8fee82e33088a6d995e956447f2e6af-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="UMI65bZ115o="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Mbed TLS 4: Add more
 algorithms
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: MaxF <max@...2606...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--UMI65bZ115o=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 MaxF. ( http://gerrit.openvpn.net/c/openvpn/+/1500?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos


Change subject: Mbed TLS 4: Add more algorithms
......................................................................

Mbed TLS 4: Add more algorithms

Expand the tables of hash functions and elliptic curve groups, and also
check if they are compiled in.

Change-Id: I740991f22b728fe2f5a48bc18d5ca4b62f56f399
Signed-off-by: Max Fillinger <maximilian.fillinger@...2918...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1500
Message-Id: <20260130071137.14398-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
507.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/crypto_mbedtls.c
M src/openvpn/ssl_mbedtls.c
2 files changed, 72 insertions(+), 3 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/00/1500/4

diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index 5418df9..02735cd 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -605,10 +605,36 @@
 }

 static const md_info_t md_info_table[] =3D {
-    /* TODO: Fill out table. */
+#if defined(PSA_WANT_ALG_MD5)
     { "MD5", PSA_ALG_MD5 },
+#endif
+#if defined(PSA_WANT_ALG_SHA_1)
     { "SHA1", PSA_ALG_SHA_1 },
+#endif
+#if defined(PSA_WANT_ALG_SHA_224)
+    { "SHA224", PSA_ALG_SHA_224 },
+#endif
+#if defined(PSA_WANT_ALG_SHA_256)
     { "SHA256", PSA_ALG_SHA_256 },
+#endif
+#if defined(PSA_WANT_ALG_SHA_384)
+    { "SHA384", PSA_ALG_SHA_384 },
+#endif
+#if defined(PSA_WANT_ALG_SHA_512)
+    { "SHA512", PSA_ALG_SHA_512 },
+#endif
+#if defined(PSA_WANT_ALG_SHA3_224)
+    { "SHA3-224", PSA_ALG_SHA3_224 },
+#endif
+#if defined(PSA_WANT_ALG_SHA3_256)
+    { "SHA3-256", PSA_ALG_SHA3_256 },
+#endif
+#if defined(PSA_WANT_ALG_SHA3_384)
+    { "SHA3-384", PSA_ALG_SHA3_384 },
+#endif
+#if defined(PSA_WANT_ALG_SHA3_512)
+    { "SHA3-512", PSA_ALG_SHA3_512 },
+#endif
 };
 const size_t md_info_table_entries =3D sizeof(md_info_table) / sizeof(md_i=
nfo_t);

diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 3e1698f..5227eb8 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -356,15 +356,54 @@

 #if MBEDTLS_VERSION_NUMBER >=3D 0x04000000
 static const mbedtls_ecp_curve_info ecp_curve_info_table[] =3D {
-    /* TODO: Fill out the table. */
+/* secp curves. */
+#if defined(PSA_WANT_ECC_SECP_R1_256)
     { "secp256r1", MBEDTLS_SSL_IANA_TLS_GROUP_SECP256R1 },
+#endif
+#if defined(PSA_WANT_ECC_SECP_R1_384)
     { "secp384r1", MBEDTLS_SSL_IANA_TLS_GROUP_SECP384R1 },
+#endif
+#if defined(PSA_WANT_ECC_SECP_R1_521)
+    { "secp521r1", MBEDTLS_SSL_IANA_TLS_GROUP_SECP521R1 },
+#endif
+
+/* Curve25519. */
+#if defined(PSA_WANT_ECC_MONTGOMERY_255)
     { "X25519", MBEDTLS_SSL_IANA_TLS_GROUP_X25519 },
+#endif
+
+/* Curve448. */
+#if defined(PSA_WANT_ECC_MONTGOMERY_448)
+    { "X448", MBEDTLS_SSL_IANA_TLS_GROUP_X448 },
+#endif
+
+/* Brainpool curves. */
+#if defined(PSA_WANT_ECC_BRAINPOOL_P_R1_256)
+    { "brainpoolP256r1", MBEDTLS_SSL_IANA_TLS_GROUP_BP256R1 },
+#endif
+#if defined(PSA_WANT_ECC_BRAINPOOL_P_R1_384)
+    { "brainpoolP384r1", MBEDTLS_SSL_IANA_TLS_GROUP_BP384R1 },
+#endif
+#if defined(PSA_WANT_ECC_BRAINPOOL_P_R1_512)
+    { "brainpoolP512r1", MBEDTLS_SSL_IANA_TLS_GROUP_BP512R1 },
+#endif
+
+/* Named Diffie-Hellman groups. */
+#if defined(PSA_WANT_DH_RFC7919_2048)
     { "ffdhe2048", MBEDTLS_SSL_IANA_TLS_GROUP_FFDHE2048 },
+#endif
+#if defined(PSA_WANT_DH_RFC7919_3072)
     { "ffdhe3072", MBEDTLS_SSL_IANA_TLS_GROUP_FFDHE3072 },
+#endif
+#if defined(PSA_WANT_DH_RFC7919_4096)
     { "ffdhe4096", MBEDTLS_SSL_IANA_TLS_GROUP_FFDHE4096 },
+#endif
+#if defined(PSA_WANT_DH_RFC7919_6144)
     { "ffdhe6144", MBEDTLS_SSL_IANA_TLS_GROUP_FFDHE6144 },
+#endif
+#if defined(PSA_WANT_DH_RFC7919_8192)
     { "ffdhe8192", MBEDTLS_SSL_IANA_TLS_GROUP_FFDHE8192 },
+#endif
 };
 static const size_t ecp_curve_info_table_items =3D sizeof(ecp_curve_info_t=
able) / sizeof(mbedtls_ecp_curve_info);

@@ -1523,7 +1562,11 @@
         pcurve++;
     }
 #else
-    msg(M_FATAL, "Mbed TLS 4 has no mechanism to list supported curves.");
+    printf("Available elliptic curves:\n\n");
+    for (size_t i =3D 0; i < ecp_curve_info_table_items; i++)
+    {
+        printf("%s\n", ecp_curve_info_table[i].name);
+    }
 #endif /* MBEDTLS_VERSION_NUMBER < 0x04000000 */
 }


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1500?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I740991f22b728fe2f5a48bc18d5ca4b62f56f399
Gerrit-Change-Number: 1500
Gerrit-PatchSet: 4
Gerrit-Owner: MaxF <max@...2606...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--UMI65bZ115o=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #4</strong> to the change originally created by MaxF.</p><p=
><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1500?usp=3Demail">View Ch=
ange</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by plaisthos</p><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">Mbed TLS 4: Add more algorithms=
<br><br>Expand the tables of hash functions and elliptic curve groups, and =
also<br>check if they are compiled in.<br><br>Change-Id: I740991f22b728fe2f=
5a48bc18d5ca4b62f56f399<br>Signed-off-by: Max Fillinger &lt;maximilian.fill=
inger@...2918...&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@...1227...&=
gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1500<br>Message-I=
d: &lt;20260130071137.14398-1-gert@...1296...&gt;<br>URL: https://www.mail-=
archive.com/openvpn-devel@lists.sourceforge.net/msg35507.html<br>Signed-off=
-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/crypto_mb=
edtls.c<br>M src/openvpn/ssl_mbedtls.c<br>2 files changed, 72 insertions(+)=
, 3 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.n=
et:29418/openvpn refs/changes/00/1500/4</pre><pre style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/cr=
ypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c</span><br><span>index 5418df9=
..02735cd 100644</span><br><span>--- a/src/openvpn/crypto_mbedtls.c</span><=
br><span>+++ b/src/openvpn/crypto_mbedtls.c</span><br><span>@@ -605,10 +605=
,36 @@</span><br><span> }</span><br><span> </span><br><span> static const m=
d_info_t md_info_table[] =3D {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    /* TODO: Fill out table. */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#if defined(PSA_WANT_ALG_MD5)</span><br><span>     { &=
quot;MD5&quot;, PSA_ALG_MD5 },</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
f defined(PSA_WANT_ALG_SHA_1)</span><br><span>     { &quot;SHA1&quot;, PSA_=
ALG_SHA_1 },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(PSA_WANT=
_ALG_SHA_224)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    { =
&quot;SHA224&quot;, PSA_ALG_SHA_224 },</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#if defined(PSA_WANT_ALG_SHA_256)</span><br><span>     { &quot;SHA256=
&quot;, PSA_ALG_SHA_256 },</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if de=
fined(PSA_WANT_ALG_SHA_384)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    { &quot;SHA384&quot;, PSA_ALG_SHA_384 },</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#if defined(PSA_WANT_ALG_SHA_512)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    { &quot;SHA512&quot;, PSA_ALG_SHA_51=
2 },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(PSA_WANT_ALG_SHA=
3_224)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    { &quot;S=
HA3-224&quot;, PSA_ALG_SHA3_224 },</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#if defined(PSA_WANT_ALG_SHA3_256)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    { &quot;SHA3-256&quot;, PSA_ALG_SHA3_256 },</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if defined(PSA_WANT_ALG_SHA3_384)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    { &quot;SHA3-384&quot;=
, PSA_ALG_SHA3_384 },</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined=
(PSA_WANT_ALG_SHA3_512)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    { &quot;SHA3-512&quot;, PSA_ALG_SHA3_512 },</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> };</span><br><spa=
n> const size_t md_info_table_entries =3D sizeof(md_info_table) / sizeof(md=
_info_t);</span><br><span> </span><br><span>diff --git a/src/openvpn/ssl_mb=
edtls.c b/src/openvpn/ssl_mbedtls.c</span><br><span>index 3e1698f..5227eb8 =
100644</span><br><span>--- a/src/openvpn/ssl_mbedtls.c</span><br><span>+++ =
b/src/openvpn/ssl_mbedtls.c</span><br><span>@@ -356,15 +356,54 @@</span><br=
><span> </span><br><span> #if MBEDTLS_VERSION_NUMBER &gt;=3D 0x04000000</sp=
an><br><span> static const mbedtls_ecp_curve_info ecp_curve_info_table[] =
=3D {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* TODO: Fil=
l out the table. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
/* secp curves. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
if defined(PSA_WANT_ECC_SECP_R1_256)</span><br><span>     { &quot;secp256r1=
&quot;, MBEDTLS_SSL_IANA_TLS_GROUP_SECP256R1 },</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#if defined(PSA_WANT_ECC_SECP_R1_384)</span><br><span>     {=
 &quot;secp384r1&quot;, MBEDTLS_SSL_IANA_TLS_GROUP_SECP384R1 },</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#if defined(PSA_WANT_ECC_SECP_R1_521)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    { &quot;secp521r1&quot=
;, MBEDTLS_SSL_IANA_TLS_GROUP_SECP521R1 },</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Curve2=
5519. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined=
(PSA_WANT_ECC_MONTGOMERY_255)</span><br><span>     { &quot;X25519&quot;, MB=
EDTLS_SSL_IANA_TLS_GROUP_X25519 },</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Curve448. */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(PSA_WANT_=
ECC_MONTGOMERY_448)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    { &quot;X448&quot;, MBEDTLS_SSL_IANA_TLS_GROUP_X448 },</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+/* Brainpool curves. */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#if defined(PSA_WANT_ECC_BRAINPOOL_P_R1_256)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    { &quot;brainpoolP256r1&quot;, MBED=
TLS_SSL_IANA_TLS_GROUP_BP256R1 },</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#if defined(PSA_WANT_ECC_BRAINPOOL_P_R1_384)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    { &quot;brainpoolP384r1&quot;, MBEDTLS_SSL_IA=
NA_TLS_GROUP_BP384R1 },</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defin=
ed(PSA_WANT_ECC_BRAINPOOL_P_R1_512)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    { &quot;brainpoolP512r1&quot;, MBEDTLS_SSL_IANA_TLS_GRO=
UP_BP512R1 },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/* Named Diffie-Hellman groups. */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(PSA_WANT_DH=
_RFC7919_2048)</span><br><span>     { &quot;ffdhe2048&quot;, MBEDTLS_SSL_IA=
NA_TLS_GROUP_FFDHE2048 },</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if def=
ined(PSA_WANT_DH_RFC7919_3072)</span><br><span>     { &quot;ffdhe3072&quot;=
, MBEDTLS_SSL_IANA_TLS_GROUP_FFDHE3072 },</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#if defined(PSA_WANT_DH_RFC7919_4096)</span><br><span>     { &quot=
;ffdhe4096&quot;, MBEDTLS_SSL_IANA_TLS_GROUP_FFDHE4096 },</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#if defined(PSA_WANT_DH_RFC7919_6144)</span><br><s=
pan>     { &quot;ffdhe6144&quot;, MBEDTLS_SSL_IANA_TLS_GROUP_FFDHE6144 },</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#if defined(PSA_WANT_DH_RFC7919_81=
92)</span><br><span>     { &quot;ffdhe8192&quot;, MBEDTLS_SSL_IANA_TLS_GROU=
P_FFDHE8192 },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endi=
f</span><br><span> };</span><br><span> static const size_t ecp_curve_info_t=
able_items =3D sizeof(ecp_curve_info_table) / sizeof(mbedtls_ecp_curve_info=
);</span><br><span> </span><br><span>@@ -1523,7 +1562,11 @@</span><br><span=
>         pcurve++;</span><br><span>     }</span><br><span> #else</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    msg(M_FATAL, &quot;Mbed TLS=
 4 has no mechanism to list supported curves.&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    printf(&quot;Available elliptic curve=
s:\n\n&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    f=
or (size_t i =3D 0; i &lt; ecp_curve_info_table_items; i++)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        printf(&quot;%s\n&quot;, ecp_curve_info_t=
able[i].name);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span> #endif /* MBEDTLS_VERSION_NUMBER &lt; 0x04000000 */</span=
><br><span> }</span><br><span> </span><br><span></span><br></pre><p>To view=
, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1500?usp=3Demail">=
change 1500</a>. To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><=
div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1500?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I740991f22b728fe2f5a48bc18d5=
ca4b62f56f399 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1500 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@...2606...&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--UMI65bZ115o=--

