From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 16 Feb 2026 15:31:56 +0000
In-Reply-To: <gerrit.1770735307000.I201abb9ef013c061fb568823098edcca32cb2df3@...2715...>
References: <gerrit.1770735307000.I201abb9ef013c061fb568823098edcca32cb2df3@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <5a9e9003dfa0434d2cf1957e1ec6e57474001987-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="1ORjPH40Pqs="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--1ORjPH40Pqs=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1512?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/12/1512/2

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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I201abb9ef013c061fb568823098edcca32cb2df3
Gerrit-Change-Number: 1512
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--1ORjPH40Pqs=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1512?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">crypto_backend: Improve signature o=
f md_full to avoid conversions<br><br>Change-Id: I201abb9ef013c061fb5688230=
98edcca32cb2df3<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt=
;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: https://=
gerrit.openvpn.net/c/openvpn/+/1512<br>Message-Id: &lt;20260216150711.16130=
-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...465...=
ists.sourceforge.net/msg35657.html<br>Signed-off-by: Gert Doering &lt;gert@=
...1296...&gt;<br>---<br>M src/openvpn/crypto_backend.h<br>M src/openvpn/cr=
ypto_mbedtls.c<br>M src/openvpn/crypto_mbedtls_legacy.c<br>M src/openvpn/cr=
ypto_openssl.c<br>4 files changed, 13 insertions(+), 13 deletions(-)<br><br=
></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/c=
hanges/12/1512/2</pre><pre style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;"><span>diff --git a/src/openvpn/crypto_backend.h b/src/op=
envpn/crypto_backend.h</span><br><span>index 5248614..7f5507a 100644</span>=
<br><span>--- a/src/openvpn/crypto_backend.h</span><br><span>+++ b/src/open=
vpn/crypto_backend.h</span><br><span>@@ -557,9 +557,9 @@</span><br><span>  =
* @param src_len       The length of the incoming buffer.</span><br><span> =
 * @param dst           Buffer to write the message digest to. May not be N=
ULL.</span><br><span>  *</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- * @return              \c 1 on success, \c 0 on failure</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * @return              true on suc=
cess, false on failure</span><br><span>  */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-int md_full(const char *mdname, const uint8_t *src, i=
nt src_len, uint8_t *dst);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+bool md_full(const char *mdname, const uint8_t *src, size_t src_len,=
 uint8_t *dst);</span><br><span> </span><br><span> /*</span><br><span>  * A=
llocate a new message digest context</span><br><span>diff --git a/src/openv=
pn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c</span><br><span>index 02=
735cd..cba6bb5 100644</span><br><span>--- a/src/openvpn/crypto_mbedtls.c</s=
pan><br><span>+++ b/src/openvpn/crypto_mbedtls.c</span><br><span>@@ -696,13=
 +696,13 @@</span><br><span>     return ctx;</span><br><span> }</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-int</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-md_full(const char *mdname, const=
 uint8_t *src, int src_len, uint8_t *dst)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+md_full(const char *mdname, const uint8_t *src, size_t src_len, uint=
8_t *dst)</span><br><span> {</span><br><span>     const md_info_t *md =3D m=
d_get(mdname);</span><br><span>     if (md =3D=3D NULL || src_len &lt; 0)</=
span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      return false;</span><br><span>     }</span><br><span> </span><br><spa=
n>     /* We depend on the caller to ensure that dst has enough room for th=
e hash,</span><br><span>@@ -710,12 +710,12 @@</span><br><span>     size_t d=
st_size =3D PSA_HASH_LENGTH(md-&gt;psa_alg);</span><br><span>     size_t ha=
sh_length =3D 0;</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    psa_status_t status =3D psa_hash_compute(md-&gt;psa_alg, s=
rc, (size_t)src_len, dst, dst_size, &amp;hash_length);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    psa_status_t status =3D psa_hash_com=
pute(md-&gt;psa_alg, src, src_len, dst, dst_size, &amp;hash_length);</span>=
<br><span>     if (status !=3D PSA_SUCCESS || hash_length !=3D dst_size)</s=
pan><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     return false;</span><br><span>     }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    return 1;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    return true;</span><br><span> }</span><br><span> </span><=
br><span> void</span><br><span>diff --git a/src/openvpn/crypto_mbedtls_lega=
cy.c b/src/openvpn/crypto_mbedtls_legacy.c</span><br><span>index b8e7d6a..0=
0fe542 100644</span><br><span>--- a/src/openvpn/crypto_mbedtls_legacy.c</sp=
an><br><span>+++ b/src/openvpn/crypto_mbedtls_legacy.c</span><br><span>@@ -=
825,8 +825,8 @@</span><br><span>  *</span><br><span>  */</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-int</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-md_full(const char *mdname, const uint8_=
t *src, int src_len, uint8_t *dst)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
md_full(const char *mdname, const uint8_t *src, size_t src_len, uint8_t *ds=
t)</span><br><span> {</span><br><span>     const mbedtls_md_info_t *kt =3D =
md_get(mdname);</span><br><span>     return 0 =3D=3D mbedtls_md(kt, src, sr=
c_len, dst);</span><br><span>diff --git a/src/openvpn/crypto_openssl.c b/sr=
c/openvpn/crypto_openssl.c</span><br><span>index ed39efa..0c6de18 100644</s=
pan><br><span>--- a/src/openvpn/crypto_openssl.c</span><br><span>+++ b/src/=
openvpn/crypto_openssl.c</span><br><span>@@ -1104,15 +1104,15 @@</span><br>=
<span>  *</span><br><span>  */</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-int</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-md_full(const char *mdname, const uint8_t *src, int src_len, uint8=
_t *dst)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+md_full(const char *mdname=
, const uint8_t *src, size_t src_len, uint8_t *dst)</span><br><span> {</spa=
n><br><span>     unsigned int in_md_len =3D 0;</span><br><span>     evp_md_=
type *kt =3D md_get(mdname);</span><br><span> </span><br><span>     int ret=
 =3D EVP_Digest(src, src_len, dst, &amp;in_md_len, kt, NULL);</span><br><sp=
an>     EVP_MD_free(kt);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    return ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   return ret =3D=3D 1;</span><br><span> }</span><br><span> </span><br><spa=
n> EVP_MD_CTX *</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1512?usp=3Demail">change 1512</a>=
. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:/=
/gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope i=
temtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"actio=
n" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/1512?usp=3Demail"/><meta itemprop=3D=
"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
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

--1ORjPH40Pqs=--

