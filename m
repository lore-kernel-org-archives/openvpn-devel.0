From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 5 Mar 2026 08:29:41 +0000
In-Reply-To: <gerrit.1769512571000.I525a5b1b9b6f173cdf12341aefc44d58f0d43aed@...2715...>
References: <gerrit.1769512571000.I525a5b1b9b6f173cdf12341aefc44d58f0d43aed@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 antonio@...2726...
Message-ID: <1562f09d13d2d7dcb28aa49beb8229b023b7296b-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="kmnbtdPRv/k="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--kmnbtdPRv/k=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#6) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1492?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by ordex


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
Acked-by: Antonio Quartulli <antonio@...2726...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1492
Message-Id: <20260304164502.15449-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
901.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/cryptoapi.c
M tests/unit_tests/openvpn/test_cryptoapi.c
2 files changed, 6 insertions(+), 15 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/92/1492/6

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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I525a5b1b9b6f173cdf12341aefc44d58f0d43aed
Gerrit-Change-Number: 1492
Gerrit-PatchSet: 6
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <antonio@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--kmnbtdPRv/k=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #6</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1492?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by ordex</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">cryptoapi: Change signature of pars=
e_hexstring to match code<br><br>parse_hexdigest is a function that is used=
 in<br>exactly one place (not counting tests). So<br>change the types in a =
way that they match what<br>the caller actually wants (DWORD) and so we<br>=
do not have any unnecessary conversions.<br><br>Change-Id: I525a5b1b9b6f173=
cdf12341aefc44d58f0d43aed<br>Signed-off-by: Frank Lichtenheld &lt;frank@...493...=
2641...&gt;<br>Acked-by: Antonio Quartulli &lt;antonio@...2726...&gt;<br>Ge=
rrit URL: https://gerrit.openvpn.net/c/openvpn/+/1492<br>Message-Id: &lt;20=
260304164502.15449-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.c=
om/openvpn-devel@lists.sourceforge.net/msg35901.html<br>Signed-off-by: Gert=
 Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/cryptoapi.c<br>M t=
ests/unit_tests/openvpn/test_cryptoapi.c<br>2 files changed, 6 insertions(+=
), 15 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn=
.net:29418/openvpn refs/changes/92/1492/6</pre><pre style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/=
cryptoapi.c b/src/openvpn/cryptoapi.c</span><br><span>index b74320d..e17936=
a 100644</span><br><span>--- a/src/openvpn/cryptoapi.c</span><br><span>+++ =
b/src/openvpn/cryptoapi.c</span><br><span>@@ -61,7 +61,7 @@</span><br><span=
>     return 0;</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#else /* HAVE_XKEY_PROVIDER */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#else  /* HAVE_XKEY_PROVIDER */<=
/span><br><span> </span><br><span> static XKEY_EXTERNAL_SIGN_fn xkey_cng_si=
gn;</span><br><span> </span><br><span>@@ -145,11 +145,6 @@</span><br><span>=
     free(cd);</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnosti=
c push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC dia=
gnostic ignored &quot;-Wsign-compare&quot;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span> /**</span><br><span>  * Parse a hex string with opt=
ional embedded spaces into</span><br><span>  * a byte array.</span><br><spa=
n>@@ -158,10 +153,10 @@</span><br><span>  * @param capacity  capacity of th=
e byte array arr</span><br><span>  * @returns the number of bytes parsed or=
 0 on error</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-parse_h=
exstring(const char *p, unsigned char *arr, size_t capacity)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+static DWORD</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+parse_hexstring(const char *p, unsigned c=
har *arr, DWORD capacity)</span><br><span> {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    int i =3D 0;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    DWORD i =3D 0;</span><br><span>     for (; *p &amp;=
&amp; i &lt; capacity; p +=3D 2)</span><br><span>     {</span><br><span>   =
      /* skip spaces */</span><br><span>@@ -182,10 +177,6 @@</span><br><spa=
n>     return i;</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnosti=
c pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static void *=
</span><br><span> decode_object(struct gc_arena *gc, LPCSTR struct_type, co=
nst CRYPT_OBJID_BLOB *val, DWORD flags,</span><br><span>               DWOR=
D *cb)</span><br><span>diff --git a/tests/unit_tests/openvpn/test_cryptoapi=
.c b/tests/unit_tests/openvpn/test_cryptoapi.c</span><br><span>index ce527d=
7..59a356d 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_crypt=
oapi.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_cryptoapi.c</spa=
n><br><span>@@ -469,7 +469,7 @@</span><br><span> </span><br><span>     for =
(size_t i =3D 0; i &lt; _countof(valid_str); i++)</span><br><span>     {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        int len =3D pars=
e_hexstring(valid_str[i], hash, _countof(hash));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        DWORD len =3D parse_hexstring(valid_st=
r[i], hash, _countof(hash));</span><br><span>         assert_int_equal(len,=
 sizeof(test_hash));</span><br><span>         assert_memory_equal(hash, tes=
t_hash, sizeof(test_hash));</span><br><span>         memset(hash, 0, _count=
of(hash));</span><br><span>@@ -477,7 +477,7 @@</span><br><span> </span><br>=
<span>     for (size_t i =3D 0; i &lt; _countof(invalid_str); i++)</span><b=
r><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 int len =3D parse_hexstring(invalid_str[i], hash, _countof(hash));</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        DWORD len =3D parse=
_hexstring(invalid_str[i], hash, _countof(hash));</span><br><span>         =
assert_int_equal(len, 0);</span><br><span>     }</span><br><span> }</span><=
br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/1492?usp=3Demail">change 1492</a>. To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/sett=
ings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema=
.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sc=
hema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/1492?usp=3Demail"/><meta itemprop=3D"name" content=3D"View C=
hange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I525a5b1b9b6f173cdf12341aefc=
44d58f0d43aed </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1492 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;antonio@...2726...&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--kmnbtdPRv/k=--

