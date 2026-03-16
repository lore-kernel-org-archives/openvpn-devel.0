From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 16 Mar 2026 13:52:21 +0000
In-Reply-To: <gerrit.1773243451000.I228f6fd9ff18256f09d4348df1fc48853f8e7306@...2715...>
References: <gerrit.1773243451000.I228f6fd9ff18256f09d4348df1fc48853f8e7306@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <d72cb983352061c87c7a870c3c82a4ce423d2541-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="zaenfaOX2dI="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Remove unnecessary
 OpenSSL init and cleanup commands in unit tests
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--zaenfaOX2dI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/15=
68?usp=3Demail )

Change subject: Remove unnecessary OpenSSL init and cleanup commands in uni=
t tests
......................................................................

Remove unnecessary OpenSSL init and cleanup commands in unit tests

After the removal of OpenSSL 1.0.2 support these instructions are
no longer needed and the main OpenVPN program also no longer calls
them in init_ssl_lib or free_ssl_lib.

Also remove them from the unit tests. This also solves a
deprecation warning on EVP_cleanup when compiling with aws-lc

Change-Id: I228f6fd9ff18256f09d4348df1fc48853f8e7306
Signed-off-by: Arne Schwabe <arne-openvpn@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1568
Message-Id: <20260316121148.25189-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36=
153.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M tests/unit_tests/openvpn/test_auth_token.c
M tests/unit_tests/openvpn/test_crypto.c
M tests/unit_tests/openvpn/test_ncp.c
M tests/unit_tests/openvpn/test_pkt.c
M tests/unit_tests/openvpn/test_tls_crypt.c
5 files changed, 5 insertions(+), 43 deletions(-)




diff --git a/tests/unit_tests/openvpn/test_auth_token.c b/tests/unit_tests/=
openvpn/test_auth_token.c
index 82c20c1..d28bd8a 100644
--- a/tests/unit_tests/openvpn/test_auth_token.c
+++ b/tests/unit_tests/openvpn/test_auth_token.c
@@ -428,11 +428,5 @@
         cmocka_unit_test_setup_teardown(auth_token_test_session_mismatch, =
setup, teardown)
     };

-#if defined(ENABLE_CRYPTO_OPENSSL)
-    OpenSSL_add_all_algorithms();
-#endif
-
-    int ret =3D cmocka_run_group_tests_name("auth-token tests", tests, NUL=
L, NULL);
-
-    return ret;
+    return cmocka_run_group_tests_name("auth-token tests", tests, NULL, NU=
LL);
 }
diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/open=
vpn/test_crypto.c
index 1679d88..cb4eaa2 100644
--- a/tests/unit_tests/openvpn/test_crypto.c
+++ b/tests/unit_tests/openvpn/test_crypto.c
@@ -963,15 +963,5 @@
         cmocka_unit_test(epoch_test_derive_data_key)
     };

-#if defined(ENABLE_CRYPTO_OPENSSL)
-    OpenSSL_add_all_algorithms();
-#endif
-
-    int ret =3D cmocka_run_group_tests_name("crypto tests", tests, NULL, N=
ULL);
-
-#if defined(ENABLE_CRYPTO_OPENSSL)
-    EVP_cleanup();
-#endif
-
-    return ret;
+    return cmocka_run_group_tests_name("crypto tests", tests, NULL, NULL);
 }
diff --git a/tests/unit_tests/openvpn/test_ncp.c b/tests/unit_tests/openvpn=
/test_ncp.c
index 52a41ee..29365db 100644
--- a/tests/unit_tests/openvpn/test_ncp.c
+++ b/tests/unit_tests/openvpn/test_ncp.c
@@ -407,8 +407,6 @@
 main(void)
 {
     openvpn_unit_test_setup();
-#if defined(ENABLE_CRYPTO_OPENSSL)
-    OpenSSL_add_all_algorithms();
-#endif
+
     return cmocka_run_group_tests(ncp_tests, NULL, NULL);
 }
diff --git a/tests/unit_tests/openvpn/test_pkt.c b/tests/unit_tests/openvpn=
/test_pkt.c
index a94732d..cad2ce0 100644
--- a/tests/unit_tests/openvpn/test_pkt.c
+++ b/tests/unit_tests/openvpn/test_pkt.c
@@ -765,15 +765,5 @@
         cmocka_unit_test(test_extract_control_message)
     };

-#if defined(ENABLE_CRYPTO_OPENSSL)
-    OpenSSL_add_all_algorithms();
-#endif
-
-    int ret =3D cmocka_run_group_tests_name("pkt tests", tests, NULL, NULL=
);
-
-#if defined(ENABLE_CRYPTO_OPENSSL)
-    EVP_cleanup();
-#endif
-
-    return ret;
+    return cmocka_run_group_tests_name("pkt tests", tests, NULL, NULL);
 }
diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_tests/o=
penvpn/test_tls_crypt.c
index ed82279..1776d71 100644
--- a/tests/unit_tests/openvpn/test_tls_crypt.c
+++ b/tests/unit_tests/openvpn/test_tls_crypt.c
@@ -673,15 +673,5 @@
         cmocka_unit_test(test_tls_crypt_v2_write_client_key_file_metadata),
     };

-#if defined(ENABLE_CRYPTO_OPENSSL)
-    OpenSSL_add_all_algorithms();
-#endif
-
-    int ret =3D cmocka_run_group_tests_name("tls-crypt tests", tests, NULL=
, NULL);
-
-#if defined(ENABLE_CRYPTO_OPENSSL)
-    EVP_cleanup();
-#endif
-
-    return ret;
+    return cmocka_run_group_tests_name("tls-crypt tests", tests, NULL, NUL=
L);
 }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1568?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I228f6fd9ff18256f09d4348df1fc48853f8e7306
Gerrit-Change-Number: 1568
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--zaenfaOX2dI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1568?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">Remove unnecessary OpenSSL init and cleanup comm=
ands in unit tests<br><br>After the removal of OpenSSL 1.0.2 support these =
instructions are<br>no longer needed and the main OpenVPN program also no l=
onger calls<br>them in init_ssl_lib or free_ssl_lib.<br><br>Also remove the=
m from the unit tests. This also solves a<br>deprecation warning on EVP_cle=
anup when compiling with aws-lc<br><br>Change-Id: I228f6fd9ff18256f09d4348d=
f1fc48853f8e7306<br>Signed-off-by: Arne Schwabe &lt;arne-openvpn@...1227...=
&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Gerrit URL:=
 https://gerrit.openvpn.net/c/openvpn/+/1568<br>Message-Id: &lt;20260316121=
148.25189-1-frank@...2641...&gt;<br>URL: https://www.mail-archive.com/openv=
pn-devel@lists.sourceforge.net/msg36153.html<br>Signed-off-by: Gert Doering=
 &lt;gert@...1296...&gt;<br>---<br>M tests/unit_tests/openvpn/test_auth_tok=
en.c<br>M tests/unit_tests/openvpn/test_crypto.c<br>M tests/unit_tests/open=
vpn/test_ncp.c<br>M tests/unit_tests/openvpn/test_pkt.c<br>M tests/unit_tes=
ts/openvpn/test_tls_crypt.c<br>5 files changed, 5 insertions(+), 43 deletio=
ns(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/tests/unit_tests/openvpn/test_auth_token.c b/tests/unit_tes=
ts/openvpn/test_auth_token.c</span><br><span>index 82c20c1..d28bd8a 100644<=
/span><br><span>--- a/tests/unit_tests/openvpn/test_auth_token.c</span><br>=
<span>+++ b/tests/unit_tests/openvpn/test_auth_token.c</span><br><span>@@ -=
428,11 +428,5 @@</span><br><span>         cmocka_unit_test_setup_teardown(a=
uth_token_test_session_mismatch, setup, teardown)</span><br><span>     };</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if d=
efined(ENABLE_CRYPTO_OPENSSL)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    OpenSSL_add_all_algorithms();</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int ret =3D =
cmocka_run_group_tests_name(&quot;auth-token tests&quot;, tests, NULL, NULL=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    return ret;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    return cmocka_run_group_tests_name(&quot=
;auth-token tests&quot;, tests, NULL, NULL);</span><br><span> }</span><br><=
span>diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests=
/openvpn/test_crypto.c</span><br><span>index 1679d88..cb4eaa2 100644</span>=
<br><span>--- a/tests/unit_tests/openvpn/test_crypto.c</span><br><span>+++ =
b/tests/unit_tests/openvpn/test_crypto.c</span><br><span>@@ -963,15 +963,5 =
@@</span><br><span>         cmocka_unit_test(epoch_test_derive_data_key)</s=
pan><br><span>     };</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#if defined(ENABLE_CRYPTO_OPENSSL)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    OpenSSL_add_all_algorithms();</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    int ret =3D cmocka_run_group_tests_name(&quot;crypto tests&quot=
;, tests, NULL, NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(ENABLE_C=
RYPTO_OPENSSL)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    EVP=
_cleanup();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    return ret;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    return cmocka_run_group_tests_name(&quot;crypt=
o tests&quot;, tests, NULL, NULL);</span><br><span> }</span><br><span>diff =
--git a/tests/unit_tests/openvpn/test_ncp.c b/tests/unit_tests/openvpn/test=
_ncp.c</span><br><span>index 52a41ee..29365db 100644</span><br><span>--- a/=
tests/unit_tests/openvpn/test_ncp.c</span><br><span>+++ b/tests/unit_tests/=
openvpn/test_ncp.c</span><br><span>@@ -407,8 +407,6 @@</span><br><span> mai=
n(void)</span><br><span> {</span><br><span>     openvpn_unit_test_setup();<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(ENABLE_CRY=
PTO_OPENSSL)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    OpenS=
SL_add_all_algorithms();</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span>     return cmocka_run_group_tests(ncp_tests, NULL, NULL);</span><br=
><span> }</span><br><span>diff --git a/tests/unit_tests/openvpn/test_pkt.c =
b/tests/unit_tests/openvpn/test_pkt.c</span><br><span>index a94732d..cad2ce=
0 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_pkt.c</span><b=
r><span>+++ b/tests/unit_tests/openvpn/test_pkt.c</span><br><span>@@ -765,1=
5 +765,5 @@</span><br><span>         cmocka_unit_test(test_extract_control_=
message)</span><br><span>     };</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#if defined(ENABLE_CRYPTO_OPENSSL)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    OpenSSL_add_all_algorithms();=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    int ret =3D cmocka_run_group_tests_name(&quot;pkt tes=
ts&quot;, tests, NULL, NULL);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(E=
NABLE_CRYPTO_OPENSSL)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    EVP_cleanup();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#en=
dif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    return ret;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return cmocka_run_group_tests_name(&q=
uot;pkt tests&quot;, tests, NULL, NULL);</span><br><span> }</span><br><span=
>diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_tests/=
openvpn/test_tls_crypt.c</span><br><span>index ed82279..1776d71 100644</spa=
n><br><span>--- a/tests/unit_tests/openvpn/test_tls_crypt.c</span><br><span=
>+++ b/tests/unit_tests/openvpn/test_tls_crypt.c</span><br><span>@@ -673,15=
 +673,5 @@</span><br><span>         cmocka_unit_test(test_tls_crypt_v2_writ=
e_client_key_file_metadata),</span><br><span>     };</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(ENABLE_CRYPTO_=
OPENSSL)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    OpenSSL_a=
dd_all_algorithms();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    int ret =3D cmocka_run_group_test=
s_name(&quot;tls-crypt tests&quot;, tests, NULL, NULL);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#if defined(ENABLE_CRYPTO_OPENSSL)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    EVP_cleanup();</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return re=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return cmocka=
_run_group_tests_name(&quot;tls-crypt tests&quot;, tests, NULL, NULL);</spa=
n><br><span> }</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1568?usp=3Demail">change 1568</a>=
. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:/=
/gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope i=
temtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"actio=
n" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/1568?usp=3Demail"/><meta itemprop=3D=
"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I228f6fd9ff18256f09d4348df1f=
c48853f8e7306 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1568 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--zaenfaOX2dI=--

