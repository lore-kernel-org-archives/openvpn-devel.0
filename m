From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 16 Feb 2026 15:31:58 +0000
In-Reply-To: <gerrit.1770735307000.I201abb9ef013c061fb568823098edcca32cb2df3@...2715...>
References: <gerrit.1770735307000.I201abb9ef013c061fb568823098edcca32cb2df3@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <5a9e9003dfa0434d2cf1957e1ec6e57474001987-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="uxrWdNIUIdI="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: crypto_backend:
 Improve signature of md_full to avoid conversions
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

--uxrWdNIUIdI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/15=
12?usp=3Demail )

Change subject: crypto_backend: Improve signature of md_full to avoid conve=
rsions
......................................................................

crypto_backend: Improve signature of md_full to avoid conversions

Change-Id: I201abb9ef013c061fb568823098edcca32cb2df3
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1512
Message-Id: <20260216150711.16130-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
657.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/crypto_backend.h
M src/openvpn/crypto_mbedtls.c
M src/openvpn/crypto_mbedtls_legacy.c
M src/openvpn/crypto_openssl.c
4 files changed, 13 insertions(+), 13 deletions(-)




diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index 5248614..7f5507a 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -557,9 +557,9 @@
  * @param src_len       The length of the incoming buffer.
  * @param dst           Buffer to write the message digest to. May not be =
NULL.
  *
- * @return              \c 1 on success, \c 0 on failure
+ * @return              true on success, false on failure
  */
-int md_full(const char *mdname, const uint8_t *src, int src_len, uint8_t *=
dst);
+bool md_full(const char *mdname, const uint8_t *src, size_t src_len, uint8=
_t *dst);

 /*
  * Allocate a new message digest context
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index 02735cd..cba6bb5 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -696,13 +696,13 @@
     return ctx;
 }

-int
-md_full(const char *mdname, const uint8_t *src, int src_len, uint8_t *dst)
+bool
+md_full(const char *mdname, const uint8_t *src, size_t src_len, uint8_t *d=
st)
 {
     const md_info_t *md =3D md_get(mdname);
     if (md =3D=3D NULL || src_len < 0)
     {
-        return 0;
+        return false;
     }
=20
     /* We depend on the caller to ensure that dst has enough room for the =
hash,
@@ -710,12 +710,12 @@
     size_t dst_size =3D PSA_HASH_LENGTH(md->psa_alg);
     size_t hash_length =3D 0;

-    psa_status_t status =3D psa_hash_compute(md->psa_alg, src, (size_t)src=
_len, dst, dst_size, &hash_length);
+    psa_status_t status =3D psa_hash_compute(md->psa_alg, src, src_len, ds=
t, dst_size, &hash_length);
     if (status !=3D PSA_SUCCESS || hash_length !=3D dst_size)
     {
-        return 0;
+        return false;
     }
-    return 1;
+    return true;
 }

 void
diff --git a/src/openvpn/crypto_mbedtls_legacy.c b/src/openvpn/crypto_mbedt=
ls_legacy.c
index b8e7d6a..00fe542 100644
--- a/src/openvpn/crypto_mbedtls_legacy.c
+++ b/src/openvpn/crypto_mbedtls_legacy.c
@@ -825,8 +825,8 @@
  *
  */

-int
-md_full(const char *mdname, const uint8_t *src, int src_len, uint8_t *dst)
+bool
+md_full(const char *mdname, const uint8_t *src, size_t src_len, uint8_t *d=
st)
 {
     const mbedtls_md_info_t *kt =3D md_get(mdname);
     return 0 =3D=3D mbedtls_md(kt, src, src_len, dst);
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index ed39efa..0c6de18 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -1104,15 +1104,15 @@
  *
  */

-int
-md_full(const char *mdname, const uint8_t *src, int src_len, uint8_t *dst)
+bool
+md_full(const char *mdname, const uint8_t *src, size_t src_len, uint8_t *d=
st)
 {
     unsigned int in_md_len =3D 0;
     evp_md_type *kt =3D md_get(mdname);

     int ret =3D EVP_Digest(src, src_len, dst, &in_md_len, kt, NULL);
     EVP_MD_free(kt);
-    return ret;
+    return ret =3D=3D 1;
 }

 EVP_MD_CTX *

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1512?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I201abb9ef013c061fb568823098edcca32cb2df3
Gerrit-Change-Number: 1512
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--uxrWdNIUIdI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1512?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">crypto_backend: Improve signature of md_full to =
avoid conversions<br><br>Change-Id: I201abb9ef013c061fb568823098edcca32cb2d=
f3<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by=
: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.openvp=
n.net/c/openvpn/+/1512<br>Message-Id: &lt;20260216150711.16130-1-gert@...1711...=
96...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1357...=
rge.net/msg35657.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt=
;<br>---<br>M src/openvpn/crypto_backend.h<br>M src/openvpn/crypto_mbedtls.=
c<br>M src/openvpn/crypto_mbedtls_legacy.c<br>M src/openvpn/crypto_openssl.=
c<br>4 files changed, 13 insertions(+), 13 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h=
</span><br><span>index 5248614..7f5507a 100644</span><br><span>--- a/src/op=
envpn/crypto_backend.h</span><br><span>+++ b/src/openvpn/crypto_backend.h</=
span><br><span>@@ -557,9 +557,9 @@</span><br><span>  * @param src_len      =
 The length of the incoming buffer.</span><br><span>  * @param dst         =
  Buffer to write the message digest to. May not be NULL.</span><br><span> =
 *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @return         =
     \c 1 on success, \c 0 on failure</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * @return              true on success, false on failure=
</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
int md_full(const char *mdname, const uint8_t *src, int src_len, uint8_t *d=
st);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool md_full(co=
nst char *mdname, const uint8_t *src, size_t src_len, uint8_t *dst);</span>=
<br><span> </span><br><span> /*</span><br><span>  * Allocate a new message =
digest context</span><br><span>diff --git a/src/openvpn/crypto_mbedtls.c b/=
src/openvpn/crypto_mbedtls.c</span><br><span>index 02735cd..cba6bb5 100644<=
/span><br><span>--- a/src/openvpn/crypto_mbedtls.c</span><br><span>+++ b/sr=
c/openvpn/crypto_mbedtls.c</span><br><span>@@ -696,13 +696,13 @@</span><br>=
<span>     return ctx;</span><br><span> }</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-int</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-md_full(const char *mdname, const uint8_t *src, int src=
_len, uint8_t *dst)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+md_full(const c=
har *mdname, const uint8_t *src, size_t src_len, uint8_t *dst)</span><br><s=
pan> {</span><br><span>     const md_info_t *md =3D md_get(mdname);</span><=
br><span>     if (md =3D=3D NULL || src_len &lt; 0)</span><br><span>     {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return 0;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        return false;</s=
pan><br><span>     }</span><br><span> </span><br><span>     /* We depend on=
 the caller to ensure that dst has enough room for the hash,</span><br><spa=
n>@@ -710,12 +710,12 @@</span><br><span>     size_t dst_size =3D PSA_HASH_L=
ENGTH(md-&gt;psa_alg);</span><br><span>     size_t hash_length =3D 0;</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    psa_s=
tatus_t status =3D psa_hash_compute(md-&gt;psa_alg, src, (size_t)src_len, d=
st, dst_size, &amp;hash_length);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    psa_status_t status =3D psa_hash_compute(md-&gt;psa_alg, s=
rc, src_len, dst, dst_size, &amp;hash_length);</span><br><span>     if (sta=
tus !=3D PSA_SUCCESS || hash_length !=3D dst_size)</span><br><span>     {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return 0;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        return false;</sp=
an><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  return 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retu=
rn true;</span><br><span> }</span><br><span> </span><br><span> void</span><=
br><span>diff --git a/src/openvpn/crypto_mbedtls_legacy.c b/src/openvpn/cry=
pto_mbedtls_legacy.c</span><br><span>index b8e7d6a..00fe542 100644</span><b=
r><span>--- a/src/openvpn/crypto_mbedtls_legacy.c</span><br><span>+++ b/src=
/openvpn/crypto_mbedtls_legacy.c</span><br><span>@@ -825,8 +825,8 @@</span>=
<br><span>  *</span><br><span>  */</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-int</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-md_full(const char *mdname, const uint8_t *src, int src_len, =
uint8_t *dst)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+md_full(const char *m=
dname, const uint8_t *src, size_t src_len, uint8_t *dst)</span><br><span> {=
</span><br><span>     const mbedtls_md_info_t *kt =3D md_get(mdname);</span=
><br><span>     return 0 =3D=3D mbedtls_md(kt, src, src_len, dst);</span><b=
r><span>diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_open=
ssl.c</span><br><span>index ed39efa..0c6de18 100644</span><br><span>--- a/s=
rc/openvpn/crypto_openssl.c</span><br><span>+++ b/src/openvpn/crypto_openss=
l.c</span><br><span>@@ -1104,15 +1104,15 @@</span><br><span>  *</span><br><=
span>  */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-md_full(cons=
t char *mdname, const uint8_t *src, int src_len, uint8_t *dst)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+md_full(const char *mdname, const uint8_t *src,=
 size_t src_len, uint8_t *dst)</span><br><span> {</span><br><span>     unsi=
gned int in_md_len =3D 0;</span><br><span>     evp_md_type *kt =3D md_get(m=
dname);</span><br><span> </span><br><span>     int ret =3D EVP_Digest(src, =
src_len, dst, &amp;in_md_len, kt, NULL);</span><br><span>     EVP_MD_free(k=
t);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return ret;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    return ret =3D=3D =
1;</span><br><span> }</span><br><span> </span><br><span> EVP_MD_CTX *</span=
><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/1512?usp=3Demail">change 1512</a>. To unsubscribe, or f=
or help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/se=
ttings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://sche=
ma.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/1512?usp=3Demail"/><meta itemprop=3D"name" content=3D"View=
 Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I201abb9ef013c061fb568823098=
edcca32cb2df3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1512 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--uxrWdNIUIdI=--

