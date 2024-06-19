From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 19 Jun 2024 14:22:24 +0000
In-Reply-To: <gerrit.1718794976000.I6e08920e4cf4762b9f14a7461a29fa77df15255c@...2715...>
References: <gerrit.1718794976000.I6e08920e4cf4762b9f14a7461a29fa77df15255c@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, gert@...1296...
Message-ID: <0bda8f76aec34ba38e3744d0cc0fce6edce223a2-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="u2POUrgRu90="; charset=UTF-8
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

--u2POUrgRu90=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos.

Hello cron2, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/667?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review+2 by cron2


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
M src/openvpn/sig.c
M src/openvpn/ssl.c
M src/openvpn/ssl.h
M src/openvpn/xkey_helper.c
M src/openvpn/xkey_provider.c
M tests/unit_tests/openvpn/test_common.h
M tests/unit_tests/openvpn/test_provider.c
M tests/unit_tests/openvpn/test_ssl.c
M tests/unit_tests/plugins/auth-pam/test_search_and_replace.c
13 files changed, 21 insertions(+), 19 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/67/667/2

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


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/667?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6e08920e4cf4762b9f14a7461a29fa77df15255c
Gerrit-Change-Number: 667
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--u2POUrgRu90=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, plaisthos. <=
/p>
<p>flichtenheld <strong>uploaded patch set #2</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/667?usp=3Demail">View Ch=
ange</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">configure: Add -Wstrict-prototypes and -Wold-style-d=
efinition<br><br>These are not covered by -Wall (nor -Wextra) but we want<b=
r>to enforce them.<br><br>Change-Id: I6e08920e4cf4762b9f14a7461a29fa77df152=
55c<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>=
M configure.ac<br>M src/openvpn/dco.h<br>M src/openvpn/dco_freebsd.c<br>M s=
rc/openvpn/dco_linux.c<br>M src/openvpn/sig.c<br>M src/openvpn/ssl.c<br>M s=
rc/openvpn/ssl.h<br>M src/openvpn/xkey_helper.c<br>M src/openvpn/xkey_provi=
der.c<br>M tests/unit_tests/openvpn/test_common.h<br>M tests/unit_tests/ope=
nvpn/test_provider.c<br>M tests/unit_tests/openvpn/test_ssl.c<br>M tests/un=
it_tests/plugins/auth-pam/test_search_and_replace.c<br>13 files changed, 21=
 insertions(+), 19 deletions(-)<br><br></pre><pre style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net=
:29418/openvpn refs/changes/67/667/2</pre><pre style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;"><span>diff --git a/configure.ac b/co=
nfigure.ac</span><br><span>index 2e5ab6a..c01ad09 100644</span><br><span>--=
- a/configure.ac</span><br><span>+++ b/configure.ac</span><br><span>@@ -140=
8,6 +1408,8 @@</span><br><span> )</span><br><span> </span><br><span> ACL_CH=
ECK_ADD_COMPILE_FLAGS([-Wno-stringop-truncation])</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ACL_CHECK_ADD_COMPILE_FLAGS([-Wstrict-prototy=
pes])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ACL_CHECK_ADD_=
COMPILE_FLAGS([-Wold-style-definition])</span><br><span> ACL_CHECK_ADD_COMP=
ILE_FLAGS([-Wall])</span><br><span> </span><br><span> if test &quot;${enabl=
e_pedantic}&quot; =3D &quot;yes&quot;; then</span><br><span>diff --git a/sr=
c/openvpn/dco.h b/src/openvpn/dco.h</span><br><span>index 50ebb35..035474f =
100644</span><br><span>--- a/src/openvpn/dco.h</span><br><span>+++ b/src/op=
envpn/dco.h</span><br><span>@@ -247,7 +247,7 @@</span><br><span>  *</span><=
br><span>  * @return                   list of colon-separated ciphers</spa=
n><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-const=
 char *dco_get_supported_ciphers();</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+const char *dco_get_supported_ciphers(void);</span><br><spa=
n> </span><br><span> #else /* if defined(ENABLE_DCO) */</span><br><span> </=
span><br><span>@@ -375,7 +375,7 @@</span><br><span> }</span><br><span> </sp=
an><br><span> static inline const char *</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-dco_get_supported_ciphers()</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+dco_get_supported_ciphers(void)</span><br><span>=
 {</span><br><span>     return &quot;&quot;;</span><br><span> }</span><br><=
span>diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c</sp=
an><br><span>index 7c8b29c..9a90f5c 100644</span><br><span>--- a/src/openvp=
n/dco_freebsd.c</span><br><span>+++ b/src/openvpn/dco_freebsd.c</span><br><=
span>@@ -773,7 +773,7 @@</span><br><span> }</span><br><span> </span><br><sp=
an> const char *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_g=
et_supported_ciphers()</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+dco_get_supported_ciphers(void)</span><br><span> {</span><br><span>     =
return &quot;none:AES-256-GCM:AES-192-GCM:AES-128-GCM:CHACHA20-POLY1305&quo=
t;;</span><br><span> }</span><br><span>diff --git a/src/openvpn/dco_linux.c=
 b/src/openvpn/dco_linux.c</span><br><span>index b2584b9..277cd64 100644</s=
pan><br><span>--- a/src/openvpn/dco_linux.c</span><br><span>+++ b/src/openv=
pn/dco_linux.c</span><br><span>@@ -1053,7 +1053,7 @@</span><br><span> }</sp=
an><br><span> </span><br><span> const char *</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-dco_get_supported_ciphers()</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+dco_get_supported_ciphers(void)</span><br><s=
pan> {</span><br><span>     return &quot;AES-128-GCM:AES-256-GCM:AES-192-GC=
M:CHACHA20-POLY1305&quot;;</span><br><span> }</span><br><span>diff --git a/=
src/openvpn/sig.c b/src/openvpn/sig.c</span><br><span>index cfbd942..8323f0=
d 100644</span><br><span>--- a/src/openvpn/sig.c</span><br><span>+++ b/src/=
openvpn/sig.c</span><br><span>@@ -448,7 +448,7 @@</span><br><span> }</span>=
<br><span> </span><br><span> void</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-halt_low_priority_signals()</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+halt_low_priority_signals(void)</span><br><span> {</spa=
n><br><span> #ifndef _WIN32</span><br><span>     struct sigaction sa;</span=
><br><span>diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c</span><br><sp=
an>index 2054eb4..17078c9 100644</span><br><span>--- a/src/openvpn/ssl.c</s=
pan><br><span>+++ b/src/openvpn/ssl.c</span><br><span>@@ -277,7 +277,7 @@</=
span><br><span> #endif</span><br><span> </span><br><span> void</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-enable_auth_user_pass()</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+enable_auth_user_pass(void)</s=
pan><br><span> {</span><br><span>     auth_user_pass_enabled =3D true;</spa=
n><br><span> }</span><br><span>diff --git a/src/openvpn/ssl.h b/src/openvpn=
/ssl.h</span><br><span>index 98e59e8..0e2a43f 100644</span><br><span>--- a/=
src/openvpn/ssl.h</span><br><span>+++ b/src/openvpn/ssl.h</span><br><span>@=
@ -381,7 +381,7 @@</span><br><span> void pem_password_setup(const char *aut=
h_file);</span><br><span> </span><br><span> /* Enables the use of user/pass=
word authentication */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-void enable_auth_user_pass();</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+void enable_auth_user_pass(void);</span><br><span> </span><br><s=
pan> /*</span><br><span>  * Setup authentication username and password. If =
auth_file is given, use the</span><br><span>diff --git a/src/openvpn/xkey_h=
elper.c b/src/openvpn/xkey_helper.c</span><br><span>index 283c95d..b68fb43 =
100644</span><br><span>--- a/src/openvpn/xkey_helper.c</span><br><span>+++ =
b/src/openvpn/xkey_helper.c</span><br><span>@@ -49,7 +49,7 @@</span><br><sp=
an> XKEY_EXTERNAL_SIGN_fn xkey_management_sign;</span><br><span> </span><br=
><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-pr=
int_openssl_errors()</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+print_openssl_errors(void)</span><br><span> {</span><br><span>     unsigne=
d long e;</span><br><span>     while ((e =3D ERR_get_error()))</span><br><s=
pan>diff --git a/src/openvpn/xkey_provider.c b/src/openvpn/xkey_provider.c<=
/span><br><span>index f5fc956..964d2eb 100644</span><br><span>--- a/src/ope=
nvpn/xkey_provider.c</span><br><span>+++ b/src/openvpn/xkey_provider.c</spa=
n><br><span>@@ -155,7 +155,7 @@</span><br><span> keymgmt_import_helper(XKEY=
_KEYDATA *key, const OSSL_PARAM params[]);</span><br><span> </span><br><spa=
n> static XKEY_KEYDATA *</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-keydata_new()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+key=
data_new(void)</span><br><span> {</span><br><span>     xkey_dmsg(D_XKEY, &q=
uot;entry&quot;);</span><br><span> </span><br><span>diff --git a/tests/unit=
_tests/openvpn/test_common.h b/tests/unit_tests/openvpn/test_common.h</span=
><br><span>index f219e93..52503c6 100644</span><br><span>--- a/tests/unit_t=
ests/openvpn/test_common.h</span><br><span>+++ b/tests/unit_tests/openvpn/t=
est_common.h</span><br><span>@@ -33,7 +33,7 @@</span><br><span>  * methods<=
/span><br><span>  */</span><br><span> static inline void</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-openvpn_unit_test_setup()</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+openvpn_unit_test_setup(void)</spa=
n><br><span> {</span><br><span>     assert_int_equal(setvbuf(stdout, NULL, =
_IONBF, BUFSIZ), 0);</span><br><span>     assert_int_equal(setvbuf(stderr, =
NULL, _IONBF, BUFSIZ), 0);</span><br><span>diff --git a/tests/unit_tests/op=
envpn/test_provider.c b/tests/unit_tests/openvpn/test_provider.c</span><br>=
<span>index 934b2d3..cfe9ac3 100644</span><br><span>--- a/tests/unit_tests/=
openvpn/test_provider.c</span><br><span>+++ b/tests/unit_tests/openvpn/test=
_provider.c</span><br><span>@@ -119,7 +119,7 @@</span><br><span> }</span><b=
r><span> </span><br><span> static void</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-init_test()</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+init_test(void)</span><br><span> {</span><br><span>     openvpn_un=
it_test_setup();</span><br><span>     prov[0] =3D OSSL_PROVIDER_load(NULL, =
&quot;default&quot;);</span><br><span>@@ -135,7 +135,7 @@</span><br><span> =
}</span><br><span> </span><br><span> static void</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-uninit_test()</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+uninit_test(void)</span><br><span> {</span><br><span> =
    for (size_t i =3D 0; i &lt; _countof(prov); i++)</span><br><span>     {=
</span><br><span>diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/u=
nit_tests/openvpn/test_ssl.c</span><br><span>index a9a3137..5da5b1c 100644<=
/span><br><span>--- a/tests/unit_tests/openvpn/test_ssl.c</span><br><span>+=
++ b/tests/unit_tests/openvpn/test_ssl.c</span><br><span>@@ -81,7 +81,7 @@<=
/span><br><span>                             &quot;-----END CERTIFICATE----=
-\n&quot;;</span><br><span> </span><br><span> static const char *</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-get_tmp_dir()</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+get_tmp_dir(void)</span><br><span> {<=
/span><br><span>     const char *ret;</span><br><span> #ifdef _WIN32</span>=
<br><span>diff --git a/tests/unit_tests/plugins/auth-pam/test_search_and_re=
place.c b/tests/unit_tests/plugins/auth-pam/test_search_and_replace.c</span=
><br><span>index ee7a151..d40467f 100644</span><br><span>--- a/tests/unit_t=
ests/plugins/auth-pam/test_search_and_replace.c</span><br><span>+++ b/tests=
/unit_tests/plugins/auth-pam/test_search_and_replace.c</span><br><span>@@ -=
9,7 +9,7 @@</span><br><span> #include &quot;utils.h&quot;</span><br><span> =
</span><br><span> static void</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-pass_any_null_param__returns_null()</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+pass_any_null_param__returns_null(void **state)</sp=
an><br><span> {</span><br><span> </span><br><span>     char DUMMY[] =3D &qu=
ot;DUMMY&quot;;</span><br><span>@@ -20,7 +20,7 @@</span><br><span> }</span>=
<br><span> </span><br><span> static void</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-pass_any_empty_string__returns_null()</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+pass_any_empty_string__returns_null(vo=
id **state)</span><br><span> {</span><br><span> </span><br><span>     char =
DUMMY[] =3D &quot;DUMMY&quot;;</span><br><span>@@ -32,7 +32,7 @@</span><br>=
<span> }</span><br><span> </span><br><span> static void</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-replace_single_char__one_time__match_is_r=
eplaced()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+replace_si=
ngle_char__one_time__match_is_replaced(void **state)</span><br><span> {</sp=
an><br><span>     char *replaced =3D searchandreplace(&quot;X&quot;, &quot;=
X&quot;, &quot;Y&quot;);</span><br><span> </span><br><span>@@ -43,7 +43,7 @=
@</span><br><span> }</span><br><span> </span><br><span> static void</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-replace_single_char__multiple=
_times__match_all_matches_are_replaced()</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+replace_single_char__multiple_times__match_all_matches=
_are_replaced(void **state)</span><br><span> {</span><br><span>     char *r=
eplaced =3D searchandreplace(&quot;XaX&quot;, &quot;X&quot;, &quot;Y&quot;)=
;</span><br><span> </span><br><span>@@ -54,7 +54,7 @@</span><br><span> }</s=
pan><br><span> </span><br><span> static void</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-replace_longer_text__multiple_times__match_all_match=
es_are_replaced()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+re=
place_longer_text__multiple_times__match_all_matches_are_replaced(void **st=
ate)</span><br><span> {</span><br><span>     char *replaced =3D searchandre=
place(&quot;XXaXX&quot;, &quot;XX&quot;, &quot;YY&quot;);</span><br><span> =
</span><br><span>@@ -65,7 +65,7 @@</span><br><span> }</span><br><span> </sp=
an><br><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-pattern_not_found__returns_original()</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+pattern_not_found__returns_original(void **state)</sp=
an><br><span> {</span><br><span>     char *replaced =3D searchandreplace(&q=
uot;abc&quot;, &quot;X&quot;, &quot;Y&quot;);</span><br><span> </span><br><=
span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/667?usp=3Demail">change 667</a>. To unsubscribe, or for help =
writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">=
settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"=
><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewActio=
n"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/667=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6e08920e4cf4762b9f14a7461a2=
9fa77df15255c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 667 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
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


--u2POUrgRu90=--

