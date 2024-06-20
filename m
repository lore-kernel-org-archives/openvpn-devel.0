From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 20 Jun 2024 15:21:07 +0000
In-Reply-To: <gerrit.1718794976000.I6e08920e4cf4762b9f14a7461a29fa77df15255c@...2715...>
References: <gerrit.1718794976000.I6e08920e4cf4762b9f14a7461a29fa77df15255c@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <f2e28245e1ac9b186eb581cf88076a0272425876-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="k45vCmIWsqc="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: configure: Add
 -Wstrict-prototypes and -Wold-style-definition
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

--k45vCmIWsqc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/66=
7?usp=3Demail )

Change subject: configure: Add -Wstrict-prototypes and -Wold-style-definiti=
on
......................................................................

configure: Add -Wstrict-prototypes and -Wold-style-definition

These are not covered by -Wall (nor -Wextra) but we want
to enforce them.

Change-Id: I6e08920e4cf4762b9f14a7461a29fa77df15255c
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20240620144230.19586-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28=
823.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M configure.ac
M src/openvpn/dco.h
M src/openvpn/dco_freebsd.c
M src/openvpn/dco_linux.c
M src/openvpn/pkcs11.h
M src/openvpn/sig.c
M src/openvpn/ssl.c
M src/openvpn/ssl.h
M src/openvpn/xkey_helper.c
M src/openvpn/xkey_provider.c
M tests/unit_tests/openvpn/test_common.h
M tests/unit_tests/openvpn/test_pkcs11.c
M tests/unit_tests/openvpn/test_provider.c
M tests/unit_tests/openvpn/test_ssl.c
M tests/unit_tests/plugins/auth-pam/test_search_and_replace.c
15 files changed, 25 insertions(+), 23 deletions(-)




diff --git a/configure.ac b/configure.ac
index 2e5ab6a..c01ad09 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1408,6 +1408,8 @@
 )

 ACL_CHECK_ADD_COMPILE_FLAGS([-Wno-stringop-truncation])
+ACL_CHECK_ADD_COMPILE_FLAGS([-Wstrict-prototypes])
+ACL_CHECK_ADD_COMPILE_FLAGS([-Wold-style-definition])
 ACL_CHECK_ADD_COMPILE_FLAGS([-Wall])

 if test "${enable_pedantic}" =3D "yes"; then
diff --git a/src/openvpn/dco.h b/src/openvpn/dco.h
index 50ebb35..035474f 100644
--- a/src/openvpn/dco.h
+++ b/src/openvpn/dco.h
@@ -247,7 +247,7 @@
  *
  * @return                   list of colon-separated ciphers
  */
-const char *dco_get_supported_ciphers();
+const char *dco_get_supported_ciphers(void);

 #else /* if defined(ENABLE_DCO) */

@@ -375,7 +375,7 @@
 }

 static inline const char *
-dco_get_supported_ciphers()
+dco_get_supported_ciphers(void)
 {
     return "";
 }
diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index 7c8b29c..9a90f5c 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -773,7 +773,7 @@
 }

 const char *
-dco_get_supported_ciphers()
+dco_get_supported_ciphers(void)
 {
     return "none:AES-256-GCM:AES-192-GCM:AES-128-GCM:CHACHA20-POLY1305";
 }
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index b2584b9..277cd64 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -1053,7 +1053,7 @@
 }

 const char *
-dco_get_supported_ciphers()
+dco_get_supported_ciphers(void)
 {
     return "AES-128-GCM:AES-256-GCM:AES-192-GCM:CHACHA20-POLY1305";
 }
diff --git a/src/openvpn/pkcs11.h b/src/openvpn/pkcs11.h
index 3caedc0..772fa4e 100644
--- a/src/openvpn/pkcs11.h
+++ b/src/openvpn/pkcs11.h
@@ -35,7 +35,7 @@
     );

 void
-pkcs11_terminate();
+pkcs11_terminate(void);

 bool
 pkcs11_addProvider(
@@ -46,10 +46,10 @@
     );

 int
-pkcs11_logout();
+pkcs11_logout(void);

 int
-pkcs11_management_id_count();
+pkcs11_management_id_count(void);

 bool
 pkcs11_management_id_get(
diff --git a/src/openvpn/sig.c b/src/openvpn/sig.c
index cfbd942..8323f0d 100644
--- a/src/openvpn/sig.c
+++ b/src/openvpn/sig.c
@@ -448,7 +448,7 @@
 }

 void
-halt_low_priority_signals()
+halt_low_priority_signals(void)
 {
 #ifndef _WIN32
     struct sigaction sa;
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 2054eb4..17078c9 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -277,7 +277,7 @@
 #endif

 void
-enable_auth_user_pass()
+enable_auth_user_pass(void)
 {
     auth_user_pass_enabled =3D true;
 }
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index 98e59e8..0e2a43f 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -381,7 +381,7 @@
 void pem_password_setup(const char *auth_file);

 /* Enables the use of user/password authentication */
-void enable_auth_user_pass();
+void enable_auth_user_pass(void);

 /*
  * Setup authentication username and password. If auth_file is given, use =
the
diff --git a/src/openvpn/xkey_helper.c b/src/openvpn/xkey_helper.c
index 283c95d..b68fb43 100644
--- a/src/openvpn/xkey_helper.c
+++ b/src/openvpn/xkey_helper.c
@@ -49,7 +49,7 @@
 XKEY_EXTERNAL_SIGN_fn xkey_management_sign;

 static void
-print_openssl_errors()
+print_openssl_errors(void)
 {
     unsigned long e;
     while ((e =3D ERR_get_error()))
diff --git a/src/openvpn/xkey_provider.c b/src/openvpn/xkey_provider.c
index f5fc956..964d2eb 100644
--- a/src/openvpn/xkey_provider.c
+++ b/src/openvpn/xkey_provider.c
@@ -155,7 +155,7 @@
 keymgmt_import_helper(XKEY_KEYDATA *key, const OSSL_PARAM params[]);

 static XKEY_KEYDATA *
-keydata_new()
+keydata_new(void)
 {
     xkey_dmsg(D_XKEY, "entry");

diff --git a/tests/unit_tests/openvpn/test_common.h b/tests/unit_tests/open=
vpn/test_common.h
index f219e93..52503c6 100644
--- a/tests/unit_tests/openvpn/test_common.h
+++ b/tests/unit_tests/openvpn/test_common.h
@@ -33,7 +33,7 @@
  * methods
  */
 static inline void
-openvpn_unit_test_setup()
+openvpn_unit_test_setup(void)
 {
     assert_int_equal(setvbuf(stdout, NULL, _IONBF, BUFSIZ), 0);
     assert_int_equal(setvbuf(stderr, NULL, _IONBF, BUFSIZ), 0);
diff --git a/tests/unit_tests/openvpn/test_pkcs11.c b/tests/unit_tests/open=
vpn/test_pkcs11.c
index 84ebb29..6d283a2 100644
--- a/tests/unit_tests/openvpn/test_pkcs11.c
+++ b/tests/unit_tests/openvpn/test_pkcs11.c
@@ -134,7 +134,7 @@

 /* Fill-in certs[] array */
 void
-init_cert_data()
+init_cert_data(void)
 {
     struct test_cert certs_local[] =3D {
         {cert1,  key1,  cname1,  "OVPN TEST CA1",  "OVPN Test Cert 1",  {0=
},  NULL},
diff --git a/tests/unit_tests/openvpn/test_provider.c b/tests/unit_tests/op=
envpn/test_provider.c
index 934b2d3..cfe9ac3 100644
--- a/tests/unit_tests/openvpn/test_provider.c
+++ b/tests/unit_tests/openvpn/test_provider.c
@@ -119,7 +119,7 @@
 }
=20
 static void
-init_test()
+init_test(void)
 {
     openvpn_unit_test_setup();
     prov[0] =3D OSSL_PROVIDER_load(NULL, "default");
@@ -135,7 +135,7 @@
 }

 static void
-uninit_test()
+uninit_test(void)
 {
     for (size_t i =3D 0; i < _countof(prov); i++)
     {
diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn=
/test_ssl.c
index a9a3137..5da5b1c 100644
--- a/tests/unit_tests/openvpn/test_ssl.c
+++ b/tests/unit_tests/openvpn/test_ssl.c
@@ -81,7 +81,7 @@
                             "-----END CERTIFICATE-----\n";

 static const char *
-get_tmp_dir()
+get_tmp_dir(void)
 {
     const char *ret;
 #ifdef _WIN32
diff --git a/tests/unit_tests/plugins/auth-pam/test_search_and_replace.c b/=
tests/unit_tests/plugins/auth-pam/test_search_and_replace.c
index ee7a151..d40467f 100644
--- a/tests/unit_tests/plugins/auth-pam/test_search_and_replace.c
+++ b/tests/unit_tests/plugins/auth-pam/test_search_and_replace.c
@@ -9,7 +9,7 @@
 #include "utils.h"

 static void
-pass_any_null_param__returns_null()
+pass_any_null_param__returns_null(void **state)
 {

     char DUMMY[] =3D "DUMMY";
@@ -20,7 +20,7 @@
 }

 static void
-pass_any_empty_string__returns_null()
+pass_any_empty_string__returns_null(void **state)
 {

     char DUMMY[] =3D "DUMMY";
@@ -32,7 +32,7 @@
 }

 static void
-replace_single_char__one_time__match_is_replaced()
+replace_single_char__one_time__match_is_replaced(void **state)
 {
     char *replaced =3D searchandreplace("X", "X", "Y");

@@ -43,7 +43,7 @@
 }

 static void
-replace_single_char__multiple_times__match_all_matches_are_replaced()
+replace_single_char__multiple_times__match_all_matches_are_replaced(void *=
*state)
 {
     char *replaced =3D searchandreplace("XaX", "X", "Y");

@@ -54,7 +54,7 @@
 }

 static void
-replace_longer_text__multiple_times__match_all_matches_are_replaced()
+replace_longer_text__multiple_times__match_all_matches_are_replaced(void *=
*state)
 {
     char *replaced =3D searchandreplace("XXaXX", "XX", "YY");

@@ -65,7 +65,7 @@
 }

 static void
-pattern_not_found__returns_original()
+pattern_not_found__returns_original(void **state)
 {
     char *replaced =3D searchandreplace("abc", "X", "Y");


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/667?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6e08920e4cf4762b9f14a7461a29fa77df15255c
Gerrit-Change-Number: 667
Gerrit-PatchSet: 5
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--k45vCmIWsqc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/667?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">configure: Add -Wstrict-prototypes and -Wold-s=
tyle-definition<br><br>These are not covered by -Wall (nor -Wextra) but we =
want<br>to enforce them.<br><br>Change-Id: I6e08920e4cf4762b9f14a7461a29fa7=
7df15255c<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>A=
cked-by: Gert Doering &lt;gert@...1296...&gt;<br>Message-Id: &lt;2024062014=
4230.19586-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openv=
pn-devel@lists.sourceforge.net/msg28823.html<br>Signed-off-by: Gert Doering=
 &lt;gert@...1296...&gt;<br>---<br>M configure.ac<br>M src/openvpn/dco.h<br=
>M src/openvpn/dco_freebsd.c<br>M src/openvpn/dco_linux.c<br>M src/openvpn/=
pkcs11.h<br>M src/openvpn/sig.c<br>M src/openvpn/ssl.c<br>M src/openvpn/ssl=
.h<br>M src/openvpn/xkey_helper.c<br>M src/openvpn/xkey_provider.c<br>M tes=
ts/unit_tests/openvpn/test_common.h<br>M tests/unit_tests/openvpn/test_pkcs=
11.c<br>M tests/unit_tests/openvpn/test_provider.c<br>M tests/unit_tests/op=
envpn/test_ssl.c<br>M tests/unit_tests/plugins/auth-pam/test_search_and_rep=
lace.c<br>15 files changed, 25 insertions(+), 23 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/configure.ac b/configure.ac</span><br><span>index 2e5ab6a..=
c01ad09 100644</span><br><span>--- a/configure.ac</span><br><span>+++ b/con=
figure.ac</span><br><span>@@ -1408,6 +1408,8 @@</span><br><span> )</span><b=
r><span> </span><br><span> ACL_CHECK_ADD_COMPILE_FLAGS([-Wno-stringop-trunc=
ation])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ACL_CHECK_AD=
D_COMPILE_FLAGS([-Wstrict-prototypes])</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ACL_CHECK_ADD_COMPILE_FLAGS([-Wold-style-definition])</s=
pan><br><span> ACL_CHECK_ADD_COMPILE_FLAGS([-Wall])</span><br><span> </span=
><br><span> if test &quot;${enable_pedantic}&quot; =3D &quot;yes&quot;; the=
n</span><br><span>diff --git a/src/openvpn/dco.h b/src/openvpn/dco.h</span>=
<br><span>index 50ebb35..035474f 100644</span><br><span>--- a/src/openvpn/d=
co.h</span><br><span>+++ b/src/openvpn/dco.h</span><br><span>@@ -247,7 +247=
,7 @@</span><br><span>  *</span><br><span>  * @return                   lis=
t of colon-separated ciphers</span><br><span>  */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-const char *dco_get_supported_ciphers();</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+const char *dco_get_suppor=
ted_ciphers(void);</span><br><span> </span><br><span> #else /* if defined(E=
NABLE_DCO) */</span><br><span> </span><br><span>@@ -375,7 +375,7 @@</span><=
br><span> }</span><br><span> </span><br><span> static inline const char *</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_get_supported_ciphe=
rs()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_get_support=
ed_ciphers(void)</span><br><span> {</span><br><span>     return &quot;&quot=
;;</span><br><span> }</span><br><span>diff --git a/src/openvpn/dco_freebsd.=
c b/src/openvpn/dco_freebsd.c</span><br><span>index 7c8b29c..9a90f5c 100644=
</span><br><span>--- a/src/openvpn/dco_freebsd.c</span><br><span>+++ b/src/=
openvpn/dco_freebsd.c</span><br><span>@@ -773,7 +773,7 @@</span><br><span> =
}</span><br><span> </span><br><span> const char *</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-dco_get_supported_ciphers()</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+dco_get_supported_ciphers(void)</span><=
br><span> {</span><br><span>     return &quot;none:AES-256-GCM:AES-192-GCM:=
AES-128-GCM:CHACHA20-POLY1305&quot;;</span><br><span> }</span><br><span>dif=
f --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c</span><br><span=
>index b2584b9..277cd64 100644</span><br><span>--- a/src/openvpn/dco_linux.=
c</span><br><span>+++ b/src/openvpn/dco_linux.c</span><br><span>@@ -1053,7 =
+1053,7 @@</span><br><span> }</span><br><span> </span><br><span> const char=
 *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_get_supported_c=
iphers()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_get_sup=
ported_ciphers(void)</span><br><span> {</span><br><span>     return &quot;A=
ES-128-GCM:AES-256-GCM:AES-192-GCM:CHACHA20-POLY1305&quot;;</span><br><span=
> }</span><br><span>diff --git a/src/openvpn/pkcs11.h b/src/openvpn/pkcs11.=
h</span><br><span>index 3caedc0..772fa4e 100644</span><br><span>--- a/src/o=
penvpn/pkcs11.h</span><br><span>+++ b/src/openvpn/pkcs11.h</span><br><span>=
@@ -35,7 +35,7 @@</span><br><span>     );</span><br><span> </span><br><span=
> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-pkcs11_terminat=
e();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+pkcs11_terminat=
e(void);</span><br><span> </span><br><span> bool</span><br><span> pkcs11_ad=
dProvider(</span><br><span>@@ -46,10 +46,10 @@</span><br><span>     );</spa=
n><br><span> </span><br><span> int</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-pkcs11_logout();</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+pkcs11_logout(void);</span><br><span> </span><br><span> int</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-pkcs11_management_id_count(=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+pkcs11_management=
_id_count(void);</span><br><span> </span><br><span> bool</span><br><span> p=
kcs11_management_id_get(</span><br><span>diff --git a/src/openvpn/sig.c b/s=
rc/openvpn/sig.c</span><br><span>index cfbd942..8323f0d 100644</span><br><s=
pan>--- a/src/openvpn/sig.c</span><br><span>+++ b/src/openvpn/sig.c</span><=
br><span>@@ -448,7 +448,7 @@</span><br><span> }</span><br><span> </span><br=
><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-halt_low_=
priority_signals()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+h=
alt_low_priority_signals(void)</span><br><span> {</span><br><span> #ifndef =
_WIN32</span><br><span>     struct sigaction sa;</span><br><span>diff --git=
 a/src/openvpn/ssl.c b/src/openvpn/ssl.c</span><br><span>index 2054eb4..170=
78c9 100644</span><br><span>--- a/src/openvpn/ssl.c</span><br><span>+++ b/s=
rc/openvpn/ssl.c</span><br><span>@@ -277,7 +277,7 @@</span><br><span> #endi=
f</span><br><span> </span><br><span> void</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-enable_auth_user_pass()</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+enable_auth_user_pass(void)</span><br><span> {</spa=
n><br><span>     auth_user_pass_enabled =3D true;</span><br><span> }</span>=
<br><span>diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h</span><br><spa=
n>index 98e59e8..0e2a43f 100644</span><br><span>--- a/src/openvpn/ssl.h</sp=
an><br><span>+++ b/src/openvpn/ssl.h</span><br><span>@@ -381,7 +381,7 @@</s=
pan><br><span> void pem_password_setup(const char *auth_file);</span><br><s=
pan> </span><br><span> /* Enables the use of user/password authentication *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void enable_auth_use=
r_pass();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void enabl=
e_auth_user_pass(void);</span><br><span> </span><br><span> /*</span><br><sp=
an>  * Setup authentication username and password. If auth_file is given, u=
se the</span><br><span>diff --git a/src/openvpn/xkey_helper.c b/src/openvpn=
/xkey_helper.c</span><br><span>index 283c95d..b68fb43 100644</span><br><spa=
n>--- a/src/openvpn/xkey_helper.c</span><br><span>+++ b/src/openvpn/xkey_he=
lper.c</span><br><span>@@ -49,7 +49,7 @@</span><br><span> XKEY_EXTERNAL_SIG=
N_fn xkey_management_sign;</span><br><span> </span><br><span> static void</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-print_openssl_errors()<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+print_openssl_errors=
(void)</span><br><span> {</span><br><span>     unsigned long e;</span><br><=
span>     while ((e =3D ERR_get_error()))</span><br><span>diff --git a/src/=
openvpn/xkey_provider.c b/src/openvpn/xkey_provider.c</span><br><span>index=
 f5fc956..964d2eb 100644</span><br><span>--- a/src/openvpn/xkey_provider.c<=
/span><br><span>+++ b/src/openvpn/xkey_provider.c</span><br><span>@@ -155,7=
 +155,7 @@</span><br><span> keymgmt_import_helper(XKEY_KEYDATA *key, const =
OSSL_PARAM params[]);</span><br><span> </span><br><span> static XKEY_KEYDAT=
A *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-keydata_new()</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+keydata_new(void)</span>=
<br><span> {</span><br><span>     xkey_dmsg(D_XKEY, &quot;entry&quot;);</sp=
an><br><span> </span><br><span>diff --git a/tests/unit_tests/openvpn/test_c=
ommon.h b/tests/unit_tests/openvpn/test_common.h</span><br><span>index f219=
e93..52503c6 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_com=
mon.h</span><br><span>+++ b/tests/unit_tests/openvpn/test_common.h</span><b=
r><span>@@ -33,7 +33,7 @@</span><br><span>  * methods</span><br><span>  */<=
/span><br><span> static inline void</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-openvpn_unit_test_setup()</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+openvpn_unit_test_setup(void)</span><br><span> {</span>=
<br><span>     assert_int_equal(setvbuf(stdout, NULL, _IONBF, BUFSIZ), 0);<=
/span><br><span>     assert_int_equal(setvbuf(stderr, NULL, _IONBF, BUFSIZ)=
, 0);</span><br><span>diff --git a/tests/unit_tests/openvpn/test_pkcs11.c b=
/tests/unit_tests/openvpn/test_pkcs11.c</span><br><span>index 84ebb29..6d28=
3a2 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_pkcs11.c</sp=
an><br><span>+++ b/tests/unit_tests/openvpn/test_pkcs11.c</span><br><span>@=
@ -134,7 +134,7 @@</span><br><span> </span><br><span> /* Fill-in certs[] ar=
ray */</span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-init_cert_data()</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+init_cert_data(void)</span><br><span> {</span><br><span>     struct tes=
t_cert certs_local[] =3D {</span><br><span>         {cert1,  key1,  cname1,=
  &quot;OVPN TEST CA1&quot;,  &quot;OVPN Test Cert 1&quot;,  {0},  NULL},</=
span><br><span>diff --git a/tests/unit_tests/openvpn/test_provider.c b/test=
s/unit_tests/openvpn/test_provider.c</span><br><span>index 934b2d3..cfe9ac3=
 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_provider.c</spa=
n><br><span>+++ b/tests/unit_tests/openvpn/test_provider.c</span><br><span>=
@@ -119,7 +119,7 @@</span><br><span> }</span><br><span> </span><br><span> s=
tatic void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-init_test()=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+init_test(void)</sp=
an><br><span> {</span><br><span>     openvpn_unit_test_setup();</span><br><=
span>     prov[0] =3D OSSL_PROVIDER_load(NULL, &quot;default&quot;);</span>=
<br><span>@@ -135,7 +135,7 @@</span><br><span> }</span><br><span> </span><b=
r><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-u=
ninit_test()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+uninit_=
test(void)</span><br><span> {</span><br><span>     for (size_t i =3D 0; i &=
lt; _countof(prov); i++)</span><br><span>     {</span><br><span>diff --git =
a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn/test_ssl.c=
</span><br><span>index a9a3137..5da5b1c 100644</span><br><span>--- a/tests/=
unit_tests/openvpn/test_ssl.c</span><br><span>+++ b/tests/unit_tests/openvp=
n/test_ssl.c</span><br><span>@@ -81,7 +81,7 @@</span><br><span>            =
                 &quot;-----END CERTIFICATE-----\n&quot;;</span><br><span> =
</span><br><span> static const char *</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-get_tmp_dir()</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+get_tmp_dir(void)</span><br><span> {</span><br><span>     const c=
har *ret;</span><br><span> #ifdef _WIN32</span><br><span>diff --git a/tests=
/unit_tests/plugins/auth-pam/test_search_and_replace.c b/tests/unit_tests/p=
lugins/auth-pam/test_search_and_replace.c</span><br><span>index ee7a151..d4=
0467f 100644</span><br><span>--- a/tests/unit_tests/plugins/auth-pam/test_s=
earch_and_replace.c</span><br><span>+++ b/tests/unit_tests/plugins/auth-pam=
/test_search_and_replace.c</span><br><span>@@ -9,7 +9,7 @@</span><br><span>=
 #include &quot;utils.h&quot;</span><br><span> </span><br><span> static voi=
d</span><br><span style=3D"color: hsl(0, 100%, 40%);">-pass_any_null_param_=
_returns_null()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+pass=
_any_null_param__returns_null(void **state)</span><br><span> {</span><br><s=
pan> </span><br><span>     char DUMMY[] =3D &quot;DUMMY&quot;;</span><br><s=
pan>@@ -20,7 +20,7 @@</span><br><span> }</span><br><span> </span><br><span>=
 static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-pass_any_=
empty_string__returns_null()</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+pass_any_empty_string__returns_null(void **state)</span><br><span>=
 {</span><br><span> </span><br><span>     char DUMMY[] =3D &quot;DUMMY&quot=
;;</span><br><span>@@ -32,7 +32,7 @@</span><br><span> }</span><br><span> </=
span><br><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-replace_single_char__one_time__match_is_replaced()</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+replace_single_char__one_time__match_i=
s_replaced(void **state)</span><br><span> {</span><br><span>     char *repl=
aced =3D searchandreplace(&quot;X&quot;, &quot;X&quot;, &quot;Y&quot;);</sp=
an><br><span> </span><br><span>@@ -43,7 +43,7 @@</span><br><span> }</span><=
br><span> </span><br><span> static void</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-replace_single_char__multiple_times__match_all_matches_ar=
e_replaced()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+replace=
_single_char__multiple_times__match_all_matches_are_replaced(void **state)<=
/span><br><span> {</span><br><span>     char *replaced =3D searchandreplace=
(&quot;XaX&quot;, &quot;X&quot;, &quot;Y&quot;);</span><br><span> </span><b=
r><span>@@ -54,7 +54,7 @@</span><br><span> }</span><br><span> </span><br><s=
pan> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-repla=
ce_longer_text__multiple_times__match_all_matches_are_replaced()</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+replace_longer_text__multiple_=
times__match_all_matches_are_replaced(void **state)</span><br><span> {</spa=
n><br><span>     char *replaced =3D searchandreplace(&quot;XXaXX&quot;, &qu=
ot;XX&quot;, &quot;YY&quot;);</span><br><span> </span><br><span>@@ -65,7 +6=
5,7 @@</span><br><span> }</span><br><span> </span><br><span> static void</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-pattern_not_found__retur=
ns_original()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+patter=
n_not_found__returns_original(void **state)</span><br><span> {</span><br><s=
pan>     char *replaced =3D searchandreplace(&quot;abc&quot;, &quot;X&quot;=
, &quot;Y&quot;);</span><br><span> </span><br><span></span><br></pre><p>To =
view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/667?usp=3Demai=
l">change 667</a>. To unsubscribe, or for help writing mail filters, visit =
<a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemsc=
ope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/667?usp=3Demail"/><meta itempro=
p=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6e08920e4cf4762b9f14a7461a2=
9fa77df15255c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 667 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--k45vCmIWsqc=--

