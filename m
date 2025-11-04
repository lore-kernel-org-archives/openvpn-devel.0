From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 4 Nov 2025 08:20:01 +0000
In-Reply-To: <gerrit.1762213799000.I61e4968f2e83d12d4d3fc3ccba92a06eb5ed5866@...2715...>
References: <gerrit.1762213799000.I61e4968f2e83d12d4d3fc3ccba92a06eb5ed5866@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 antonio@...2726...
Message-ID: <dc0a1d1197ca661810f3b48bfe55a09a775f5ff4-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="eS1nXCt88R4="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: unit_tests: prefer
 proper cmocka assert helpers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--eS1nXCt88R4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/13=
45?usp=3Demail )

Change subject: unit_tests: prefer proper cmocka assert helpers
......................................................................

unit_tests: prefer proper cmocka assert helpers

We have agreed to never use the plain assert()
anywhere in the code.

Unit tests are almost there as they always use
cmocka provided assert helpers, except for two cases.
Convert those two to cmocka assert calls too.

While at it also ensure that the proper bool helpers
are used rather than checking _int_equal against true/false.

Drop assert.h in cryptoapi.c as well as it's not needed
anymore.

GitHub: Closes OpenVPN/openvpn#894
Change-Id: I61e4968f2e83d12d4d3fc3ccba92a06eb5ed5866
Signed-off-by: Antonio Quartulli <antonio@...2726...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1345
Message-Id: <20251104081653.3368-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
179.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/cryptoapi.c
M tests/unit_tests/openvpn/test_buffer.c
M tests/unit_tests/openvpn/test_cryptoapi.c
M tests/unit_tests/openvpn/test_misc.c
M tests/unit_tests/openvpn/test_pkcs11.c
5 files changed, 14 insertions(+), 15 deletions(-)




diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c
index bba6ed2..b18b9d4 100644
--- a/src/openvpn/cryptoapi.c
+++ b/src/openvpn/cryptoapi.c
@@ -45,7 +45,6 @@
 #include <ncrypt.h>
 #include <stdio.h>
 #include <ctype.h>
-#include <assert.h>

 #include "buffer.h"
 #include "openssl_compat.h"
diff --git a/tests/unit_tests/openvpn/test_buffer.c b/tests/unit_tests/open=
vpn/test_buffer.c
index 92c4c65..25a8def 100644
--- a/tests/unit_tests/openvpn/test_buffer.c
+++ b/tests/unit_tests/openvpn/test_buffer.c
@@ -463,38 +463,38 @@
     const char test1[] =3D A_TIMES_256 "EOL\n" A_TIMES_256 "EOF";

     /* line buffer bigger than actual line */
-    assert_int_equal(buf_write(&buf, test1, sizeof(test1)), true);
+    assert_true(buf_write(&buf, test1, sizeof(test1)));
     status =3D buf_parse(&buf, '\n', line, sizeof(line));
-    assert_int_equal(status, true);
+    assert_true(status);
     assert_string_equal(line, A_TIMES_256 "EOL");
     status =3D buf_parse(&buf, '\n', line, sizeof(line));
-    assert_int_equal(status, true);
+    assert_true(status);
     assert_string_equal(line, A_TIMES_256 "EOF");

     /* line buffer exactly same size as actual line + terminating \0 */
     buf_reset_len(&buf);
-    assert_int_equal(buf_write(&buf, test1, sizeof(test1)), true);
+    assert_true(buf_write(&buf, test1, sizeof(test1)));
     status =3D buf_parse(&buf, '\n', line, 260);
-    assert_int_equal(status, true);
+    assert_true(status);
     assert_string_equal(line, A_TIMES_256 "EOL");
     status =3D buf_parse(&buf, '\n', line, 260);
-    assert_int_equal(status, true);
+    assert_true(status);
     assert_string_equal(line, A_TIMES_256 "EOF");

     /* line buffer smaller than actual line */
     buf_reset_len(&buf);
-    assert_int_equal(buf_write(&buf, test1, sizeof(test1)), true);
+    assert_true(buf_write(&buf, test1, sizeof(test1)));
     status =3D buf_parse(&buf, '\n', line, 257);
-    assert_int_equal(status, true);
+    assert_true(status);
     assert_string_equal(line, A_TIMES_256);
     status =3D buf_parse(&buf, '\n', line, 257);
-    assert_int_equal(status, true);
+    assert_true(status);
     assert_string_equal(line, "EOL");
     status =3D buf_parse(&buf, '\n', line, 257);
-    assert_int_equal(status, true);
+    assert_true(status);
     assert_string_equal(line, A_TIMES_256);
     status =3D buf_parse(&buf, '\n', line, 257);
-    assert_int_equal(status, true);
+    assert_true(status);
     assert_string_equal(line, "EOF");

     gc_free(&gc);
diff --git a/tests/unit_tests/openvpn/test_cryptoapi.c b/tests/unit_tests/o=
penvpn/test_cryptoapi.c
index 6e83465..2edfba9b 100644
--- a/tests/unit_tests/openvpn/test_cryptoapi.c
+++ b/tests/unit_tests/openvpn/test_cryptoapi.c
@@ -121,7 +121,7 @@
         { cert4, key4, cname4, "OVPN TEST CA2", "OVPN Test Cert 4", hash4,=
 0 },
         { 0 }
     };
-    assert(sizeof(certs_local) =3D=3D sizeof(certs));
+    assert_int_equal(sizeof(certs_local), sizeof(certs));
     memcpy(certs, certs_local, sizeof(certs_local));
 }

diff --git a/tests/unit_tests/openvpn/test_misc.c b/tests/unit_tests/openvp=
n/test_misc.c
index 10bed1d..954794e 100644
--- a/tests/unit_tests/openvpn/test_misc.c
+++ b/tests/unit_tests/openvpn/test_misc.c
@@ -101,7 +101,7 @@
     const char *msg =3D parse_auth_failed_temp(&o, teststr);
     assert_string_equal(msg, "");
     assert_int_equal(o.server_backoff_time, 42);
-    assert_int_equal(o.no_advance, true);
+    assert_true(o.no_advance);
 }

 static void
diff --git a/tests/unit_tests/openvpn/test_pkcs11.c b/tests/unit_tests/open=
vpn/test_pkcs11.c
index 01cbf96..81d2280 100644
--- a/tests/unit_tests/openvpn/test_pkcs11.c
+++ b/tests/unit_tests/openvpn/test_pkcs11.c
@@ -148,7 +148,7 @@
         { cert4, key4, cname4, "OVPN TEST CA2", "OVPN Test Cert 4", { 0 },=
 NULL },
         { 0 }
     };
-    assert(sizeof(certs_local) =3D=3D sizeof(certs));
+    assert_int_equal(sizeof(certs_local), sizeof(certs));
     memcpy(certs, certs_local, sizeof(certs_local));
 }


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1345?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I61e4968f2e83d12d4d3fc3ccba92a06eb5ed5866
Gerrit-Change-Number: 1345
Gerrit-PatchSet: 2
Gerrit-Owner: ordex <antonio@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--eS1nXCt88R4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1345?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">unit_tests: prefer proper cmocka assert helpers<=
br><br>We have agreed to never use the plain assert()<br>anywhere in the co=
de.<br><br>Unit tests are almost there as they always use<br>cmocka provide=
d assert helpers, except for two cases.<br>Convert those two to cmocka asse=
rt calls too.<br><br>While at it also ensure that the proper bool helpers<b=
r>are used rather than checking _int_equal against true/false.<br><br>Drop =
assert.h in cryptoapi.c as well as it&#39;s not needed<br>anymore.<br><br>G=
itHub: Closes OpenVPN/openvpn#894<br>Change-Id: I61e4968f2e83d12d4d3fc3ccba=
92a06eb5ed5866<br>Signed-off-by: Antonio Quartulli &lt;antonio@...2726...&g=
t;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: https:/=
/gerrit.openvpn.net/c/openvpn/+/1345<br>Message-Id: &lt;20251104081653.3368=
-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...465...=
ists.sourceforge.net/msg34179.html<br>Signed-off-by: Gert Doering &lt;gert@=
...1296...&gt;<br>---<br>M src/openvpn/cryptoapi.c<br>M tests/unit_tests/op=
envpn/test_buffer.c<br>M tests/unit_tests/openvpn/test_cryptoapi.c<br>M tes=
ts/unit_tests/openvpn/test_misc.c<br>M tests/unit_tests/openvpn/test_pkcs11=
.c<br>5 files changed, 14 insertions(+), 15 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c</span><br=
><span>index bba6ed2..b18b9d4 100644</span><br><span>--- a/src/openvpn/cryp=
toapi.c</span><br><span>+++ b/src/openvpn/cryptoapi.c</span><br><span>@@ -4=
5,7 +45,6 @@</span><br><span> #include &lt;ncrypt.h&gt;</span><br><span> #i=
nclude &lt;stdio.h&gt;</span><br><span> #include &lt;ctype.h&gt;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#include &lt;assert.h&gt;</span>=
<br><span> </span><br><span> #include &quot;buffer.h&quot;</span><br><span>=
 #include &quot;openssl_compat.h&quot;</span><br><span>diff --git a/tests/u=
nit_tests/openvpn/test_buffer.c b/tests/unit_tests/openvpn/test_buffer.c</s=
pan><br><span>index 92c4c65..25a8def 100644</span><br><span>--- a/tests/uni=
t_tests/openvpn/test_buffer.c</span><br><span>+++ b/tests/unit_tests/openvp=
n/test_buffer.c</span><br><span>@@ -463,38 +463,38 @@</span><br><span>     =
const char test1[] =3D A_TIMES_256 &quot;EOL\n&quot; A_TIMES_256 &quot;EOF&=
quot;;</span><br><span> </span><br><span>     /* line buffer bigger than ac=
tual line */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    asser=
t_int_equal(buf_write(&amp;buf, test1, sizeof(test1)), true);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_write(&amp;bu=
f, test1, sizeof(test1)));</span><br><span>     status =3D buf_parse(&amp;b=
uf, &#39;\n&#39;, line, sizeof(line));</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    assert_int_equal(status, true);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(status);</span><br><span>=
     assert_string_equal(line, A_TIMES_256 &quot;EOL&quot;);</span><br><spa=
n>     status =3D buf_parse(&amp;buf, &#39;\n&#39;, line, sizeof(line));</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal(sta=
tus, true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_true(status);</span><br><span>     assert_string_equal(line, A_TIMES_256=
 &quot;EOF&quot;);</span><br><span> </span><br><span>     /* line buffer ex=
actly same size as actual line + terminating \0 */</span><br><span>     buf=
_reset_len(&amp;buf);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    assert_int_equal(buf_write(&amp;buf, test1, sizeof(test1)), true);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_writ=
e(&amp;buf, test1, sizeof(test1)));</span><br><span>     status =3D buf_par=
se(&amp;buf, &#39;\n&#39;, line, 260);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    assert_int_equal(status, true);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(status);</span><br><span>=
     assert_string_equal(line, A_TIMES_256 &quot;EOL&quot;);</span><br><spa=
n>     status =3D buf_parse(&amp;buf, &#39;\n&#39;, line, 260);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal(status, true=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(s=
tatus);</span><br><span>     assert_string_equal(line, A_TIMES_256 &quot;EO=
F&quot;);</span><br><span> </span><br><span>     /* line buffer smaller tha=
n actual line */</span><br><span>     buf_reset_len(&amp;buf);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal(buf_write(&am=
p;buf, test1, sizeof(test1)), true);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_true(buf_write(&amp;buf, test1, sizeof(test1)))=
;</span><br><span>     status =3D buf_parse(&amp;buf, &#39;\n&#39;, line, 2=
57);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_int_eq=
ual(status, true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_true(status);</span><br><span>     assert_string_equal(line, A_TI=
MES_256);</span><br><span>     status =3D buf_parse(&amp;buf, &#39;\n&#39;,=
 line, 257);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    asser=
t_int_equal(status, true);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_true(status);</span><br><span>     assert_string_equal(li=
ne, &quot;EOL&quot;);</span><br><span>     status =3D buf_parse(&amp;buf, &=
#39;\n&#39;, line, 257);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    assert_int_equal(status, true);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_true(status);</span><br><span>     assert_str=
ing_equal(line, A_TIMES_256);</span><br><span>     status =3D buf_parse(&am=
p;buf, &#39;\n&#39;, line, 257);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    assert_int_equal(status, true);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_true(status);</span><br><span>     as=
sert_string_equal(line, &quot;EOF&quot;);</span><br><span> </span><br><span=
>     gc_free(&amp;gc);</span><br><span>diff --git a/tests/unit_tests/openv=
pn/test_cryptoapi.c b/tests/unit_tests/openvpn/test_cryptoapi.c</span><br><=
span>index 6e83465..2edfba9b 100644</span><br><span>--- a/tests/unit_tests/=
openvpn/test_cryptoapi.c</span><br><span>+++ b/tests/unit_tests/openvpn/tes=
t_cryptoapi.c</span><br><span>@@ -121,7 +121,7 @@</span><br><span>         =
{ cert4, key4, cname4, &quot;OVPN TEST CA2&quot;, &quot;OVPN Test Cert 4&qu=
ot;, hash4, 0 },</span><br><span>         { 0 }</span><br><span>     };</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert(sizeof(certs_l=
ocal) =3D=3D sizeof(certs));</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    assert_int_equal(sizeof(certs_local), sizeof(certs));</span><b=
r><span>     memcpy(certs, certs_local, sizeof(certs_local));</span><br><sp=
an> }</span><br><span> </span><br><span>diff --git a/tests/unit_tests/openv=
pn/test_misc.c b/tests/unit_tests/openvpn/test_misc.c</span><br><span>index=
 10bed1d..954794e 100644</span><br><span>--- a/tests/unit_tests/openvpn/tes=
t_misc.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_misc.c</span><=
br><span>@@ -101,7 +101,7 @@</span><br><span>     const char *msg =3D parse=
_auth_failed_temp(&amp;o, teststr);</span><br><span>     assert_string_equa=
l(msg, &quot;&quot;);</span><br><span>     assert_int_equal(o.server_backof=
f_time, 42);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    asser=
t_int_equal(o.no_advance, true);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_true(o.no_advance);</span><br><span> }</span><br><s=
pan> </span><br><span> static void</span><br><span>diff --git a/tests/unit_=
tests/openvpn/test_pkcs11.c b/tests/unit_tests/openvpn/test_pkcs11.c</span>=
<br><span>index 01cbf96..81d2280 100644</span><br><span>--- a/tests/unit_te=
sts/openvpn/test_pkcs11.c</span><br><span>+++ b/tests/unit_tests/openvpn/te=
st_pkcs11.c</span><br><span>@@ -148,7 +148,7 @@</span><br><span>         { =
cert4, key4, cname4, &quot;OVPN TEST CA2&quot;, &quot;OVPN Test Cert 4&quot=
;, { 0 }, NULL },</span><br><span>         { 0 }</span><br><span>     };</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert(sizeof(certs_=
local) =3D=3D sizeof(certs));</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_int_equal(sizeof(certs_local), sizeof(certs));</span><=
br><span>     memcpy(certs, certs_local, sizeof(certs_local));</span><br><s=
pan> }</span><br><span> </span><br><span></span><br></pre><p>To view, visit=
 <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1345?usp=3Demail">change =
1345</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div i=
temscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"ur=
l" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1345?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I61e4968f2e83d12d4d3fc3ccba9=
2a06eb5ed5866 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1345 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@...2726...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--eS1nXCt88R4=--

