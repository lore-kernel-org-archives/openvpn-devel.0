From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 16 Feb 2026 15:50:01 +0000
In-Reply-To: <gerrit.1769512571000.I525a5b1b9b6f173cdf12341aefc44d58f0d43aed@...2715...>
References: <gerrit.1769512571000.I525a5b1b9b6f173cdf12341aefc44d58f0d43aed@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, antonio@...2726...
Message-ID: <d9174d9be8b2153ec946617e1e0a1bf1751fa099-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7V9EgSbao6k="; charset=UTF-8
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

--7V9EgSbao6k=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello ordex, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1492?usp=3Demail

to look at the new patch set (#5).

The change is no longer submittable: checks~ChecksSubmitRule is unsatisfied=
 now.


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/92/1492/5

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
=20
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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I525a5b1b9b6f173cdf12341aefc44d58f0d43aed
Gerrit-Change-Number: 1492
Gerrit-PatchSet: 5
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <antonio@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--7V9EgSbao6k=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #5</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1492?usp=3Demail">View C=
hange</a></p><p>The change is no longer submittable: checks~ChecksSubmitRul=
e is unsatisfied now.</p><pre class=3D"blocks" style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;">cryptoapi: Change signature of parse=
_hexstring to match code<br><br>parse_hexdigest is a function that is used =
in<br>exactly one place (not counting tests). So<br>change the types in a w=
ay that they match what<br>the caller actually wants (DWORD) and so we<br>d=
o not have any unnecessary conversions.<br><br>Change-Id: I525a5b1b9b6f173c=
df12341aefc44d58f0d43aed<br>Signed-off-by: Frank Lichtenheld &lt;frank@...1665...=
641...&gt;<br>---<br>M src/openvpn/cryptoapi.c<br>M tests/unit_tests/openvp=
n/test_cryptoapi.c<br>2 files changed, 6 insertions(+), 15 deletions(-)<br>=
<br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn ref=
s/changes/92/1492/5</pre><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;"><span>diff --git a/src/openvpn/cryptoapi.c b/src/open=
vpn/cryptoapi.c</span><br><span>index b74320d..e17936a 100644</span><br><sp=
an>--- a/src/openvpn/cryptoapi.c</span><br><span>+++ b/src/openvpn/cryptoap=
i.c</span><br><span>@@ -61,7 +61,7 @@</span><br><span>     return 0;</span>=
<br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#else /* HAVE_XKEY_PROVIDER */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#else  /* HAVE_XKEY_PROVIDER */</span><br><span> </span=
><br><span> static XKEY_EXTERNAL_SIGN_fn xkey_cng_sign;</span><br><span> </=
span><br><span>@@ -145,11 +145,6 @@</span><br><span>     free(cd);</span><b=
r><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Ws=
ign-compare&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#end=
if</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /=
**</span><br><span>  * Parse a hex string with optional embedded spaces int=
o</span><br><span>  * a byte array.</span><br><span>@@ -158,10 +153,10 @@</=
span><br><span>  * @param capacity  capacity of the byte array arr</span><b=
r><span>  * @returns the number of bytes parsed or 0 on error</span><br><sp=
an>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-int</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-parse_hexstring(const char *p, u=
nsigned char *arr, size_t capacity)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+static DWORD</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+parse_hexstring(const char *p, unsigned char *arr, DWORD capacity)=
</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  int i =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    D=
WORD i =3D 0;</span><br><span>     for (; *p &amp;&amp; i &lt; capacity; p =
+=3D 2)</span><br><span>     {</span><br><span>         /* skip spaces */</=
span><br><span>@@ -182,10 +177,6 @@</span><br><span>     return i;</span><b=
r><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span> static void *</span><br><span> decode_=
object(struct gc_arena *gc, LPCSTR struct_type, const CRYPT_OBJID_BLOB *val=
, DWORD flags,</span><br><span>               DWORD *cb)</span><br><span>di=
ff --git a/tests/unit_tests/openvpn/test_cryptoapi.c b/tests/unit_tests/ope=
nvpn/test_cryptoapi.c</span><br><span>index ce527d7..59a356d 100644</span><=
br><span>--- a/tests/unit_tests/openvpn/test_cryptoapi.c</span><br><span>++=
+ b/tests/unit_tests/openvpn/test_cryptoapi.c</span><br><span>@@ -469,7 +46=
9,7 @@</span><br><span> </span><br><span>     for (size_t i =3D 0; i &lt; _=
countof(valid_str); i++)</span><br><span>     {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        int len =3D parse_hexstring(valid_str[i],=
 hash, _countof(hash));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        DWORD len =3D parse_hexstring(valid_str[i], hash, _countof(hash=
));</span><br><span>         assert_int_equal(len, sizeof(test_hash));</spa=
n><br><span>         assert_memory_equal(hash, test_hash, sizeof(test_hash)=
);</span><br><span>         memset(hash, 0, _countof(hash));</span><br><spa=
n>@@ -477,7 +477,7 @@</span><br><span> </span><br><span>     for (size_t i =
=3D 0; i &lt; _countof(invalid_str); i++)</span><br><span>     {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        int len =3D parse_hexstr=
ing(invalid_str[i], hash, _countof(hash));</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        DWORD len =3D parse_hexstring(invalid_str[i]=
, hash, _countof(hash));</span><br><span>         assert_int_equal(len, 0);=
</span><br><span>     }</span><br><span> }</span><br><span></span><br></pre=
><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1492?us=
p=3Demail">change 1492</a>. To unsubscribe, or for help writing mail filter=
s, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">setting=
s</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><lin=
k itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1492?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I525a5b1b9b6f173cdf12341aefc=
44d58f0d43aed </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1492 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;antonio@...2726...&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--7V9EgSbao6k=--

