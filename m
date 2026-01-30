From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 30 Jan 2026 16:11:10 +0000
References: <gerrit.1769789455000.Ib0d2b9520e4a77a9f4bf70ce092f76ca73608537@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <717cb70604af930a1a5e2ba47c4d2fb1b74f0ed6-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="uNOjcdVYNnA="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--uNOjcdVYNnA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1503?usp=3Demail

to review the following change.


Change subject: ssl_ncp: Fix length check in mutate_ncp_cipher_list
......................................................................

ssl_ncp: Fix length check in mutate_ncp_cipher_list

* Make it more readable by removing a level of negation
* Fix an off-by-one error. It accepted one char fewer than
  allowed.
* Slightly improve the UT.

Change-Id: Ib0d2b9520e4a77a9f4bf70ce092f76ca73608537
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/ssl_ncp.c
M tests/unit_tests/openvpn/test_ncp.c
2 files changed, 18 insertions(+), 14 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/03/1503/1

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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib0d2b9520e4a77a9f4bf70ce092f76ca73608537
Gerrit-Change-Number: 1503
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--uNOjcdVYNnA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1503?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">ssl_ncp: Fix length check in mutate_ncp_cip=
her_list<br><br>* Make it more readable by removing a level of negation<br>=
* Fix an off-by-one error. It accepted one char fewer than<br>  allowed.<br=
>* Slightly improve the UT.<br><br>Change-Id: Ib0d2b9520e4a77a9f4bf70ce092f=
76ca73608537<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<b=
r>---<br>M src/openvpn/ssl_ncp.c<br>M tests/unit_tests/openvpn/test_ncp.c<b=
r>2 files changed, 18 insertions(+), 14 deletions(-)<br><br></pre><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/03/1503/1=
</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;"><span>diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c</span><=
br><span>index 500e09d..fdac6925 100644</span><br><span>--- a/src/openvpn/s=
sl_ncp.c</span><br><span>+++ b/src/openvpn/ssl_ncp.c</span><br><span>@@ -92=
,11 +92,6 @@</span><br><span>     }</span><br><span> }</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) ||=
 defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#p=
ragma GCC diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#pragma GCC diagnostic ignored &quot;-Wsign-compare&quot;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span> char *</span><br><span> mutate_n=
cp_cipher_list(const char *list, struct gc_arena *gc)</span><br><span> {</s=
pan><br><span>@@ -168,7 +163,7 @@</span><br><span>             }</span><br>=
<span> </span><br><span>             /* Ensure buffer has capacity for ciph=
er name + : + \0 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          if (!(buf_forward_capacity(&amp;new_list) &gt; strlen(ovpn_cipher=
_name) + 2))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     if (buf_forward_capacity(&amp;new_list) &lt; (int)strlen(ovpn_cipher_n=
ame) + 2)</span><br><span>             {</span><br><span>                 m=
sg(M_WARN, &quot;Length of --data-ciphers is over the &quot;</span><br><spa=
n>                             &quot;limit of 127 chars&quot;);</span><br><=
span>@@ -207,10 +202,6 @@</span><br><span>     o-&gt;ncp_ciphers =3D ncp_ci=
phers;</span><br><span> }</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span> bool</span><br><span> t=
ls_item_in_cipher_list(const char *item, const char *list)</span><br><span>=
 {</span><br><span>diff --git a/tests/unit_tests/openvpn/test_ncp.c b/tests=
/unit_tests/openvpn/test_ncp.c</span><br><span>index 9f569a7..52a41ee 10064=
4</span><br><span>--- a/tests/unit_tests/openvpn/test_ncp.c</span><br><span=
>+++ b/tests/unit_tests/openvpn/test_ncp.c</span><br><span>@@ -123,10 +123,=
23 @@</span><br><span>     assert_ptr_equal(mutate_ncp_cipher_list(&quot;AE=
S-256-GCM:vollbit&quot;, &amp;gc), NULL);</span><br><span>     assert_ptr_e=
qual(mutate_ncp_cipher_list(&quot;&quot;, &amp;gc), NULL);</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_ptr_equal=
(mutate_ncp_cipher_list(&quot;ChaCha20-Poly1305:ChaCha20-Poly1305:ChaCha20-=
Poly1305:&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
                                      &quot;ChaCha20-Poly1305:ChaCha20-Poly=
1305:ChaCha20-Poly1305:&quot;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                                            &quot;ChaCha20-Poly1305=
&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
                              &amp;gc),</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    const char long_string[MAX_NCP_CIPHERS_LENGTH] =3D<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &quot;CHACHA=
20-POLY1305:CHACHA20-POLY1305:CHACHA20-POLY1305:&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        &quot;CHACHA20-POLY1305:CHACHA20=
-POLY1305:CHACHA20-POLY1305:&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        &quot;CHACHA20-POLY1305&quot;;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const char longer_string[MAX_NCP_CIPH=
ERS_LENGTH + 1] =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        &quot;CHACHA20-POLY1305:CHACHA20-POLY1305:CHACHA20-POLY1305:&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &quot;CHACHA=
20-POLY1305:CHACHA20-POLY1305:CHACHA20-POLY1305:&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        &quot;CHACHA20-POLY1305:&quot;;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char longe=
st_string[] =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    &quot;CHACHA20-POLY1305:CHACHA20-POLY1305:CHACHA20-POLY1305:&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        &quot;CHACHA20-P=
OLY1305:CHACHA20-POLY1305:CHACHA20-POLY1305:&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        &quot;CHACHA20-POLY1305:CHACHA20-POL=
Y1305&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_string_equal(mutate_ncp_cipher_list(long_string, &amp;gc),</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                        long_str=
ing);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_str=
ing_equal(mutate_ncp_cipher_list(longer_string, &amp;gc),</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                        long_string);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_ptr_equa=
l(mutate_ncp_cipher_list(longest_string, &amp;gc),</span><br><span>        =
              NULL);</span><br><span> </span><br><span> #ifdef ENABLE_CRYPT=
O_OPENSSL</span><br><span></span><br></pre><p>To view, visit <a href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/1503?usp=3Demail">change 1503</a>. To un=
subscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1503?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib0d2b9520e4a77a9f4bf70ce092=
f76ca73608537 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1503 </div>
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

--uNOjcdVYNnA=--

