From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 4 Mar 2026 16:20:52 +0000
In-Reply-To: <gerrit.1769789455000.Ib0d2b9520e4a77a9f4bf70ce092f76ca73608537@...2715...>
References: <gerrit.1769789455000.Ib0d2b9520e4a77a9f4bf70ce092f76ca73608537@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <1d0810771fbf3de4de7c702d9f86d3325b5058a2-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="AUjUyeVHjVw="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--AUjUyeVHjVw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/15=
03?usp=3Demail )

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

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib0d2b9520e4a77a9f4bf70ce092f76ca73608537
Gerrit-Change-Number: 1503
Gerrit-PatchSet: 6
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--AUjUyeVHjVw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1503?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">ssl_ncp: Fix length check in mutate_ncp_cipher_l=
ist<br><br>* Make it more readable by removing a level of negation<br>* Fix=
 an off-by-one error. It accepted one char fewer than<br>  allowed.<br>* Sl=
ightly improve the UT.<br><br>Change-Id: Ib0d2b9520e4a77a9f4bf70ce092f76ca7=
3608537<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Ack=
ed-by: Arne Schwabe &lt;arne-openvpn@...1227...&gt;<br>Gerrit URL: https://=
gerrit.openvpn.net/c/openvpn/+/1503<br>Message-Id: &lt;20260302181627.29008=
-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...465...=
ists.sourceforge.net/msg35828.html<br>Signed-off-by: Gert Doering &lt;gert@=
...1296...&gt;<br>---<br>M src/openvpn/ssl_ncp.c<br>M tests/unit_tests/open=
vpn/test_ncp.c<br>2 files changed, 18 insertions(+), 14 deletions(-)<br><br=
></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c</span><br><sp=
an>index 500e09d..fdac6925 100644</span><br><span>--- a/src/openvpn/ssl_ncp=
.c</span><br><span>+++ b/src/openvpn/ssl_ncp.c</span><br><span>@@ -92,11 +9=
2,6 @@</span><br><span>     }</span><br><span> }</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defin=
ed(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma =
GCC diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#p=
ragma GCC diagnostic ignored &quot;-Wsign-compare&quot;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span> char *</span><br><span> mutate_ncp_cip=
her_list(const char *list, struct gc_arena *gc)</span><br><span> {</span><b=
r><span>@@ -168,7 +163,7 @@</span><br><span>             }</span><br><span>=
 </span><br><span>             /* Ensure buffer has capacity for cipher nam=
e + : + \0 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    if (!(buf_forward_capacity(&amp;new_list) &gt; strlen(ovpn_cipher_name)=
 + 2))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            i=
f (buf_forward_capacity(&amp;new_list) &lt; (int)strlen(ovpn_cipher_name) +=
 2)</span><br><span>             {</span><br><span>                 msg(M_W=
ARN, &quot;Length of --data-ciphers is over the &quot;</span><br><span>    =
                         &quot;limit of 127 chars&quot;);</span><br><span>@=
@ -207,10 +202,6 @@</span><br><span>     o-&gt;ncp_ciphers =3D ncp_ciphers;=
</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span> bool</span><br><span> tls_ite=
m_in_cipher_list(const char *item, const char *list)</span><br><span> {</sp=
an><br><span>diff --git a/tests/unit_tests/openvpn/test_ncp.c b/tests/unit_=
tests/openvpn/test_ncp.c</span><br><span>index 9f569a7..52a41ee 100644</spa=
n><br><span>--- a/tests/unit_tests/openvpn/test_ncp.c</span><br><span>+++ b=
/tests/unit_tests/openvpn/test_ncp.c</span><br><span>@@ -123,10 +123,23 @@<=
/span><br><span>     assert_ptr_equal(mutate_ncp_cipher_list(&quot;AES-256-=
GCM:vollbit&quot;, &amp;gc), NULL);</span><br><span>     assert_ptr_equal(m=
utate_ncp_cipher_list(&quot;&quot;, &amp;gc), NULL);</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_ptr_equal(mutat=
e_ncp_cipher_list(&quot;ChaCha20-Poly1305:ChaCha20-Poly1305:ChaCha20-Poly13=
05:&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
                                &quot;ChaCha20-Poly1305:ChaCha20-Poly1305:C=
haCha20-Poly1305:&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                                            &quot;ChaCha20-Poly1305&quot;=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    =
                        &amp;gc),</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    const char long_string[MAX_NCP_CIPHERS_LENGTH] =3D</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        &quot;CHACHA20-POL=
Y1305:CHACHA20-POLY1305:CHACHA20-POLY1305:&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        &quot;CHACHA20-POLY1305:CHACHA20-POLY1=
305:CHACHA20-POLY1305:&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        &quot;CHACHA20-POLY1305&quot;;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    const char longer_string[MAX_NCP_CIPHERS_LE=
NGTH + 1] =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  &quot;CHACHA20-POLY1305:CHACHA20-POLY1305:CHACHA20-POLY1305:&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        &quot;CHACHA20-POL=
Y1305:CHACHA20-POLY1305:CHACHA20-POLY1305:&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        &quot;CHACHA20-POLY1305:&quot;;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    const char longest_str=
ing[] =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &q=
uot;CHACHA20-POLY1305:CHACHA20-POLY1305:CHACHA20-POLY1305:&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        &quot;CHACHA20-POLY130=
5:CHACHA20-POLY1305:CHACHA20-POLY1305:&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        &quot;CHACHA20-POLY1305:CHACHA20-POLY1305&=
quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_st=
ring_equal(mutate_ncp_cipher_list(long_string, &amp;gc),</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                        long_string);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_eq=
ual(mutate_ncp_cipher_list(longer_string, &amp;gc),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                        long_string);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_ptr_equal(mu=
tate_ncp_cipher_list(longest_string, &amp;gc),</span><br><span>            =
          NULL);</span><br><span> </span><br><span> #ifdef ENABLE_CRYPTO_OP=
ENSSL</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://=
gerrit.openvpn.net/c/openvpn/+/1503?usp=3Demail">change 1503</a>. To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit.ope=
nvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"=
http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1503?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
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

--AUjUyeVHjVw=--

