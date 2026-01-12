From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 12 Jan 2026 13:26:59 +0000
References: <gerrit.1768224415000.I789022af7c4977c4dff4f7671f491fe5836828fa@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <2de5e4f72213ed67b9a327c6197036822288ad89-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="K2IDI7yazno="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: cryptoapi: Avoid
 conversion warnings
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

--K2IDI7yazno=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1464?usp=3Demail

to review the following change.


Change subject: cryptoapi: Avoid conversion warnings
......................................................................

cryptoapi: Avoid conversion warnings

Due to the differences in the types of APIs
between xkey provider and Windows cryptoapi
we can't avoid the casts. And they should be
safe generally since the involved sizes should
be small compared to the maximum values. So
just add asserts and explicit cast to avoid
the warnings.

Change-Id: I789022af7c4977c4dff4f7671f491fe5836828fa
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/cryptoapi.c
1 file changed, 11 insertions(+), 16 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/64/1464/1

diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c
index b18b9d4..49f5bbb 100644
--- a/src/openvpn/cryptoapi.c
+++ b/src/openvpn/cryptoapi.c
@@ -61,7 +61,7 @@
     return 0;
 }

-#else /* HAVE_XKEY_PROVIDER */
+#else  /* HAVE_XKEY_PROVIDER */

 static XKEY_EXTERNAL_SIGN_fn xkey_cng_sign;

@@ -341,21 +341,18 @@
     return rv;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 /** Sign hash in tbs using EC key in cd and NCryptSignHash */
 static int
 xkey_cng_ec_sign(CAPI_DATA *cd, unsigned char *sig, size_t *siglen, const =
unsigned char *tbs,
                  size_t tbslen)
 {
-    DWORD len =3D *siglen;
+    ASSERT(*siglen <=3D UINT_MAX);
+    ASSERT(tbslen <=3D UINT_MAX);
+    DWORD len =3D (DWORD)*siglen;

     msg(D_LOW, "Signing using NCryptSignHash with EC key");

-    DWORD status =3D NCryptSignHash(cd->crypt_prov, NULL, (BYTE *)tbs, tbs=
len, sig, len, &len, 0);
+    DWORD status =3D NCryptSignHash(cd->crypt_prov, NULL, (BYTE *)tbs, (DW=
ORD)tbslen, sig, len, &len, 0);

     if (status !=3D ERROR_SUCCESS)
     {
@@ -383,7 +380,9 @@

     ASSERT(cd);
     ASSERT(sig);
+    ASSERT(*siglen <=3D UINT_MAX);
     ASSERT(tbs);
+    ASSERT(tbslen <=3D INT_MAX);

     DWORD status =3D ERROR_SUCCESS;
     DWORD len =3D 0;
@@ -406,10 +405,10 @@
     }
     else if (!strcmp(sigalg.padmode, "pss"))
     {
-        int saltlen =3D tbslen; /* digest size by default */
+        int saltlen =3D (int)tbslen; /* digest size by default */
         if (!strcmp(sigalg.saltlen, "max"))
         {
-            saltlen =3D xkey_max_saltlen(EVP_PKEY_bits(cd->pubkey), tbslen=
);
+            saltlen =3D xkey_max_saltlen(EVP_PKEY_bits(cd->pubkey), saltle=
n);
             if (saltlen < 0)
             {
                 msg(M_NONFATAL, "Error in cryptoapicert: invalid salt leng=
th (%d)", saltlen);
@@ -420,8 +419,8 @@
         msg(D_LOW, "Signing using NCryptSignHash with PSS padding: hashalg=
 <%s>, saltlen <%d>",
             sigalg.mdname, saltlen);

-        BCRYPT_PSS_PADDING_INFO padinfo =3D { hashalg,
-                                            (DWORD)saltlen }; /* cast is s=
afe as saltlen >=3D 0 */
+        /* cast is safe as saltlen >=3D 0 */
+        BCRYPT_PSS_PADDING_INFO padinfo =3D { hashalg, (DWORD)saltlen };
         status =3D NCryptSignHash(cd->crypt_prov, &padinfo, (BYTE *)tbs, (=
DWORD)tbslen, sig,
                                 (DWORD)*siglen, &len, BCRYPT_PAD_PSS);
     }
@@ -442,10 +441,6 @@
     return (*siglen > 0);
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 /** Dispatch sign op to xkey_cng_<rsa/ec>_sign */
 static int
 xkey_cng_sign(void *handle, unsigned char *sig, size_t *siglen, const unsi=
gned char *tbs,

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1464?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I789022af7c4977c4dff4f7671f491fe5836828fa
Gerrit-Change-Number: 1464
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--K2IDI7yazno=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1464?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">cryptoapi: Avoid conversion warnings<br><br=
>Due to the differences in the types of APIs<br>between xkey provider and W=
indows cryptoapi<br>we can&#39;t avoid the casts. And they should be<br>saf=
e generally since the involved sizes should<br>be small compared to the max=
imum values. So<br>just add asserts and explicit cast to avoid<br>the warni=
ngs.<br><br>Change-Id: I789022af7c4977c4dff4f7671f491fe5836828fa<br>Signed-=
off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/=
cryptoapi.c<br>1 file changed, 11 insertions(+), 16 deletions(-)<br><br></p=
re><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/chang=
es/64/1464/1</pre><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;"><span>diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cry=
ptoapi.c</span><br><span>index b18b9d4..49f5bbb 100644</span><br><span>--- =
a/src/openvpn/cryptoapi.c</span><br><span>+++ b/src/openvpn/cryptoapi.c</sp=
an><br><span>@@ -61,7 +61,7 @@</span><br><span>     return 0;</span><br><sp=
an> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#else /* HAVE_XKEY_PROVIDER */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#else  /* HAVE_XKEY_PROVIDER */</span><br><span> </span><br><s=
pan> static XKEY_EXTERNAL_SIGN_fn xkey_cng_sign;</span><br><span> </span><b=
r><span>@@ -341,21 +341,18 @@</span><br><span>     return rv;</span><br><sp=
an> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wconv=
ersion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /** Si=
gn hash in tbs using EC key in cd and NCryptSignHash */</span><br><span> st=
atic int</span><br><span> xkey_cng_ec_sign(CAPI_DATA *cd, unsigned char *si=
g, size_t *siglen, const unsigned char *tbs,</span><br><span>              =
    size_t tbslen)</span><br><span> {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    DWORD len =3D *siglen;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    ASSERT(*siglen &lt;=3D UINT_MAX);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(tbslen &lt;=3D UINT_MAX=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    DWORD len =3D=
 (DWORD)*siglen;</span><br><span> </span><br><span>     msg(D_LOW, &quot;Si=
gning using NCryptSignHash with EC key&quot;);</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    DWORD status =3D NCryptSignH=
ash(cd-&gt;crypt_prov, NULL, (BYTE *)tbs, tbslen, sig, len, &amp;len, 0);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    DWORD status =3D =
NCryptSignHash(cd-&gt;crypt_prov, NULL, (BYTE *)tbs, (DWORD)tbslen, sig, le=
n, &amp;len, 0);</span><br><span> </span><br><span>     if (status !=3D ERR=
OR_SUCCESS)</span><br><span>     {</span><br><span>@@ -383,7 +380,9 @@</spa=
n><br><span> </span><br><span>     ASSERT(cd);</span><br><span>     ASSERT(=
sig);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(*si=
glen &lt;=3D UINT_MAX);</span><br><span>     ASSERT(tbs);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    ASSERT(tbslen &lt;=3D INT_MAX);</=
span><br><span> </span><br><span>     DWORD status =3D ERROR_SUCCESS;</span=
><br><span>     DWORD len =3D 0;</span><br><span>@@ -406,10 +405,10 @@</spa=
n><br><span>     }</span><br><span>     else if (!strcmp(sigalg.padmode, &q=
uot;pss&quot;))</span><br><span>     {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        int saltlen =3D tbslen; /* digest size by default =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        int saltl=
en =3D (int)tbslen; /* digest size by default */</span><br><span>         i=
f (!strcmp(sigalg.saltlen, &quot;max&quot;))</span><br><span>         {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            saltlen =3D x=
key_max_saltlen(EVP_PKEY_bits(cd-&gt;pubkey), tbslen);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            saltlen =3D xkey_max_saltlen=
(EVP_PKEY_bits(cd-&gt;pubkey), saltlen);</span><br><span>             if (s=
altlen &lt; 0)</span><br><span>             {</span><br><span>             =
    msg(M_NONFATAL, &quot;Error in cryptoapicert: invalid salt length (%d)&=
quot;, saltlen);</span><br><span>@@ -420,8 +419,8 @@</span><br><span>      =
   msg(D_LOW, &quot;Signing using NCryptSignHash with PSS padding: hashalg =
&lt;%s&gt;, saltlen &lt;%d&gt;&quot;,</span><br><span>             sigalg.m=
dname, saltlen);</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        BCRYPT_PSS_PADDING_INFO padinfo =3D { hashalg,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                             =
               (DWORD)saltlen }; /* cast is safe as saltlen &gt;=3D 0 */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* cast is saf=
e as saltlen &gt;=3D 0 */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        BCRYPT_PSS_PADDING_INFO padinfo =3D { hashalg, (DWORD)saltlen=
 };</span><br><span>         status =3D NCryptSignHash(cd-&gt;crypt_prov, &=
amp;padinfo, (BYTE *)tbs, (DWORD)tbslen, sig,</span><br><span>             =
                    (DWORD)*siglen, &amp;len, BCRYPT_PAD_PSS);</span><br><s=
pan>     }</span><br><span>@@ -442,10 +441,6 @@</span><br><span>     return=
 (*siglen &gt; 0);</span><br><span> }</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang_=
_)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnos=
tic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /** Dispatc=
h sign op to xkey_cng_&lt;rsa/ec&gt;_sign */</span><br><span> static int</s=
pan><br><span> xkey_cng_sign(void *handle, unsigned char *sig, size_t *sigl=
en, const unsigned char *tbs,</span><br><span></span><br></pre><p>To view, =
visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1464?usp=3Demail">ch=
ange 1464</a>. To unsubscribe, or for help writing mail filters, visit <a h=
ref=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><di=
v itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1464?usp=3Demail"/><met=
a itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I789022af7c4977c4dff4f7671f4=
91fe5836828fa </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1464 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--K2IDI7yazno=--

