From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 12 Mar 2026 16:20:47 +0000
In-Reply-To: <gerrit.1677175662000.I1292894fe7f537049a97bee97af4419e5e854a00@...2715...>
References: <gerrit.1677175662000.I1292894fe7f537049a97bee97af4419e5e854a00@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 max@...2606...
Message-ID: <ddc934a1d13096306cb3df121c67355be6d3c254-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="eE2fGRYyu6c="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Add siphash
 reference implementation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: MaxF <max@...2606...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--eE2fGRYyu6c=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/29=
?usp=3Demail )

Change subject: Add siphash reference implementation
......................................................................

Add siphash reference implementation

OpenSSL only supports SIPHASH with OpenSSL 3.1 and newer. The source code of
siphash is quite small and has very liberal CC0 license, so include it inst=
ead
of pulling an extra library for it.

Change-Id: I1292894fe7f537049a97bee97af4419e5e854a00
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: MaxF <max@...2606...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/29
Message-Id: <20260312153329.4700-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36=
072.html
Signed-off-by: Gert Doering <gert@...1296...>
---
A src/openvpn/siphash.h
A src/openvpn/siphash_reference.c
2 files changed, 253 insertions(+), 0 deletions(-)




diff --git a/src/openvpn/siphash.h b/src/openvpn/siphash.h
new file mode 100644
index 0000000..ef61110
--- /dev/null
+++ b/src/openvpn/siphash.h
@@ -0,0 +1,29 @@
+/*
+ * SipHash reference C implementation
+ *
+ * Copyright (c) 2012-2021 Jean-Philippe Aumasson
+ * <jeanphilippe.aumasson@...277...>
+ * Copyright (c) 2012-2014 Daniel J. Bernstein <djb@...2717...>
+ *
+ * To the extent possible under law, the author(s) have dedicated all copy=
right
+ * and related and neighboring rights to this software to the public domain
+ * worldwide. This software is distributed without any warranty.
+ *
+ * You should have received a copy of the CC0 Public Domain Dedication alo=
ng
+ * with
+ * this software. If not, see
+ * <http://creativecommons.org/publicdomain/zero/1.0/>.
+ */
+
+#ifndef SIPHASH_H
+#define SIPHASH_H
+
+#include <inttypes.h>
+
+/* siphash always uses 128-bit keys */
+#define SIPHASH_KEY_SIZE 16
+
+int siphash(const void *in, size_t inlen, const void *k, uint8_t *out,
+            size_t outlen);
+
+#endif
diff --git a/src/openvpn/siphash_reference.c b/src/openvpn/siphash_referenc=
e.c
new file mode 100644
index 0000000..b21a86e
--- /dev/null
+++ b/src/openvpn/siphash_reference.c
@@ -0,0 +1,224 @@
+/*
+ * SipHash reference C implementation
+ *
+ * Copyright 2012-2024 JP Aumasson
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software=
"),
+ * to deal in the Software without restriction, including without limitati=
on
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included=
 in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
+ * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABIL=
ITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL=
 THE
+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEA=
LINGS
+ * IN THE SOFTWARE.
+ *
+ */
+
+/* Note:  the reference implementation is also available under CC0 license
+ * (dual licensed) we included the MIT license here since it is shorter */
+
+#include "siphash.h"
+#include <assert.h>
+#include <stddef.h>
+#include <stdint.h>
+
+/* default: SipHash-2-4 */
+#ifndef cROUNDS
+#define cROUNDS 2
+#endif
+#ifndef dROUNDS
+#define dROUNDS 4
+#endif
+
+#define ROTL(x, b) (uint64_t)(((x) << (b)) | ((x) >> (64 - (b))))
+
+#define U32TO8_LE(p, v)            \
+    (p)[0] =3D (uint8_t)((v));       \
+    (p)[1] =3D (uint8_t)((v) >> 8);  \
+    (p)[2] =3D (uint8_t)((v) >> 16); \
+    (p)[3] =3D (uint8_t)((v) >> 24);
+
+#define U64TO8_LE(p, v)              \
+    U32TO8_LE((p), (uint32_t)((v))); \
+    U32TO8_LE((p) + 4, (uint32_t)((v) >> 32));
+
+#define U8TO64_LE(p)                                           \
+    (((uint64_t)((p)[0])) | ((uint64_t)((p)[1]) << 8)          \
+     | ((uint64_t)((p)[2]) << 16) | ((uint64_t)((p)[3]) << 24) \
+     | ((uint64_t)((p)[4]) << 32) | ((uint64_t)((p)[5]) << 40) \
+     | ((uint64_t)((p)[6]) << 48) | ((uint64_t)((p)[7]) << 56))
+
+#define SIPROUND           \
+    do                     \
+    {                      \
+        v0 +=3D v1;          \
+        v1 =3D ROTL(v1, 13); \
+        v1 ^=3D v0;          \
+        v0 =3D ROTL(v0, 32); \
+        v2 +=3D v3;          \
+        v3 =3D ROTL(v3, 16); \
+        v3 ^=3D v2;          \
+        v0 +=3D v3;          \
+        v3 =3D ROTL(v3, 21); \
+        v3 ^=3D v0;          \
+        v2 +=3D v1;          \
+        v1 =3D ROTL(v1, 17); \
+        v1 ^=3D v2;          \
+        v2 =3D ROTL(v2, 32); \
+    } while (0)
+
+#ifdef DEBUG_SIPHASH
+#include <stdio.h>
+
+#define TRACE                                            \
+    do                                                   \
+    {                                                    \
+        printf("(%3zu) v0 %016" PRIx64 "\n", inlen, v0); \
+        printf("(%3zu) v1 %016" PRIx64 "\n", inlen, v1); \
+        printf("(%3zu) v2 %016" PRIx64 "\n", inlen, v2); \
+        printf("(%3zu) v3 %016" PRIx64 "\n", inlen, v3); \
+    } while (0)
+#else /* ifdef DEBUG_SIPHASH */
+#define TRACE
+#endif
+
+/*
+ *  Computes a SipHash value
+ * in: pointer to input data (read-only)
+ *  inlen: input data length in bytes (any size_t value)
+ * k: pointer to the key data (read-only), must be 16 bytes
+ * out: pointer to output data (write-only), outlen bytes must be allocated
+ *  outlen: length of the output in bytes, must be 8 or 16
+ */
+int
+siphash(const void *in, const size_t inlen, const void *k, uint8_t *out,
+        const size_t outlen)
+{
+    const unsigned char *ni =3D (const unsigned char *)in;
+    const unsigned char *kk =3D (const unsigned char *)k;
+
+    assert((outlen =3D=3D 8) || (outlen =3D=3D 16));
+    uint64_t v0 =3D UINT64_C(0x736f6d6570736575);
+    uint64_t v1 =3D UINT64_C(0x646f72616e646f6d);
+    uint64_t v2 =3D UINT64_C(0x6c7967656e657261);
+    uint64_t v3 =3D UINT64_C(0x7465646279746573);
+    uint64_t k0 =3D U8TO64_LE(kk);
+    uint64_t k1 =3D U8TO64_LE(kk + 8);
+    uint64_t m;
+    int i;
+    const unsigned char *end =3D ni + inlen - (inlen % sizeof(uint64_t));
+    const int left =3D inlen & 7;
+    uint64_t b =3D ((uint64_t)inlen) << 56;
+    v3 ^=3D k1;
+    v2 ^=3D k0;
+    v1 ^=3D k1;
+    v0 ^=3D k0;
+
+    if (outlen =3D=3D 16)
+    {
+        v1 ^=3D 0xee;
+    }
+
+    for (; ni !=3D end; ni +=3D 8)
+    {
+        m =3D U8TO64_LE(ni);
+        v3 ^=3D m;
+
+        TRACE;
+        for (i =3D 0; i < cROUNDS; ++i)
+        {
+            SIPROUND;
+        }
+
+        v0 ^=3D m;
+    }
+
+    switch (left)
+    {
+        case 7:
+            b |=3D ((uint64_t)ni[6]) << 48;
+
+        /* FALLTHRU */
+        case 6:
+            b |=3D ((uint64_t)ni[5]) << 40;
+
+        /* FALLTHRU */
+        case 5:
+            b |=3D ((uint64_t)ni[4]) << 32;
+
+        /* FALLTHRU */
+        case 4:
+            b |=3D ((uint64_t)ni[3]) << 24;
+
+        /* FALLTHRU */
+        case 3:
+            b |=3D ((uint64_t)ni[2]) << 16;
+
+        /* FALLTHRU */
+        case 2:
+            b |=3D ((uint64_t)ni[1]) << 8;
+
+        /* FALLTHRU */
+        case 1:
+            b |=3D ((uint64_t)ni[0]);
+            break;
+
+        case 0:
+            break;
+    }
+
+    v3 ^=3D b;
+
+    TRACE;
+    for (i =3D 0; i < cROUNDS; ++i)
+    {
+        SIPROUND;
+    }
+
+    v0 ^=3D b;
+
+    if (outlen =3D=3D 16)
+    {
+        v2 ^=3D 0xee;
+    }
+    else
+    {
+        v2 ^=3D 0xff;
+    }
+
+    TRACE;
+    for (i =3D 0; i < dROUNDS; ++i)
+    {
+        SIPROUND;
+    }
+
+    b =3D v0 ^ v1 ^ v2 ^ v3;
+    U64TO8_LE(out, b);
+
+    if (outlen =3D=3D 8)
+    {
+        return 0;
+    }
+
+    v1 ^=3D 0xdd;
+
+    TRACE;
+    for (i =3D 0; i < dROUNDS; ++i)
+    {
+        SIPROUND;
+    }
+
+    b =3D v0 ^ v1 ^ v2 ^ v3;
+    U64TO8_LE(out + 8, b);
+
+    return 0;
+}

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/29?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1292894fe7f537049a97bee97af4419e5e854a00
Gerrit-Change-Number: 29
Gerrit-PatchSet: 10
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--eE2fGRYyu6c=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/29?usp=3Demail">View Change</a></p><div style=3D"white-space:pre-w=
rap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;">Add siphash reference implementation<br><br>OpenSS=
L only supports SIPHASH with OpenSSL 3.1 and newer. The source code of<br>s=
iphash is quite small and has very liberal CC0 license, so include it inste=
ad<br>of pulling an extra library for it.<br><br>Change-Id: I1292894fe7f537=
049a97bee97af4419e5e854a00<br>Signed-off-by: Arne Schwabe &lt;arne@...2639...=
..&gt;<br>Acked-by: MaxF &lt;max@...2606...&gt;<br>Gerrit URL: https://gerr=
it.openvpn.net/c/openvpn/+/29<br>Message-Id: &lt;20260312153329.4700-1-gert=
@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1466...=
urceforge.net/msg36072.html<br>Signed-off-by: Gert Doering &lt;gert@...1726...=
...&gt;<br>---<br>A src/openvpn/siphash.h<br>A src/openvpn/siphash_referenc=
e.c<br>2 files changed, 253 insertions(+), 0 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/siphash.h b/src/openvpn/siphash.h</span><br><sp=
an>new file mode 100644</span><br><span>index 0000000..ef61110</span><br><s=
pan>--- /dev/null</span><br><span>+++ b/src/openvpn/siphash.h</span><br><sp=
an>@@ -0,0 +1,29 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * SipHash refere=
nce C implementation</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Copyright (c)=
 2012-2021 Jean-Philippe Aumasson</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * &lt;jeanphilippe.aumasson@...277...&gt;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * Copyright (c) 2012-2014 Daniel J. B=
ernstein &lt;djb@...2717...&gt;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * To=
 the extent possible under law, the author(s) have dedicated all copyright<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * and related and n=
eighboring rights to this software to the public domain</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * worldwide. This software is distribu=
ted without any warranty.</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * You shou=
ld have received a copy of the CC0 Public Domain Dedication along</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * with</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * this software. If not, see</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * &lt;http://creativecommons.o=
rg/publicdomain/zero/1.0/&gt;.</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef SIPHASH_H</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#define SIPHASH_H</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#include &lt;inttypes.h&gt;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+/* siphash always uses 128-bit keys */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#define SIPHASH_KEY_SIZE 16</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+int siphash(const void *in, size_t inlen, const vo=
id *k, uint8_t *out,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            size_t outlen);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</sp=
an><br><span>diff --git a/src/openvpn/siphash_reference.c b/src/openvpn/sip=
hash_reference.c</span><br><span>new file mode 100644</span><br><span>index=
 0000000..b21a86e</span><br><span>--- /dev/null</span><br><span>+++ b/src/o=
penvpn/siphash_reference.c</span><br><span>@@ -0,0 +1,224 @@</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * SipHash reference C implementation</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * Copyright 2012-2024 JP Aumasson</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * Permission is hereby granted, free of charge, to =
any person obtaining a</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * copy of this software and associated documentation files (the &quot;S=
oftware&quot;),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * t=
o deal in the Software without restriction, including without limitation</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the rights to use, =
copy, modify, merge, publish, distribute, sublicense,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * and/or sell copies of the Software, an=
d to permit persons to whom the</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * Software is furnished to do so, subject to the following con=
ditions:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * The above copyright notic=
e and this permission notice shall be included in</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * all copies or substantial portions of the =
Software.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * THE SOFTWARE IS PROVIDED=
 &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIND, EXPRESS</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * OR IMPLIED, INCLUDING BUT NOT LIMI=
TED TO THE WARRANTIES OF MERCHANTABILITY,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEME=
NT. IN NO EVENT SHALL THE</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR O=
THER</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * LIABILITY, W=
HETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * FROM, OUT OF OR IN CONNECTION WI=
TH THE SOFTWARE OR THE USE OR OTHER DEALINGS</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * IN THE SOFTWARE.</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/* Note:  the reference imp=
lementation is also available under CC0 license</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * (dual licensed) we included the MIT license =
here since it is shorter */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &q=
uot;siphash.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#include &lt;assert.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#include &lt;stddef.h&gt;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#include &lt;stdint.h&gt;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/=
* default: SipHash-2-4 */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#ifndef cROUNDS</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#define cROUNDS 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef dROUN=
DS</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define dROUNDS 4=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#define ROTL(x, b) (uint64_t)(((x) &lt;&lt; (b)) | =
((x) &gt;&gt; (64 - (b))))</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define U32T=
O8_LE(p, v)            \</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    (p)[0] =3D (uint8_t)((v));       \</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    (p)[1] =3D (uint8_t)((v) &gt;&gt; 8);  \</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    (p)[2] =3D (uint8_t)((=
v) &gt;&gt; 16); \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   (p)[3] =3D (uint8_t)((v) &gt;&gt; 24);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#define U64TO8_LE(p, v)              \</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    U32TO8_LE((p), (uint32_t)((v))); \</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    U32TO8_LE((p) + 4, (uint32_t)(=
(v) &gt;&gt; 32));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define U8TO64_LE(p)=
                                           \</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    (((uint64_t)((p)[0])) | ((uint64_t)((p)[1]) &l=
t;&lt; 8)          \</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+     | ((uint64_t)((p)[2]) &lt;&lt; 16) | ((uint64_t)((p)[3]) &lt;&lt; 24)=
 \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     | ((uint64_t=
)((p)[4]) &lt;&lt; 32) | ((uint64_t)((p)[5]) &lt;&lt; 40) \</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+     | ((uint64_t)((p)[6]) &lt;&lt;=
 48) | ((uint64_t)((p)[7]) &lt;&lt; 56))</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#define SIPROUND           \</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    do                     \</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {                      \</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        v0 +=3D v1;          \</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        v1 =3D ROTL(v1, 13); \</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        v1 ^=3D v0;     =
     \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        v0 =
=3D ROTL(v0, 32); \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        v2 +=3D v3;          \</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        v3 =3D ROTL(v3, 16); \</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        v3 ^=3D v2;          \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        v0 +=3D v3;          \</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        v3 =3D ROTL(v3, 21); \=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        v3 ^=3D v0;=
          \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
v2 +=3D v1;          \</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        v1 =3D ROTL(v1, 17); \</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        v1 ^=3D v2;          \</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        v2 =3D ROTL(v2, 32); \</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    } while (0)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#ifdef DEBUG_SIPHASH</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#include &lt;stdio.h&gt;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#define TRACE                                            \</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    do                            =
                       \</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {                                                    \</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        printf(&quot;(%3zu) v0 =
%016&quot; PRIx64 &quot;\n&quot;, inlen, v0); \</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        printf(&quot;(%3zu) v1 %016&quot; PRIx6=
4 &quot;\n&quot;, inlen, v1); \</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        printf(&quot;(%3zu) v2 %016&quot; PRIx64 &quot;\n&quot;=
, inlen, v2); \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    printf(&quot;(%3zu) v3 %016&quot; PRIx64 &quot;\n&quot;, inlen, v3); \<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    } while (0)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#else /* ifdef DEBUG_SIP=
HASH */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define TRAC=
E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *  Computes a SipHash value</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * in: pointer to input data (read-only)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *  inlen: input data length in bytes=
 (any size_t value)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * k: pointer to the key data (read-only), must be 16 bytes</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * out: pointer to output data (wri=
te-only), outlen bytes must be allocated</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *  outlen: length of the output in bytes, must be 8 o=
r 16</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+siphash(const void *in, const size_t inlen, con=
st void *k, uint8_t *out,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        const size_t outlen)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 const unsigned char *ni =3D (const unsigned char *)in;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    const unsigned char *kk =3D (const =
unsigned char *)k;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert((outlen =
=3D=3D 8) || (outlen =3D=3D 16));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    uint64_t v0 =3D UINT64_C(0x736f6d6570736575);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    uint64_t v1 =3D UINT64_C(0x=
646f72616e646f6d);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   uint64_t v2 =3D UINT64_C(0x6c7967656e657261);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    uint64_t v3 =3D UINT64_C(0x746564627974657=
3);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint64_t k0 =
=3D U8TO64_LE(kk);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   uint64_t k1 =3D U8TO64_LE(kk + 8);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    uint64_t m;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    int i;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    const unsigned char *end =3D ni + inlen - (inlen % sizeof(uint64_t=
));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const int le=
ft =3D inlen &amp; 7;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    uint64_t b =3D ((uint64_t)inlen) &lt;&lt; 56;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    v3 ^=3D k1;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    v2 ^=3D k0;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    v1 ^=3D k1;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    v0 ^=3D k0;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (outlen =3D=3D 16)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        v=
1 ^=3D 0xee;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    for (; ni !=3D end; ni +=3D 8)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        m =3D U8TO64_LE(ni);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        v3 ^=3D m;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        TRACE;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        for (i =3D 0; i &lt; cROUNDS; ++i)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            SIPROUND;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        v0 ^=3D m;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    switch (left)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        case 7:</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            b |=3D ((uint64_t)ni[6]) &lt;&lt;=
 48;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        /* FALLTHRU */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        case 6:</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            b |=3D ((uint64_t)ni[5]=
) &lt;&lt; 40;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* FALLTHRU */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        case 5:</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            b |=3D ((uint=
64_t)ni[4]) &lt;&lt; 32;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* FAL=
LTHRU */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cas=
e 4:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            b |=
=3D ((uint64_t)ni[3]) &lt;&lt; 24;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    /* FALLTHRU */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       case 3:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       b |=3D ((uint64_t)ni[2]) &lt;&lt; 16;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        /* FALLTHRU */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        case 2:</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            b |=3D ((uint64_t)ni[1]) &lt;&lt; 8;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        /* FALLTHRU */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        case 1:</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            b |=3D ((uint64_t)ni[0]);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            break;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        case 0:</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            break;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    v3 ^=3D b;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    TRACE;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    for (i =3D 0; i &lt; cROUNDS; ++i)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        SIPROUND;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    v0 ^=3D=
 b;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (outlen =3D=3D 16)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        v2 ^=3D 0xee;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     v2 ^=3D 0xff;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    TRACE;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    for (i =3D 0; i &lt; dROUNDS; ++i)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        SIPROUND;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    b =3D v0 ^ v1 ^ v2 ^ v3;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    U64TO8_LE(out, b);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (outlen =3D=3D 8)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retu=
rn 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    v1 ^=3D 0xdd;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    TRACE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  for (i =3D 0; i &lt; dROUNDS; ++i)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        SIPROUND;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    b =3D v0 ^ v1 ^ v2 ^ v3;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    U64TO8_LE(out + 8, =
b);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    return 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span></span><br></pre><p>To =
view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/29?usp=3Demail=
">change 29</a>. To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><=
div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/29?usp=3Demail"/><me=
ta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1292894fe7f537049a97bee97af=
4419e5e854a00 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 29 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 10 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: MaxF &lt;max@...2606...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--eE2fGRYyu6c=--

