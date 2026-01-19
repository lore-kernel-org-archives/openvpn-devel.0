From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 19 Jan 2026 11:40:38 +0000
In-Reply-To: <gerrit.1768224415000.I789022af7c4977c4dff4f7671f491fe5836828fa@...2715...>
References: <gerrit.1768224415000.I789022af7c4977c4dff4f7671f491fe5836828fa@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., selva.nair@...277...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <dfa9f06a2fae216ce8badbed3c9cead51bbbe3ae-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="pXQEqk3uLe8="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, selvanair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--pXQEqk3uLe8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1464?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+1 by cron2, Code-Review+2 by selvanair


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
Acked-by: Selva Nair <selva.nair@...277...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1464
Message-Id: <20260116135729.40545-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
304.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/cryptoapi.c
1 file changed, 11 insertions(+), 16 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/64/1464/2

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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I789022af7c4977c4dff4f7671f491fe5836828fa
Gerrit-Change-Number: 1464
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: selvanair <selva.nair@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--pXQEqk3uLe8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1464?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+1 by cron2, Code-Review+2 by selvanair</p><pre class=3D"blocks"=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;">cryptoa=
pi: Avoid conversion warnings<br><br>Due to the differences in the types of=
 APIs<br>between xkey provider and Windows cryptoapi<br>we can&#39;t avoid =
the casts. And they should be<br>safe generally since the involved sizes sh=
ould<br>be small compared to the maximum values. So<br>just add asserts and=
 explicit cast to avoid<br>the warnings.<br><br>Change-Id: I789022af7c4977c=
4dff4f7671f491fe5836828fa<br>Signed-off-by: Frank Lichtenheld &lt;frank@...493...=
2641...&gt;<br>Acked-by: Selva Nair &lt;selva.nair@...277...&gt;<br>Gerrit =
URL: https://gerrit.openvpn.net/c/openvpn/+/1464<br>Message-Id: &lt;2026011=
6135729.40545-1-frank@...2641...&gt;<br>URL: https://www.mail-archive.com/o=
penvpn-devel@lists.sourceforge.net/msg35304.html<br>Signed-off-by: Gert Doe=
ring &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/cryptoapi.c<br>1 file =
changed, 11 insertions(+), 16 deletions(-)<br><br></pre><pre class=3D"block=
s" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git p=
ull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/64/1464/2</pre><pre=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>d=
iff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c</span><br><sp=
an>index b18b9d4..49f5bbb 100644</span><br><span>--- a/src/openvpn/cryptoap=
i.c</span><br><span>+++ b/src/openvpn/cryptoapi.c</span><br><span>@@ -61,7 =
+61,7 @@</span><br><span>     return 0;</span><br><span> }</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else /* HAVE_XKEY_P=
ROVIDER */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else  /*=
 HAVE_XKEY_PROVIDER */</span><br><span> </span><br><span> static XKEY_EXTER=
NAL_SIGN_fn xkey_cng_sign;</span><br><span> </span><br><span>@@ -341,21 +34=
1,18 @@</span><br><span>     return rv;</span><br><span> }</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__=
) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span> /** Sign hash in tbs using EC =
key in cd and NCryptSignHash */</span><br><span> static int</span><br><span=
> xkey_cng_ec_sign(CAPI_DATA *cd, unsigned char *sig, size_t *siglen, const=
 unsigned char *tbs,</span><br><span>                  size_t tbslen)</span=
><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    DWOR=
D len =3D *siglen;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   ASSERT(*siglen &lt;=3D UINT_MAX);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    ASSERT(tbslen &lt;=3D UINT_MAX);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    DWORD len =3D (DWORD)*siglen;</span><=
br><span> </span><br><span>     msg(D_LOW, &quot;Signing using NCryptSignHa=
sh with EC key&quot;);</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    DWORD status =3D NCryptSignHash(cd-&gt;crypt_prov, N=
ULL, (BYTE *)tbs, tbslen, sig, len, &amp;len, 0);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    DWORD status =3D NCryptSignHash(cd-&gt;cr=
ypt_prov, NULL, (BYTE *)tbs, (DWORD)tbslen, sig, len, &amp;len, 0);</span><=
br><span> </span><br><span>     if (status !=3D ERROR_SUCCESS)</span><br><s=
pan>     {</span><br><span>@@ -383,7 +380,9 @@</span><br><span> </span><br>=
<span>     ASSERT(cd);</span><br><span>     ASSERT(sig);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    ASSERT(*siglen &lt;=3D UINT_MAX);<=
/span><br><span>     ASSERT(tbs);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    ASSERT(tbslen &lt;=3D INT_MAX);</span><br><span> </span><=
br><span>     DWORD status =3D ERROR_SUCCESS;</span><br><span>     DWORD le=
n =3D 0;</span><br><span>@@ -406,10 +405,10 @@</span><br><span>     }</span=
><br><span>     else if (!strcmp(sigalg.padmode, &quot;pss&quot;))</span><b=
r><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 int saltlen =3D tbslen; /* digest size by default */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        int saltlen =3D (int)tbslen; /* d=
igest size by default */</span><br><span>         if (!strcmp(sigalg.saltle=
n, &quot;max&quot;))</span><br><span>         {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            saltlen =3D xkey_max_saltlen(EVP_PKEY=
_bits(cd-&gt;pubkey), tbslen);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            saltlen =3D xkey_max_saltlen(EVP_PKEY_bits(cd-&gt;pu=
bkey), saltlen);</span><br><span>             if (saltlen &lt; 0)</span><br=
><span>             {</span><br><span>                 msg(M_NONFATAL, &quo=
t;Error in cryptoapicert: invalid salt length (%d)&quot;, saltlen);</span><=
br><span>@@ -420,8 +419,8 @@</span><br><span>         msg(D_LOW, &quot;Sign=
ing using NCryptSignHash with PSS padding: hashalg &lt;%s&gt;, saltlen &lt;=
%d&gt;&quot;,</span><br><span>             sigalg.mdname, saltlen);</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        BCR=
YPT_PSS_PADDING_INFO padinfo =3D { hashalg,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                                            (DWORD)sa=
ltlen }; /* cast is safe as saltlen &gt;=3D 0 */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        /* cast is safe as saltlen &gt;=3D 0 *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        BCRYPT_PSS=
_PADDING_INFO padinfo =3D { hashalg, (DWORD)saltlen };</span><br><span>    =
     status =3D NCryptSignHash(cd-&gt;crypt_prov, &amp;padinfo, (BYTE *)tbs=
, (DWORD)tbslen, sig,</span><br><span>                                 (DWO=
RD)*siglen, &amp;len, BCRYPT_PAD_PSS);</span><br><span>     }</span><br><sp=
an>@@ -442,10 +441,6 @@</span><br><span>     return (*siglen &gt; 0);</span=
><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span> /** Dispatch sign op to xkey_cng_&l=
t;rsa/ec&gt;_sign */</span><br><span> static int</span><br><span> xkey_cng_=
sign(void *handle, unsigned char *sig, size_t *siglen, const unsigned char =
*tbs,</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://=
gerrit.openvpn.net/c/openvpn/+/1464?usp=3Demail">change 1464</a>. To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit.ope=
nvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"=
http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1464?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I789022af7c4977c4dff4f7671f4=
91fe5836828fa </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1464 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: selvanair &lt;selva.nair@...1665...=
77...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--pXQEqk3uLe8=--

