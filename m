From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 4 Mar 2026 16:20:50 +0000
In-Reply-To: <gerrit.1769789455000.Ib0d2b9520e4a77a9f4bf70ce092f76ca73608537@...2715...>
References: <gerrit.1769789455000.Ib0d2b9520e4a77a9f4bf70ce092f76ca73608537@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <1d0810771fbf3de4de7c702d9f86d3325b5058a2-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Ww6Gdr1fM+Q="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: ssl_ncp: Fix length
 check in mutate_ncp_cipher_list
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

--Ww6Gdr1fM+Q=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#6) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1503?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos


Change subject: ssl_ncp: Fix length check in mutate_ncp_cipher_list
......................................................................

ssl_ncp: Fix length check in mutate_ncp_cipher_list

* Make it more readable by removing a level of negation
* Fix an off-by-one error. It accepted one char fewer than
  allowed.
* Slightly improve the UT.

Change-Id: Ib0d2b9520e4a77a9f4bf70ce092f76ca73608537
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1503
Message-Id: <20260302181627.29008-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
828.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/ssl_ncp.c
M tests/unit_tests/openvpn/test_ncp.c
2 files changed, 18 insertions(+), 14 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/03/1503/6

diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
index 500e09d..fdac6925 100644
--- a/src/openvpn/ssl_ncp.c
+++ b/src/openvpn/ssl_ncp.c
@@ -92,11 +92,6 @@
     }
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
 char *
 mutate_ncp_cipher_list(const char *list, struct gc_arena *gc)
 {
@@ -168,7 +163,7 @@
             }

             /* Ensure buffer has capacity for cipher name + : + \0 */
-            if (!(buf_forward_capacity(&new_list) > strlen(ovpn_cipher_nam=
e) + 2))
+            if (buf_forward_capacity(&new_list) < (int)strlen(ovpn_cipher_=
name) + 2)
             {
                 msg(M_WARN, "Length of --data-ciphers is over the "
                             "limit of 127 chars");
@@ -207,10 +202,6 @@
     o->ncp_ciphers =3D ncp_ciphers;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 bool
 tls_item_in_cipher_list(const char *item, const char *list)
 {
diff --git a/tests/unit_tests/openvpn/test_ncp.c b/tests/unit_tests/openvpn=
/test_ncp.c
index 9f569a7..52a41ee 100644
--- a/tests/unit_tests/openvpn/test_ncp.c
+++ b/tests/unit_tests/openvpn/test_ncp.c
@@ -123,10 +123,23 @@
     assert_ptr_equal(mutate_ncp_cipher_list("AES-256-GCM:vollbit", &gc), N=
ULL);
     assert_ptr_equal(mutate_ncp_cipher_list("", &gc), NULL);
=20
-    assert_ptr_equal(mutate_ncp_cipher_list("ChaCha20-Poly1305:ChaCha20-Po=
ly1305:ChaCha20-Poly1305:"
-                                            "ChaCha20-Poly1305:ChaCha20-Po=
ly1305:ChaCha20-Poly1305:"
-                                            "ChaCha20-Poly1305",
-                                            &gc),
+    const char long_string[MAX_NCP_CIPHERS_LENGTH] =3D
+        "CHACHA20-POLY1305:CHACHA20-POLY1305:CHACHA20-POLY1305:"
+        "CHACHA20-POLY1305:CHACHA20-POLY1305:CHACHA20-POLY1305:"
+        "CHACHA20-POLY1305";
+    const char longer_string[MAX_NCP_CIPHERS_LENGTH + 1] =3D
+        "CHACHA20-POLY1305:CHACHA20-POLY1305:CHACHA20-POLY1305:"
+        "CHACHA20-POLY1305:CHACHA20-POLY1305:CHACHA20-POLY1305:"
+        "CHACHA20-POLY1305:";
+    const char longest_string[] =3D
+        "CHACHA20-POLY1305:CHACHA20-POLY1305:CHACHA20-POLY1305:"
+        "CHACHA20-POLY1305:CHACHA20-POLY1305:CHACHA20-POLY1305:"
+        "CHACHA20-POLY1305:CHACHA20-POLY1305";
+    assert_string_equal(mutate_ncp_cipher_list(long_string, &gc),
+                        long_string);
+    assert_string_equal(mutate_ncp_cipher_list(longer_string, &gc),
+                        long_string);
+    assert_ptr_equal(mutate_ncp_cipher_list(longest_string, &gc),
                      NULL);

 #ifdef ENABLE_CRYPTO_OPENSSL

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1503?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib0d2b9520e4a77a9f4bf70ce092f76ca73608537
Gerrit-Change-Number: 1503
Gerrit-PatchSet: 6
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Ww6Gdr1fM+Q=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #6</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1503?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by plaisthos</p><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">ssl_ncp: Fix length check in mu=
tate_ncp_cipher_list<br><br>* Make it more readable by removing a level of =
negation<br>* Fix an off-by-one error. It accepted one char fewer than<br> =
 allowed.<br>* Slightly improve the UT.<br><br>Change-Id: Ib0d2b9520e4a77a9=
f4bf70ce092f76ca73608537<br>Signed-off-by: Frank Lichtenheld &lt;frank@...1665...=
641...&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@...1227...&gt;<br>Ger=
rit URL: https://gerrit.openvpn.net/c/openvpn/+/1503<br>Message-Id: &lt;202=
60302181627.29008-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.co=
m/openvpn-devel@lists.sourceforge.net/msg35828.html<br>Signed-off-by: Gert =
Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/ssl_ncp.c<br>M test=
s/unit_tests/openvpn/test_ncp.c<br>2 files changed, 18 insertions(+), 14 de=
letions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:294=
18/openvpn refs/changes/03/1503/6</pre><pre style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl_ncp.=
c b/src/openvpn/ssl_ncp.c</span><br><span>index 500e09d..fdac6925 100644</s=
pan><br><span>--- a/src/openvpn/ssl_ncp.c</span><br><span>+++ b/src/openvpn=
/ssl_ncp.c</span><br><span>@@ -92,11 +92,6 @@</span><br><span>     }</span>=
<br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;=
-Wsign-compare&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
> char *</span><br><span> mutate_ncp_cipher_list(const char *list, struct g=
c_arena *gc)</span><br><span> {</span><br><span>@@ -168,7 +163,7 @@</span><=
br><span>             }</span><br><span> </span><br><span>             /* E=
nsure buffer has capacity for cipher name + : + \0 */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            if (!(buf_forward_capacity(&amp=
;new_list) &gt; strlen(ovpn_cipher_name) + 2))</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            if (buf_forward_capacity(&amp;new_li=
st) &lt; (int)strlen(ovpn_cipher_name) + 2)</span><br><span>             {<=
/span><br><span>                 msg(M_WARN, &quot;Length of --data-ciphers=
 is over the &quot;</span><br><span>                             &quot;limi=
t of 127 chars&quot;);</span><br><span>@@ -207,10 +202,6 @@</span><br><span=
>     o-&gt;ncp_ciphers =3D ncp_ciphers;</span><br><span> }</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC_=
_) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span> bool</span><br><span> tls_item_in_cipher_list(const char *item, =
const char *list)</span><br><span> {</span><br><span>diff --git a/tests/uni=
t_tests/openvpn/test_ncp.c b/tests/unit_tests/openvpn/test_ncp.c</span><br>=
<span>index 9f569a7..52a41ee 100644</span><br><span>--- a/tests/unit_tests/=
openvpn/test_ncp.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_ncp.=
c</span><br><span>@@ -123,10 +123,23 @@</span><br><span>     assert_ptr_equ=
al(mutate_ncp_cipher_list(&quot;AES-256-GCM:vollbit&quot;, &amp;gc), NULL);=
</span><br><span>     assert_ptr_equal(mutate_ncp_cipher_list(&quot;&quot;,=
 &amp;gc), NULL);</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    assert_ptr_equal(mutate_ncp_cipher_list(&quot;ChaCha20-Po=
ly1305:ChaCha20-Poly1305:ChaCha20-Poly1305:&quot;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                                            &qu=
ot;ChaCha20-Poly1305:ChaCha20-Poly1305:ChaCha20-Poly1305:&quot;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                                 =
           &quot;ChaCha20-Poly1305&quot;,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                                            &amp;gc),</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char long_s=
tring[MAX_NCP_CIPHERS_LENGTH] =3D</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        &quot;CHACHA20-POLY1305:CHACHA20-POLY1305:CHACHA20-PO=
LY1305:&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  &quot;CHACHA20-POLY1305:CHACHA20-POLY1305:CHACHA20-POLY1305:&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        &quot;CHACHA20-POL=
Y1305&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    con=
st char longer_string[MAX_NCP_CIPHERS_LENGTH + 1] =3D</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        &quot;CHACHA20-POLY1305:CHACHA20-=
POLY1305:CHACHA20-POLY1305:&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        &quot;CHACHA20-POLY1305:CHACHA20-POLY1305:CHACHA20-PO=
LY1305:&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  &quot;CHACHA20-POLY1305:&quot;;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    const char longest_string[] =3D</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        &quot;CHACHA20-POLY1305:CHACHA20-POLY=
1305:CHACHA20-POLY1305:&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        &quot;CHACHA20-POLY1305:CHACHA20-POLY1305:CHACHA20-POLY13=
05:&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &q=
uot;CHACHA20-POLY1305:CHACHA20-POLY1305&quot;;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_string_equal(mutate_ncp_cipher_list(l=
ong_string, &amp;gc),</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                        long_string);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_string_equal(mutate_ncp_cipher_list(longer_s=
tring, &amp;gc),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                     long_string);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_ptr_equal(mutate_ncp_cipher_list(longest_string, =
&amp;gc),</span><br><span>                      NULL);</span><br><span> </s=
pan><br><span> #ifdef ENABLE_CRYPTO_OPENSSL</span><br><span></span><br></pr=
e><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1503?u=
sp=3Demail">change 1503</a>. To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settin=
gs</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div =
itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1503?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib0d2b9520e4a77a9f4bf70ce092=
f76ca73608537 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1503 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--Ww6Gdr1fM+Q=--

