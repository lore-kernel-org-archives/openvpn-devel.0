From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 27 Jan 2026 11:16:18 +0000
References: <gerrit.1769512571000.I525a5b1b9b6f173cdf12341aefc44d58f0d43aed@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <d918051f100b12af06304c306dd5743bf35502f7-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="boUP6Sa9aDI="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: cryptoapi: Change
 signature of parse_hexstring to match code
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

--boUP6Sa9aDI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1492?usp=3Demail

to review the following change.


Change subject: cryptoapi: Change signature of parse_hexstring to match code
......................................................................

cryptoapi: Change signature of parse_hexstring to match code

parse_hexdigest is a function that is used in
exactly one place (not counting tests). So
change the types in a way that they match what
the caller actually wants (DWORD) and so we
do not have any unnecessary conversions.

Change-Id: I525a5b1b9b6f173cdf12341aefc44d58f0d43aed
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/cryptoapi.c
M tests/unit_tests/openvpn/test_cryptoapi.c
2 files changed, 6 insertions(+), 15 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/92/1492/1

diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c
index b74320d..e17936a 100644
--- a/src/openvpn/cryptoapi.c
+++ b/src/openvpn/cryptoapi.c
@@ -61,7 +61,7 @@
     return 0;
 }

-#else /* HAVE_XKEY_PROVIDER */
+#else  /* HAVE_XKEY_PROVIDER */

 static XKEY_EXTERNAL_SIGN_fn xkey_cng_sign;

@@ -145,11 +145,6 @@
     free(cd);
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
 /**
  * Parse a hex string with optional embedded spaces into
  * a byte array.
@@ -158,10 +153,10 @@
  * @param capacity  capacity of the byte array arr
  * @returns the number of bytes parsed or 0 on error
  */
-int
-parse_hexstring(const char *p, unsigned char *arr, size_t capacity)
+static DWORD
+parse_hexstring(const char *p, unsigned char *arr, DWORD capacity)
 {
-    int i =3D 0;
+    DWORD i =3D 0;
     for (; *p && i < capacity; p +=3D 2)
     {
         /* skip spaces */
@@ -182,10 +177,6 @@
     return i;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 static void *
 decode_object(struct gc_arena *gc, LPCSTR struct_type, const CRYPT_OBJID_B=
LOB *val, DWORD flags,
               DWORD *cb)
diff --git a/tests/unit_tests/openvpn/test_cryptoapi.c b/tests/unit_tests/o=
penvpn/test_cryptoapi.c
index ce527d7..59a356d 100644
--- a/tests/unit_tests/openvpn/test_cryptoapi.c
+++ b/tests/unit_tests/openvpn/test_cryptoapi.c
@@ -469,7 +469,7 @@

     for (size_t i =3D 0; i < _countof(valid_str); i++)
     {
-        int len =3D parse_hexstring(valid_str[i], hash, _countof(hash));
+        DWORD len =3D parse_hexstring(valid_str[i], hash, _countof(hash));
         assert_int_equal(len, sizeof(test_hash));
         assert_memory_equal(hash, test_hash, sizeof(test_hash));
         memset(hash, 0, _countof(hash));
@@ -477,7 +477,7 @@

     for (size_t i =3D 0; i < _countof(invalid_str); i++)
     {
-        int len =3D parse_hexstring(invalid_str[i], hash, _countof(hash));
+        DWORD len =3D parse_hexstring(invalid_str[i], hash, _countof(hash)=
);
         assert_int_equal(len, 0);
     }
 }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1492?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I525a5b1b9b6f173cdf12341aefc44d58f0d43aed
Gerrit-Change-Number: 1492
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--boUP6Sa9aDI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1492?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">cryptoapi: Change signature of parse_hexstr=
ing to match code<br><br>parse_hexdigest is a function that is used in<br>e=
xactly one place (not counting tests). So<br>change the types in a way that=
 they match what<br>the caller actually wants (DWORD) and so we<br>do not h=
ave any unnecessary conversions.<br><br>Change-Id: I525a5b1b9b6f173cdf12341=
aefc44d58f0d43aed<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&=
gt;<br>---<br>M src/openvpn/cryptoapi.c<br>M tests/unit_tests/openvpn/test_=
cryptoapi.c<br>2 files changed, 6 insertions(+), 15 deletions(-)<br><br></p=
re><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/chang=
es/92/1492/1</pre><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;"><span>diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cry=
ptoapi.c</span><br><span>index b74320d..e17936a 100644</span><br><span>--- =
a/src/openvpn/cryptoapi.c</span><br><span>+++ b/src/openvpn/cryptoapi.c</sp=
an><br><span>@@ -61,7 +61,7 @@</span><br><span>     return 0;</span><br><sp=
an> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#else /* HAVE_XKEY_PROVIDER */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#else  /* HAVE_XKEY_PROVIDER */</span><br><span> </span><br><s=
pan> static XKEY_EXTERNAL_SIGN_fn xkey_cng_sign;</span><br><span> </span><b=
r><span>@@ -145,11 +145,6 @@</span><br><span>     free(cd);</span><br><span=
> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wsign-com=
pare&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /**</spa=
n><br><span>  * Parse a hex string with optional embedded spaces into</span=
><br><span>  * a byte array.</span><br><span>@@ -158,10 +153,10 @@</span><b=
r><span>  * @param capacity  capacity of the byte array arr</span><br><span=
>  * @returns the number of bytes parsed or 0 on error</span><br><span>  */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-int</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-parse_hexstring(const char *p, unsigned=
 char *arr, size_t capacity)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+static DWORD</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+parse_hexstring(const char *p, unsigned char *arr, DWORD capacity)</span>=
<br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int i=
 =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    DWORD i =
=3D 0;</span><br><span>     for (; *p &amp;&amp; i &lt; capacity; p +=3D 2)=
</span><br><span>     {</span><br><span>         /* skip spaces */</span><b=
r><span>@@ -182,10 +177,6 @@</span><br><span>     return i;</span><br><span=
> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span> static void *</span><br><span> decode_object(=
struct gc_arena *gc, LPCSTR struct_type, const CRYPT_OBJID_BLOB *val, DWORD=
 flags,</span><br><span>               DWORD *cb)</span><br><span>diff --gi=
t a/tests/unit_tests/openvpn/test_cryptoapi.c b/tests/unit_tests/openvpn/te=
st_cryptoapi.c</span><br><span>index ce527d7..59a356d 100644</span><br><spa=
n>--- a/tests/unit_tests/openvpn/test_cryptoapi.c</span><br><span>+++ b/tes=
ts/unit_tests/openvpn/test_cryptoapi.c</span><br><span>@@ -469,7 +469,7 @@<=
/span><br><span> </span><br><span>     for (size_t i =3D 0; i &lt; _countof=
(valid_str); i++)</span><br><span>     {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        int len =3D parse_hexstring(valid_str[i], hash, =
_countof(hash));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     DWORD len =3D parse_hexstring(valid_str[i], hash, _countof(hash));</sp=
an><br><span>         assert_int_equal(len, sizeof(test_hash));</span><br><=
span>         assert_memory_equal(hash, test_hash, sizeof(test_hash));</spa=
n><br><span>         memset(hash, 0, _countof(hash));</span><br><span>@@ -4=
77,7 +477,7 @@</span><br><span> </span><br><span>     for (size_t i =3D 0; =
i &lt; _countof(invalid_str); i++)</span><br><span>     {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        int len =3D parse_hexstring(inv=
alid_str[i], hash, _countof(hash));</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        DWORD len =3D parse_hexstring(invalid_str[i], hash,=
 _countof(hash));</span><br><span>         assert_int_equal(len, 0);</span>=
<br><span>     }</span><br><span> }</span><br><span></span><br></pre><p>To =
view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1492?usp=3Dema=
il">change 1492</a>. To unsubscribe, or for help writing mail filters, visi=
t <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.<=
/p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemp=
rop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1492?usp=3Demail"=
/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I525a5b1b9b6f173cdf12341aefc=
44d58f0d43aed </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1492 </div>
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

--boUP6Sa9aDI=--

