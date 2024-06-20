From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Thu, 20 Jun 2024 14:22:47 +0000
In-Reply-To: <gerrit.1718794976000.I6e08920e4cf4762b9f14a7461a29fa77df15255c@...2715...>
References: <gerrit.1718794976000.I6e08920e4cf4762b9f14a7461a29fa77df15255c@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, gert@...1296...
Message-ID: <cf291454f68558ad171ee35ebc8b533fe2523d21-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gx3swKJ1cJY="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, cron2 <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--gx3swKJ1cJY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos.

Hello cron2, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/667?usp=3Demail

to look at the new patch set (#3).

The following approvals got outdated and were removed:
Code-Review+2 by cron2

The change is no longer submittable: Code-Review and checks~ChecksSubmitRul=
e are unsatisfied now.


Change subject: configure: Add -Wstrict-prototypes and -Wold-style-definiti=
on
......................................................................

configure: Add -Wstrict-prototypes and -Wold-style-definition

These are not covered by -Wall (nor -Wextra) but we want
to enforce them.

Change-Id: I6e08920e4cf4762b9f14a7461a29fa77df15255c
Signed-off-by: Frank Lichtenheld <frank@...2641...>
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
M tests/unit_tests/openvpn/test_provider.c
M tests/unit_tests/openvpn/test_ssl.c
M tests/unit_tests/plugins/auth-pam/test_search_and_replace.c
14 files changed, 24 insertions(+), 22 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/67/667/3

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
diff --git a/tests/unit_tests/openvpn/test_provider.c b/tests/unit_tests/op=
envpn/test_provider.c
index 934b2d3..cfe9ac3 100644
--- a/tests/unit_tests/openvpn/test_provider.c
+++ b/tests/unit_tests/openvpn/test_provider.c
@@ -119,7 +119,7 @@
 }

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


--=20
To view, visit http://gerrit.openvpn.net/c/openvpn/+/667?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6e08920e4cf4762b9f14a7461a29fa77df15255c
Gerrit-Change-Number: 667
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--gx3swKJ1cJY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, plaisthos. <=
/p>
<p>flichtenheld <strong>uploaded patch set #3</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/667?usp=3Demail">View Ch=
ange</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by cron2</p><p>The change is no longer submittable: Code-Revi=
ew and checks~ChecksSubmitRule are unsatisfied now.</p><pre style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;">configure: Add -Wstrict=
-prototypes and -Wold-style-definition<br><br>These are not covered by -Wal=
l (nor -Wextra) but we want<br>to enforce them.<br><br>Change-Id: I6e08920e=
4cf4762b9f14a7461a29fa77df15255c<br>Signed-off-by: Frank Lichtenheld &lt;fr=
ank@...2641...&gt;<br>---<br>M configure.ac<br>M src/openvpn/dco.h<br>M src=
/openvpn/dco_freebsd.c<br>M src/openvpn/dco_linux.c<br>M src/openvpn/pkcs11=
.h<br>M src/openvpn/sig.c<br>M src/openvpn/ssl.c<br>M src/openvpn/ssl.h<br>=
M src/openvpn/xkey_helper.c<br>M src/openvpn/xkey_provider.c<br>M tests/uni=
t_tests/openvpn/test_common.h<br>M tests/unit_tests/openvpn/test_provider.c=
<br>M tests/unit_tests/openvpn/test_ssl.c<br>M tests/unit_tests/plugins/aut=
h-pam/test_search_and_replace.c<br>14 files changed, 24 insertions(+), 22 d=
eletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/=
changes/67/667/3</pre><pre style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;"><span>diff --git a/configure.ac b/configure.ac</span><br=
><span>index 2e5ab6a..c01ad09 100644</span><br><span>--- a/configure.ac</sp=
an><br><span>+++ b/configure.ac</span><br><span>@@ -1408,6 +1408,8 @@</span=
><br><span> )</span><br><span> </span><br><span> ACL_CHECK_ADD_COMPILE_FLAG=
S([-Wno-stringop-truncation])</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ACL_CHECK_ADD_COMPILE_FLAGS([-Wstrict-prototypes])</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ACL_CHECK_ADD_COMPILE_FLAGS([-Wold=
-style-definition])</span><br><span> ACL_CHECK_ADD_COMPILE_FLAGS([-Wall])</=
span><br><span> </span><br><span> if test &quot;${enable_pedantic}&quot; =
=3D &quot;yes&quot;; then</span><br><span>diff --git a/src/openvpn/dco.h b/=
src/openvpn/dco.h</span><br><span>index 50ebb35..035474f 100644</span><br><=
span>--- a/src/openvpn/dco.h</span><br><span>+++ b/src/openvpn/dco.h</span>=
<br><span>@@ -247,7 +247,7 @@</span><br><span>  *</span><br><span>  * @retu=
rn                   list of colon-separated ciphers</span><br><span>  */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-const char *dco_get_sup=
ported_ciphers();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+co=
nst char *dco_get_supported_ciphers(void);</span><br><span> </span><br><spa=
n> #else /* if defined(ENABLE_DCO) */</span><br><span> </span><br><span>@@ =
-375,7 +375,7 @@</span><br><span> }</span><br><span> </span><br><span> stat=
ic inline const char *</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-dco_get_supported_ciphers()</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+dco_get_supported_ciphers(void)</span><br><span> {</span><br><span=
>     return &quot;&quot;;</span><br><span> }</span><br><span>diff --git a/=
src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c</span><br><span>index=
 7c8b29c..9a90f5c 100644</span><br><span>--- a/src/openvpn/dco_freebsd.c</s=
pan><br><span>+++ b/src/openvpn/dco_freebsd.c</span><br><span>@@ -773,7 +77=
3,7 @@</span><br><span> }</span><br><span> </span><br><span> const char *</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_get_supported_ciphe=
rs()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_get_support=
ed_ciphers(void)</span><br><span> {</span><br><span>     return &quot;none:=
AES-256-GCM:AES-192-GCM:AES-128-GCM:CHACHA20-POLY1305&quot;;</span><br><spa=
n> }</span><br><span>diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco=
_linux.c</span><br><span>index b2584b9..277cd64 100644</span><br><span>--- =
a/src/openvpn/dco_linux.c</span><br><span>+++ b/src/openvpn/dco_linux.c</sp=
an><br><span>@@ -1053,7 +1053,7 @@</span><br><span> }</span><br><span> </sp=
an><br><span> const char *</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-dco_get_supported_ciphers()</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+dco_get_supported_ciphers(void)</span><br><span> {</span><br><=
span>     return &quot;AES-128-GCM:AES-256-GCM:AES-192-GCM:CHACHA20-POLY130=
5&quot;;</span><br><span> }</span><br><span>diff --git a/src/openvpn/pkcs11=
.h b/src/openvpn/pkcs11.h</span><br><span>index 3caedc0..772fa4e 100644</sp=
an><br><span>--- a/src/openvpn/pkcs11.h</span><br><span>+++ b/src/openvpn/p=
kcs11.h</span><br><span>@@ -35,7 +35,7 @@</span><br><span>     );</span><br=
><span> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-pkcs11_terminate();</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+pkcs11_terminate(void);</span><br><span> </span><br><span> bool</s=
pan><br><span> pkcs11_addProvider(</span><br><span>@@ -46,10 +46,10 @@</spa=
n><br><span>     );</span><br><span> </span><br><span> int</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-pkcs11_logout();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+pkcs11_logout(void);</span><br><span> </s=
pan><br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-pkc=
s11_management_id_count();</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+pkcs11_management_id_count(void);</span><br><span> </span><br><span>=
 bool</span><br><span> pkcs11_management_id_get(</span><br><span>diff --git=
 a/src/openvpn/sig.c b/src/openvpn/sig.c</span><br><span>index cfbd942..832=
3f0d 100644</span><br><span>--- a/src/openvpn/sig.c</span><br><span>+++ b/s=
rc/openvpn/sig.c</span><br><span>@@ -448,7 +448,7 @@</span><br><span> }</sp=
an><br><span> </span><br><span> void</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-halt_low_priority_signals()</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+halt_low_priority_signals(void)</span><br><span> {</=
span><br><span> #ifndef _WIN32</span><br><span>     struct sigaction sa;</s=
pan><br><span>diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c</span><br>=
<span>index 2054eb4..17078c9 100644</span><br><span>--- a/src/openvpn/ssl.c=
</span><br><span>+++ b/src/openvpn/ssl.c</span><br><span>@@ -277,7 +277,7 @=
@</span><br><span> #endif</span><br><span> </span><br><span> void</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-enable_auth_user_pass()</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+enable_auth_user_pass(void)=
</span><br><span> {</span><br><span>     auth_user_pass_enabled =3D true;</=
span><br><span> }</span><br><span>diff --git a/src/openvpn/ssl.h b/src/open=
vpn/ssl.h</span><br><span>index 98e59e8..0e2a43f 100644</span><br><span>---=
 a/src/openvpn/ssl.h</span><br><span>+++ b/src/openvpn/ssl.h</span><br><spa=
n>@@ -381,7 +381,7 @@</span><br><span> void pem_password_setup(const char *=
auth_file);</span><br><span> </span><br><span> /* Enables the use of user/p=
assword authentication */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-void enable_auth_user_pass();</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+void enable_auth_user_pass(void);</span><br><span> </span><br=
><span> /*</span><br><span>  * Setup authentication username and password. =
If auth_file is given, use the</span><br><span>diff --git a/src/openvpn/xke=
y_helper.c b/src/openvpn/xkey_helper.c</span><br><span>index 283c95d..b68fb=
43 100644</span><br><span>--- a/src/openvpn/xkey_helper.c</span><br><span>+=
++ b/src/openvpn/xkey_helper.c</span><br><span>@@ -49,7 +49,7 @@</span><br>=
<span> XKEY_EXTERNAL_SIGN_fn xkey_management_sign;</span><br><span> </span>=
<br><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-print_openssl_errors()</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+print_openssl_errors(void)</span><br><span> {</span><br><span>     unsi=
gned long e;</span><br><span>     while ((e =3D ERR_get_error()))</span><br=
><span>diff --git a/src/openvpn/xkey_provider.c b/src/openvpn/xkey_provider=
.c</span><br><span>index f5fc956..964d2eb 100644</span><br><span>--- a/src/=
openvpn/xkey_provider.c</span><br><span>+++ b/src/openvpn/xkey_provider.c</=
span><br><span>@@ -155,7 +155,7 @@</span><br><span> keymgmt_import_helper(X=
KEY_KEYDATA *key, const OSSL_PARAM params[]);</span><br><span> </span><br><=
span> static XKEY_KEYDATA *</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-keydata_new()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
keydata_new(void)</span><br><span> {</span><br><span>     xkey_dmsg(D_XKEY,=
 &quot;entry&quot;);</span><br><span> </span><br><span>diff --git a/tests/u=
nit_tests/openvpn/test_common.h b/tests/unit_tests/openvpn/test_common.h</s=
pan><br><span>index f219e93..52503c6 100644</span><br><span>--- a/tests/uni=
t_tests/openvpn/test_common.h</span><br><span>+++ b/tests/unit_tests/openvp=
n/test_common.h</span><br><span>@@ -33,7 +33,7 @@</span><br><span>  * metho=
ds</span><br><span>  */</span><br><span> static inline void</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-openvpn_unit_test_setup()</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+openvpn_unit_test_setup(void)</=
span><br><span> {</span><br><span>     assert_int_equal(setvbuf(stdout, NUL=
L, _IONBF, BUFSIZ), 0);</span><br><span>     assert_int_equal(setvbuf(stder=
r, NULL, _IONBF, BUFSIZ), 0);</span><br><span>diff --git a/tests/unit_tests=
/openvpn/test_provider.c b/tests/unit_tests/openvpn/test_provider.c</span><=
br><span>index 934b2d3..cfe9ac3 100644</span><br><span>--- a/tests/unit_tes=
ts/openvpn/test_provider.c</span><br><span>+++ b/tests/unit_tests/openvpn/t=
est_provider.c</span><br><span>@@ -119,7 +119,7 @@</span><br><span> }</span=
><br><span> </span><br><span> static void</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-init_test()</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+init_test(void)</span><br><span> {</span><br><span>     openvpn=
_unit_test_setup();</span><br><span>     prov[0] =3D OSSL_PROVIDER_load(NUL=
L, &quot;default&quot;);</span><br><span>@@ -135,7 +135,7 @@</span><br><spa=
n> }</span><br><span> </span><br><span> static void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-uninit_test()</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+uninit_test(void)</span><br><span> {</span><br><s=
pan>     for (size_t i =3D 0; i &lt; _countof(prov); i++)</span><br><span> =
    {</span><br><span>diff --git a/tests/unit_tests/openvpn/test_ssl.c b/te=
sts/unit_tests/openvpn/test_ssl.c</span><br><span>index a9a3137..5da5b1c 10=
0644</span><br><span>--- a/tests/unit_tests/openvpn/test_ssl.c</span><br><s=
pan>+++ b/tests/unit_tests/openvpn/test_ssl.c</span><br><span>@@ -81,7 +81,=
7 @@</span><br><span>                             &quot;-----END CERTIFICAT=
E-----\n&quot;;</span><br><span> </span><br><span> static const char *</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-get_tmp_dir()</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+get_tmp_dir(void)</span><br><spa=
n> {</span><br><span>     const char *ret;</span><br><span> #ifdef _WIN32</=
span><br><span>diff --git a/tests/unit_tests/plugins/auth-pam/test_search_a=
nd_replace.c b/tests/unit_tests/plugins/auth-pam/test_search_and_replace.c<=
/span><br><span>index ee7a151..d40467f 100644</span><br><span>--- a/tests/u=
nit_tests/plugins/auth-pam/test_search_and_replace.c</span><br><span>+++ b/=
tests/unit_tests/plugins/auth-pam/test_search_and_replace.c</span><br><span=
>@@ -9,7 +9,7 @@</span><br><span> #include &quot;utils.h&quot;</span><br><s=
pan> </span><br><span> static void</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-pass_any_null_param__returns_null()</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+pass_any_null_param__returns_null(void **state=
)</span><br><span> {</span><br><span> </span><br><span>     char DUMMY[] =
=3D &quot;DUMMY&quot;;</span><br><span>@@ -20,7 +20,7 @@</span><br><span> }=
</span><br><span> </span><br><span> static void</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-pass_any_empty_string__returns_null()</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+pass_any_empty_string__returns_=
null(void **state)</span><br><span> {</span><br><span> </span><br><span>   =
  char DUMMY[] =3D &quot;DUMMY&quot;;</span><br><span>@@ -32,7 +32,7 @@</sp=
an><br><span> }</span><br><span> </span><br><span> static void</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-replace_single_char__one_time__mat=
ch_is_replaced()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+rep=
lace_single_char__one_time__match_is_replaced(void **state)</span><br><span=
> {</span><br><span>     char *replaced =3D searchandreplace(&quot;X&quot;,=
 &quot;X&quot;, &quot;Y&quot;);</span><br><span> </span><br><span>@@ -43,7 =
+43,7 @@</span><br><span> }</span><br><span> </span><br><span> static void<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-replace_single_char__m=
ultiple_times__match_all_matches_are_replaced()</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+replace_single_char__multiple_times__match_all_=
matches_are_replaced(void **state)</span><br><span> {</span><br><span>     =
char *replaced =3D searchandreplace(&quot;XaX&quot;, &quot;X&quot;, &quot;Y=
&quot;);</span><br><span> </span><br><span>@@ -54,7 +54,7 @@</span><br><spa=
n> }</span><br><span> </span><br><span> static void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-replace_longer_text__multiple_times__match_=
all_matches_are_replaced()</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+replace_longer_text__multiple_times__match_all_matches_are_replaced(=
void **state)</span><br><span> {</span><br><span>     char *replaced =3D se=
archandreplace(&quot;XXaXX&quot;, &quot;XX&quot;, &quot;YY&quot;);</span><b=
r><span> </span><br><span>@@ -65,7 +65,7 @@</span><br><span> }</span><br><s=
pan> </span><br><span> static void</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-pattern_not_found__returns_original()</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+pattern_not_found__returns_original(void **s=
tate)</span><br><span> {</span><br><span>     char *replaced =3D searchandr=
eplace(&quot;abc&quot;, &quot;X&quot;, &quot;Y&quot;);</span><br><span> </s=
pan><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/667?usp=3Demail">change 667</a>. To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/s=
ettings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Emai=
lMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/=
ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/667?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6e08920e4cf4762b9f14a7461a2=
9fa77df15255c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 667 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--gx3swKJ1cJY=--

